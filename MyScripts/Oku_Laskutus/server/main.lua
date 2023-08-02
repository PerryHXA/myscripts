ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent('Oku_Laskutus:sendBill')
AddEventHandler('Oku_Laskutus:sendBill', function(playerId, sharedAccountName, label, amount)
	local identifier = GetPlayerIdentifiers(source)[1]
	local xTarget = GetPlayerIdentifiers(playerId)[1]
	amount = math.floor(tonumber(amount))

	if amount > 0 and xTarget then
		TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)
			if account then
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
					['@identifier'] = xTarget,
					['@sender'] = identifier,
					['@target_type'] = 'society',
					['@target'] = sharedAccountName,
					['@label'] = label,
					['@amount'] = amount
				}, function(rowsChanged)
					TriggerClientEvent("vorp:TipBottom", playerId, 'Sait laskun', 5000)
				end)
			end
		end)
	end
end)

ESX.RegisterServerCallback('Oku_Laskutus:getBills', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchAll('SELECT amount, id, label FROM billing WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		cb(result)
	end)
end)

ESX.RegisterServerCallback('Oku_Laskutus:getTargetBills', function(source, cb, target)
	local identifier = GetPlayerIdentifiers(target)[1]

	if identifier then
		MySQL.Async.fetchAll('SELECT amount, id, label FROM billing WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function(result)
			cb(result)
		end)
	else
		cb({})
	end
end)

ESX.RegisterServerCallback('Oku_Laskutus:payBill', function(source, cb, billId)
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter 
	MySQL.Async.fetchAll('SELECT sender, target_type, target, amount FROM billing WHERE id = @id', {
		['@id'] = billId
	}, function(result)
		if result[1] then
			local amount = result[1].amount
			if result[1].target_type == 'society' then
				TriggerEvent('esx_addonaccount:getSharedAccount', result[1].target, function(account)
					if Character.money >= amount then
						MySQL.Async.execute('DELETE FROM billing WHERE id = @id', {
							['@id'] = billId
						}, function(rowsChanged)
							if rowsChanged == 1 then
								Character.removeCurrency(0, amount) -- Remove money 1000 | 0 = money, 1 = gold, 2 = rol
								local account_name = result[1].target
								local Parameters = { ['account_name'] = account_name,['money'] = amount}
								exports.ghmattimysql:execute("UPDATE addon_account_data Set money=money+@money WHERE account_name=@account_name", Parameters)

								TriggerClientEvent("vorp:TipBottom", _source, "Maksoit laskun suurudelta ".. amount, 4000)
							end

							cb()
						end)
					else
						TriggerClientEvent("vorp:TipBottom", _source, "Sinulla ei ole tarpeeksi rahaa maksaaksesi tätä laskua.", 4000)
						cb()
					end
				end)
			end
			
		end
	end)
	
end)