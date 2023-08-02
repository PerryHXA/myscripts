ESX = nil

local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Leveltable = {
	['fishing'] = {xp = 0, lvl = 1, label = 'Kalastus'},
	['woodcutting'] = {xp = 0, lvl = 1, label = 'Puunhakkuu'},
	['crafting'] = {xp = 0, lvl = 1, label = 'Käsityö'},
	['farming'] = {xp = 0, lvl = 1, label = 'Viljely'},
	['mining'] = {xp = 0, lvl = 1, label = 'Louhinta'},
	['thieving'] = {xp = 0, lvl = 1, label = 'Näpistely'},
	['herblore'] = {xp = 0, lvl = 1, label = 'Kasvitiede'},
	['smithing'] = {xp = 0, lvl = 1, label = 'Metallityö'},
	['hunting'] = {xp = 0, lvl = 1, label = 'Metsästys'},
	['cooking'] = {xp = 0, lvl = 1, label = 'Ruoanlaitto'},
    ['washing'] = {xp = 0, lvl = 1, label = 'Huuhdonta'},
   -- ['slayer'] = {xp = 0, lvl = 1, label = 'Lahtaus'},
}

local XPTable = {
    [1] = 83,
    [2] = 174,
    [3] = 276,
    [4] = 388,
    [5] = 512,
    [6] = 650,
    [7] = 801,
    [8] = 969,
    [9] = 1154,
    [10] = 1358,
    [11] = 1584,
    [12] = 1833,
    [13] = 2107,
    [14] = 2411,
    [15] = 2746,
    [16] = 3115,
    [17] = 3523,
    [18] = 3973,
    [19] = 4470,
    [20] = 5018,
    [21] = 5624,
    [22] = 6291,
    [23] = 7028,
    [24] = 7842,
    [25] = 8740,
    [26] = 9730,
    [27] = 10824,
    [28] = 12031,
    [29] = 13363,
    [30] = 14833,
    [31] = 16456,
    [32] = 18247,
    [33] = 20224,
    [34] = 22406,
    [35] = 24815,
    [36] = 27473,
    [37] = 30408,
    [38] = 33648,
    [39] = 37224,
    [40] = 41171,
    [41] = 45529,
    [42] = 50339,
    [43] = 55649,
    [44] = 61512,
    [45] = 67983,
    [46] = 75127,
    [47] = 83014,
    [48] = 91721,
    [49] = 101333,
    [50] = 111945,
    [51] = 123660,
    [52] = 136594,
    [53] = 150872,
    [54] = 166636,
    [55] = 184040,
    [56] = 203254,
    [57] = 224466,
    [58] = 247886,
    [59] = 273742,
    [60] = 302288,
    [61] = 333804,
    [62] = 368599,
    [63] = 407015,
    [64] = 449428,
    [65] = 496254,
    [66] = 547953,
    [67] = 605032,
    [68] = 668051,
    [69] = 737627,
    [70] = 814445,
    [71] = 899257,
    [72] = 992895,
    [73] = 1096278,
    [74] = 1210421,
    [75] = 1336443,
    [76] = 1475581,
    [77] = 1629200,
    [78] = 1798808,
    [79] = 1986068,
    [80] = 2192818,
    [81] = 2421087,
    [82] = 2673114,
    [83] = 2951373,
    [84] = 3258594,
    [85] = 3597792,
    [86] = 3972294,
    [87] = 4385776,
    [88] = 4842295,
    [89] = 5346332,
    [90] = 5902831,
    [91] = 6517253,
    [92] = 7195629,
    [93] = 7944614,
    [94] = 8771558,
    [95] = 9684577,
    [96] = 10692629,
    [97] = 11805606,
    [98] = 13034431,
    [99] = 14391160,
}

local function getLevelFromXp(xp)
    for i = 1, #XPTable do
        if xp < XPTable[i] then
            return i - 1, XPTable[i - 1]
        end
    end
    return #XPTable, XPTable[#XPTable]
