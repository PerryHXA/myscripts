ESX             = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VORP = exports.vorp_inventory:vorp_inventoryApi()

local lahella1 = {}
local lahella2 = {}
local osallistuneet = {}
local arvontakesken = false

RegisterServerEvent('esx_ruletti:osallistuminen')
AddEventHandler('esx_ruletti:osallistuminen', function(osallistumismaksu, vari)
	if not arvontakesken then
		local _source = source
		
		local User = VorpCore.getUser(_source) 
		local Character = User.getUsedCharacter 
	
		if Character.money >= osallistumismaksu then
			Character.removeCurrency(0, osallistumismaksu)
			osallistuneet[#osallistuneet+1] = { pelaaja=_source, osallistujanpanos=osallistumismaksu, osallistujanvari=vari }
			TriggerClientEvent("redemrp_notification:start", _source, 'Panos '..osallistumismaksu..' asetettu: '..vari, 5)
			perse = vari
			if vari == 'M' then
				perse = 'mustalle'
			elseif vari == 'P' then
				perse = 'punaiselle'
			elseif vari == 0 or vari == 'V' then
				perse = 'vihreälle'
			else
				perse = 'numerolle '..perse
			end
			TriggerClientEvent('bb-3dme:client:triggerDisplay', -1, source, '* panostaa '..osallistumismaksu..'$ '..perse..' *', "do")
		else
			TriggerClientEvent("vorp:TipRight", _source, 'Sinulla ei ole tarpeeksi käteistä', 5000) 
			TriggerClientEvent('esx:ruletti:epaonnistui', _source)
		end
	else
		TriggerClientEvent("vorp:TipRight", _source, 'Et voi osallistua enää tälle kierrokselle', 5000) 
		TriggerClientEvent('esx:ruletti:epaonnistui', source)
	end
end)

RegisterServerEvent('esx_ruletti:lahella')
AddEventHandler('esx_ruletti:lahella', function()
	if source ~= nil then
		if arvontakesken then
			lahella2[#lahella2+1] = { pelaaja=source }
		else
			lahella1[#lahella1+1] = { pelaaja=source }
		end
	end
end)

function arvonta()

	arvontakesken = true
	local tulos = math.random(0,36)
	
	if lahella1[1] ~= nil then
		for i=1, #lahella1, 1 do
			TriggerClientEvent('esx:ruletti:tulos', lahella1[i].pelaaja, tulos)
        end
	end
	
	SetTimeout(12000, function()
	
		if osallistuneet[1] ~= nil then
			for i=1, #osallistuneet, 1 do
				if osallistuneet[i].osallistujanvari == tulos or osallistuneet[i].osallistujanvari == 'V' and tulos == 0 then
					local User = VorpCore.getUser(osallistuneet[i].pelaaja) 
					local Character = User.getUsedCharacter 
					TriggerClientEvent("vorp:TipRight", osallistuneet[i].pelaaja, 'Voitit '.. osallistuneet[i].osallistujanpanos*10 ..'$', 5000) 
					TriggerClientEvent('bb-3dme:client:triggerDisplay', -1, osallistuneet[i].pelaaja, '* voitti '.. osallistuneet[i].osallistujanpanos*10 ..'$ *', "do")
					Character.addCurrency(0, osallistuneet[i].osallistujanpanos*10) 
					sendToDiscord2('Ruletti',"Pelaaja: " ..GetPlayerName(osallistuneet[i].pelaaja).. " voitti ruletista: "..(osallistuneet[i].osallistujanpanos*10).."$")
				elseif osallistuneet[i].osallistujanvari == 'M' and tulos > 18 or osallistuneet[i].osallistujanvari == 'P' and tulos <= 18 and tulos > 0 then
					local User = VorpCore.getUser(osallistuneet[i].pelaaja) 
					local Character = User.getUsedCharacter 
					TriggerClientEvent("vorp:TipRight", osallistuneet[i].pelaaja, 'Voitit '.. osallistuneet[i].osallistujanpanos*2 ..'$', 5000) 
					TriggerClientEvent('bb-3dme:client:triggerDisplay', -1, osallistuneet[i].pelaaja, '* voitti '.. osallistuneet[i].osallistujanpanos*2 ..'$ *', "do")
					Character.addCurrency(0, osallistuneet[i].osallistujanpanos*2) 
					sendToDiscord2('Ruletti',"Pelaaja: " ..GetPlayerName(osallistuneet[i].pelaaja).. " voitti ruletista: "..(osallistuneet[i].osallistujanpanos*2).."$")			
				else
					TriggerClientEvent("vorp:TipRight", osallistuneet[i].pelaaja, 'Hävisit '..osallistuneet[i].osallistujanpanos..'$', 5000) 
					sendToDiscord2('Ruletti',"Pelaaja: " ..GetPlayerName(osallistuneet[i].pelaaja).. " hävisi rulettiin "..(osallistuneet[i].osallistujanpanos).."$")

				end
			end
		end

		lahella1 = lahella2
		lahella2 = {}
		osallistuneet = {}
		arvontakesken = false
		
		SetTimeout(30000, arvonta)
	
	end)

end

arvonta()

function sendToDiscord2 (name,message,color)
	local DiscordWebHook = "https://discordapp.com/api/webhooks/908879789316788236/G6T2e2kKJw2SCRbhAq2g7AZPO9fhqVy7x5wldXRH5GtKwnCS0nEQswf3klm0aUBwPXTq"
  
	  local embeds = {
		  {
			  ["title"]=message,
			  ["type"]="rich",
			  ["color"] =color,
			  ["footer"]=  {
			  ["text"]= "RULETTI - LOGIT",
		  },
		  }
	  }
  
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
  end