---------------------------------------------
----------------JUOMAT-----------------------
---------------------------------------------
RegisterNetEvent('Perry_tarpeet:water')
AddEventHandler('Perry_tarpeet:water', function()	
	local propEntity = CreateObject(GetHashKey('p_mugCoffee01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
	local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('p_mugCoffee01x_ph_r_hand'), GetHashKey('DRINK_COFFEE_HOLD'), 1, 0, -1.0)
    Citizen.Wait(10000)
    PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
    local Stamina = GetAttributeCoreValue(PlayerPedId(), 1)
	local newStamina = Stamina + 5
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, newStamina) --core
    Citizen.InvokeNative(0x50C803A4CD5932C5, true) --core
end)

RegisterNetEvent('Perry_tarpeet:medicine')
AddEventHandler('Perry_tarpeet:medicine', function()	
    local playerPed = PlayerPedId()
    local prop_name = 'p_bottlemedicine01x'
    local x,y,z = table.unpack(GetEntityCoords(playerPed))
    local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_Finger12")

    RequestAnimDict("amb_rest_drunk@world_human_drinking@male_a@idle_a")
    while not HasAnimDictLoaded("amb_rest_drunk@world_human_drinking@male_a@idle_a") do
        Citizen.Wait(100)
    end
    TaskPlayAnim(playerPed, "amb_rest_drunk@world_human_drinking@male_a@idle_a", "idle_a", 8.0, 8.0, 12600, 0, 0, true, 0, false, 0, false)
    AttachEntityToEntity(prop, playerPed, boneIndex, 0.02, 0.028, 0.001, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
    Citizen.Wait(2800)
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
    ClearPedSecondaryTask(playerPed)
	DeleteObject(prop)
end)

local kuolemakoittaa = false
local cure = false

RegisterNetEvent('Perry_tarpeet:pilallajuomat')
AddEventHandler('Perry_tarpeet:pilallajuomat', function(juoma)	
	if juoma == "kotikalja" then
		local playerPed = PlayerPedId()
		local propEntity = CreateObject(GetHashKey('p_bottlebeer01a'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
		local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('p_bottleBeer01x_PH_R_HAND'), GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-55_H18_Neck_A8_B1-8_TABLE_HOLD'), 1, 0, -1.0)
		Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
		Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "slightly_drunk")
		Citizen.Wait(10000)
		Effektit()
		Citizen.Wait(40000)
		Effektit()
		kuolemakoittaa = true
		Citizen.Wait(5000)
		if kuolemakoittaa then
			KuolemaVaihe()
		end
	elseif juoma == "omenakilju" then
		local playerPed = PlayerPedId()
		local propEntity = CreateObject(GetHashKey('s_inv_gin01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
		local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('s_inv_gin01x_PH_R_HAND'), GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_TABLE_HOLD'), 1, 0, -1.0)
		Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
		Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "slightly_drunk")
		Citizen.Wait(10000)
		Effektit()
		Citizen.Wait(40000)
		Effektit()
		kuolemakoittaa = true
		Citizen.Wait(5000)
		if kuolemakoittaa then
			KuolemaVaihe()
		end
	elseif juoma == "paarynakilju" then
		local playerPed = PlayerPedId()
		local propEntity = CreateObject(GetHashKey('s_inv_gin01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
		local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('s_inv_gin01x_PH_R_HAND'), GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_TABLE_HOLD'), 1, 0, -1.0)
		Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
		Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "slightly_drunk")
		Citizen.Wait(10000)
		Effektit()
		Citizen.Wait(40000)
		Effektit()
		kuolemakoittaa = true
		Citizen.Wait(5000)
		if kuolemakoittaa then
			KuolemaVaihe()
		end
	elseif juoma == "karhunvatukkaolut" then
		local playerPed = PlayerPedId()
		local propEntity = CreateObject(GetHashKey('p_bottlebeer01a'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
		local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('p_bottleBeer01x_PH_R_HAND'), GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-55_H18_Neck_A8_B1-8_TABLE_HOLD'), 1, 0, -1.0)
		Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
		Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "slightly_drunk")
		Citizen.Wait(10000)
		Effektit()
		Citizen.Wait(40000)
		Effektit()
		kuolemakoittaa = true
		Citizen.Wait(5000)
		if kuolemakoittaa then
			KuolemaVaihe()
		end
	elseif juoma == "inkiolut" then
		local playerPed = PlayerPedId()
		local propEntity = CreateObject(GetHashKey('p_bottlebeer01a'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
		local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('p_bottleBeer01x_PH_R_HAND'), GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-55_H18_Neck_A8_B1-8_TABLE_HOLD'), 1, 0, -1.0)
		Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
		Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "slightly_drunk")
		Citizen.Wait(10000)
		Effektit()
		Citizen.Wait(40000)
		Effektit()
		kuolemakoittaa = true
		Citizen.Wait(5000)
		if kuolemakoittaa then
			KuolemaVaihe()
		end
	elseif juoma == "rommi" then
		local playerPed = PlayerPedId()
		local propEntity = CreateObject(GetHashKey('s_inv_rum01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
		local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('s_inv_rum01x_PH_R_HAND'), GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_TABLE_HOLD'), 1, 0, -1.0)
		Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
		Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "slightly_drunk")
		Citizen.Wait(10000)
		Effektit()
		Citizen.Wait(40000)
		Effektit()
		kuolemakoittaa = true
		Citizen.Wait(5000)
		if kuolemakoittaa then
			KuolemaVaihe()
		end
	elseif juoma == "kotiviini" then
		local playerPed = PlayerPedId()
		local propEntity = CreateObject(GetHashKey('s_inv_rum01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
		local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('s_inv_rum01x_PH_R_HAND'), GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_TABLE_HOLD'), 1, 0, -1.0)
		Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
		Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "slightly_drunk")
		Citizen.Wait(10000)
		Effektit()
		Citizen.Wait(40000)
		Effektit()
		kuolemakoittaa = true
		Citizen.Wait(5000)
		if kuolemakoittaa then
			KuolemaVaihe()
		end
	end
end)

function KuolemaVaihe()
	while kuolemakoittaa do
		Citizen.Wait(0)
		if cure == false then
			AnimpostfxStop("PlayerDrunk01")
			local pl = Citizen.InvokeNative(0x217E9DC48139933D)
			local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
			Citizen.InvokeNative(0x697157CED63F18D4, ped, 500000, false, true, true)
			break
		else
			AnimpostfxStop("PlayerDrunk01")
			kuolemakoittaa = false
			break
		end
	end
end

RegisterNetEvent('Perry_tarpeet:laakehiili')
AddEventHandler('Perry_tarpeet:laakehiili', function()	
    RequestAnimDict("mech_pickup@plant@berries")
    while not HasAnimDictLoaded("mech_pickup@plant@berries") do
        Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), "mech_pickup@plant@berries", "exit_eat", 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
    Wait(2500)
	local randomia = math.random(1,10)
	if randomia >= 6 then
		cure = true
		TriggerEvent("vorp:TipBottom", "Lääkehiili alkaa vaikuttamaan kehossasi", 4000) 
	else
		TriggerEvent("vorp:TipBottom", "Lääkehiili ei vaikuttanut", 4000) 
	end
end)

function Effektit()
	AnimpostfxPlay("PlayerDrunk01")
	Citizen.Wait(20000)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HURL_1"),0,0,0,0,0)  -- FULL BODY EMOTE
	Citizen.Wait(10000)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HURL_1"),0,0,0,0,0)  -- FULL BODY EMOTE
	Citizen.Wait(10000)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HURL_1"),0,0,0,0,0)  -- FULL BODY EMOTE
	Citizen.Wait(10000)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HURL_1"),0,0,0,0,0)  -- FULL BODY EMOTE
	Citizen.Wait(10000)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HURL_1"),0,0,0,0,0)  -- FULL BODY EMOTE
	Citizen.Wait(10000)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HURL_1"),0,0,0,0,0)  -- FULL BODY EMOTE
	Citizen.Wait(10000)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HURL_1"),0,0,0,0,0)  -- FULL BODY EMOTE
	Citizen.Wait(10000)
	SetPedToRagdoll(PlayerPedId(), 10000, 10000, 0, 0, 0, 0)
	Citizen.Wait(10000)
end


