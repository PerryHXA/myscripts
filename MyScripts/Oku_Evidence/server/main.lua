ESX = nil

local shots = {}
local blood = {}

TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

VORP = exports.vorp_inventory:vorp_inventoryApi()

ESX.RegisterServerCallback(
    "Perry_Evidence:getData",
    function(source, cb)
        cb({shots = shots, blood = blood, time = os.time()})
    end
)

ESX.RegisterServerCallback(
    "Perry_Evidence:getStorageData",
    function(source, cb)
        exports.oxmysql:execute(
            "SELECT * FROM `evidence_storage` WHERE 1",
            {},
            function(reports)
                cb(reports)
            end
        )
    end
)

ESX.RegisterServerCallback("Perry_Evidence:getJobPlayer", function(source, cb)
	local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter 
	local job = Character.job
	local grade = Character.jobGrade
	cb({
		job = job,
		grade = grade
	})
end)

RegisterServerEvent("Perry_Evidence:deleteEvidenceFromStorage")
AddEventHandler(
    "Perry_Evidence:deleteEvidenceFromStorage",
    function(id)
        exports.oxmysql:execute(
            "DELETE FROM `evidence_storage` WHERE id = @id",
            {
                ["@id"] = id
            }
        )
    end
)

RegisterServerEvent("Perry_Evidence:GiveShot")
AddEventHandler("Perry_Evidence:GiveShot", function()
	local _source = source
	local canCarry = VORP.canCarryItem(_source, "emptyshell", 1)
	if canCarry then
		VORP.addItem(_source, "emptyshell", 1)
	end
end)

RegisterServerEvent("Perry_Evidence:addEvidenceToStorage")
AddEventHandler(
    "Perry_Evidence:addEvidenceToStorage",
    function(evidence)
        exports.oxmysql:execute(
            "INSERT INTO `evidence_storage`(`data`) VALUES (@evidence)",
            {
                ["@evidence"] = evidence
            }
        )
    end
)

RegisterServerEvent("Perry_Evidence:removeEverything")
AddEventHandler(
    "Perry_Evidence:removeEverything",
    function()
        for k, v in pairs(blood) do
            if v.interior == 0 then
                blood[k] = nil
            end
        end
        for k, v in pairs(shots) do
            if v.interior == 0 then
                shots[k] = nil
            end
        end
    end
)

RegisterServerEvent("Perry_Evidence:removeBlood")
AddEventHandler(
    "Perry_Evidence:removeBlood",
    function(identifier)
        blood[identifier] = nil
    end
)

RegisterServerEvent("Perry_Evidence:removeShot")
AddEventHandler(
    "Perry_Evidence:removeShot",
    function(identifier)
        shots[identifier] = nil
    end
)

RegisterServerEvent("Perry_Evidence:saveBlood")
AddEventHandler(
    "Perry_Evidence:saveBlood",
    function(coords, interior)
        local src = source
		local User = VORPcore.getUser(src)
		local Character = User.getUsedCharacter 
		local identifier = Character.identifier

        exports.oxmysql:execute(
            "SELECT " .. Config.EvidenceReportInformationBlood .. " FROM `characters` WHERE identifier = @owner LIMIT 1",
            {
                ["@owner"] = identifier
            },
            function(reportInfo)
                local time = os.time()
                blood[time] = {coords = coords, reportInfo = reportInfo[1], interior = interior}
            end
        )
    end
)

RegisterServerEvent("Perry_Evidence:saveShot")
AddEventHandler(
    "Perry_Evidence:saveShot",
    function(coords, bullet, interior)
        local src = source
		local User = VORPcore.getUser(src)
		local Character = User.getUsedCharacter 
		local identifier = Character.identifier

        exports.oxmysql:execute(
            "SELECT " .. Config.EvidenceReportInformationBullet .. " FROM `characters` WHERE identifier = @owner LIMIT 1",
            {
                ["@owner"] = identifier
            },
            function(reportInfo)
                local time = os.time()
                shots[time] = {coords = coords, bullet = bullet, reportInfo = reportInfo[1], interior = interior}
            end
        )
    end
)
