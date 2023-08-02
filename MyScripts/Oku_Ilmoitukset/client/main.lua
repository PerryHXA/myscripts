local currentPlate = ""
local currentType = 0

local job = ""
local grade = 0

local unitCooldown = false
local alertsToggled = true
local unitBlipsToggled = true
local callBlipsToggled = true

local callBlips = {}
local blips = {}

Citizen.CreateThread(
function()
        while ESX == nil do
            TriggerEvent("esx:getSharedObject",function(obj)
                ESX = obj
            end)
            Citizen.Wait(0)
        end

        Citizen.Wait(2000)

        local jobInfo = {}
        jobInfo[Config.JobOne.job] = {
            color = Config.JobOne.color,
            column = 1,
            label = Config.JobOne.label,
            canRequestLocalBackup = Config.JobOne.canRequestLocalBackup,
            canRequestOtherJobBackup = Config.JobOne.canRequestOtherJobBackup,
            forwardCall = Config.JobOne.forwardCall,
            canRemoveCall = Config.JobOne.canRemoveCall
        }
        jobInfo[Config.JobTwo.job] = {
            color = Config.JobTwo.color,
            column = 2,
            label = Config.JobTwo.label,
            canRequestLocalBackup = Config.JobTwo.canRequestLocalBackup,
            canRequestOtherJobBackup = Config.JobTwo.canRequestOtherJobBackup,
            forwardCall = Config.JobTwo.forwardCall,
            canRemoveCall = Config.JobTwo.canRemoveCall
        }

        ESX.TriggerServerCallback("core_dispach:getPersonalInfo", function(firstname, lastname)
            SendNUIMessage(
                {
                    type = "Init",
                    firstname = firstname,
                    lastname = lastname,
                    jobInfo = jobInfo
                }
            )
        end)
end)


RegisterCommand("ilmoitukset", function(source, args, rawCommand)
    openDispach()
end)


--[[
RegisterCommand("ilmo", function(source, args, rawCommand)
	local ped = PlayerPedId()
	local playerPos = GetEntityCoords(ped)
	if IsPedMale(ped) then
		TriggerServerEvent("core_dispach:addCall", "RYÖSTÖ", "Kansalaista Ryöstetään!",{{icon = "fa-venus-mars", info = "Mies"}},{playerPos[1], playerPos[2], playerPos[3]},"police",5000)
	else
		TriggerServerEvent("core_dispach:addCall","RYÖSTÖ","Kansalaista Ryöstetään!",{{icon = "fa-venus-mars", info = "Nainen"}},{playerPos[1], playerPos[2], playerPos[3]},"police",5000)
	end
end)]]

RegisterCommand(Config.JobOne.callCommand,function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    local cord = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent("core_dispach:addMessage",msg,{cord[1], cord[2], cord[3]},Config.JobOne.job,5000)
end)

RegisterCommand(Config.JobTwo.callCommand, function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    local cord = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent("core_dispach:addMessage",msg,{cord[1], cord[2], cord[3]},Config.JobTwo.job,5000)
end)

function addBlipForCall(coords, text)
	local teksti = tostring(text)
	local alpha = 250
	local blip = Citizen.InvokeNative(0x45f13b7e0a15c880, -1282792512, coords.x, coords.y, coords.z, 10.0)
    SetBlipScale(blip, 0.2)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, teksti)
    Citizen.InvokeNative(0x662D364ABF16DE2F,blip,0x6F85C3CE)

    table.insert(callBlips, blip)

    while alpha ~= 0 do
        Citizen.Wait(Config.CallBlipDisappearInterval)
        alpha = alpha - 1

        if alpha == 0 then
            RemoveBlip(blip)
         
            return
        end
    end
end

function openDispach()
    SetNuiFocus(false, false)
	ESX.TriggerServerCallback("Oku_Ilmoitukset:haejob", function(job)
		if Config.JobOne.job == job or Config.JobTwo.job == job then
			ESX.TriggerServerCallback("core_dispach:getInfo", function(units, calls, ustatus)
				SetNuiFocus(true, true)
				SendNUIMessage(
					{
						type = "open",
						units = units,
						calls = calls,
						ustatus = ustatus,
						job = job,
						id = GetPlayerServerId(PlayerId())
					}
				)
			end)
		elseif job == "offpolice" then
			TriggerEvent('vorp:TipBottom', "Et ole vuorossa", 4000)
		else
			TriggerEvent('vorp:TipBottom', "Et kuulu virkavaltaan", 4000)
		end
	end)
end




RegisterNetEvent("core_dispach:callAdded")
AddEventHandler("core_dispach:callAdded", function(id, call, j, cooldown)
	ESX.TriggerServerCallback("Oku_Ilmoitukset:haejob", function(job)
		if job == j and alertsToggled then
			SendNUIMessage(
				{
					type = "call",
					id = id,
					call = call,
					cooldown = cooldown
				}
			)

			if Config.AddCallBlips then
				addBlipForCall(vector3(call.coords[1], call.coords[2], call.coords[3]), id)
			end
		end
	end)
end)

