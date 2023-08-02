ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)


RegisterCommand("lvl", function(source, args, rawCommand)
	AvaaLvL()
end)


local opened = false
CreateThread(function()
    while true do
        Wait(1)
        if IsControlJustReleased(0, 0x4F49CC4C) then
            if not opened then
                AvaaLvL()
                opened = true
            else
                opened = false
                MenuData.CloseAll()
            end
        end
    end
end)


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

local function getNextLevelXp(currentXp)
    for i = 1, #XPTable do
        if currentXp < XPTable[i] then
            return XPTable[i]
        end
    end
    return "200,000,000"
end


function AvaaLvL()

	ESX.TriggerServerCallback('Perry_XP:GetLvl', function(level)
        local thievinglvl, thievingxp = level.thieving.lvl, level.thieving.xp
        local huntinglvl, huntingxp = level.hunting.lvl, level.hunting.xp
        local fishinglvl, fishingxp = level.fishing.lvl, level.fishing.xp
        local mininglvl, miningxp = level.mining.lvl, level.mining.xp
        local cookinglvl, cookingxp = level.cooking.lvl, level.cooking.xp
        local herblorelvl, herblorexp = level.herblore.lvl, level.herblore.xp
        local smithinglvl, smithingxp = level.smithing.lvl, level.smithing.xp
        local woodcuttinglvl, woodcuttingxp = level.woodcutting.lvl, level.woodcutting.xp
        local farminglvl, farmingxp = level.farming.lvl, level.farming.xp
        local washinglvl, washingxp = level.washing.lvl, level.farming.xp
        local totallvl = thievinglvl + huntinglvl + fishinglvl  + mininglvl + cookinglvl + herblorelvl + smithinglvl + woodcuttinglvl + farminglvl + washinglvl
		local elements = {
				{label = "Näpistely - " .. thievinglvl.. "/99", desc = 'XP: '..thievingxp..' | Seuraava level: '..(getNextLevelXp(thievingxp) - thievingxp)..'xp', value = ''},
				{label = "Metsästys - ".. huntinglvl.. "/99", desc = 'XP: '..huntingxp..' | Seuraava level: '..(getNextLevelXp(huntingxp) - huntingxp)..'xp', value = ''},
				{label = "Kalastus - ".. fishinglvl.. "/99", desc = 'XP: '..fishingxp..' | Seuraava level: '..(getNextLevelXp(fishingxp) - fishingxp)..'xp', value = ''},
				{label = "Louhinta - ".. mininglvl.. "/99", desc = 'XP: '..miningxp..' | Seuraava level: '..(getNextLevelXp(miningxp) - miningxp)..'xp', value = ''},
				{label = "Ruoanlaitto - ".. cookinglvl.. "/99", desc = 'XP: '..cookingxp..' | Seuraava level: '..(getNextLevelXp(cookingxp) - cookingxp)..'xp', value = ''},
				{label = "Kasvitiede - ".. herblorelvl.. "/99", desc = 'XP: '..herblorexp..' | Seuraava level: '..(getNextLevelXp(herblorexp) - herblorexp)..'xp', value = ''},
				{label = "Metallityö - ".. smithinglvl.. "/99", desc = 'XP: '..smithingxp..' | Seuraava level: '..(getNextLevelXp(smithingxp) - smithingxp)..'xp', value = ''},
				{label = "Puunhakkuu - ".. woodcuttinglvl.. "/99", desc = 'XP: '..woodcuttingxp..' | Seuraava level: '..(getNextLevelXp(woodcuttingxp) - woodcuttingxp)..'xp', value = ''},
				{label = "Viljely - ".. farminglvl.. "/99", desc = 'XP: '..farmingxp..' | Seuraava level: '..(getNextLevelXp(farmingxp) - farmingxp)..'xp', value = ''},
                {label = "Kullanhuudonta - ".. washinglvl.. "/99", desc = 'XP: '..washingxp..' | Seuraava level: '..(getNextLevelXp(washingxp) - washinglvl)..'xp', value = ''},
		}
		MenuData.Open(

			'default', GetCurrentResourceName(), 'perryxp_menu',

			{

				title    = 'Hahmon levelit',

				subtext    = 'Kokonais LVL : [ '..totallvl..' ]',

				align    = 'right',

				elements = elements,

			},

			function(data, menu)
                menu.close()
		end, function(data, menu)
			menu.close()
		end) 
	end)
end
