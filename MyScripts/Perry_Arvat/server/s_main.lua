local ESX = nil 
local players = {}
local totalSumChance = 0

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

CreateThread(function()
  for _,priceInfo in pairs(Config.Prices) do
    totalSumChance = totalSumChance + priceInfo['chance']
  end 
end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("scratch_ticket", function(data)
		local _source = data.source
		TriggerClientEvent("dr-scratching:isActiveCooldown", _source)
	end)
end)

RegisterNetEvent("dr-scratching:handler", function(returncooldown, cooldown)
  local _source = source
  local tempsrc = tonumber(_source)
  local playerName, playerIdentifier = GetPlayerName(_source), GetPlayerIdentifier(_source, 0)
  local count = VorpInv.getItemCount(_source, "scratch_ticket")
  local randomNumber = math.random(1, totalSumChance)
  local add = 0

  if returncooldown then
    if Config.ShowCooldownNotifications then
		TriggerClientEvent("vorp:TipRight", _source, "Et voi käyttää uutta korttia "..cooldown.." sekuntiin", 2000)
    end
    return
  end

  if count >= 1 then
	VorpInv.subItem(_source,"scratch_ticket", 1)
	TriggerClientEvent("vorp_inventory:CloseInv", source)
    TriggerClientEvent("dr-scratching:setCooldown", _source)
    if Config.ShowUsedTicketNotification then
		TriggerClientEvent("vorp:TipRight", _source, "Käytetty", 2000)
    end
  else
	sendWebhook(playerName, playerIdentifier, "somehow used a scratching ticket without having one. Possible cheating attempt.")
    return
  end

  TriggerClientEvent("dr-scratching:startScratchingEmote", _source)

  for key,priceInfo in pairs(Config.Prices) do
    local chance = priceInfo['chance']
    if randomNumber > add and randomNumber <= add + chance then
      local price_is_item = priceInfo['price']['item']['price_is_item']
      local amount = priceInfo['price']['item']['item_amount']
      local price_type, price = nil

      if not price_is_item then
          price = priceInfo['price']['price_money']
          price_type = 'money'
      else 
        price = priceInfo['price']['item']['item_label']
        price_type = 'item'
      end
	  players[tempsrc] = tostring(price)
      TriggerClientEvent("dr-scratching:nuiOpenCard", _source, key, price, amount, price_type)
      return price
    end
    add = add + chance
  end
end)

RegisterNetEvent("dr-scratching:deposit", function(key, price, amount, type)
  local _source = source
  local playerName, playerIdentifier = GetPlayerName(_source), GetPlayerIdentifier(_source, 0)
  local User = VorpCore.getUser(_source) 
  local Character = User.getUsedCharacter 
  local tempsrc = tonumber(_source)
  local giveItem = false
  local giveMoney = false
  local passed = false
  local priceAmount = nil

  if players[tempsrc] ~= tostring(price) then
    sendWebhook(playerName, playerIdentifier, "important", "Player triggered event with a non matching price assigned to name. Assigned price: " .. players[tempsrc] .. " Requested price: " .. tostring(price) .. ". Possible unauthorized event trigger")
    Print(("%s (%s) somehow managed to trigger the deposit event with a non-matching price matching to his/her name. Assigned price: %s - Requested price: %s Possible cheating attempt."):format(resourceName, playerName, playerIdentifier, players[tempsrc], tostring(price)))
    players[tempsrc] = nil
    return
  end

  if type == 'money' then
    local winningAmount = tonumber(price)
    if winningAmount == nil or winningAmount < 0 then
	  sendToDiscord(playerName.." "..playerIdentifier.." IPMORTANT Invalid price provided, provided money price: "..winningAmount, 16711680)
      Print(("%s (%s) Invalid price provided. Possible cheating attempt. Provided price: %s"):format(playerName, playerIdentifier, winningAmount))
      players[tempsrc] = nil
      return
    end
    giveMoney = true
  else
    giveItem = true
  end
  for priceKey,priceInfo in pairs(Config.Prices) do
    if priceKey == key then
      priceAmount = priceInfo["price"]["item"]["item_amount"]
      if Config.ShowResultTicketNotification then
		TriggerClientEvent("vorp:TipRight", _source, priceInfo['message'], 2000)
      end
      if type == 'item' and giveItem == true then
        if tonumber(amount) == priceAmount then
          local price = priceInfo["price"]["item"]["item_name"]
		  VorpInv.addItem(source, price, priceAmount) -- source, itemname, quantity
        else
		  sendToDiscord(playerName.." "..playerIdentifier.. " somehow managed to trigger the deposit event with a non-matching item. Possible cheating attempt.", 16711680)
          players[tempsrc] = nil
          return
        end
      elseif type == 'money' and giveMoney == true then
        if tonumber(amount) == priceAmount then
		  Character.addCurrency(0, price) -- Add money 1000 | 0 = money, 1 = gold, 2 = rol
        else
		  sendToDiscord(playerName.." "..playerIdentifier.. " important ".. "Player managed to trigger deposit event with a non-matching money amount. Possible unauthorized event trigger", 16711680)
          Print(("%s (%s) somehow managed to trigger the deposit event with a non-matching amount. Possible cheating attempt."):format(playerName, playerIdentifier))
          players[tempsrc] = nil
          return
        end
      end
    end
  end
	sendToDiscord(playerName.." "..playerIdentifier.. " ".. type.." "..price.." "..priceAmount, 16711680)
    players[tempsrc] = nil
    return
end)

RegisterNetEvent("dr-scratching:stopScratching", function(price, amount, type)
  local _source = source
  local playerName, playerIdentifier = GetPlayerName(_source), GetPlayerIdentifier(_source, 0)
  local tempsrc = tonumber(_source)

  players[tempsrc] = nil
  return
end)

local DISCORD_WEBHOOK = "webhookmissing"
local DISCORD_NAME = "Arpalogit"
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