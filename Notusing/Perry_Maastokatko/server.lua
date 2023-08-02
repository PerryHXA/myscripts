local VorpCore = {}

ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

katkot = {}

VORP = exports.vorp_inventory:vorp_inventoryApi()

-----VANHAT-------

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VORP.RegisterUsableItem("katko", function(data)
		local _source = data.source
		VORP.subItem(_source, "katko", 1)
		TriggerClientEvent("Perry_Katkot:LaitaKatko", _source)
	end)
end)

Citizen.CreateThread(function()
	TriggerEvent("Perry_Katko:load")
end)

AddEventHandler('Perry_Katko:load', function()
    exports.oxmysql:execute('SELECT * FROM katkot', {}, function(result)
        if (#result > 0) then
            print("success", 'Kätköjä löytyi '.. #result)
            katkot = result
        else
            print(nil,'Kätköjä ei löytynyt')
        end
    end)
end)

RegisterServerEvent('Perry_Katko:AnnaTakas')
AddEventHandler('Perry_Katko:AnnaTakas', function()
	VORP.addItem(source, "katko", 1)
	TriggerClientEvent('vorp:TipBottom',source, "Sait kätkön!", 4000) 
end)

ESX.RegisterServerCallback('Perry_Katko:remove', function(source, cb, katkotID)
	local _source = source
    exports.oxmysql:execute('SELECT * FROM katkot WHERE id = @id LIMIT 1', { ['@id'] = katkotID }, function(result)
        if ( result[1] ~= nil ) then
            exports.oxmysql:execute('DELETE FROM katkot WHERE id = @id LIMIT 1', { ['id'] = katkotID })

			VORP.addItem(_source, "katko", 1)
			TriggerClientEvent('vorp:TipBottom',_source, "Sait kätkön!", 4000) 
            TriggerEvent('Perry_Katko:remove', _source, katkotID)

            for i,v in ipairs(katkot) do
                if ( v.id == katkotID ) then
                    table.remove(katkot, i)
                    break
                end
            end

            TriggerClientEvent('Perry_Katko:load', -1)
            cb(true)
        end
    end)
end)

ESX.RegisterServerCallback('Perry_Katko:HaeTavarat', function(source, cb)
	local _source = source
	local User = VorpCore.getUser(source) 
	local Character = User.getUsedCharacter
	local currentMoney = Character.money
	TriggerEvent("vorpCore:getUserInventory", tonumber(_source), function(getInventory)
		cb({ currentMoney = currentMoney, items = getInventory })
	end)
end)

RegisterServerEvent("Perry_Katko:LaitaTavara")
AddEventHandler("Perry_Katko:LaitaTavara", function(item, count, id, label)
	local src = source
	local User = VorpCore.getUser(source) 
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier

    exports.oxmysql:execute('SELECT * FROM katkot WHERE id = @id', { ['@id'] = id }, function(result)
		local playerItemCount = VORP.getItemCount(src, item)
        if playerItemCount >= count and count > 0 then
            local re = json.decode(result[1]['inventory_items'])
            local founded = false

            if not ( table.empty(re) ) then
                for i,v in ipairs(re) do
                    if ( v['name'] == item ) then
                        founded = true
                        v['amount'] = v['amount'] + count
                        break
                    end
                end
            end
            

            if not ( founded ) then
                table.insert(re, { name = item, amount = count, label = label})
            end
            exports.oxmysql:execute('UPDATE katkot SET inventory_items = @inventory_items WHERE id = @id',
                { ['@id'] = id, ['@inventory_items'] = json.encode(re) }
            )
			VORP.subItem(src, item, count)
			sendToDiscord("kätkölogit", "HEX "..identifier.." laittoi kätköön " ..id.. " tavaran " ..label.." "..count.." kpl", 16711680)
			TriggerClientEvent("vorp:TipBottom", src, 'Laitoit ' .. label .. " x " .. count, 5000)
        else
			TriggerClientEvent("vorp:TipBottom", src, 'Tarkistahan määrä!', 5000)
        end
        
    end)
end)

ESX.RegisterServerCallback('Perry_Katko:HaeKaappiTavarat', function(source, cb, id)
    local _source = source

    local items = {}
    
    exports.oxmysql:execute('SELECT * FROM katkot WHERE id = @id', { ['@id'] = id }, function(result)

        if ( result[1] ~= nil ) then
            items = json.decode(result[1]['inventory_items'])
            for i,v in ipairs(items) do
                v['name'] = v['name']
				 v['label'] = v['label']
            end
            cb({ items = items })
        else
            cb(false)
        end
    end)
end)

RegisterServerEvent("Perry_Katko:OtaTavaraKaapista")
AddEventHandler("Perry_Katko:OtaTavaraKaapista", function(item, count, id, labeli)
	local src = source
	local User = VorpCore.getUser(src) 
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local canCarry = VORP.canCarryItem(src, item, count)
	if canCarry then
		exports.oxmysql:execute('SELECT * FROM katkot WHERE id = @id', { ['@id'] = id }, function(result)
			local inventory = json.decode(result[1]['inventory_items'])
			for i,v in ipairs(inventory) do
				if ( v['name'] == item) then
					if count > 0 and v['amount'] >= count then
						v['amount'] = v['amount'] - count
						if ( item.amount == 0 ) then
							table.remove(inventory, i)
						end

						exports.oxmysql:execute('UPDATE katkot SET inventory_items = @inventory_items WHERE id = @id',
							{ ['@inventory_items'] = json.encode(inventory), ['@id'] = id }
						)
						VORP.addItem(src, item, count) -- source, itemname, quantity
						sendToDiscord("kätkölogit", "HEX "..identifier.." otti kätköstä " ..id.. " tavaran " ..labeli.." "..count.." kpl", 16711680)
						TriggerClientEvent("vorp:TipBottom", src, 'Otit kätköstä tavaran '.. labeli.." "..count.." kpl", 5000)
					else
						TriggerClientEvent("vorp:TipBottom", src, 'Vaikea on ottaa mitä ei ole laatikossa', 5000)
					end		
				end
			end    
		end)
	else
		TriggerClientEvent('vorp:TipBottom', _source, "Sinulla ei ole repussa tilaa!", 4000)
	end
end)

ESX.RegisterServerCallback('Perry_Katko:getData', function(source, cb)
    cb(katkot)
end)

RegisterServerEvent('Perry_Katko:LaitaDatabase')
AddEventHandler('Perry_Katko:LaitaDatabase', function(x, y, z, h)
    local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier
    
    TriggerEvent('Perry_Katko:createNew', _source, coords)

    local coords = {x = x, y = y, z = z, h = h}
    local insertData = {
        ['owner_hex'] = identifier,
        ['owner_charid'] = charid,
        ['placed_date'] = os.date()
    }
    
        exports.oxmysql:execute('INSERT INTO katkot (coords, data) VALUES (@coords, @data)',
            { ['coords'] = json.encode(coords), ['data'] = json.encode(insertData) },
        function(insertId)
        print("success", 'Kätkö luotu ID: '.. insertId.insertId)
        exports.oxmysql:execute('SELECT * FROM katkot WHERE id = @id LIMIT 1', { ['id'] = tonumber(insertId.insertId) }, function(result)
            if (result[1] ~= nil) then
                table.insert(katkot, result[1])
                TriggerClientEvent('Perry_Katko:load', -1)
				TriggerClientEvent('vorp:TipBottom',_source, "Laitoit kätkön!", 4000) 
            end
        end)
    end)
end)

table.empty = function(self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end

local DISCORD_WEBHOOK = "webhookmissing"
local DISCORD_NAME = "Kätkölogit"
local STEAM_KEY = ""
local DISCORD_IMAGE = "https://i.imgur.com/CLoTdx1.jpg" -- default is FiveM logo

function sendToDiscord(name, message, color)
  local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "",
            },
        }
    }
  PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end