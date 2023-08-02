ESX = nil

Id = 0

Units = {}
Calls = {}
UnitStatus = {}

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('Oku_Ilmoitukset:haejob', function(source, cb)
	local _source = source
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter 
	job = Character.job
	cb(job)
end)


RegisterServerEvent("core_dispach:playerStatus")
AddEventHandler("core_dispach:playerStatus", function()
    local src = source
	local User = VorpCore.getUser(src) 
	local Character = User.getUsedCharacter 
	local joba = Character.job
    Units[src] = {plate = "", type = 0, job = joba}
end)

RegisterServerEvent("core_dispach:removeCall")
AddEventHandler("core_dispach:removeCall",function(id)
	Calls[tonumber(id)] = nil
end)

RegisterServerEvent("core_dispach:changeStatus")
AddEventHandler("core_dispach:changeStatus",function(userid, status)
	UnitStatus[userid] = status
end)

RegisterServerEvent("core_dispach:unitDismissed")
AddEventHandler("core_dispach:unitDismissed",function(id, job)
	local src = source
	local count = 1

    for _, v in ipairs(Calls[tonumber(id)].respondingUnits) do
        if v.unit == src then
            table.remove(Calls[tonumber(id)].respondingUnits, count)
        end
        count = count + 1
    end
end)

RegisterServerEvent("core_dispach:unitResponding")
AddEventHandler("core_dispach:unitResponding",function(id, job)
    local src = source
    table.insert(Calls[tonumber(id)].respondingUnits, {unit = src, type = job})
end)

RegisterServerEvent("core_dispach:forwardCall")
AddEventHandler("core_dispach:forwardCall",function(id, job)
    local add = true
    for _, v in ipairs(Calls[tonumber(id)].job) do
        if v == job then
            add = false
        end
    end

    if add then
        table.insert(Calls[tonumber(id)].job, job)

        TriggerClientEvent("core_dispach:callAdded", -1, tonumber(id), Calls[tonumber(id)], job, 5000)
    end
end)

RegisterServerEvent("core_dispach:addMessage")
AddEventHandler("core_dispach:addMessage", function(message, location, job, cooldown, sprite, color)
    local src = source

    Calls[Id] = {
        code = "",
        title = "",
        extraInfo = {},
        respondingUnits = {},
        coords = location,
        job = {job},
        phone = "22",
        message = message,
        type = "message",
        caller = src
    }

    TriggerClientEvent("core_dispach:callAdded", -1, Id, Calls[Id], job, cooldown or 5000, sprite or 11, color or 5)

    Id = Id + 1

end)

RegisterServerEvent("core_dispach:addCall")
AddEventHandler("core_dispach:addCall",function(code, title, info, location, job, cooldown, sprite, color)
    Calls[Id] = {
        code = code,
        title = title,
        extraInfo = info,
        respondingUnits = {},
        coords = location,
        job = {job},
        type = "call"
    }

    TriggerClientEvent("core_dispach:callAdded", -1, Id, Calls[Id], job, cooldown or 3500, sprite or 11, color or 5)


    Id = Id + 1
end)

RegisterServerEvent("core_dispach:arrivalNotice")
AddEventHandler("core_dispach:arrivalNotice",function(caller)
    if caller ~= nil then
		TriggerClientEvent("core_dispach:arrivalNotice", caller)
    end
end)

ESX.RegisterServerCallback("core_dispach:getPersonalInfo", function(source, cb)
    local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charidentifier = Character.charIdentifier
    local firstname =  MySQL.Sync.fetchScalar("SELECT firstname FROM characters WHERE identifier = @identifier AND charidentifier = @charidentifier", {["@identifier"] = identifier, ["@charidentifier"] = charidentifier})
    local lastname = MySQL.Sync.fetchScalar("SELECT lastname FROM characters WHERE identifier = @identifier AND charidentifier = @charidentifier", {["@identifier"] = identifier, ["@charidentifier"] = charidentifier})
    cb(firstname, lastname)
end)

ESX.RegisterServerCallback("core_dispach:getInfo", function(source, cb)
    local generated = {}

    for k, v in pairs(Units) do
        if GetPlayerPing(k) > 0 then
			local User = VorpCore.getUser(k)
			local Character = User.getUsedCharacter 
			local identifier = Character.identifier
			local charidentifier = Character.charIdentifier
			local firstname =  MySQL.Sync.fetchScalar("SELECT firstname FROM characters WHERE identifier = @identifier AND charidentifier = @charidentifier", {["@identifier"] = identifier, ["@charidentifier"] = charidentifier})
			local lastname = MySQL.Sync.fetchScalar("SELECT lastname FROM characters WHERE identifier = @identifier AND charidentifier = @charidentifier", {["@identifier"] = identifier, ["@charidentifier"] = charidentifier})
            if generated[v.plate] == nil then
                generated[v.plate] = {
                    type = Config.Icons[v.type],
                    units = {{id = k, name = firstname .. " " .. lastname}},
                    job = v.job
                }
            elseif generated[v.plate].job == v.job then
                table.insert(generated[v.plate].units, {id = k, name = firstname .. " " .. lastname})
            end
        end
    end
    cb(generated, Calls, UnitStatus)
end)
