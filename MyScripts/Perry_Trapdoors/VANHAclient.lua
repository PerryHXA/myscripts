local kirjastohylly = false
local kaupantrapdoor = false
local gunsmithtrapdoor = false
local objekti
local open = false


function InitiateOpen(doorname)
	for k, v in pairs(Config.TrapDoors) do
		local door = GetClosestObjectOfType(v.x,v.y, v.z , 5.0, v.objekti, false, false, false) 
		if DoesEntityExist(door) then

			DeleteEntity(door)
		else
			DeleteEntity(door)
		end
	end
	for k, v in pairs(Config.TrapDoors) do
		local propName = v.objekti
		LoadModel(propName)
		v.name = CreateObject(propName, v.x, v.y, v.z, true, true, false) --Creating new doorobjectt
		if not v.trapdoor then
			if not kirjastohylly then
				SetEntityRotation(v.name, 0.0, 0.0, v.closedr, 2, true)
			else
				SetEntityRotation(v.name, 0.0, 0.0, v.openr, 2, true)
			end
			RotateDoors(doorname, v.name)
		else
			if not kirjastohylly then
				SetEntityRotation(v.name, 0.0, 0.0, v.rotation, 0, true)
			else
				SetEntityRotation(v.name, -90.0, 0.0, v.rotation, 0, true)
			end
		end
	end
end

function RotateDoors(name, entity)
	if name == "kirjastohylly" then
		if kirjastohylly == false then
			local value = 93.47
			while true do
				Wait(1)
				value = value + 1
				SetEntityRotation(entity, 0.0, 0.0, value, 2, true)
				if value >= 154.46 then
					open = true
					TriggerServerEvent("Perry_Trapdoor:ChangeState", name)
					break
				end
			end
		else
			local value = 154.46
			while true do
				Wait(1)
				value = value - 1
				SetEntityRotation(entity, 0.0, 0.0, value, 2, true)
				if value <= 93.47 then
					open = false
					TriggerServerEvent("Perry_Trapdoor:ChangeState", name)
					break
				end
			end
		end
	elseif name == "kaupantrapdoor" then
		if kaupantrapdoor == false then
			TriggerServerEvent("Perry_Trapdoor:ChangeState", name)
			SetEntityRotation(entity, 0.0, 0.0, 10.68, 2, true)
		else
			TriggerServerEvent("Perry_Trapdoor:ChangeState", name)
			SetEntityRotation(entity, 0.0, 0.0, 144.68063354492, 2, true)
		end
	elseif name == "gunsmithtrapdoor" then
		if gunsmithtrapdoor == false then
			TriggerServerEvent("Perry_Trapdoor:ChangeState", name)
			SetEntityRotation(entity, -90.0, 0.0, -174.7237701416, 0, true)
		else
			TriggerServerEvent("Perry_Trapdoor:ChangeState", name)
			SetEntityRotation(entity, 0.0, 0.0, -174.7237701416, 0, true)
		end
	elseif name == "rgunsmithtrapdoor" then
		if rgunsmithtrapdoor == false then
			TriggerServerEvent("Perry_Trapdoor:ChangeState", name)
			SetEntityRotation(entity, -90.0, 0.0, -174.7237701416, 0, true)
		else
			TriggerServerEvent("Perry_Trapdoor:ChangeState", name)
			SetEntityRotation(entity, 0.0, 0.0, -174.7237701416, 0, true)
		end
	end

end

RegisterNetEvent("Perry_Trapdoors:AvaaOvi")
AddEventHandler("Perry_Trapdoors:AvaaOvi", function(doori)
	InitiateOpen(doori)
end)

RegisterNetEvent("Perry_Trapdoor:ChangeState")
AddEventHandler("Perry_Trapdoor:ChangeState", function(door)
	if door == "kirjastohylly" then
		if kirjastohylly == true then
			kirjastohylly = false
		else
			kirjastohylly = true
		end
	elseif door == "kaupantrapdoor" then
		if kaupantrapdoor == true then
			kaupantrapdoor = false
		else
			kaupantrapdoor = true
		end
	elseif door == "gunsmithtrapdoor" then
		if gunsmithtrapdoor == true then
			gunsmithtrapdoor = false
		else
			gunsmithtrapdoor = true
		end
	elseif door == "rgunsmithtrapdoor" then
		if rgunsmithtrapdoor == true then
			rgunsmithtrapdoor = false
		else
			rgunsmithtrapdoor = true
		end
	end
end)

LoadModel = function(model)
	while not HasModelLoaded(model) do RequestModel(model) Citizen.Wait(10) end
end