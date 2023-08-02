local deathTable = {}

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("bandage", function(data)
		local _source = data.source
		TriggerClientEvent('healself', _source)
		VorpInv.subItem(_source,"bandage", 1)
	end)
end)

RegisterServerEvent('eventDeath', function(damagetype, bones) --// kuolessa ammutaan servueventti missä tuodaat damagetype ja vaikka bonedamage tai muuta mitä haluaa tuoda
    local src = source
	local User = VorpCore.getUser(src)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier

	if not deathTable[charid] then
		deathTable[charid] = {}
	else
		local deathData = {
			damagetype = damagetype, 
			bones = bones
		}
		table.insert(deathTable[charid], deathData)
	end
end)

RegisterNetEvent("givebackitem")
AddEventHandler("givebackitem", function(item, qty)
    VorpInv.addItem(source, item, qty)
end)

RegisterServerEvent('reconnectDeath', function() --// Täytyy ampuu clientistä, kun pelaaja spawnaa servulle, ja jos isDead niin tappaa uudelleen ja triggeröi tuon eventin, jolloin vanhempi data saadaan näkymään kaikille clienteille
    local src = source
	local User = VorpCore.getUser(src)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier
    if deathTable[charid] then
        TriggerClientEvent('clientevent', -1, json.encode(deathTable[charid])) --// reconnnectissa lähetetään kaikille clienteille tietoon kuolema data
    end
end)

RegisterServerEvent('resetDeath', function() --// Triggeröi reviven tapahtuessa ja nollaa servun välimuistista hahmon kuolemadatan
    local src = source
	local User = VorpCore.getUser(src)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier
    if deathTable[charid] then
        deathTable[charid] = {}
    end
end)

RegisterServerEvent('resurrectPlayer', function(id) --// haetaan pelaajan deathtable data client
    if id then
        TriggerClientEvent("vorp:resurrectPlayer", id)
		TriggerClientEvent("GoOnTheGround", id)
        TriggerClientEvent("vorp:TipBottom", id, "Sinut on parannettu", 5000)
    end
end)


RegisterServerEvent('getdeathcause', function(target) --// haetaan pelaajan deathtable data client
    local src = source
	--TARGET
	local User = VorpCore.getUser(target)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier
	--SOURCE
	local User = VorpCore.getUser(src)
	local Character = User.getUsedCharacter 
	local job = Character.job
    if deathTable[charid] then
        TriggerClientEvent('clientsenddeathTable', src, json.encode(deathTable[charid]), job) --// reconnnectissa lähetetään kaikille clienteille tietoon kuolema data
    end
end)

RegisterServerEvent('getdamagepoints', function(target) --// haetaan pelaajan deathtable data client
    local src = source
	--TARGET
	local User = VorpCore.getUser(target)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier
    if deathTable[charid] then
        TriggerClientEvent('clientsenddamagepoints', src, json.encode(deathTable[charid])) --// reconnnectissa lähetetään kaikille clienteille tietoon kuolema data
    end
end)

RegisterServerEvent('getitemstorevive', function() 
	local count = VorpInv.getItemCount(source, "syringe")
	local count2 = VorpInv.getItemCount(source, "nousema")
	if count >= 1 then
		VorpInv.subItem(source, "syringe", 1)
		TriggerClientEvent("revivesystem", source, "syringe")
	elseif count2 >= 1 then
		VorpInv.subItem(source, "nousema", 1)
		TriggerClientEvent("revivesystem", source, "nousema")
	else
		TriggerClientEvent("vorp:TipBottom", source, "Sinulla ei ole tarvittavia tavaroita!  (Ruisku tai NostoRohto)", 5000)
	end
end)

RegisterServerEvent('getbandage', function() 
	local User = VorpCore.getUser(source)
	local Character = User.getUsedCharacter 
	local count = VorpInv.getItemCount(source, "bandage")
	if count >= 1 then
		VorpInv.subItem(source, "bandage", 1)
		TriggerClientEvent("healclosest", source)
	else
		TriggerClientEvent("vorp:TipBottom", source, "Sinulla ei ole tarvittavia tavaroita! (Sideharso)", 5000)
	end
end)




VorpInv = exports.vorp_inventory:vorp_inventoryApi()

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

local ESX = exports['vorp_core']:GetObj()

RegisterNetEvent('hospital:server:ambulanceAlert', function(text)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local players = GetPlayers()
    for k,v in pairs(players) do
		local player = VorpCore.getUser(v).getUsedCharacter
        if player.job == 'medic' then
			--TriggerEvent("Notification:left", mname, mmsg, 'menu_textures', 'menu_icon_alert', 4000)
            TriggerClientEvent('hospital:client:ambulanceAlert', v, coords, text, src)
        end
    end
end)