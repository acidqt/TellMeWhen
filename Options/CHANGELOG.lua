if not TMW then return end

TMW.CHANGELOG = {

[==[===v7.1.2===]==],
[==[* The Combat Event icon type now has special events that will fire when you multistrike.]==],
[==[* Various tooltips now reflect that WoW only supports .ogg files for custom sound files - MP3s are no longer supported by the game client.]==],
[==[* Removed error warning about other addons using debugprofilestart() - we got the data we needed.]==],
[==[]==],
[==[====Bug Fixes====]==],
[==[* The Item in Range of Unit condition should once again work properly.]==],
[==[* TellMeWhen will no longer forcibly disable Blizzard's cooldown timer text when Tukui is enabled since Tukui now uses those texts as its timers.]==],
[==[]==],
[==[===v7.1.1===]==],
[==[====Bug Fixes====]==],
[==[* Fixed a very silly mistake that broke anchoring of an icon's text displays when Masque was not installed.]==],
[==[]==],
[==[]==],
[==[===v7.1.0===]==],
[==[* TellMeWhen has been updated for Warlords of Draenor. Please open a ticket on CurseForge for TMW if you notice anything missing.]==],
[==[]==],
[==[* New icon types:]==],
[==[** All-Unit Buffs/Debuffs. This icon type is mainly useful for tracking your multi-dotting on targets which might not have a unitID.]==],
[==[** Combat Event Error. This icon type reacts to messages like "Must be behind the target" or "You are already at full health".]==],
[==[]==],
[==[* New icon display method: Vertical Bars.]==],
[==[]==],
[==[* New conditions]==],
[==[** Instance Size]==],
[==[** Zone PvP Type]==],
[==[]==],
[==[* You can now set a rotation amount for a icon's text displays.]==],
[==[* The "Highlight timer edge" setting is back.]==],
[==[* You can now export all your global groups at once.]==],
[==[]==],
[==[* The suggestion list now defers its sorting so that input is more responsive.]==],
[==[* The suggestion list is now much smarter at suggesting things. For Example, "swp" will now suggestion "Shadow Word: Pain", and "dis mag" will suggest "Dispel Magic".]==],
[==[]==],
[==[]==],
[==[====Bug Fixes====]==],
[==[* Fixed another issue with ElvUI's timer texts (they weren't going away when they should have been).]==],
[==[* A whole lot of other minor bugs have been fixed - too many to list here.]==],
[==[]==],
[==[]==],
[==[===v7.0.3===]==],
[==[* Re-worked the Instance Type condition to make it more extensible in the future, and also added a few missing instance types to it.]==],
[==[* Added a Unit Specialization condition that can check the specs of enemies in arenas, and all units in battlegrounds.]==],
[==[]==],
[==[====Bug Fixes====]==],
[==[* Fixed an error that would be thrown if the whisper target ended up evaluating to nil.]==],
[==[* TellMeWhen now duplicates Blizzard's code for the spell activation overlay (and has some additional code to get this to play nicely with Masque) so that it should hopefully no longer get blamed for tainting your action bars.]==],
[==[* TellMeWhen also now duplicates Blizzard's code for dropdown menus, and improves upon it slightly. This should also help with taint issues.]==],
[==[]==],
[==[===v7.0.2===]==],
[==[====Bug Fixes====]==],
[==[* Fixed the missing slider value text for the Unit Level condition.]==],
[==[* The Haste conditions no longer have a hard cap of 100%.]==],
[==[* Fixed a false error that would display during configuring while using the [Range] DogTag.]==],
[==[* Fixed an error relating to refreshing the tooltip for non-button widgets.]==],
[==[]==],
[==[===v7.0.1===]==],
[==[* Numbered units entered with a space in the middle (e.g. "arena 1") will once again be corrected by TellMeWhen. It is still bad practice to enter units like that, though.]==],
[==[]==],
[==[====Bug Fixes====]==],
[==[* Fixed a typo that was preventing Loss of Control icons from reporting their spell.]==],
[==[* Fixed an error that would happen when upgrading a text layout that was previously unnamed: IconModule_TextsTexts.lua:150 attempt to concatenate field 'Name' (a nil value)]==],
[==[]==],
[==[===v7.0.0===]==],
[==[]==],
[==[====Core Systems====]==],
[==[* You can now create global groups that exist for all characters on your account. These groups can be enabled and disabled on a per-profile basis.]==],
[==[* Text Layouts are now defined on an account-wide basis instead of being defined for individual profiles.]==],
[==[]==],
[==[* Many icon types, when set on the first icon in a group, are now able to control that entire group with the data that they harvest.]==],
[==[]==],
[==[* All references from one icon or group to another in TellMeWhen are now tracked by a unique ID. This ID will persist no matter where it is moved or exported to.]==],
[==[** This includes:]==],
[==[*** DogTags]==],
[==[*** Meta icons]==],
[==[*** Icon Shown conditions (and the other conditions that track icons)]==],
[==[*** Group anchoring to other groups]==],
[==[** The consequence of this is that you can now, for example, import/export a meta icon separately from the icons it is checking and they will automatically find eachother once they are all imported (as long as these export strings were created with TMW v7.0.0+)]==],
[==[** IMPORTANT: Existing DogTags that reference other icons/groups by ID cannot be updated automatically - you will need to change these yourself.]==],
[==[]==],
[==[====Events/Notifications====]==],
[==[* Events have been re-branded to Notifications, and you can now add notifications that will trigger continually while a set of conditions evaluate to true.]==],
[==[* New Notification: Counter. Configure a counter that can be checked in conditions and displayed with DogTags.]==],
[==[* The On Other Icon Show/Hide events have been removed. Their functionality can be obtained using an On Condition Set Passing trigger.]==],
[==[* You can now adjust the target opacity of the Alpha Flash animation]==],
[==[]==],
[==[====Icon Types====]==],
[==[* Global Cooldowns are now only filtered for icon types that can track things on the global cooldown.]==],
[==[* Combat Event: the unit exclusion "Miscellaneous: Unknown Unit" will now also cause events that were fired without a unit to be excluded.]==],
[==[* Meta Icon: The "Inherit failed condition opacity" setting has been removed. Meta icons will now always inherit the exact opacity of the icons they are showing, though this can be overridden by the meta icon's opacity settings.]==],
[==[* Meta Icon: Complex chains of meta icon inheritance should now be handled much better, especially when some of the icons have animations on them.]==],
[==[* Diminishing Returns: The duration of Diminishing Returns is now customizable in TMW's main options.]==],
[==[* Buff/Debuff: Ice Block and Divine Shield are now treated as being as non-stealable (Blizzard flags them incorrectly)]==],
[==[* Buff/Debuff: Added an [AuraSource] DogTag to obtain the unit that applied a buff/debuff, if available.]==],
[==[* Buff/Debuff Check: Removed the "Hide if no units" option since it didn't make much sense for this icon type.]==],
[==[]==],
[==[====Conditions====]==],
[==[* New Conditions added that offer integration with Big Wigs and Deadly Boss Mods.]==],
[==[* New Condition: Specialization Role]==],
[==[* New Condition: Unit Range (uses LibRangeCheck-2.0 to check the unit's approximate range)]==],
[==[* The Buff/Debuff - "Number of" conditions now accept semicolon-delimited lists of multiple auras that should be counted.]==],
[==[]==],
[==[====Group Modules====]==],
[==[* You can now anchor groups to the cursor.]==],
[==[* You can now right-click-and-drag the group resize handle to easily change the number of rows and columns of a group, and doing so with this method will preserve the relative positions of icons within a group.]==],
[==[* Added group settings that allow you to specify when a group should be shown based on the role that your current specialization fulfills.]==],
[==[]==],
[==[====Icon Modules====]==],
[==[* You can now enter "none" or "blank" as a custom texture for an icon to force it to display no texture.]==],
[==[* You can now enter a spell prefixed by a dash to omit that spell from any equivalencies entered, E.g. "Slowed; -Dazed" would check all slowed effects except daze.]==],
[==[]==],
[==[* New text layout settings: Width, Height, & JustifyV.]==],
[==[]==],
[==[====Miscellaneous====]==],
[==[* The group settings tab in the Icon Editor now only displays the group options for the currently loaded icon's group by default. This can be changed back to the old behavior with a checkbox in the top-left corner of the tab in the Icon Editor.]==],
[==[]==],
[==[* Exporting a meta icon will also export the string(s) of its component icons.]==],
[==[* Exporting groups and icons will also export the string(s) of their text layouts.]==],
[==[]==],
[==[* Various updates to many buff/debuff equivalencies.]==],
[==[* New buff equivalency: SpeedBoosts]==],
[==[]==],
[==[* Code snippets can now be disabled from autorunning at login.]==],
[==[* Dramatically decreased memory usage for icons that have no icon type assigned.]==],
[==[* You can now use "thisobj" in Lua conditions as a reference to the icon or group that is checking the conditions.]==],
[==[]==],
[==[* TellMeWhen now warns you when importing executable Lua code so that you can't be tricked into importing scripts you don't know about.]==],
[==[]==],
[==[* TellMeWhen_Options now maintains a backup of TellMeWhen's SavedVariables that will be restored if TellMeWhen's SVs become corrupted.]==],
[==[]==],
[==[* TellMeWhen no longer includes the massively incomplete localizations for itIT, ptBR, frFR, deDE, koKR, and esMX (esMX now uses esES). If you would like to contribute to localization, go to http://wow.curseforge.com/addons/tellmewhen/localization/]==],
[==[]==],
[==[====Bug Fixes====]==],
[==[* Units tracked by name with spaces in them (E.g. Kor'kron Warbringer as a CLEU unit filter) will now be interpreted properly as input.]==],
[==[** IMPORTANT: A consequence of this fix is that if you are enter a unit like "boss 1", this will no longer work. You need to enter "boss1", which has always been the proper unitID.]==],
[==[* Importing/Exporting icons from/to strings with hyperlinks in some part of the icon's data will now preserve the hyperlink.]==],
[==[* Icons should now always have the correct size after their view changes or the size or ID of a group changes.]==],
[==[* Fixed an issue where strings imported from older version of TellMeWhen (roughly pre-v6.0.0) could have their StackMin/Max and DurationMin/Max settings as strings instead of numbers.]==],
[==[* The "Equipment set equipped" condition should properly update when saving the equipment set that is currently equipped.]==],
[==[* Fixed an issue when upgrading text layouts that could also cause them to not be upgraded at all: /Components/IconModules/IconModule_Texts/Texts.lua line 205: attempt to index field 'Anchors' (a nil value)]==],
[==[* Currency conditions should once again be listed in the condition type selection menu.]==],
[==[* The NPC ID condition should now work correctly with npcIDs that are greater than 65535 (0xFFFF).]==],
[==[* Meta icons should reflect changes in the icons that they are checking that are caused by using slash commands to enable/disable icons while TMW is locked.]==],
[==[* TellMeWhen no longer registers PLAYER_TALENT_UPDATE - there is a Blizzard big causing this to fire at random for warlocks, and possibly other classes as well, which triggers a TMW:Update() which can cause a sudden framerate drop. PLAYER_SPECIALIZATION_CHANGED still fires for everything that we cared about.]==],
[==[]==],
}
