-- Escape Police For Brainrots
-- Game ID: 135094773390024

return function(section, config)
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local StarterGui = game:GetService("StarterGui")
    
    local plr = Players.LocalPlayer
    local char = plr.Character or plr.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local humanoid = char:WaitForChild("Humanoid")
    
    local elements = loadstring(game:HttpGet(getgitpath("src").."elements.lua"))()
    
    -- Toggles
    local toggles = {
        autoCollect = false,
        speedBoost = false,
        autoRebirth = false,
        noClip = false,
        autoCash = false,
        godMode = false,
        teleportToSafe = false,
        autoUpgrade = false,
    }
    
    local speedValue = 50
    local collectDistance = 50
    
    -- Create UI elements
    elements:Label("=== ESCAPE POLICE ===", section)
    elements:Label("Run from police & collect brainrots!", section)
    elements:Label("", section)
    
    -- Speed Boost
    elements:Toggle("Speed Boost", section, toggles.speedBoost, function(v)
        toggles.speedBoost = v
        if v then
            humanoid.WalkSpeed = speedValue
        else
            humanoid.WalkSpeed = 16
        end
    end)
    
    elements:Textbox("Speed Value (default 50)", section, "50", function(str)
        local val = tonumber(str)
        if val then
            speedValue = val
            if toggles.speedBoost then
                humanoid.WalkSpeed = val
            end
        end
    end)
    
    elements:Label("", section)
    
    -- Auto Collect Brainrots
    elements:Toggle("Auto Collect Brainrots", section, toggles.autoCollect, function(v)
        toggles.autoCollect = v
    end)
    
    -- Collect Distance
    elements:Textbox("Collect Distance (default 50)", section, "50", function(str)
        local val = tonumber(str)
        if val then
            collectDistance = val
        end
    end)
    
    elements:Label("", section)
    
    -- Auto Rebirth
    elements:Toggle("Auto Rebirth", section, toggles.autoRebirth, function(v)
        toggles.autoRebirth = v
    end)
    
    -- Auto Upgrade Speed
    elements:Toggle("Auto Upgrade Speed", section, toggles.autoUpgrade, function(v)
        toggles.autoUpgrade = v
    end)
    
    elements:Label("", section)
    
    -- NoClip
    elements:Toggle("NoClip (Walk Through Walls)", section, toggles.noClip, function(v)
        toggles.noClip = v
    end)
    
    -- God Mode
    elements:Toggle("God Mode", section, toggles.godMode, function(v)
        toggles.godMode = v
        if v then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
        else
            humanoid.MaxHealth = 100
            humanoid.Health = 100
        end
    end)
    
    elements:Label("", section)
    
    -- Teleport to Safe Zone
    elements:Button("Teleport to Safe Zone", section, function()
        -- Try to find a safe zone
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name:lower():find("safe") then
                hrp.CFrame = obj.CFrame + Vector3.new(0, 5, 0)
                break
            end
        end
    end)
    
    -- Teleport to Spawn
    elements:Button("Teleport to Spawn", section, function()
        local spawn = workspace:FindFirstChild("SpawnLocation") or workspace:FindFirstChild("Spawn")
        if spawn then
            hrp.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
        else
            hrp.CFrame = CFrame.new(0, 5, 0)
        end
    end)
    
    elements:Label("", section)
    
    -- Speed Display
    elements:Label("Speed: " .. humanoid.WalkSpeed, section)
    
    -- ==================== LOOPS ====================
    
    -- Character Respawn
    plr.CharacterAdded:Connect(function(c)
        char = c
        hrp = c:WaitForChild("HumanoidRootPart")
        humanoid = c:WaitForChild("Humanoid")
        
        if toggles.speedBoost then
            humanoid.WalkSpeed = speedValue
        end
        if toggles.godMode then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
        end
    end)
    
    -- NoClip Loop
    RunService.Stepped:Connect(function()
        if toggles.noClip then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
    
    -- Auto Collect Loop
    task.spawn(function()
        while task.wait(0.5) do
            if toggles.autoCollect then
                pcall(function()
                    -- Try to find and fire collect remote
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and obj.Name:lower():find("brainrot") then
                            local dist = (obj.Position - hrp.Position).Magnitude
                            if dist <= collectDistance then
                                -- Try to touch it
                                hrp.CFrame = obj.CFrame
                            end
                        end
                    end
                    
                    -- Also try firing any collect remotes
                    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                        if v:IsA("RemoteEvent") and v.Name:lower():find("collect") then
                            v:FireServer()
                        end
                    end
                end)
            end
        end
    end)
    
    -- Auto Rebirth Loop
    task.spawn(function()
        while task.wait(2) do
            if toggles.autoRebirth then
                pcall(function()
                    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                        if v:IsA("RemoteEvent") and v.Name:lower():find("rebirth") then
                            v:FireServer()
                        end
                    end
                end)
            end
        end
    end)
    
    -- Auto Upgrade Loop
    task.spawn(function()
        while task.wait(2) do
            if toggles.autoUpgrade then
                pcall(function()
                    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                        if v:IsA("RemoteEvent") and v.Name:lower():find("upgrade") then
                            v:FireServer()
                        end
                    end
                end)
            end
        end
    end)
    
    -- God Mode Loop
    task.spawn(function()
        while task.wait(1) do
            if toggles.godMode then
                pcall(function()
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                end)
            end
        end
    end)
    
    -- Auto Cash Collection
    task.spawn(function()
        while task.wait(1) do
            if toggles.autoCash then
                pcall(function()
                    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                        if v:IsA("RemoteEvent") and v.Name:lower():find("cash") then
                            v:FireServer()
                        end
                    end
                end)
            end
        end
    end)
    
    -- Initialize
    elements:Label("", section)
    elements:Label("Script loaded successfully!", section)
    elements:Label("Features will activate when toggled", section)
end