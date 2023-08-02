local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local AccountsIndex, Accounts, SharedAccounts = {}, {}, {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM addon_account')

	for i=1, #result, 1 do
		local name   = result[i].name
		local label  = result[i].label
		local shared = result[i].shared

		local result2 = MySQL.Sync.fetchAll('SELECT * FROM addon_account_data WHERE account_name = @account_name', {
			['@account_name'] = name
		})

		if shared == 0 then
			table.insert(AccountsIndex, name)
			Accounts[name] = {}

			for j=1, #result2, 1 do
				local addonAccount = CreateAddonAccount(name, result2[j].owner, result2[j].money)
				table.insert(Accounts[name], addonAccount)
			end
		else
			local money = nil

			if #result2 == 0 then
				MySQL.Sync.execute('INSERT INTO addon_account_data (account_name, money, owner) VALUES (@account_name, @money, NULL)', {
					['@account_name'] = name,
					['@money']        = 0
				})

				money = 0
			else
				money = result2[1].money
			end

			local addonAccount   = CreateAddonAccount(name, nil, money)
			SharedAccounts[name] = addonAccount
		end
	end
end)

function GetAccount(name, owner)
	for i=1, #Accounts[name], 1 do
		if Accounts[name][i].owner == owner then
			return Accounts[name][i]
		end
	end
end

function GetSharedAccount(name)
	return SharedAccounts[name]
end

AddEventHandler('esx_addonaccount:getAccount', function(name, owner, cb)
	cb(GetAccount(name, owner))
end)

AddEventHandler('esx_addonaccount:getSharedAccount', function(name, cb)
	cb(GetSharedAccount(name))
end)

RegisterServerEvent('Oku_Accounts:PalkkaaPelaaja')
AddEventHandler('Oku_Accounts:PalkkaaPelaaja', function(id, job, grade)
	local _source = source
	local User = VorpCore.getUser(id) -- Return User with functions and all characters
	local Character = User.getUsedCharacter -- Return character selected by user
	if User then
		Character.setJob(job)
		Character.setJobGrade(grade)
		TriggerClientEvent("vorp:TipBottom", _source, 'Palkkasit kansalaisen!', 5000)
		TriggerClientEvent("vorp:TipBottom", id, 'Sinut on palkattu työhön'..job, 5000)
	else
		MySQL.Async.execute('UPDATE characters SET job = @job, jobgrade = @jobgrade WHERE identifier = @identifier', {
			['@job']        = job,
			['@jobgrade']  = grade,
			['@identifier'] = identifier
		}, function(rowsChanged)
			cb()
		end)
	end
end)

RegisterServerEvent('Oku_Accounts:PotkiPelaaja2')
AddEventHandler('Oku_Accounts:PotkiPelaaja2', function(id, job, grade)
	local _source = source
	local User = VorpCore.getUser(id) -- Return User with functions and all characters
	local Character = User.getUsedCharacter -- Return character selected by user
	if User then
		Character.setJob(job)
		Character.setJobGrade(grade)
		TriggerClientEvent("vorp:TipBottom", _source, 'Potkit kansalaisen!', 5000)
		TriggerClientEvent("vorp:TipBottom", id, 'Sait potkut töistä', 5000)
	else
		MySQL.Async.execute('UPDATE characters SET job = @job, jobgrade = @jobgrade WHERE identifier = @identifier', {
			['@job']        = job,
			['@jobgrade']  = grade,
			['@identifier'] = identifier
		}, function(rowsChanged)
			cb()
		end)
	end
end)

RegisterServerEvent('Oku_Accounts:PotkiPelaaja')
AddEventHandler('Oku_Accounts:PotkiPelaaja', function(identifier, charidentifier)
	local _source = source
	local grade = 0
	local job = "unemployed"
	MySQL.Async.execute('UPDATE characters SET job = @job, jobgrade = @jobgrade WHERE identifier = @identifier AND charidentifier = @charidentifier', {
		['@job']        = job,
		['@jobgrade']  = grade,
		['@identifier'] = identifier,
		['@charidentifier'] = charidentifier
	}, function(rowsChanged)
		if rowsChanged then
		else
		end
	end)
end)

