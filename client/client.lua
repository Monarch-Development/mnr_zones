local zones = lib.load("config.config")

local function CreateZone(name, data)
    local zone = nil
    if data.zoneShape == "poly" then
        zone = lib.zones.poly({
            points = data.points,
            thickness = data.height,
            debug = data.debug,
        })
    elseif data.zoneShape == "box" then
        zone = lib.zones.box({
            coords = vec3(data.coords.x, data.coords.y, data.coords.z),
            size = data.size,
            rotation = data.coords.w,
            debug = data.debug,
        })
    elseif data.zoneShape == "sphere" then
        zone = lib.zones.sphere({
            coords = vec3(data.coords.x, data.coords.y, data.coords.z),
            radius = data.radius,
            debug = data.debug,
        })
    end

    if not zone then
        print(("^1[ERROR: mnr_zones] Error creating zone: %s^0"):format(name))
        return
    end

    local function ToggleEffects(status)
        client.Notify(status and locale("notify.enter") or locale("notify.exit"), "info")

        local playerPed = cache.ped or PlayerPedId()
        if data.speedZone then
            local speedLimit = data.speedLimit or 0.0
            SetVehicleMaxSpeed(GetVehiclePedIsIn(playerPed, false), status and speedLimit or 0.0)
        end

        if data.safeZone then
            SetEntityInvincible(playerPed, status)
        end
    end

    function zone:onEnter()
        ToggleEffects(true)
    end

    function zone:onExit()
        ToggleEffects(false)
    end
end

for name, data in pairs(zones) do
    CreateZone(name, data)
end