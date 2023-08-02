RegisterNetEvent("start:boat")
AddEventHandler("start:boat", function()
    -- tp bateau
    DoScreenFadeOut(500)
    Wait(1000)
    SetEntityCoords(PlayerPedId(),2652.61, -1586.46, 48.31)
    Wait(1500)
    DoScreenFadeIn(1800)
    
    SetCinematicModeActive(true)
    Wait(10000)
    Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, 'Guarma', 'Veneesi on matkalla', 'Olet kohta perillä ...')
    Wait(20000)
    -- tp guarma
    Citizen.InvokeNative(0x74E2261D2A66849A, 1)
    Citizen.InvokeNative(0xA657EC9DBC6CC900, 1935063277)
    Citizen.InvokeNative(0xE8770EE02AEE45C2, 1)
    -- fin tp
    SetEntityCoords(PlayerPedId(),1267.03, -6852.97, 43.31)

    SetCinematicModeActive(false)
    ShutdownLoadingScreen()
end)


RegisterNetEvent("Perry_Guarma:takasin")
AddEventHandler("Perry_Guarma:takasin", function()
	SetCinematicModeActive(true)
	Wait(1500)
	DoScreenFadeOut(500)
	Wait(1000)
	
	TriggerEvent('retour:boat')
	Wait(5000)
end)

RegisterNetEvent("retour:boat")
AddEventHandler("retour:boat", function()
    -- tp bateau
    Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, 'Takaisinmatka', 'Veneesi on matkalla', 'Olet kohta takaisin ...')
    Wait(30000)
    -- tp guarma
    Citizen.InvokeNative(0x74E2261D2A66849A, 0)
    Citizen.InvokeNative(0xA657EC9DBC6CC900, -1868977180)
    Citizen.InvokeNative(0xE8770EE02AEE45C2, 0)
    -- fin tp
    SetEntityCoords(PlayerPedId(), 2664.38, -1544.03, 45.16)
    ShutdownLoadingScreen()
    DoScreenFadeIn(1000)

    Wait(1000)
 
    SetCinematicModeActive(false)
end)

local inguarma = false
--[[
RegisterCommand('guarma', function(source, args, rawCommand)
	print("yay")
	if inguarma then
		print("Guarmassa")
		inguarma = false
		Citizen.InvokeNative(0x74E2261D2A66849A, 1)
		Citizen.InvokeNative(0xA657EC9DBC6CC900, 1935063277)
		Citizen.InvokeNative(0xE8770EE02AEE45C2, 1)
	else
		print("Ei Guarmassa")
		inguarma = true
		Citizen.InvokeNative(0x74E2261D2A66849A, 0)
		Citizen.InvokeNative(0xA657EC9DBC6CC900, -1868977180)
		Citizen.InvokeNative(0xE8770EE02AEE45C2, 0)
	end
end)]]