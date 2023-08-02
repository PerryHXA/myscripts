local proned = false


RegisterCommand("makaa", function(source, args, rawCommand)
	if not IsPedInAnyVehicle(ped, true) and not IsPedOnMount(ped) and not IsPedFalling(ped) and not IsPedDiving(ped) and not IsPedInCover(ped, false) and not IsEntityInWater(ped) and not Citizen.InvokeNative(0x3AA24CCC0D451379, ped) then
		if proned then
			ClearPedTasks(ped)
			local me = GetEntityCoords(ped)
			SetEntityCoords(ped, me.x, me.y, me.z-0.5)
			proned = false
		elseif not proned then
			RequestAnimDict("mech_crawl@base")
			while not HasAnimDictLoaded("mech_crawl@base") do
				Citizen.Wait(100)
			end
			ClearPedTasksImmediately(ped)
			proned = true
			SetProned()
		end
	end
end)

Citizen.CreateThread( function()
	while true do 
		Citizen.Wait( 1 )
		local ped = PlayerPedId()
		if ( DoesEntityExist( ped ) and not IsPedDeadOrDying( ped ) ) then 
			ProneMovement()
		else
			proned = false
		end
	end
end)

function SetProned()
	ped = PlayerPedId()
	ClearPedTasksImmediately(ped)
	TaskPlayAnimAdvanced(PlayerPedId(), "mech_crawl@base", "onfront_fwd", GetEntityCoords(PlayerPedId()), 0.0, 0.0, GetEntityHeading(PlayerPedId()), 1.0, 1.0, 1.0, 2, 1.0, 0, 0)
end


function ProneMovement()
	if proned then
		ped = PlayerPedId()
		DisableControlAction(0, 0xB2F377E8)
		DisableControlAction(0, 0x8FFC75D6)
		DisableControlAction(0, 0xF3830D8E)
		if IsEntityInWater(ped) then
			ClearPedTasks(ped)
			proned = false
		end
		if IsControlPressed(0, 0x8FD015D8) or IsControlPressed(0, 0xD27782E3) then
			DisablePlayerFiring(ped, true)
		 elseif IsControlJustReleased(0, 0x8FD015D8) or IsControlJustReleased(0, 0xD27782E3) then
		 	DisablePlayerFiring(ped, false)
		 end
		if IsControlJustPressed(0, 0x8FD015D8) and not movefwd then
			movefwd = true
			TaskPlayAnimAdvanced(PlayerPedId(), "mech_crawl@base", "onfront_fwd", GetEntityCoords(PlayerPedId()), 0.0, 0.0, GetEntityHeading(PlayerPedId()), 1.0, 1.0, 1.0, 1, 1.0, 0, 0)
		elseif IsControlJustReleased(0, 0x8FD015D8) and movefwd then
			TaskPlayAnimAdvanced(PlayerPedId(), "mech_crawl@base", "onfront_fwd", GetEntityCoords(PlayerPedId()), 0.0, 0.0, GetEntityHeading(PlayerPedId()), 1.0, 1.0, 1.0, 2, 1.0, 0, 0)
			movefwd = false
		end		
		if IsControlJustPressed(0, 0xD27782E3) and not movebwd then
			movebwd = true
			TaskPlayAnimAdvanced(PlayerPedId(), "mech_crawl@base", "onfront_bwd", GetEntityCoords(PlayerPedId()), 0.0, 0.0, GetEntityHeading(PlayerPedId()), 1.0, 1.0, 1.0, 1, 1.0, 0, 0)
		elseif IsControlJustReleased(0, 0xD27782E3) and movebwd then 
			TaskPlayAnimAdvanced(PlayerPedId(), "mech_crawl@base", "onfront_bwd", GetEntityCoords(PlayerPedId()), 0.0, 0.0, GetEntityHeading(PlayerPedId()), 1.0, 1.0, 1.0, 2, 1.0, 0, 0)
		    movebwd = false
		end
		if IsControlPressed(0, 0x7065027D) then
			SetEntityHeading(ped, GetEntityHeading(ped)+2.0 )
		elseif IsControlPressed(0, 0xB4E465B4) then
			SetEntityHeading(ped, GetEntityHeading(ped)-2.0 )
		end
	end
end
