local is_soundset_playing = false
local soundset_ref = "MOB2_SOUNDSET"
local soundset_name =  "POLICE_WHISTLE_MULTI"


--[[
RegisterCommand("pilli", function(source, args, rawCommand)
	--TaskPlayAnim(PlayerPedId(), dicti, animi, 8.0, 8.0, -1, 31, 0.4, false, false, false)
	RequestAnimDict("amb_rest@world_human_smoke_cigar@male_a@idle_a")
	while not HasAnimDictLoaded("amb_rest@world_human_smoke_cigar@male_a@idle_a") do
		Citizen.Wait(100)
	end
	local counter_i = 1
	while soundset_ref~=0 and not Citizen.InvokeNative(0xD9130842D7226045 ,soundset_ref,0) and counter_i <= 300  do  -- load soundset
		counter_i = counter_i + 1
		Citizen.Wait(0)
	end

	if soundset_ref == 0 or Citizen.InvokeNative(0xD9130842D7226045 ,soundset_ref,0) then
    -- PLAY SOUND FROM POSITION:
		local ped = PlayerPedId()
		local ped_coords = GetEntityCoords(ped)
		local x,y,z =  table.unpack(ped_coords)
		Citizen.InvokeNative(0xCCE219C922737BFA,soundset_name, x, y, z-1.0, soundset_ref, true, 0, true, 0)  -- PLAY_SOUND_FROM_POSITION
		local pilli = CreateObject(GetHashKey('p_whistle01x'), x, y, z + 0.2, true, true, true)
		local righthand = GetEntityBoneIndexByName(ped, "SKEL_R_Finger13")
		AttachEntityToEntity(pilli, ped, righthand, 0.017, -0.01, -0.01, 0.0, 120.0, 10.0, true, true, false, true, 1, true)
		TaskPlayAnim(ped, "amb_rest@world_human_smoke_cigar@male_a@idle_a", "idle_b", 8.0, -8.0, -1, 30, 0.4, false, 0, false, 0, false)
		Citizen.Wait(1200)
		Citizen.InvokeNative(0xCCE219C922737BFA,soundset_name, x, y, z-1.0, soundset_ref, true, 0, true, 0)  -- PLAY_SOUND_FROM_POSITION
		Citizen.Wait(300)
		ClearPedTasks(PlayerPedId())
		Citizen.InvokeNative(0x531A78D6BF27014B,soundset_ref)  -- stop soundset (required, otherwise new soundsets can fail to load)
        DeleteEntity(pilli)
	end
end)

]]--


RegisterNetEvent("Perry_Virkapilli:Aloitapilli")
AddEventHandler("Perry_Virkapilli:Aloitapilli", function()
	--TaskPlayAnim(PlayerPedId(), dicti, animi, 8.0, 8.0, -1, 31, 0.4, false, false, false)
	RequestAnimDict("amb_rest@world_human_smoke_cigar@male_a@idle_a")
	while not HasAnimDictLoaded("amb_rest@world_human_smoke_cigar@male_a@idle_a") do
		Citizen.Wait(100)
	end
	local counter_i = 1
	while soundset_ref~=0 and not Citizen.InvokeNative(0xD9130842D7226045 ,soundset_ref,0) and counter_i <= 300  do  -- load soundset
		counter_i = counter_i + 1
		Citizen.Wait(0)
	end

	if soundset_ref == 0 or Citizen.InvokeNative(0xD9130842D7226045 ,soundset_ref,0) then
    -- PLAY SOUND FROM POSITION:
		local ped = PlayerPedId()
		local ped_coords = GetEntityCoords(ped)
		local x,y,z =  table.unpack(ped_coords)
		Citizen.InvokeNative(0xCCE219C922737BFA,soundset_name, x, y, z-1.0, soundset_ref, true, 0, true, 0)  -- PLAY_SOUND_FROM_POSITION
		local pilli = CreateObject(GetHashKey('p_whistle01x'), x, y, z + 0.2, true, true, true)
		local righthand = GetEntityBoneIndexByName(ped, "SKEL_R_Finger13")
		AttachEntityToEntity(pilli, ped, righthand, 0.017, -0.01, -0.01, 0.0, 120.0, 10.0, true, true, false, true, 1, true)
		TaskPlayAnim(ped, "amb_rest@world_human_smoke_cigar@male_a@idle_a", "idle_b", 8.0, -8.0, -1, 30, 0.4, false, 0, false, 0, false)
		Citizen.Wait(1200)
		Citizen.InvokeNative(0xCCE219C922737BFA,soundset_name, x, y, z-1.0, soundset_ref, true, 0, true, 0)  -- PLAY_SOUND_FROM_POSITION
		Citizen.Wait(300)
		ClearPedTasks(PlayerPedId())
		Citizen.InvokeNative(0x531A78D6BF27014B,soundset_ref)  -- stop soundset (required, otherwise new soundsets can fail to load)
        DeleteEntity(pilli)
	end
end)