RegisterNUICallback("dismissCall",function(data)
    local id = data["id"]:gsub("call_", "")

    TriggerServerEvent("core_dispach:unitDismissed", id)
    SetGpsMultiRouteRender(false)
end)

RegisterNUICallback("updatestatus",function(data)
    local id = data["id"]
    local status = data["status"]

    TriggerServerEvent("core_dispach:changeStatus", id, status)
end)

RegisterNUICallback("sendnotice",function(data)
    local caller = data["caller"]

    if Config.EnableUnitArrivalNotice then
        TriggerServerEvent("core_dispach:arrivalNotice", caller)
    end
end)

RegisterNetEvent("core_dispach:arrivalNotice")
AddEventHandler("core_dispach:arrivalNotice", function()
    if not unitCooldown then
		TriggerEvent('vorp:TipBottom', Config.Text["someone_is_reacting"], 4000) 
        unitCooldown = true
        Citizen.Wait(20000)
        unitCooldown = false
    end
end)

RegisterNUICallback("toggleoffduty", function(data)
    TriggerServerEvent("twh_duty:changeStatus")
	TriggerEvent('vorp:TipBottom', "Lähdit vuorosta!", 4000) 
end)

RegisterNUICallback("togglecallblips", function(data)
    callBlipsToggled = not callBlipsToggled

    if callBlipsToggled then
        for _, z in pairs(callBlips) do
            SetBlipDisplay(z, 4)
        end
		TriggerEvent('vorp:TipBottom', Config.Text["call_blips_turned_on"], 4000) 
    else
        for _, z in pairs(callBlips) do
            SetBlipDisplay(z, 0)
        end

		TriggerEvent('vorp:TipBottom', Config.Text["call_blips_turned_off"], 4000) 
    end
end)

RegisterNUICallback("togglealerts", function(data)
    alertsToggled = not alertsToggled

    if alertsToggled then
		TriggerEvent('vorp:TipBottom', Config.Text["alerts_turned_on"], 4000) 
    else
		TriggerEvent('vorp:TipBottom', Config.Text["alerts_turned_off"], 4000) 
    end
end)

RegisterNUICallback("forwardCall", function(data)
    local id = data["id"]:gsub("call_", "")

    SendTextMessage(Config.Text["call_forwarded"])
    TriggerServerEvent("core_dispach:forwardCall", id, data["job"])
end)

RegisterNUICallback("acceptCall", function(data)
    local id = data["id"]:gsub("call_", "")
    StartGpsMultiRoute(6, true, true)
    AddPointToGpsMultiRoute(tonumber(data["x"]), tonumber(data["y"]), 0)
    SetGpsMultiRouteRender(true)

    TriggerServerEvent("core_dispach:unitResponding", id, job)
end)

RegisterNUICallback("removeCall", function(data)
    local id = data["id"]:gsub("call_", "")
	TriggerEvent('vorp:TipBottom', Config.Text["call_removed"], 4000) 
    TriggerServerEvent("core_dispach:removeCall", id)
end)

RegisterNUICallback("close", function(data)
    SetNuiFocus(false, false)
end)

--Shots in area
Citizen.CreateThread(
    function()
        while Config.EnableShootingAlerts do
            Citizen.Wait(10)
            local whithin = false
            local ped = PlayerPedId()
            local playerPos = GetEntityCoords(ped)

            for _, v in ipairs(Config.ShootingZones) do
                local distance = #(playerPos - v.coords)
                if distance < v.radius then
                    whithin = true
                end
            end

            if whithin then

            
                if IsPedShooting(ped) and math.random(1, 2) == 1 then
                    local gender = "unknown"
                    local model = GetEntityModel(ped)
                    if (model == GetHashKey("mp_f_freemode_01")) then
                        gender = "female"
                    end
                    if (model == GetHashKey("mp_m_freemode_01")) then
                        gender = "male"
                    end

                    TriggerServerEvent("core_dispach:addCall","10-71","Shots in area",{{icon = "fa-venus-mars", info = gender}},{playerPos[1], playerPos[2], playerPos[3]},"police",5000)
                    Citizen.Wait(20000)
                end
            else
                Citizen.Wait(2000)
            end
        end
    end
)

--[[
Citizen.CreateThread(function()
	while true do
		local netid = NetworkGetNetworkIdFromEntity(PlayerPedId())
        TriggerServerEvent("core_dispach:playerStatus", netId)
        Citizen.Wait(1000)
    end
end)]]


--EXPORTS

exports("addCall",function(code, title, extraInfo, coords, job, cooldown, sprite, color)
	TriggerServerEvent("core_dispach:addCall", code, title, extraInfo, coords, job, cooldown or 5000)
end)

exports("addMessage",function(message, coords, job, cooldown, sprite, color)
	TriggerServerEvent("core_dispach:addMessage", message, coords, job, sprite, cooldown or 5000)
end)
