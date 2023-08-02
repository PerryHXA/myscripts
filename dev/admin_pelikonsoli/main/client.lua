RegisterNetEvent('stg_switch:use')
AddEventHandler('stg_switch:use', function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		type = "open"
	})
	nintendoAnim()
end)

RegisterNUICallback('exit', function()
    SetNuiFocus(false, false)
	DeleteObject(object)
	ClearPedTasksImmediately(PlayerPedId())
end)

function nintendoAnim()
	local dict = "mech_carry_box"
	local anim = "idle"
	ClearPedTasksImmediately(PlayerPedId())
	local ped = PlayerPedId()

	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
		RequestAnimDict(dict)
	end
	CarregarAnim(dict)
	TaskPlayAnim(ped, dict, anim, 1.0, 8.0, -1, 31, 0, 0, 0, 0) 
end

function CarregarAnim(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
end
