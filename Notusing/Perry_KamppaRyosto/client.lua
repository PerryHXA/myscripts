ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local DoingBreak = false
local showPro = false 
local avasoven = false

Citizen.CreateThread(function()
	while true do
    Citizen.Wait(5)
		for i,v in pairs(Config.Asunnot) do
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			local house = i
			if GetDistanceBetweenCoords(v.inside.x, v.inside.y, v.inside.z, coords.x, coords.y, coords.z, false) <= 3.0 then
				DrawText3D(v.inside.x, v.inside.y, v.inside.z, "Mene ulos", 0.4)
				if GetDistanceBetweenCoords(v.inside.x, v.inside.y, v.inside.z, coords.x, coords.y, coords.z, false) <= 1.2 and IsControlJustPressed(0, 0x760A9C6F) then
					fade()
					teleport(house)
				end
			end
		end 
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(9)
		for i,v in pairs(Config.Asunnot) do
			local playerPed = PlayerPedId()
			local house = i
			local coords = GetEntityCoords(playerPed)
			local dist   = GetDistanceBetweenCoords(v.coords.x, v.coords.y, v.coords.z, coords.x, coords.y, coords.z, false)
			if GetClockHours() >= 21 or GetClockHours() >= 0 and GetClockHours() <= 1 then
				if dist <= 1.2 and not DoingBreak then
					ESX.TriggerServerCallback('Perry_Kamppa:canRob', function(cb)
						canRob = cb
					end, i)
					if canRob then
						DrawText3D(v.coords.x, v.coords.y, v.coords.z, "Tiirikoi [G]", 0.4)                   
						if IsControlJustPressed(0, 0x760A9C6F) then
							HouseBreak(house)
							TriggerServerEvent('Perry_Kampat:rob', i)
						end
					else
						DrawText3D(v.coords.x, v.coords.y, v.coords.z, "Avaa Ovi [G]", 0.4)                   
						if IsControlJustPressed(0, 0x760A9C6F) then
							fade()
							SetCoords(playerPed, v.inside.x, v.inside.y, v.inside.z - 0.98)
							SetEntityHeading(playerPed, v.inside.h)
						end
					end
				end	
			end
		end
	end
end)

function HouseBreak(house)
	local v = GetHouseValues(house, Config.Asunnot)
	local playerPed = PlayerPedId()
	fade()
    DoingBreak = true
    FreezeEntityPosition(playerPed, true)
	RequestAnimDict("script_story@mob3@ig@ig1_dutch_holds_up_cashier")
	while not HasAnimDictLoaded("script_story@mob3@ig@ig1_dutch_holds_up_cashier") do
		Citizen.Wait(100)
	end
	TaskPlayAnim(PlayerPedId(), "script_story@mob3@ig@ig1_dutch_holds_up_cashier", "ig1_cashier_idle_01_cashier", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
    procent(70)
    TriggerServerEvent('Perry_Kampat:Remove', 'lockpick', 1)
    fade()
    ClearPedTasks(playerPed)
    FreezeEntityPosition(playerPed, false)
    SetCoords(playerPed, v.inside.x, v.inside.y, v.inside.z - 0.98)
    SetEntityHeading(playerPed, v.inside.h)
end

function procent(time)
  showPro = true
  TimeLeft = 0
  repeat
  TimeLeft = TimeLeft + 1        -- thank you (github.com/Loffes)
  Citizen.Wait(time)
  until(TimeLeft == 100)
  showPro = false
end

function teleport(house)
  local values = GetHouseValues(house, Config.Asunnot)
  local playerPed = PlayerPedId()
  SetCoords(playerPed, values.coords.x, values.coords.y, values.coords.z - 0.98)
  SetEntityHeading(playerPed, values.coords.h)
  DoingBreak = false
end

function SetCoords(playerPed, x, y, z)
  SetEntityCoords(playerPed, x, y, z)
  Citizen.Wait(100)
  SetEntityCoords(playerPed, x, y, z)
end

function GetHouseValues(house, pair)
    for k,v in pairs(pair) do
        if k == house then
            return v
        end
    end
end

function DrawText3D(x, y, z, text)
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

function fade()
  DoScreenFadeOut(1000)
  Citizen.Wait(1000)
  DoScreenFadeIn(1000)
end

RegisterCommand('instaan', function(source, args, rawCommand)
	TriggerServerEvent('instanceplayer:setNamed', 'InstanceName')  -- InstanceName can be any string, e.g Apartment-26
end)

RegisterCommand('instaan3', function(source, args, rawCommand)
	TriggerServerEvent('instance:set')
end)

RegisterCommand('instaan2', function(source, args, rawCommand)
	TriggerServerEvent('instanceplayer:setNamed', 0)
end)