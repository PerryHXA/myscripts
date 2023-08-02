local VorpCore = {}
TriggerEvent("getCore", function(core)
  VorpCore = core
end)

local VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterNetEvent("Perry_kaapit:Reloadkaapit") -- inventory system
AddEventHandler("Perry_kaapit:Reloadkaapit", function(theid)
  local _source = source
  local id = theid
  local Character = VorpCore.getUser(_source).getUsedCharacter
  local charidentifier = Character.charIdentifier
  exports["ghmattimysql"]:execute("SELECT items FROM kaapit WHERE id = @id"
    , { ["@id"] = id}, function(result)
    if result[1].items then
      local items = {}
      local inv = json.decode(result[1].items)
      if not inv then
        items.itemList = {}
        items.action = "setSecondInventoryItems"
        TriggerClientEvent("vorp_inventory:ReloadContainerInventory", _source, json.encode(items))
      else
        items.itemList = inv
        items.action = "setSecondInventoryItems"
        TriggerClientEvent("vorp_inventory:ReloadContainerInventory", _source, json.encode(items))
      end
    end
  end)
end)


local processinguser = {}

function inprocessing(id)
  for k, v in pairs(processinguser) do
    if v == id then
      return true
    end
  end
  return false
end

function trem(id)
  for k, v in pairs(processinguser) do
    if v == id then
      table.remove(processinguser, k)
    end
  end
end

function AnIndexOf(t, val)
  for k, v in ipairs(t) do
    if v == val then return k end
  end
end

function ToInteger(number)
  _source = source
  number = tonumber(number)
  if number then
    if 0 > number then
      number = number * -1
    elseif number == 0 then
      return nil
    end
    return math.floor(number or error("Could not cast '" .. tostring(number) .. "' to number.'"))
  else
    return nil
  end
end

