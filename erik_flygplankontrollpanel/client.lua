function DrawFlightInstruments() -- Definerar 
    local speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId())) * 1.943844492
    local altitude = GetEntityCoords(PlayerPedId()).z * 3.28084
    local heading = GetEntityHeading(GetVehiclePedIsIn(PlayerPedId()))
    local verticalspeed = GetEntityVelocity(GetVehiclePedIsIn(PlayerPedId())).z * 196.850394
    if speed < 40 then speed = 20 end
    if speed > 200 then speed = 200 end
    if altitude<0 then altitude = 0 end
    if verticalspeed>2000 then verticalspeed = 2000 elseif verticalspeed < -2000 then verticalspeed = -2000 end
    local flightstate
    
    
    if not HasStreamedTextureDictLoaded("flightinstruments") then
        RequestStreamedTextureDict("flightinstruments", true)
        while not HasStreamedTextureDictLoaded("flightinstruments") do
            Wait(1)
        end
    end
    
    DrawSprite("flightinstruments", "speedometer", 0.9, 0.9, 0.08, 0.08*1.77777778, 0, 255, 255, 255, 255) -- Fart Grunden
    DrawSprite("flightinstruments", "speedometer_needle", 0.9, 0.9, 0.08, 0.08*1.77777778, ((speed-20)/20)*36, 255, 255, 255, 255) -- Fart Pekaren
    DrawSprite("flightinstruments", "altimeter", 0.80, 0.9, 0.08, 0.08*1.77777778, 0, 255, 255, 255, 255) -- Höjd aka atitude
    DrawSprite("flightinstruments", "altimeter-needle100", 0.80, 0.9, 0.08, 0.08*1.77777778, altitude/100*36, 255, 255, 255, 255) -- Höjd aka atitude 100
    DrawSprite("flightinstruments", "altimeter-needle1000", 0.80, 0.9, 0.08, 0.08*1.77777778, altitude/1000*36, 255, 255, 255, 255) -- Höjd aka atitude 1000
    DrawSprite("flightinstruments", "altimeter-needle10000", 0.80, 0.9, 0.08, 0.08*1.77777778, altitude/10000*36, 255, 255, 255, 255) -- Höjd aka atitude 1000
    DrawSprite("flightinstruments", "heading", 0.70, 0.9, 0.08, 0.08*1.77777778, 0, 255, 255, 255, 255) -- Heading grund, position man färdas
    DrawSprite("flightinstruments", "heading_needle", 0.70, 0.9, 0.08, 0.08*1.77777778, heading, 255, 255, 255, 255) -- heading pekare
    DrawSprite("flightinstruments", "verticalspeedometer", 0.60, 0.9, 0.08, 0.08*1.77777778, 0, 255, 255, 255, 255) -- vertical fart, grund
    DrawSprite("flightinstruments", "verticalspeedometer_needle", 0.60, 0.9, 0.08, 0.08*1.77777778, 270+(verticalspeed/1000*90), 255, 255, 255, 255) -- vertical fart, pekare
    
end

Citizen.CreateThread(function() -- Tar fram panelen ifall man är i ett flygplan 
    while true do
        Wait(0)
        if IsPedInAnyPlane(PlayerPedId()) then
            DrawFlightInstruments()
        end
    end
end)