local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('Perry_Kuumapallo:HaePallot', function(source, cb)
    local _source = source
    local User = VorpCore.getUser(source) 
    local Character = User.getUsedCharacter 
	local u_identifier = GetPlayerIdentifiers(source)[1]
	local u_charid = Character.charIdentifier

    local Parameters = { ['@identifier'] = u_identifier, ['@charid'] = u_charid }
    exports.ghmattimysql:execute('SELECT * FROM kuumis WHERE identifier = @identifier AND charid = @charid', Parameters, function(HasPallot)
        if HasPallot[1] then
            local kuumis = HasPallot[1].kuumis
			

			cb(HasPallot)
		else
			cb(HasPallot)
        end
    end)
end)

local function GetKuumikset( Player_ID, Character_ID )
    local OnKuumis = MySQL.Sync.fetchAll( "SELECT * FROM kuumis WHERE identifier = @identifier AND charid = @charid ", {
        ['identifier'] = Player_ID,
        ['charid'] = Character_ID
    } )
    if #OnKuumis > 0 then return true end
    return false
end

RegisterServerEvent('Perry_Kuumailmapallo:Vuokraakuumis')
AddEventHandler( 'Perry_Kuumailmapallo:Vuokraakuumis', function ( args )

    local _src   = source
    local _price = args['Vuokra']
    local _model = args['Model']
	
    local User = VorpCore.getUser(source) 
    local Character = User.getUsedCharacter 

	local u_money = Character.money
	
	local count = VorpInv.getItemCount(source, "kuumalipuke")
	
	if count >= 1 then
		VorpInv.subItem(_source, "kuumalipuke", 1)
		TriggerClientEvent("vorp:TipBottom", _src, "Käytit kuumailmapallo lipukkeen!", 5000) -- from server side
		TriggerClientEvent('Perry_Kuumailmapallo:SpawnaaPallo',_src, _model)
	else
		if u_money <= _price then
			TriggerClientEvent("vorp:TipBottom", _src, "Sinulla ei ole rahaa!", 5000) -- from server side
		else
			Character.removeCurrency(0, _price)
			TriggerClientEvent("vorp:TipBottom", _src, "Vuokrasit kuumailmapallon!", 5000) -- from server side
			print("tämme")
			TriggerClientEvent('Perry_Kuumailmapallo:SpawnaaPallo', _src, _model)
		end

	end
end)

RegisterServerEvent('Perry_Kuumailmapallo:OstaKuumis')
AddEventHandler( 'Perry_Kuumailmapallo:OstaKuumis', function ( args )

    local _src   = source
    local _price = args['Price']
    local _model = args['Model']
	
    local User = VorpCore.getUser(source) 
    local Character = User.getUsedCharacter 

	local u_identifier = GetPlayerIdentifiers(source)[1]
	local u_charid = Character.charIdentifier
	local u_money = Character.money

    local _resul = GetKuumikset( u_identifier, u_charid )

    if u_money <= _price then
		TriggerClientEvent("vorp:TipBottom", _src, "Sinulla ei ole rahaa!", 5000) -- from server side
        return
    end

	Character.removeCurrency(0, _price)

		
    if _resul ~= true then
        local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['kuumis'] = _model }
        MySQL.Async.execute("INSERT INTO kuumis ( `identifier`, `charid`, `kuumis` ) VALUES ( @identifier, @charid, @kuumis )", Parameters)
		TriggerClientEvent("vorp:TipBottom", _src, "Ostit kuumailmapallon!", 5000) -- from server side
    else
        local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['kuumis'] = _model }
        MySQL.Async.execute(" UPDATE kuumis SET kuumis = @kuumis WHERE identifier = @identifier AND charid = @charid ", Parameters)
		TriggerClientEvent("vorp:TipBottom", _src, "Ostit kuumailmapallon!", 5000) -- from server side
    end

end)
