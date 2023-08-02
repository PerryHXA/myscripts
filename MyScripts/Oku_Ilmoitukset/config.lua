Config = {

Sprite = { -- Vehicle blip sprite by class
	[0] = 225,
	[1] = 225,
	[2] = 225,
	[3] = 225,
	[4] = 225,
	[5] = 225,
	[6] = 225,
	[7] = 225,
	[8] = 226,
	[9] = 225,
	[10] = 67,
	[11] = 67,
	[12] = 67,
	[13] = 226,
	[14] = 410,
	[15] = 422,
	[16] = 423,
	[17] = 225,
	[18] = 225,
	[19] = 225,
	[20] = 67
},

Icons = { -- Vehicle icon by class
	[0] = 'fa-car',
	[1] = 'fa-car',
	[2] = 'fa-car',
	[3] = 'fa-car',
	[4] = 'fa-car',
	[5] = 'fa-car',
	[6] = 'fa-car',
	[7] = 'fa-car',
	[8] = 'fa-motorcycle',
	[9] = 'fa-car',
	[10] = 'fa-truck',
	[11] = 'fa-truck',
	[12] = 'fa-truck',
	[13] = 'fa-bicycle',
	[14] = 'fa-ship',
	[15] = 'fa-helicopter',
	[16] = 'fa-plane',
	[17] = 'fa-car',
	[18] = 'fa-car',
	[19] = 'fa-car',
	[20] = 'fa-truck'
},


OpenMenuKey = 'F9', -- Key to open the dispach menu (Leave blank if you dont need a key)
OpenMenuCommand = 'dispach', -- Command to open dispach menu (CAN NOT BE LEFT BLANK)

EnableUnitArrivalNotice = true, -- Give player notice that the unit is arriving to them! (Triggered when any unit accepts the call)


callCommandSprite = 280, -- Blip sprite when player calls using command
callCommandColor = 57, -- Blip color when player calls using command

EnableMapBlipsForUnits = true, -- Shows units in their vehicles on the map
AddCallBlips = true, -- Adds blips for calls that disappear over time
CallBlipDisappearInterval = 500, -- The higher value longer they will stay on the map

EnableShootingAlerts = true, -- Alerts when citizens shoot in shooting zones
ShootingZones = { -- Zones where citizens shooting gives police an alert
	{coords = vector3(-20.188398361206,6629.5073242188,30.817811965942), radius = 200.0}
},


-- You can have 3 jobs that can interact with the dispach and 
-- canRequestLocalBackup - This is for requesting backup/help from same job as yours
-- canRequestOtherJobBackup - This is for requesting backup/help from other jobs too
-- forwardCall - This will allow you to forward your jobs call to other jobs
-- callCommand - Command to make a call in dispach (You can also use triggers and make phone funcionallity or smth)
-- color - This is the color of units! this is a css class if you dont know what are you doing dont change
-- label - Label of the job
JobOne = {job = 'police', canRequestLocalBackup = true, canRequestOtherJobBackup = true, forwardCall = true, canRemoveCall = true, callCommand = "911", color = "blueunit", label = "Virkavalta", blipColor = 26 },
JobTwo = {job = 'medic', canRequestLocalBackup = true, canRequestOtherJobBackup = true, forwardCall = true, canRemoveCall = true, callCommand = "103", color = "redunit", label = "Tohtori",  blipColor = 1 },


Text = {

	['call_removed'] = 'Tehtävä poistettu',
	['call_forwarded'] = 'Tehtävä siiretty',
	['someone_is_reacting'] = 'Apuja on tulossa!',
	['offduty'] = 'Ei ole asetettu!',
	['alerts_turned_off'] = 'Ilmoitukset poistettu käytöstä!',
	['alerts_turned_on'] = 'Ilmoitukset käytössä!',
	['call_blips_turned_on'] = 'Karttamerkit näkyvissä',
	['call_blips_turned_off'] = 'Karttamerkit poissa näkyvissä'

}
	

}



-- Only change if you know what are you doing!
function SendTextMessage(msg)

		print(msg)
		--exports['mythic_notify']:SendAlert('inform', msg)

end