end

local function getNextLevelXp(currentXp)
    for i = 1, #XPTable do
        if currentXp < XPTable[i] then
            return XPTable[i]
        end
    end
    return "200,000,000"
end

--[[
ESX.RegisterServerCallback('Perry_XP:GetLvl', function(source, cb)
	local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charidentifier = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT level FROM characters WHERE identifier = @identifier  AND charidentifier = @charidentifier ' , {
		['identifier'] = identifier, 
		['charidentifier'] = charidentifier
	}, function(result)
        if result[1] ~= nil then 
            local levels = json.decode(result[1].level)
			cb(levels)
        end
    end)
end)]]

ESX.RegisterServerCallback('Perry_XP:GetLvl', function(source, cb)
	local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charidentifier = Character.charIdentifier
	
	exports.ghmattimysql:execute('SELECT level FROM characters WHERE identifier = @identifier AND charidentifier = @charidentifier' , {
		['identifier'] = identifier, 
		['charidentifier'] = charidentifier
	}, function(result)
        if result[1] ~= nil then 
            local levels = json.decode(result[1].level)
			
			-- Löytyi leveleitä, tsekataan onko lisätty uusia tableen
			for level, data in pairs(Leveltable) do
				if not levels[level] then
					-- Pelaajalta löytyi puuttuva leveli, luodaan se 
					levels[level] = {xp = data.xp, lvl = data.lvl, label = data.label}
					exports.ghmattimysql:execute('UPDATE characters SET level = @level WHERE identifier = @identifier AND charidentifier = @charidentifier', {
						['identifier'] = identifier,
						['charidentifier'] = charidentifier,
						['level'] = json.encode(levels)
					})
				end
			end
			
			cb(levels)
        else
			-- Pelaajalla ei mitään dataa leveleistä, luodaan ne nyt
			local levels = {}
			for level, data in pairs(Leveltable) do
				levels[level] = {xp = data.xp, lvl = data.lvl, label = data.label}
			end
			
			exports.ghmattimysql:execute('UPDATE characters SET level = @level WHERE identifier = @identifier AND charidentifier = @charidentifier', {
				['identifier'] = identifier,
				['charidentifier'] = charidentifier,
				['level'] = json.encode(levels)
			})
			
			cb(levels)
		end
    end)
end)

RegisterServerEvent('Perry_XP:AnnaServerXP')
AddEventHandler('Perry_XP:AnnaServerXP', function(src, levelname, addxp)
	TriggerEvent('Perry_XP:AnnaXP', levelname, addxp, src)
end)

RegisterServerEvent('Perry_XP:AnnaXP')
AddEventHandler('Perry_XP:AnnaXP', function(levelname, addXP, alts)
    local _source
    if alts then
        _source = alts
    else
        _source = source
    end
    local User = VORPcore.getUser(_source)
    local Character = User.getUsedCharacter
    local identifier = Character.identifier
    local charidentifier = Character.charIdentifier
    local maxXP = 200000000 -- maximum XP value
    exports.ghmattimysql:execute('SELECT level FROM characters WHERE identifier = @identifier AND charidentifier = @charidentifier' , {
        ['identifier'] = identifier, 
        ['charidentifier'] = charidentifier
    }, function(result)
        if result[1].level ~= nil then 
            local levels = json.decode(result[1].level)

            --Checking for new levels--
			for level, data in pairs(Leveltable) do
				if not levels[level] then
					levels[level] = {xp = data.xp, lvl = data.lvl, label = data.label}
					exports.ghmattimysql:execute('UPDATE characters SET level = @level WHERE identifier = @identifier AND charidentifier = @charidentifier', {
						['identifier'] = identifier,
						['charidentifier'] = charidentifier,
						['level'] = json.encode(levels)
					})
				end
			end

            local currentXP = levels[levelname].xp or 0
            local nextLevelXP = getNextLevelXp(currentXP)
            local newXP = currentXP + addXP
            -- Tsekataan jos on max XP ettei koodi liiku eteenpäin
            if newXP >= maxXP then
				return
            end				
            local xptext = levels[levelname].label.. ' +'..addXP..'xp'
            TriggerClientEvent('vorp:ShowBottomRight',_source, xptext, 3000)
            levels[levelname].xp = newXP --// Lisätään uudet XP:t vanhojen päälle

            local newLevel, nextLevelXP = getLevelFromXp(newXP) --// Haetaan levelit ja tsekataan jos level-uppaa
            if newLevel ~= levels[levelname].lvl then --Level up
				local text = levels[levelname].label..' taso nousi: '..levels[levelname].lvl.. ' > '..newLevel
				local duration = 4000
				TriggerClientEvent('vorp:ShowBottomRight',_source, text, duration)
                levels[levelname].lvl = newLevel
            end
			
            exports.ghmattimysql:execute('UPDATE characters SET level = @level WHERE identifier = @identifier AND charidentifier = @charidentifier', {
                ['identifier'] = identifier,
                ['charidentifier'] = charidentifier,
                ['level'] = json.encode(levels)
            })
        
        end
    end)

end)


