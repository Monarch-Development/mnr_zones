local zones = lib.load('config.config')

local function applyEffects(self)
    client.Notify(locale('notify.enter'), 'info')

    if self.speedzone then
        SetVehicleMaxSpeed(cache.vehicle, self.speedlimit)
    end

    if self.safezone then
        SetPlayerInvincible(cache.playerId, true)
    end
end

local function removeEffects(self)
    client.Notify(locale('notify.exit'), 'info')

    if self.speedzone then
        SetVehicleMaxSpeed(cache.vehicle, 0.0)
    end

    if self.safezone then
        SetPlayerInvincible(cache.playerId, false)
    end
end

local function checkStatus(self)
    if self.speedzone and cache.vehicle then
        SetVehicleMaxSpeed(cache.vehicle, self.speedlimit)
    end

    if self.safezone and not GetPlayerInvincible(cache.playerId) then
        SetPlayerInvincible(cache.playerId, true)
    end
end

local function CreateZone(name, data)
    if data.zoneShape == 'poly' then
        lib.zones.poly({
            points = data.points,
            thickness = data.height,
            debug = data.debug,
            speedzone = data.speedZone,
            speedlimit = data.speedLimit,
            safezone = data.safeZone,
            onEnter = applyEffects,
            onExit = removeEffects,
            inside = checkStatus,
        })
    elseif data.zoneShape == 'box' then
        lib.zones.box({
            coords = vec3(data.coords.x, data.coords.y, data.coords.z),
            size = data.size,
            rotation = data.coords.w,
            debug = data.debug,
            speedzone = data.speedZone,
            speedlimit = data.speedLimit,
            safezone = data.safeZone,
            onEnter = applyEffects,
            onExit = removeEffects,
            inside = checkStatus,
        })
    elseif data.zoneShape == 'sphere' then
        lib.zones.sphere({
            coords = vec3(data.coords.x, data.coords.y, data.coords.z),
            radius = data.radius,
            debug = data.debug,
            speedzone = data.speedZone,
            speedlimit = data.speedLimit,
            safezone = data.safeZone,
            onEnter = applyEffects,
            onExit = removeEffects,
            inside = checkStatus,
        })
    end
end

for name, data in pairs(zones) do
    CreateZone(name, data)
end