ESX.RegisterServerCallback('Oku_Accounts:HaePalkatut', function(source, cb, society)
	local _perm = tonumber(source)
	
	MySQL.Async.fetchAll('SELECT identifier, job, jobgrade, firstname, lastname, charidentifier FROM characters WHERE job = @job ORDER BY jobgrade DESC', {
		['@job'] = society
	}, function (result)
		local employees = {}

		for i=1, #result, 1 do
			table.insert(employees, {
				name       = GetPlayerName(source),
				identifier = result[i].identifier,
				charidentifier = result[i].charidentifier,
				firstname = result[i].firstname,
				lastname = result[i].lastname,
				grade      = result[i].jobgrade
			})
		end

		cb(employees)
	end)
end)

ESX.RegisterServerCallback('Oku_Accounts:HaePelaajat', function(source, cb)
	local _perm = tonumber(source)
	
	local pelaajat = {}
	local players = GetPlayers()
	for _, playerId in ipairs(GetPlayers()) do
		local nimi = GetPlayerName(playerId)
		local id = playerId
		if nimi ~= nil or id ~= nil then
			table.insert(pelaajat, {
				nimi = nimi,
				id = id ,
			})
		end
	end
	cb(pelaajat)
end)

ESX.RegisterServerCallback('Oku_Accounts:Haetilitiedot', function(source, cb, society)
	local src = source
	local identifier = GetPlayerIdentifiers(source)[1]
	local tiliomistus = society

	MySQL.Async.fetchAll('SELECT money FROM addon_account_data WHERE `account_name`=@account_name;', {account_name = tiliomistus}, function(name)
		if name[1]then
			local maara = name[1].money
			cb(maara)
		end
	end)
end)

RegisterServerEvent('Oku_Accounts:Talleta')
AddEventHandler('Oku_Accounts:Talleta', function(maara, society)
	local _source = source
	local amount = tonumber(maara)
	local User = VorpCore.getUser(_source) -- Return User with functions and all characters
	local Character = User.getUsedCharacter -- Return character selected by user
	local tiliomistus = society

	if Character.money <= amount then
		TriggerClientEvent("vorp:TipBottom", _source, "Sinulla ei ole tarpeeksi rahaa", 5000)
	else
		Character.removeCurrency(0, amount) -- Remove money 1000 | 0 = money, 1 = gold, 2 = rol
		MySQL.Async.execute( 'UPDATE addon_account_data SET money = money + @amount WHERE account_name = @account_name', { amount = amount, account_name = tiliomistus })
		TriggerClientEvent("vorp:TipBottom", _source, 'Talletettu tilille '..amount, 5000)
	end
end)

RegisterServerEvent('Oku_Accounts:Nosta')
AddEventHandler('Oku_Accounts:Nosta', function(maara, society)
	local amount = tonumber(maara)
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
				TriggerClientEvent("vorp:TipBottom", _source, 'Nostettu tililtä '..amount, 5000)
			else 
				TriggerClientEvent("vorp:TipBottom", _source, "Firman tilillä ei ole tarpeeksi rahaa", 5000)
			end
		end
	end)
end)

ESX.RegisterServerCallback('Oku_Accounts:HaeTiedotJob', function(source, cb)
	local _source = source
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter 
	local tiedot = {
		job       = Character.job,
		grade = Character.jobGrade
	}
	cb(tiedot)
end)

ESX.RegisterServerCallback('Oku_Accounts:HowMany', function(source, cb, job)
	local players = GetPlayers()
	local jobcount = 0
	for c,b in pairs(players) do
		TriggerEvent("vorp:getCharacter",tonumber(b),function(user)
			if user.job == job then
				jobcount = jobcount + 1
			end
		end)
	end
	cb(jobcount)
end)