exports('GetLVL', function(source)
	local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charidentifier = Character.charIdentifier
	local levels = {}
	exports.ghmattimysql:execute('SELECT level FROM characters WHERE identifier = @identifier AND charidentifier = @charidentifier' , {
		['identifier'] = identifier, 
		['charidentifier'] = charidentifier
	}, function(result)
        if result[1] ~= nil then 
            levels = json.decode(result[1].level)
			
			-- Löytyi leveleitä, tsekataan onko lisätty uusia tableen
			for level, data in pairs(Leveltable) do
				if not levels[level] then
					-- Pelaajalta löytyi puuttuva leveli, luodaan se 
					levels[level] = {xp = data.xp, lvl = data.lvl, label = data.label}
					exports.ghmattimysql:execute('UPDATE characters SET level = @level WHERE identifier = @identifier AND charidentifier = @charidentifier', {
						['identifier'] = identifier,
						['charidentifier'] = charidentifier,
						['level'] = json.encode(levels)
					})
				end
			end
        else
			-- Pelaajalla ei mitään dataa leveleistä, luodaan ne nyt
			levels = {}
			for level, data in pairs(Leveltable) do
				levels[level] = {xp = data.xp, lvl = data.lvl, label = data.label}
			end
			
			exports.ghmattimysql:execute('UPDATE characters SET level = @level WHERE identifier = @identifier AND charidentifier = @charidentifier', {
				['identifier'] = identifier,
				['charidentifier'] = charidentifier,
				['level'] = json.encode(levels)
			})
		end
    end)
    Wait(1000)
    return levels
end)
--[[
RegisterServerEvent('Perry_XP:AnnaXP')
AddEventHandler('Perry_XP:AnnaXP', function(levelname, xp)
    local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charidentifier = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT level FROM characters WHERE identifier = @identifier  AND charidentifier = @charidentifier ' , {['identifier'] = identifier, ['charidentifier'] = charidentifier}, function(result)
        if result[1] ~= nil then 
            local levels = json.decode(result[1].level)
			levels[name] = levels[name] + xp
			local language = Config.language[name]
			exports.ghmattimysql:execute("UPDATE characters Set level=@level WHERE identifier = @identifier  AND charidentifier = @charidentifier", { ['identifier'] = identifier, ['charidentifier'] = charidentifier, ['level'] = json.encode(levels) })
			local ekalvl = GetLvl(levels[name])
			local tokalvl = GetLvl(levels[name]+xp)
			if ekalvl >= tokalvl then
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = "Levelisi nousi LVL: "..tokalvl  }) 
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = ""..language.." "..xp.."XP"  }) 
			end
        end
    end)
end)]]
