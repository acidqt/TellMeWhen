-- --------------------
-- TellMeWhen
-- Originally by Nephthys of Hyjal <lieandswell@yahoo.com>

-- Other contributions by:
--		Sweetmms of Blackrock, Oozebull of Twisting Nether, Oodyboo of Mug'thol,
--		Banjankri of Blackrock, Predeter of Proudmoore, Xenyr of Aszune

-- Currently maintained by
-- Cybeloras of Aerie Peak/Detheroc/Mal'Ganis
-- --------------------


if not TMW then return end

local TMW = TMW
local L = TMW.L
local print = TMW.print
local IE = TMW.IE
local CI = TMW.CI




local TabGroup = IE:RegisterTabGroup("MAIN", TMW.L["MAIN"], 3, function(tabGroup)
	local titlePrepend = "TellMeWhen v" .. TELLMEWHEN_VERSION_FULL

	IE.Header:SetText(titlePrepend)
end)









-- ----------------------
-- CHANGELOG
-- ----------------------

local ChangelogTab = IE:RegisterTab("MAIN", "CHANGELOG", "Changelog", 100)
ChangelogTab:SetTexts(L["CHANGELOG"], L["CHANGELOG_DESC"])

local changelogEnd = "<p align='center'>|cff666666To see the changelog for versions up to v" ..
(TMW.CHANGELOG_LASTVER or "???") .. ", click the tab below again.|r</p>"
local changelogEndAll = "<p align='center'>|cff666666For older versions, visit TellMeWhen's AddOn page on Curse.com|r</p><br/>"

function IE:ShowChangelog(lastVer)

	IE.TabGroups.MAIN.CHANGELOG:Click()

	if not lastVer then lastVer = 0 end

	local CHANGELOGS = IE:ProcessChangelogData()

	local texts = {}

	for version, text in TMW:OrderedPairs(CHANGELOGS, nil, nil, true) do
		if lastVer >= version then
			if lastVer > 0 then
				text = text:gsub("</h1>", " (" .. L["CHANGELOG_LAST_VERSION"] .. ")</h1>")
			end
				
			tinsert(texts, text)
			break
		else
			tinsert(texts, text)
		end
	end

	-- The intro text, before any actual changelog entries
	tinsert(texts, 1, "<p align='center'>|cff999999" .. L["CHANGELOG_INFO2"]:format(TELLMEWHEN_VERSION_FULL) .. "|r</p>")

	if lastVer > 0 then
		tinsert(texts, changelogEnd .. changelogEndAll)
	else
		tinsert(texts, changelogEndAll)
	end

	local Container = IE.Pages.Changelog.Container

	local body = format("<html><body>%s</body></html>", table.concat(texts, "<br/>"))
	Container.HTML:SetText(body)

	-- This has to be stored because there is no GetText method.
	Container.HTML.text = body

	IE.Pages.Changelog.Container.ScrollFrame:SetVerticalScroll(0)
	Container:GetScript("OnSizeChanged")(Container)
end

local function htmlEscape(char)
	if char == "&" then
		return "&amp;"
	elseif char == "<" then
		return "&lt;"
	elseif char == ">" then
		return "&gt;"
	end
end

local bulletColors = {
	"4FD678",
	"2F99FF",
	"F62FAD",
}

