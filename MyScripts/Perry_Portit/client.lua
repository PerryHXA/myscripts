

--vector3(2538.24, -1313.08, 49.12) Cineman sisä
-- vector3(2554.83, -1302.61, 49.11)

RegisterNetEvent("Starkki_Portit:Telee")
AddEventHandler("Starkki_Portit:Telee", function(x, y, z, h)
	local player = PlayerPedId()
	DoScreenFadeOut(500)
	Wait(500)
    SetEntityCoords(player, x, y, z)
    SetEntityHeading(player, h)
	Wait(500)
	DoScreenFadeIn(500)
end)