RegisterServerEvent("syn_Container:TakeFromContainer") -- inventory system
AddEventHandler("syn_Container:TakeFromContainer", function(jsonData)
	local _source = source
	if not inprocessing(_source) then
    processinguser[#processinguser + 1] = _source
    local notpass = false
    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local identifier = Character.identifier
    local charidentifier = Character.charIdentifier
    local data = json.decode(jsonData)
    local name = data["Container"]
    local item = data.item
    local itemCount = ToInteger(data["number"])
    local itemType = data.type
    if itemCount and itemCount ~= 0 then
      if item.count < itemCount then
        TriggerClientEvent("vorp:TipBottom", _source, "Invalid", 5000)
        return trem(_source)
      end
    else
      TriggerClientEvent("vorp:TipBottom", _source, "Invalid", 5000)
      return trem(_source)
    end
    if itemType == "item_weapon" then
      TriggerEvent("vorpCore:canCarryWeapons", tonumber(_source), itemCount, function(canCarry)
        if canCarry then
          exports["ghmattimysql"]:execute("SELECT items FROM kaapit WHERE id = @id"
            , { ["@id"] = name}, function(result)
            notpass = true
            if result[1] then
              local items = {}
              local inv = json.decode(result[1].items)
              local foundItem, foundIndex = nil, nil
              for k, v in pairs(inv) do
                if v.name == item.name then
                  foundItem = v
                  if #foundItem > 1 then
                    if k == 1 then
                      foundItem = v
                    end
                  end
                end
              end
              if foundItem then
                local foundIndex2 = AnIndexOf(inv, foundItem)
                foundItem.count = foundItem.count - itemCount
                if 0 >= foundItem.count then
                  table.remove(inv, foundIndex2)
                end
                items.itemList = inv
                items.action = "setSecondInventoryItems"
                local weapId = foundItem.id
                VorpInv.giveWeapon(_source, weapId, 0)
                TriggerClientEvent("vorp_inventory:ReloadContainerInventory", _source, json.encode(items))
                exports["ghmattimysql"]:execute("UPDATE kaapit SET items = @inv WHERE id = @id"
                  , { ["@inv"] = json.encode(inv), ["@id"] = name })

              end
            end
            notpass = false
          end)
          while notpass do
            Wait(500)
          end
        else
          TriggerClientEvent("vorp:TipBottom", _source, "limit", 5000)
        end
      end)
    else
      if itemCount and itemCount ~= 0 then
        if item.count < itemCount then
          TriggerClientEvent("vorp:TipBottom", _source, "invalid", 5000)
          return trem(_source)
        end
      else
        TriggerClientEvent("vorp:TipBottom", _source, "invalid", 5000)
        return trem(_source)
      end
      local count = VorpInv.getItemCount(_source, item.name)

      if (count + itemCount) > item.limit then
        TriggerClientEvent("vorp:TipBottom", _source, "maxlimit", 5000)
        return trem(_source)
      end
      TriggerEvent("vorpCore:canCarryItems", tonumber(_source), itemCount, function(canCarry)
        TriggerEvent("vorpCore:canCarryItem", tonumber(_source), item.name, itemCount, function(canCarry2)
          if canCarry and canCarry2 then
            exports["ghmattimysql"]:execute("SELECT items FROM kaapit WHERE id = @id"
              , { ["@id"] = name }, function(result)
              notpass = true
              if result[1] then
                local items = {}
                local inv = json.decode(result[1].items)
                local foundItem, foundIndex = nil, nil
                for k, v in pairs(inv) do
                  if v.name == item.name then
                    foundItem = v
                  end
                end
                if foundItem then
                  local foundIndex2 = AnIndexOf(inv, foundItem)
                  foundItem.count = foundItem.count - itemCount
                  if 0 >= foundItem.count then
                    table.remove(inv, foundIndex2)
                  end

                  items.itemList = inv
                  items.action = "setSecondInventoryItems"

                  VorpInv.addItem(_source, item.name, itemCount)
                  TriggerClientEvent("vorp_inventory:ReloadContainerInventory", _source, json.encode(items))
                  exports["ghmattimysql"]:execute("UPDATE kaapit SET items = @inv WHERE id = @id"
                    , { ["@inv"] = json.encode(inv), ["@id"] = name })
                end
              end
              notpass = false
            end)
            while notpass do
              Wait(500)
            end
          else
            TriggerClientEvent("vorp:TipBottom", _source, "limit", 5000)
          end
        end)
      end)
    end
    trem(_source)
  end
end)

RegisterServerEvent("syn_Container:MoveToContainer") -- inventory system
AddEventHandler("syn_Container:MoveToContainer", function(jsonData)
	local _source = source
	if not inprocessing(_source) then
		processinguser[#processinguser + 1] = _source
		local notpass = false
		local User = VorpCore.getUser(_source)
		local Character = User.getUsedCharacter
		local identifier = Character.identifier
		local charidentifier = Character.charIdentifier
		local data = json.decode(jsonData)
		local bankName = data["Container"]
		local item = data.item
		local itemCount = ToInteger(data["number"])
		local itemType = data["type"]
		local itemDBCount = 1                    
		exports["ghmattimysql"]:execute("SELECT items FROM kaapit WHERE id = @id", { ["@id"] = bankName }, function(result)
			if result[1].items ~= "[]" then
				local inv = json.decode(result[1].items) 
				for k, v in pairs(inv) do
					if v.name == item.name then
						if itemType == "item_standard" then 
							itemDBCount = v.count + itemCount
						elseif itemType == "item_weapon" then 
							itemDBCount = itemDBCount + itemCount
						end
					end
				end
			else
				itemDBCount = itemCount
			end 
			if itemType ~= "item_weapon" then
				local countin = VorpInv.getItemCount(_source, item.name)
				if itemCount > countin then
					TriggerClientEvent("vorp:TipBottom", _source, "limit", 5000)
					return trem(_source)
				end
			end
			if itemType == "item_weapon" then
				itemCount = 1
				item.count = 1
			end
			if itemCount and itemCount ~= 0 then
				if item.count < itemCount then
					TriggerClientEvent("vorp:TipBottom", _source, "invalid", 5000)
					return trem(_source)
				end
			else
				TriggerClientEvent("vorp:TipBottom", _source, "invalid", 5000)
				return trem(_source)
			end
			exports["ghmattimysql"]:execute("SELECT items FROM kaapit WHERE id = @id", { ["@id"] = bankName }, function(result)
				notpass = true
				if result[1].items then
					local space = 500
					local items = {}
					local countDB = 0
					local inv = json.decode(result[1].items)
					local foundItem = nil
					for _, k in pairs(inv) do
						if k.name == item.name then
							if itemType == "item_standard" then
								foundItem = k
							end
						end
					end
					for _, k in pairs(inv) do
						countDB = countDB + k.count
					end
					countDB = countDB + itemCount
					if countDB > space then
						TriggerClientEvent("vorp:TipBottom", _source, "limit", 5000)
					elseif foundItem then
						foundItem.count = foundItem.count + itemCount
					elseif itemType == "item_standard" then
						foundItem = { name = item.name, count = itemCount, label = item.label, type = item.type, limit = item.limit }
						inv[#inv + 1] = foundItem
					else
						foundItem = { name = item.name, count = itemCount, label = item.label, type = item.type, limit = item.limit, id = item.id }
						inv[#inv + 1] = foundItem
					end
					items.itemList = inv
					items.action = "setSecondInventoryItems"
					if itemType == "item_standard" then
						VorpInv.subItem(_source, item.name, itemCount)
						TriggerClientEvent("vorp:TipBottom", _source, "Laitettu x" .. itemCount .. " " .. item.label, 5000)
					end
					if itemType == "item_weapon" then
						local weapId = item.id
						VorpInv.subWeapon(_source, weapId)
						TriggerClientEvent("vorp:TipBottom", _source, "Laitettu " .. item.label, 5000)
					end
					TriggerClientEvent("vorp_inventory:ReloadBankInventory", _source, json.encode(items))
					exports["ghmattimysql"]:execute("UPDATE kaapit SET items = @inv WHERE id = @id", { ["@inv"] = json.encode(inv), ["@id"] = bankName })
					notpass = false
				end
			end)
			while notpass do
				Wait(500)
			end
			trem(_source)
		end)
	end
end)
	