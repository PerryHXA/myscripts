local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('Perry_Venekauppa:HaeVeneet', function(source, cb)
	print("jee")
    local _source = source
    local User = VorpCore.getUser(_source).getUsedCharacter
    u_identifier = User.identifier
    u_charid = User.charIdentifier

    local Parameters = { ['@identifier'] = u_identifier, ['@charid'] = u_charid }
    exports.ghmattimysql:execute('SELECT * FROM boates WHERE identifier = @identifier AND charid = @charid', Parameters, function(HasBoats)
        if HasBoats[1] then
            local boat = HasBoats[1].boat
			

			cb(HasBoats)
		else
			cb(HasBoats)
        end
    end)
end)

RegisterServerEvent('elrp:buyboat')
AddEventHandler( 'elrp:buyboat', function ( args )

    local _src   = source
    local _price = args['Price']
    local _model = args['Model']
	
	local User = VorpCore.getUser(source).getUsedCharacter
    u_identifier = User.identifier
    u_charid = User.charIdentifier
    u_money = User.money

    if u_money <= _price then
        TriggerClientEvent("vorp:TipBottom", _src, "Sinulla ei ole rahaa!", 3000)
        return
    end

	User.removeCurrency(0, _price)

    local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['boat'] = _model }
    MySQL.Async.execute("INSERT INTO boates ( `identifier`, `charid`, `boat` ) VALUES ( @identifier, @charid, @boat )", Parameters)
	TriggerClientEvent("vorp:TipBottom", _src, "Ostit uuden veneen!", 3000)

end)

RegisterServerEvent( 'elrp:dropboat' )
AddEventHandler( 'elrp:dropboat', function ( )

    local _src = source

    local User = VorpCore.getUser(_src).getUsedCharacter
    u_identifier = User.identifier
    u_charid = User.charIdentifier

    local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid }
    local HasBoates = MySQL.Sync.fetchAll( "SELECT * FROM Boates WHERE identifier = @identifier AND charid = @charid ", Parameters )

    if HasBoates[1] then
        local boat = HasBoates[1].boat
        TriggerClientEvent("elrp:spawnBoat", _src, boat)
    end

end )