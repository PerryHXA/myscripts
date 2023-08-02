local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("lippu", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Fort:Aloitusta", _source) 
	end)
end)

RegisterServerEvent('Perry_Fort:Otarahuskilia')
AddEventHandler('Perry_Fort:Otarahuskilia', function()
	local paiva = os.date('%d')
	local fort = "fortwallace"
	exports.oxmysql:execute('SELECT * FROM fortit WHERE name = @name', { ['@name'] = fort }, function(result)
		day = json.decode(result[1]['day'])
		money = json.decode(result[1]['money'])
		if tostring(paiva) == tostring(day) then -- En tiiä miksei toimi if not 
		else
			if money == 5 then
				exports.ghmattimysql:execute("UPDATE fortit Set day=@day WHERE name = @name", { ['name'] = fort, ['day'] = paiva })
				exports.ghmattimysql:execute("UPDATE fortit Set money=@money WHERE name = @name", { ['name'] = fort, ['money'] = 0 })
			else
				local insertData = {}
				exports.ghmattimysql:execute("UPDATE fortit Set data=@data WHERE name = @name", { ['name'] = fort, ['data'] = json.encode(insertData) })
				exports.ghmattimysql:execute("UPDATE fortit Set hasowner=@hasowner WHERE name = @name", { ['name'] = fort, ['hasowner'] = 0 })
				exports.ghmattimysql:execute("UPDATE fortit Set day=@day WHERE name = @name", { ['name'] = fort, ['day'] = nil })
			end
		end
	end)
end)

RegisterServerEvent('Perry_Fort:LaitaRahaa')
AddEventHandler('Perry_Fort:LaitaRahaa', function(argut)
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	local money = Character.money
	local fort = argut.fortti
	local rahat = argut.rahaa
	if rahat < 5 then
		if money >= 5 then
			Character.removeCurrency(0, 5) 
			exports.ghmattimysql:execute("UPDATE fortit Set money=@money WHERE name = @name", { ['name'] = fort, ['money'] = 5 })
			print("talletettu")
			TriggerClientEvent('vorp:TipBottom', _source, "Talletettu 5$", 4000) -- TOIMII
		else
			print("ei oo rahaa")
			TriggerClientEvent('vorp:TipBottom', _source, "Sinulla ei ole rahaa!", 4000) -- TOIMII
		end
	else
		print("on jo")
		TriggerClientEvent('vorp:TipBottom', _source, "Tilillä on jo 5$", 4000) -- TOIMII
	end
end)

RegisterServerEvent('Perry_Fort:TarkistaOmistaja')
AddEventHandler('Perry_Fort:TarkistaOmistaja', function(fort)
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier
	exports.oxmysql:execute('SELECT data FROM fortit WHERE name = @name' , {['name'] = fort}, function(result)
		if result[1] ~= nil then 
			local data = json.decode(result[1].data)
			local owner = data["owner_hex"]
			local ownercharid = data["owner_charid"]
			if owner == identifier then
				if ownercharid == charid then
					exports.oxmysql:execute('SELECT * FROM fortit WHERE name = @name' , {['name'] = fort}, function(result)
						money = json.decode(result[1]['money'])
						TriggerClientEvent("Perry_Fort:AvaaMenu", _source, money, fort)
					end)
				else
					TriggerClientEvent('vorp:TipBottom', _source, "Et omista tätä linnaketta!", 4000) -- TOIMII
				end
			else
				TriggerClientEvent('vorp:TipBottom', _source, "Et omista tätä linnaketta!", 4000) -- TOIMII
			end
		end
	end)
end)

RegisterServerEvent('Perry_Fort:Vallattu')
AddEventHandler('Perry_Fort:Vallattu', function(fort)
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier
	local day = os.date('%d')
    local insertData = {
        ['owner_hex'] = identifier,
        ['owner_charid'] = charid,
        ['placed_date'] = os.date(),
    }
	exports.ghmattimysql:execute("UPDATE fortit Set data=@data WHERE name = @name", { ['name'] = fort, ['data'] = json.encode(insertData) })
	exports.ghmattimysql:execute("UPDATE fortit Set hasowner=@hasowner WHERE name = @name", { ['name'] = fort, ['hasowner'] = 1 })
	exports.ghmattimysql:execute("UPDATE fortit Set day=@day WHERE name = @name", { ['name'] = fort, ['day'] = day })
end)

RegisterServerEvent('Perry_Fort:TarkastaRyosto')
AddEventHandler('Perry_Fort:TarkastaRyosto', function(fort)
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier
	exports.oxmysql:execute('SELECT * FROM fortit WHERE name = @name', { ['@name'] = fort }, function(result)
		owner = json.decode(result[1]['hasowner'])
		if owner == 0 then 
			TriggerClientEvent("Perry_Fort:AloitaValtaaminen", _source, fort)
			TriggerClientEvent('Perry_Fort:StarttaaNPC', _source)	
		else
			exports.oxmysql:execute('SELECT data FROM fortit WHERE name = @name' , {['name'] = fort}, function(result)
				if result[1] ~= nil then 
					local data = json.decode(result[1].data)
					local owner = data["owner_hex"]
					local ownercharid = data["owner_charid"]
					
					if owner == identifier then
						TriggerClientEvent('vorp:TipBottom', _source, "Et voi valloittaa omaa forttiasi!", 4000) -- TOIMII
					else
						local players = GetPlayers()
						for _, player in ipairs(players) do
							local playerPed = GetPlayerPed(player)

							if DoesEntityExist(playerPed) then
								local User = VorpCore.getUser(player)
								local Character = User.getUsedCharacter --get player info
								local identifier = Character.identifier
								local charid = Character.charIdentifier
								if owner == identifier then
									if charid == ownercharid then
										TriggerClientEvent("Perry_Fort:AloitaValtaaminen", _source, fort)
										TriggerClientEvent('Perry_Fort:StarttaaNPC', _source)
									else
										TriggerClientEvent('vorp:TipBottom', _source, "Linnakkeen omistajan on oltava paikalla!", 4000) -- TOIMII
									end
								end
							end
						end
					end
					
				end
			end)
		end
	end)	
end)
