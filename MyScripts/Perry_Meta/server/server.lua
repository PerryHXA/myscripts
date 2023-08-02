local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

RegisterNetEvent('Perry_Needs:UpdatePlayer', function(currentHunger, currentThirst)
    local src = source
	local Player = VORPcore.getUser(src)
    if not Player then return end
    local newHunger = currentHunger - Config.HungerRate
    local newThirst = currentThirst - Config.ThirstRate
    if newHunger <= 0 then
        newHunger = 0
    end
    if newThirst <= 0 then
        newThirst = 0
    end
	TriggerClientEvent("Perry_Needs:UpdateClient", src, newHunger, newThirst)
    --TriggerClientEvent('hud:client:UpdateNeeds', src, newHunger, newThirst)
    local data = {
        hunger = newHunger,
        thirst = newThirst
    }
    TriggerClientEvent('BasicNeeds.update', src, data)
	TriggerEvent("Perry_Needs:UpdateDatabasee", src, newHunger, newThirst)
end)

RegisterNetEvent('Perry_Needs:UpdateNeeds', function(currentHunger, currentThirst)
    local src = source
	local Player = VORPcore.getUser(src)
    if not Player then return end
    if currentHunger <= 0 then
        currentHunger = 0
    end
    if currentThirst <= 0 then
        currentThirst = 0
    end
    local data = {
        hunger = currentHunger,
        thirst = currentThirst
    }
    TriggerClientEvent('BasicNeeds.update', src, data)
	TriggerClientEvent("Perry_Needs:UpdateClient", src, currentHunger, currentThirst)
    --TriggerClientEvent('hud:client:UpdateNeeds', src, currentHunger, currentThirst)
end)

RegisterNetEvent('Perry_Needs:GetData', function()
	local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charidentifier = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT metabolism FROM characters WHERE identifier = @identifier  AND charidentifier = @charidentifier ' , {['identifier'] = identifier, ['charidentifier'] = charidentifier}, function(result)
        if result[1] ~= nil then 
            local metat = json.decode(result[1].metabolism)
			TriggerClientEvent("Perry_Needs:UpdateClientToMeta", _source, metat)
            TriggerClientEvent("BasicNeeds.update",_source, metat)
        end
    end)
end)

RegisterNetEvent('Perry_Needs:UpdateDatabasee', function(source, currentHunger, currentThirst)
	if currentHunger >= 100 then
		currentHunger = 100 
	end
	if currentThirst >= 100 then
		currentThirst = 100 
	end
    local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charidentifier = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT metabolism FROM characters WHERE identifier = @identifier  AND charidentifier = @charidentifier ' , {['identifier'] = identifier, ['charidentifier'] = charidentifier}, function(result)
        if result[1] ~= nil then 
            local metat = json.decode(result[1].metabolism)
			metat["hunger"] = currentHunger
			metat["thirst"] = currentThirst
			exports.ghmattimysql:execute("UPDATE characters Set metabolism=@metabolism WHERE identifier = @identifier  AND charidentifier = @charidentifier", { ['identifier'] = identifier, ['charidentifier'] = charidentifier, ['metabolism'] = json.encode(metat) })
        end
    end)
end)

