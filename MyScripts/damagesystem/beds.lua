local ESX = exports['vorp_core']:GetObj()
local getOutDict = 'script_re@campfire_massacre'
local getOutAnim = 'cry_getup_man'
local walkHealthDict = 'arthur_healthy'
local walkHealthAnim = 'default'
local canLeaveBed = true
local bedOccupying = nil
local bedObject = nil
local bedOccupyingData = nil
local closestBed = nil
local doctorCount = 0
local CurrentDamageList = {}
inBedDict = "script_common@dead@male"
inBedAnim = "faceup_01"
isInHospitalBed = false
isBleeding = 0
bleedTickTimer, advanceBleedTimer = 0, 0
fadeOutTimer, blackoutTimer = 0, 0
legCount = 0
armcount = 0
headCount = 0
playerHealth = nil
isDead = false
isStatusChecking = false
statusChecks = {}
statusCheckTime = 0
isHealingPerson = false
injured = {}

local function GetAvailableBed(bedId)
    local pos = GetEntityCoords(PlayerPedId())
    local retval = nil
    if bedId == nil then
        for k, v in pairs(Config.Locations['beds']) do
            if not Config.Locations['beds'][k].taken then
                if #(pos - vector3(Config.Locations['beds'][k].coords.x, Config.Locations['beds'][k].coords.y, Config.Locations['beds'][k].coords.z)) < 500 then
                        retval = k
                end
            end
        end
    else
        if not Config.Locations['beds'][bedId].taken then
            if #(pos - vector3(Config.Locations['beds'][bedId].coords.x, Config.Locations['beds'][bedId].coords.y, Config.Locations['beds'][bedId].coords.z))  < 500 then
                retval = bedId
            end
        end
    end
    return retval
end

function SetClosestBed()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for k, v in pairs(Config.Locations['beds']) do
        local dist2 = #(pos - vector3(Config.Locations['beds'][k].coords.x, Config.Locations['beds'][k].coords.y, Config.Locations['beds'][k].coords.z))
        if current then
            if dist2 < dist then
                current = k
                dist = dist2
            end
        else
            dist = dist2
            current = k
        end
    end
    if current ~= closestBed and not isInHospitalBed then
        closestBed = current
    end
end

