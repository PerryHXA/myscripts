ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


local arvonta = false
local arvontavalmis = false
local tulos = 0
local sattumaluku = 0
local fakelaskuri = 0


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		for k,v in pairs(Config.Roulettes) do
			local coords = GetEntityCoords(PlayerPedId())
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 10) then
				if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2) then
					if not lahella then
						TriggerServerEvent('esx_ruletti:lahella')
						lahella = true
					end
					if not arvonta then
						if not liitytty then
							DrawTxt("Paina [ENTER] osallistuaksesi rulettiin", 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
						else
							DrawTxt("Olet osallistunut kierrokselle - odotetaan Voit lisätä panoksia painamalla [ENTER]", 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
						end
					end
						if IsControlJustPressed(0, 0xC7B5340A) then
							maxLength = 5
							AddTextEntry('FMMC_KEY_TIP8', "Panos - Max 50$")
							DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", maxLength)
							DrawTxt("~b~Määritä panos", 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
							blockinput = true

							while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
								Citizen.Wait( 0 )
							end

							local osallistumismaksu = GetOnscreenKeyboardResult()

							osallistumismaksu = tonumber(osallistumismaksu)
							Citizen.Wait(150)

							blockinput = false

							if osallistumismaksu ~= nil and osallistumismaksu > 0 and osallistumismaksu < 51 then
								maxLength = 2
								AddTextEntry('FMMC_KEY_TIP8', "Väri tai numero")
								DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", maxLength)
								exports['mythic_notify']:DoLongHudText('Error', "Valitse väri P, M, V tai numero 0-36")
								blockinput = true

								while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
									Citizen.Wait( 0 )
								end

								local vari = GetOnscreenKeyboardResult()

								Citizen.Wait(150)
								blockinput = false
								if vari == 'P' or vari == 'M' or vari == 'V' then
									TriggerServerEvent('esx_ruletti:osallistuminen', osallistumismaksu, vari)
									liitytty = true
								else
									vari = tonumber(vari)
									if vari ~= nil and vari >= 0 and vari < 37 then
										TriggerServerEvent('esx_ruletti:osallistuminen', osallistumismaksu, vari)
										liitytty = true
									else
										exports['mythic_notify']:DoLongHudText('Error', 'Virheellinen väri tai numero')
									end
								end
							else
								exports['mythic_notify']:DoLongHudText('Error', "Määritä kelvollinen panos")
							end
						end
						if arvonta then
							if fakelaskuri > 16 then
								sattumaluku = math.random(0,36)
								fakelaskuri = 0
								if not arvontavalmis then
									PlaySound(-1, "CANCEL", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
								end
							end
							if arvontavalmis then
								sattumaluku = tulos
							end
							fakelaskuri = fakelaskuri + 1
							if sattumaluku == 0 then
								text = 'Ruletti: ~t6~'..sattumaluku
							elseif sattumaluku > 18 then
								text = 'Ruletti: ~m~'..sattumaluku
							else
								text = 'Ruletti: ~e~'..sattumaluku
							end
						else
							text = 'Ruletti: ~g~asettakaa panoksenne'
						end
						DrawText3Ds(v.x, v.y, v.z, text)
				end
			else
				Citizen.Wait(1000)
			end
		end
	end
end)

RegisterNetEvent('esx:ruletti:tulos')
AddEventHandler('esx:ruletti:tulos', function(servuntulos)
	tulos = servuntulos
	arvonta = true
	Citizen.Wait(10000)
	arvontavalmis = true
	Citizen.Wait(5000)
	liitytty = false
	arvonta = false
	arvontavalmis = false
	lahella = false
end)

RegisterNetEvent('esx:ruletti:epaonnistui')
AddEventHandler('esx:ruletti:epaonnistui', function()
	liitytty = false
end)


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)


    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())  
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    if onScreen then
    	SetTextScale(0.30, 0.30)
  		SetTextFontForCurrentCommand(1)
    	SetTextColor(255, 255, 255, 215)
    	SetTextCentre(1)
    	DisplayText(str,_x,_y)
    	local factor = (string.len(text)) / 225
    	DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
    	--DrawSprite("feeds", "toast_bg", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
    end
end
