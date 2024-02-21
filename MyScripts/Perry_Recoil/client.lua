local menu = 'mp_lobby_textures'
local shake = false
local speed = 2.6
local PlayerData		= {}
local size = {x=0.01, y=0.015}
local huntinglvl = 5
-- -1569615261

local banned = {
	[-1609580060], -- Nyrkki
	[-728555052], -- Puukot
	[308416707], -- Lasso
	[1622482340], -- Fishingrod
	[-954861255], -- group_held
	[-1212426201], -- Sniput
}
---------------- AIMSHAKE ----------------

--levelit--


---------


CreateThread(function()

	if not HasStreamedTextureDictLoaded(menu) then
		RequestStreamedTextureDict(menu)
	end
	while not huntinglvl do Wait(1) print('getting lvl') end
	while true do
		local player = PlayerPedId()
		local hasWeapon,weaponHash = GetCurrentPedWeapon(player)
		local grouppi = GetWeapontypeGroup(weaponHash)
		local speed = speed / 1 + (huntinglvl / 100)
		if hasWeapon then
			if not banned[grouppi] then
				if IsPlayerFreeAiming(PlayerId()) then
					Citizen.InvokeNative(0x8BC7C1F929D07BF3, 0xBB47198C)
					
					if not shake then
						--huntinglvl = level.hunting.lvl
						ShakeGameplayCam("HAND_SHAKE", speed) --Hae levelit, speed / 1 +(huntinglevel / 100)
						shake = true
					end
				else
					if shake then
						ShakeGameplayCam("HAND_SHAKE", 0.0)
						shake = false
					end
				end
			end
		else
			Wait(100)
		end
		Wait(1)
	end
end)

---------------- REKYILIIIIIIIIIIIIII --------------

local recoils = {
	-- Revolverit
	[0x0797FBF5] = 1.3,			--['weapon_revolver_doubleaction']
	[0x169F59F7] = 1.8,			--['weapon_revolver_cattleman']
	[0x16D655F7] = 1.0,			--['weapon_revolver_cattleman_mexican']
	[0x5B2D26B5] = 1.0,			--['weapon_revolver_lemat']
	[0x7BBD1FF6] = 1.0,			--['weapon_revolver_schofield']
	[0x83DD5617] = 1.0,			--['weapon_revolver_doubleaction_gambler']
	-- Pistoolit
	[0x020D13FF] = 1.8,			--['weapon_pistol_volcanic']
	[0x5B78B8DD] = 1.0,			--['weapon_pistol_m1899']
	[0x657065D6] = 1.0,			--['weapon_pistol_semiauto']
	[0x8580C63E] = 1.0,			--['weapon_pistol_mauser']
	-- REPEATERS
	[0x7194721E] = 1.3,			--['weapon_repeater_evans']
	[0x95B24592] = 1.8,			--['weapon_repeater_henry']
	[0xA84762EC] = 1.0,			--['weapon_repeater_winchester']
	[0xF5175BA1] = 1.0,			--['weapon_repeater_carbine']
	-- Riflet
	[0x63F46DE6] = 1.3,			--['weapon_rifle_springfield']
	[0x772C8DD6] = 1.8,			--['weapon_rifle_boltaction']
	[0xDDF7BC1E] = 1.0,			--['weapon_rifle_varmint']
	-- Haulikot
	[0x1765A8F8] = 1.0,			--['weapon_shotgun_sawedoff']
	[0x2250E150] = 1.0,			--['weapon_shotgun_doublebarrel_exotic']
	[0x31B7B9FE] = 1.3,			--['weapon_shotgun_pump']
	[0x63CA782A] = 1.8,			--['weapon_shotgun_repeating']
	[0x6D9BB970] = 1.0,			--['weapon_shotgun_semiauto']
	[0x6DFA071B] = 1.0,			--['weapon_shotgun_doublebarrel']
	-- Sniiput
	[0x53944780] = 1.0,			--['weapon_sniperrifle_carcano']
	[0xE1D2B317] = 1.0,			--['weapon_sniperrifle_rollingblock']
	-- Heittopaskat
	[0x09E12A01] = 1.3,			--['weapon_melee_hatchet']
	[0x2A5CF9D6] = 1.8,			--['weapon_melee_hatchet_hunter']
	[0x7067E7A7] = 1.0,			--['weapon_thrown_molotov']
	[0x7F23B6C7] = 1.0,			--['weapon_thrown_tomahawk_ancient']
	[0xA5E972D7] = 1.3,			--['weapon_thrown_tomahawk']
	[0xA64DAA5E] = 1.8,			--['weapon_thrown_dynamite']
	[0xBCC63763] = 1.0,			--['weapon_melee_hatchet_double_bit']
	[0xD2718D48] = 1.0,			--['weapon_thrown_throwing_knives']
	[0xEF32A25D] = 1.0,			--['weapon_melee_cleaver']
	-- Bowi ja lasso
	[0x88a8505c] = 1.0,			--['weapon_bow']
	--[0x7a8a724a] = 5.0,			--['weapon_lasso']
	--  Weapons from game version 1207.80 till 1311.12
	[-1717423096] = 4.0,			--['weapon_rifle_elephant']
	[132728264] = 2.0,			--['weapon_revolver_navy']
	[389133414] = 3.0,			--['weapon_revolver_navy_crossover']
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		local ped = PlayerPedId()
		
        if IsPedShooting(ped) then
			local speed = speed / 1 + (huntinglvl / 100)
            local _,tykki = GetCurrentPedWeapon(ped)
            if recoils[tykki] and (recoils[tykki] / 1 + (huntinglvl / 100)) ~= 0 then --recoils[tykki] / 1 +(huntinglevel/100)
                tv = 0
                repeat 
                    Wait(0)
                    p = GetGameplayCamRelativePitch()
                    if recoils[tykki] > 0.1 then
                        SetGameplayCamRelativePitch(p+0.6, 1.2)
                        tv = tv+0.6
                    else
                        SetGameplayCamRelativePitch(p+0.016, 0.333)
                        tv = tv+0.1
                    end
                until tv >= recoils[tykki]
            end
        end
    end
end)
