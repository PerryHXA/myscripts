local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Perry_Saluuna:HaeTiedotJob', function(source, cb)
	local _source = source
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter 
	local tiedot = {
		job       = Character.job,
		grade = Character.jobGrade
	}
	cb(tiedot)
end)

RegisterServerEvent('Perry_Saluuna:PoistaTuote')
AddEventHandler('Perry_Saluuna:PoistaTuote', function(pullo)
	TriggerClientEvent("Perry_Saluuna:PoistaTuoteClient", -1, pullo)
end)

RegisterServerEvent('Perry_Saluuna:PoistaTuote2')
AddEventHandler('Perry_Saluuna:PoistaTuote2', function(lautanen, paaruoka, sivuruoka, sivuruoka2)
	TriggerClientEvent("Perry_Saluuna:PoistaTuoteClient2", -1, lautanen, paaruoka, sivuruoka, sivuruoka2)
end)

RegisterServerEvent('Perry_Saluuna:Serverilletuotteet')
AddEventHandler('Perry_Saluuna:Serverilletuotteet', function(PropHash, x, y, z)
	TriggerClientEvent("Perry_Saluuna:ClientTuotteet", -1, PropHash, x, y, z)
end)

RegisterServerEvent('Perry_Saluuna:Serverilletuotteet2')
AddEventHandler('Perry_Saluuna:Serverilletuotteet2', function(PropHash, plate, main, side, side2, x, y, z)
	TriggerClientEvent("Perry_Saluuna:ClientTuotteet2", -1, PropHash, plate, main, side, side2, x, y, z)
end)

RegisterServerEvent('Perry_Saluuna:Talleta')
AddEventHandler('Perry_Saluuna:Talleta', function(amount, society)
	local _source = source
	local User = VorpCore.getUser(_source) -- Return User with functions and all characters
	local Character = User.getUsedCharacter -- Return character selected by user
	local tiliomistus = society

	if Character.money <= amount then
		TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarpeeksi rahaa", 5000)
	else
		Character.removeCurrency(0, amount) -- Remove money 1000 | 0 = money, 1 = gold, 2 = rol
		MySQL.Async.execute( 'UPDATE addon_account_data SET money = money + @amount WHERE account_name = @account_name', { amount = amount, account_name = tiliomistus })
		TriggerClientEvent("vorp:TipRight", _source, 'Talletettu tilille '..amount, 5000)
	end
	
end)

ESX.RegisterServerCallback('Perry_Saluuna:Haetilitiedot', function(source, cb, society)
	local src = source
	local identifier = GetPlayerIdentifiers(source)[1]
	local tiliomistus = "society_saluuna"

	MySQL.Async.fetchAll('SELECT money FROM addon_account_data WHERE `account_name`=@account_name;', {account_name = tiliomistus}, function(name)
		if name[1]then
			local maara = name[1].money
			cb(maara)
		end
	end)
end)

RegisterServerEvent('Perry_Saluuna:Nosta')
AddEventHandler('Perry_Saluuna:Nosta', function(amount, society)
	local _source = source
	local User = VorpCore.getUser(_source) -- Return User with functions and all characters
	local Character = User.getUsedCharacter -- Return character selected by user
	local tiliomistus = society
	MySQL.Async.fetchAll('SELECT money FROM addon_account_data WHERE `account_name`=@account_name;', {account_name = tiliomistus}, function(name)
		if name[1]then
			local maara = name[1].money
			if maara >= amount then
				Character.addCurrency(0, amount) -- Add money 1000 | 0 = money, 1 = gold, 2 = rol
				MySQL.Async.execute( 'UPDATE addon_account_data SET money = money - @amount WHERE account_name = @account_name', { amount = amount, account_name = tiliomistus })
				TriggerClientEvent("vorp:TipRight", _source, 'Nostettu tililtä '..amount, 5000)
			else 
				TriggerClientEvent("vorp:TipRight", _source, "Firman tilillä ei ole tarpeeksi rahaa", 5000)
			end
		end
	end)
end)