local flipped = false

RegisterNetEvent("Perry_Tarot:KatsoKortti")
AddEventHandler("Perry_Tarot:KatsoKortti", function(kortti)
    local propEntity = CreateObject(GetHashKey(kortti), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    local task = TaskItemInteraction_2(PlayerPedId(), 1326880085, propEntity, GetHashKey('PrimaryItem'), GetHashKey('CIGARETTE_CARD_W6-5_H10-7_SINGLE_BASE'), 1, 0, -1.0)
	
	
	while true do
		Citizen.Wait(1)
		if IsControlJustReleased(0, 0x3B24C470) then
			Citizen.Wait(500)
			local task = TaskItemInteraction_2(PlayerPedId(), 1326880085, propEntity, GetHashKey('PrimaryItem'), GetHashKey('CIGARETTE_CARD_W6-5_H10-7_SINGLE_HOLSTER'), 1, 0, -1.0)
			DeleteEntity(propEntity)
			--[[
		elseif IsControlJustReleased(0, 0x760A9C6F) then
			print("jee")
			Citizen.Wait(1000)
			if not flipped then
				print("flippaa")
				flipped = true
				local task = TaskItemInteraction_2(PlayerPedId(), 1326880085, propEntity, GetHashKey('PrimaryItem'), GetHashKey('CIGARETTE_CARD_W6-5_H10-7_INSPECT_ONLY_FLIP_TO_BACK'), 1, 0, -1.0)
			else
				print("takas")
				flipped = false
				local task = TaskItemInteraction_2(PlayerPedId(), 1326880085, propEntity, GetHashKey('PrimaryItem'), GetHashKey('CIGARETTE_CARD_W6-5_H10-7_SINGLE_BASE'), 1, 0, -1.0)
			end
			--]]
		end
	end
end)