local function bullets(b, text)
	local numDashes = #b 
	
	if numDashes <= 0 then
		return "><p>" .. text .. "</p><"
	end

	local color = bulletColors[(numDashes-1) % #bulletColors + 1]
	
	-- This is not a regular space. It is U+2002 - EN SPACE
	local dashes = (" "):rep(numDashes) .. "•"

	return "><p>|cFF" .. color .. dashes .. " |r" .. text .. "</p><"
end

local CHANGELOGS
function IE:ProcessChangelogData()
	if CHANGELOGS then
		return CHANGELOGS
	end

	CHANGELOGS = {}

	if not TMW.CHANGELOG then
		TMW:Error("There was an error loading TMW's changelog data.")
		TMW:Print("There was an error loading TMW's changelog data.")

		return CHANGELOGS
	end

	local log = TMW.CHANGELOG

	log = log:gsub("([&<>])", htmlEscape)        
	log = log:trim(" \t\r\n")

	-- Replace 4 equals with h2
	log = log:gsub("[ \t]*====(.-)====[ \t]*", "<h2>%1</h2>")

	-- Replace 3 equals with h1, formatting as a version name
	log = log:gsub("[ \t]*===(.-)===[ \t]*", "<h1>TellMeWhen %1</h1>")

	-- Remove extra space after closing header tags
	log = log:gsub("(</h.>)%s*", "%1")

	-- Remove extra space before opening header tags.
	log = log:gsub("%s*(<h.>)", "%1")

	-- Convert newlines to <br/>
	log = log:gsub("\r\n", "<br/>")
	log = log:gsub("\n", "<br/>")

	-- Put a break at the end for the next gsub - it relies on a tag of some kind
	-- being at the end of each line.
	log = log .. "<br/>"

	-- Convert asterisks to colored dashes
	log = log:gsub(">%s*(*+)%s*(.-)<", bullets)

	-- Remove double breaks 
	log = log:gsub("<br/><br/>", "<br/>")

	-- Remove breaks between paragraphs
	log = log:gsub("</p><br/><p>", "</p><p>")

	-- Add breaks between paragraphs and h2ss
	-- Put an empty paragraph in since they are smaller than a full break.
	log = log:gsub("</p>%s*<h2>", "</p><p> </p><h2>")

	-- Add a "General" header before the first paragraph after an h1
	log = log:gsub("</h1>%s*<p>", "</h1><h2>General</h2><p>")

	-- Make the phrase "IMPORTANT" be red.
	log = log:gsub("IMPORTANT", "|cffff0000IMPORTANT|r")


	local subStart, subEnd = 0, 0
	repeat
		local done

		-- Find the start of a version
		subStart, endH1 = log:find("<h1>", subEnd)

		-- Find the start of the next version
		subEnd = log:find("<h1>", endH1)

		if not subEnd then
			-- We're at the end of the data. Set the length of the data as the end position.
			subEnd = #log
			done = true
		else
			-- We want to end just before the start of the next version.
			subEnd = subEnd - 1
		end

		local versionString = log:match("TellMeWhen v([0-9%.]+)", subStart):gsub("%.", "")
		local versionNumber = tonumber(versionString) * 100
		
		-- A full version's changelog is between subStart and subEnd. Store it.
		CHANGELOGS[versionNumber] = log:sub(subStart, subEnd)
	until done

	-- Send this out to the garbage collector
	TMW.CHANGELOG = nil

	return CHANGELOGS
end

TMW:RegisterCallback("TMW_CONFIG_LOADED", function()
	if IE.db.global.LastChangelogVersion > 0 then		
		if IE.db.global.LastChangelogVersion < TELLMEWHEN_VERSIONNUMBER then
			if IE.db.global.LastChangelogVersion < TELLMEWHEN_FORCECHANGELOG -- forced
			or TELLMEWHEN_VERSION_MINOR == "" -- upgraded to a release version (e.g. 7.0.0 release)
			or floor(IE.db.global.LastChangelogVersion/100) < floor(TELLMEWHEN_VERSIONNUMBER/100) -- upgraded to a new minor version (e.g. 6.2.6 release -> 7.0.0 alpha)
			then
				-- Put this in a C_Timer so that it runs after all the auto tab clicking mumbo jumbo has finished.
				-- C_Timers with a delay of 0 will run after the current script finishes execution.
				-- In the case of loading the IE, it is probably an OnClick.

				-- We have to upvalue this since its about to get set to the current version.l
				local version = IE.db.global.LastChangelogVersion
				C_Timer.After(0, function()
					IE:ShowChangelog(version)	
				end)
			end

			IE.db.global.LastChangelogVersion = TELLMEWHEN_VERSIONNUMBER
		end
	else
		IE.db.global.LastChangelogVersion = TELLMEWHEN_VERSIONNUMBER
	end
end)