local function loadAnimDict(dict)
	while(not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Wait(1)
	end
end

local function SetBedCam()
    print('setbedcam')
    isInHospitalBed = true
    canLeaveBed = false
    local player = PlayerPedId()

    DoScreenFadeOut(1000)

    while not IsScreenFadedOut() do
        Wait(100)
    end

	if IsPedDeadOrDying(player) then
		local pos = GetEntityCoords(player, true)
		NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
    end

    bedObject = GetClosestObjectOfType(bedOccupyingData.coords.x, bedOccupyingData.coords.y, bedOccupyingData.coords.z, 1.0, bedOccupyingData.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(player, bedOccupyingData.coords.x, bedOccupyingData.coords.y, bedOccupyingData.coords.z + 0.47)
    SetEntityInvincible(PlayerPedId(), true)
    Wait(500)
    FreezeEntityPosition(player, true)

    loadAnimDict(inBedDict)

    TaskPlayAnim(player, inBedDict , inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
    SetEntityHeading(player, bedOccupyingData.coords.w)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, player, 31085, 0, 1.0, 1.0 , true)
    SetCamFov(cam, 90.0)
    local heading = GetEntityHeading(player)
    heading = (heading > 180) and heading - 180 or heading + 180
    SetCamRot(cam, -45.0, 0.0, heading, 2)

    DoScreenFadeIn(1000)

    Wait(1000)
    FreezeEntityPosition(player, true)
end

local function LeaveBed()
    local player = PlayerPedId()

    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Wait(0)
    end

    FreezeEntityPosition(player, false)
    SetEntityInvincible(player, false)
    SetEntityHeading(player, bedOccupyingData.coords.w - 90)
    TaskPlayAnim(player, getOutDict , getOutAnim, 100.0, 1.0, -1, 8, -1, 0, 0, 0)
    Wait(4000)
    ClearPedTasks(player)
    TriggerServerEvent('hospital:server:LeaveBed', bedOccupying)
    FreezeEntityPosition(bedObject, true)
    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    bedOccupying = nil
    bedObject = nil
    bedOccupyingData = nil
    isInHospitalBed = false
end

local function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)

    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

CreateThread(function()
    while true do
        Wait(1000)
        SetClosestBed()
    end
end)

CreateThread(function()
    for k, v in pairs(Config.Locations['stations']) do
        local AmbulanceBlip = N_0x554d9d53f696d002(1664425300, v.coords)
        SetBlipSprite(AmbulanceBlip, 3599598875, 52)
        SetBlipScale(AmbulanceBlip, 0.2)
        Citizen.InvokeNative(0x662D364ABF16DE2F, AmbulanceBlip, `BLIP_MODIFIER_MP_COLOR_2`)
        Citizen.InvokeNative(0x9CB1A1623062F402, tonumber(AmbulanceBlip), v.label)
    end
end)


--vector3(Config.Locations["beds"][k].coords.x, Config.Locations["beds"][k].coords.y, Config.Locations["beds"][k].coords.z), Config.PromptKey

CreateThread(function()
    while true do
        sleep = 1000
        if IsPedDeadOrDying(PlayerPedId()) then
            local pos = GetEntityCoords(PlayerPedId())
            for k,v in pairs(Config.Locations['beds']) do
                sleep = 1
                local dist2 = #(pos - vector3(Config.Locations['beds'][k].coords.x, Config.Locations['beds'][k].coords.y, Config.Locations['beds'][k].coords.z))
                if dist2 <= 2.6 then
                    DrawTxt('~COLOR_GREEN~E~COLOR_WHITE~ - Mene sängylle', 0.50, 0.80, 0.5, 0.5, true, 255, 0, 0, 200, true)
                    if IsControlJustReleased(0, 0xCEFD9220) or IsDisabledControlJustReleased(0, 0xCEFD9220) then
                        print('Halo')
                        TriggerEvent('ambulance:client:promptBed')
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('ambulance:client:promptBed',function()
    if GetAvailableBed(closestBed) then
        if not IsPedDeadOrDying(PlayerPedId()) then
            TriggerServerEvent("hospital:server:SendToBed", closestBed, true)
        elseif IsPedDeadOrDying(PlayerPedId()) then
            if doctorCount < 1 then
                TriggerServerEvent("hospital:server:SendToBed", closestBed, true, true, 40)
            else
                print('Tohtoreita löytyy')
                ESX.Notify(5, 'Tohtoreita on paikalla, huuda apua!')
            end
        end
    else
        ESX.Notify('Kaikki sängyt viety')
    end
end)


RegisterNetEvent('hospital:client:Revive', function()
    local player = PlayerPedId()
    if IsEntityDead(player) or IsPedDeadOrDying(player) then
        local pos = GetEntityCoords(player, true)
        NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
        isDead = false
        SetEntityInvincible(player, false)
        ClearPedTasks(player)
    end

    if isInHospitalBed then
        loadAnimDict(inBedDict)
        TaskPlayAnim(player, inBedDict , inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
        SetEntityInvincible(player, true)
        canLeaveBed = true
    end

    SetEntityMaxHealth(player, 600)
    SetEntityHealth(player, GetEntityMaxHealth(player))
    Citizen.InvokeNative(0xC6258F41D86676E0,PlayerPedId(), 0, 600)
    ClearPedBloodDamage(player)
    TriggerServerEvent('resetPomade')
    SetPedConfigFlag(PlayerPedId(), 140, true)
    SetPedConfigFlag(PlayerPedId(), 141, true)
    SetPedConfigFlag(PlayerPedId(), 142, true)
    SetPedConfigFlag(PlayerPedId(), 143, true)
    SetPedConfigFlag(PlayerPedId(), 144, true)
    ExecuteCommand('ressu')
end)

RegisterNetEvent('beds:playerDropped', function()
    if bedOccupying then
        TriggerServerEvent("hospital:server:LeaveBed", bedOccupying)
    end
end)

RegisterNetEvent('hospital:client:SendToBed', function(id, data, isRevive)
    bedOccupying = id
    bedOccupyingData = data
    SetBedCam()
    CreateThread(function ()
        Wait(5)
        if isRevive then
            ESX.Notify('Hoidetaan')
            Wait(7 * 1000)
            TriggerEvent("hospital:client:Revive")
        else
            canLeaveBed = true
        end
    end)
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    --SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end

CreateThread(function()
    while true do
        sleep = 1000
        if isInHospitalBed and canLeaveBed then
            sleep = 0
            local pos = GetEntityCoords(PlayerPedId())
            DrawTxt('~COLOR_GREEN~E~COLOR_WHITE~ - Lähde sängystä', 0.50, 0.80, 0.5, 0.5, true, 255, 0, 0, 200, true)
            if IsControlJustPressed(0, 0xCEFD9220) --[[E]]then
                LeaveBed()
            end
            if isInHospitalBed then
                if not IsEntityPlayingAnim(ped, inBedDict, inBedAnim, 3) then
                    loadAnimDict(inBedDict)
                    TaskPlayAnim(ped, inBedDict, inBedAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                end
            else
                if not IsEntityPlayingAnim(ped, deadAnimDict, deadAnim, 3) then
                    loadAnimDict(deadAnimDict)
                    TaskPlayAnim(ped, deadAnimDict, deadAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('hospital:client:SetBed', function(id, isTaken)
    Config.Locations['beds'][id].taken = isTaken
end)


RegisterNetEvent('hospital:client:SetDoctorCount', function(amount)
    doctorCount = amount
end)

--[[
RegisterNetEvent('vorp:SelectedCharacter', function()
    createAmbuPrompts()
end)

function createAmbuPrompts()

    for k, v in pairs(Config.Locations["beds"]) do
        if not IsPedDeadOrDying(PlayerPedId()) then
            exports['vorp_core']:createPrompt("ambulance:bed:"..k, vector3(Config.Locations["beds"][k].coords.x, Config.Locations["beds"][k].coords.y, Config.Locations["beds"][k].coords.z), Config.PromptKey, 'Mene sängylle: '..Config.BillCost..'$', {
                type = 'client',
                event = 'ambulance:client:promptBed',
            })
        else
            exports['vorp_core']:createPrompt("ambulance:bed:"..k, vector3(Config.Locations["beds"][k].coords.x, Config.Locations["beds"][k].coords.y, Config.Locations["beds"][k].coords.z), Config.PromptKey, 'Mene sängylle: '..Config.BillCost..'$', {
                type = 'client',
                event = 'ambulance:client:promptBed',
            })
        end
    end
end]]