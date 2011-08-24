﻿-- --------------------
-- TellMeWhen
-- Originally by Nephthys of Hyjal <lieandswell@yahoo.com>

-- Other contributions by
-- Sweetmms of Blackrock
-- Oozebull of Twisting Nether
-- Oodyboo of Mug'thol
-- Banjankri of Blackrock
-- Predeter of Proudmoore
-- Xenyr of Aszune

-- Currently maintained by
-- Cybeloras of Mal'Ganis
-- --------------------

local TMW = TMW
if not TMW then return end
local L = TMW.L

local db, UPD_INTV, ClockGCD, rc, mc, pr, ab
local GetRuneType, GetRuneCooldown =
	  GetRuneType, GetRuneCooldown
local OnGCD = TMW.OnGCD
local print = TMW.print
local _, pclass = UnitClass("Player")
local SpellTextures = TMW.SpellTextures

local Type = {}
LibStub("AceEvent-3.0"):Embed(Type)
Type.name = L["ICONMENU_RUNES"]
Type.hidden = pclass ~= "DEATHKNIGHT"
Type.TypeChecks = {
	setting = "TotemSlots",
	text = L["RUNES"],
}
Type.WhenChecks = {
	text = L["ICONMENU_SHOWWHEN"],
	{ value = "alpha",             	text = L["ICONMENU_USABLE"],             	colorCode = "|cFF00FF00" },
	{ value = "unalpha",          	text = L["ICONMENU_UNUSABLE"],             	colorCode = "|cFFFF0000" },
	{ value = "always",         	text = L["ICONMENU_ALWAYS"] },
}
Type.RelevantSettings = {
	Name = false,
	Sort = true,
	TotemSlots = true,
	ShowCBar = true,
	CBarOffs = true,
	InvertBars = true,
	DurationMin = true,
	DurationMax = true,
	DurationMinEnabled = true,
	DurationMaxEnabled = true,
}

local textures = {
	"Interface\\Icons\\Spell_Deathknight_BloodPresence",
	"Interface\\Icons\\Spell_Deathknight_UnholyPresence",
	"Interface\\Icons\\Spell_Deathknight_FrostPresence",
	"Interface\\Addons\\TellMeWhen\\Textures\\DeathPresence",
}

function Type:Update()
	db = TMW.db
	UPD_INTV = db.profile.Interval
	ClockGCD = db.profile.ClockGCD
	rc = db.profile.OORColor
	mc = db.profile.OOMColor
	pr = db.profile.PRESENTColor
	ab = db.profile.ABSENTColor
end

local huge = math.huge
local function Runes_OnUpdate(icon, time)
	if icon.UpdateTimer <= time - UPD_INTV then
		icon.UpdateTimer = time
		local CndtCheck = icon.CndtCheck if CndtCheck and CndtCheck() then return end
		
		local Slots, Sort = icon.Slots, icon.Sort
		local readyslot
		local unstart, unduration, unslot
		local d = Sort == -1 and huge or 0
		
		for iSlot = 1, #Slots do -- be careful here. slots that are explicitly disabled by the user are set false. slots that are disabled internally are set nil.
			if Slots[iSlot] then
				local start, duration, runeReady = GetRuneCooldown(iSlot)
				
				if start == 0 then duration = 0 end
				if start > time then runeReady = false end
				
				if runeReady then
					if not readyslot then
						readyslot = iSlot
					end
					if icon.Alpha > 0 then
						break
					end
				else
					if Sort then
						local _d = duration - (time - start)
						if d*Sort < _d*Sort then
							unstart, unduration, unslot, d = start, duration, iSlot, _d
						end
					else
						if not unstart or (unstart > time and start < time) then
							unstart, unduration, unslot = start, duration, iSlot
						end
						if start < time and icon.Alpha == 0 then
							break
						end
					end
				end
			end
		end
		if readyslot then
			icon:SetInfo(icon.Alpha, 1, textures[GetRuneType(readyslot)], 0, 0)
		elseif unslot then
			icon:SetInfo(icon.UnAlpha, 1, textures[GetRuneType(unslot)], unstart, unduration)
		else
			print("WTF?")
		end
	end
end


Type.AllowNoName = true
function Type:Setup(icon, groupID, iconID)
	icon.Slots = wipe(icon.Slots or {})
	for i=1, 6 do
		icon.Slots[i] = tonumber(strsub(icon.TotemSlots.."000000", i, i)) == 1
	end
	
	for k, v in ipairs(icon.Slots) do
		if v then
			icon.FirstTexture = textures[ceil(k/2)]
			break
		end
	end
	
	icon:SetTexture(icon.FirstTexture or "Interface\\Icons\\INV_Misc_QuestionMark")
	
	icon:SetScript("OnUpdate", Runes_OnUpdate)
	--icon:OnUpdate(TMW.time)
end


TMW:RegisterIconType(Type, "runes")