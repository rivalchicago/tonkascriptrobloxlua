getgenv().Tonka = {
    Options = {
        ['Intro'] = true,
        ['Intro_Type'] = "Console", -- // "Print", "Console", "Picture"
        ['Pack'] = true, -- // Animation Pack Combined With The New One. 
        ['Luarmor_Key'] = "ur_key_here" 
    },
    Aimbot = {
        ['Enabled'] = true,
        ['Keybinds'] = "q",
        ['Locking'] = false, -- // don't touch
        ['Prediction'] = 0.1531, 
        ['Smoothing'] = true,
        ['Smoothness'] = 0.02115,
        ['Shake'] = false,
        ['Value'] = 0.7, -- // Shake Value
        ['NormalAimpart'] = "HumanoidRootPart",
        ['IgnorePart'] = true,
        ['IgnoredParts'] = {"RightFoot", "LeftFoot"},
		['AimpartType'] = "Nearest Point", -- // "Normal", "Nearest Part", "Nearest Point"
        ['Aimpart'] = "HumanoidRootPart",
    },
    FOV = {
        ['Enabled'] = false,
        ['Amount'] = 3000, -- // Dynamic Value
        ['FOVType'] = "Static", -- // "Dynamic", "Static"
        ['Radius'] = 120,
        ['Filled'] = false,
        ['Sides'] = 25,
        ['Thickness'] = 1,
        ['Transparency'] = 1,
        ['Color'] = Color3.fromRGB(74, 219, 0)
    },
    Resolving = { -- // Note The Positive And Negetive Are Detection.
        ['Enabled'] = true,
        ['Type'] = "When Velocity is too high",
        ['Positive'] = 60,
        ['Negetive'] = 60
    },
    Checks = {
        Aimbot = {
            ['YAxis'] = false,
            ['Wall'] = true,
            ['Visible'] = true,
            ['ForceField'] = true,
            ['SelfAlive'] = true,
            ['KO'] = true,
            ['Grabbed'] = true,
            ['Crew'] = false,
            ['InFOV'] = false,
            ['SelfReload'] = false,
            ['FirstPerson'] = false,
            ['AllowThirdPersonShiftLock'] = false,
            ['ThirdPerson'] = false,
        },
        Direction = {
            ['Ground'] = true, -- // No Ground Shots
            ['HitChance'] = 100, -- // HitChance To Be More Legit
            ['YAxis'] = false,
            ['SelfAlive'] = true,
            ['SelfReload'] = true,
            ['InFOV'] = true,
            ['Grabbed'] = true,
            ['ForceField'] = false,
            ['Crew'] = false,
            ['Wall'] = false,
            ['KO'] = false,
        }
    },
    Macro = {
        ['Keybind'] = "v",
        ['Speed'] = 1,
        ['Type'] = "First" -- // "First", "Third"
    },
    Direction = { -- // Silent Aim
        ['Enabled'] = true,
        ['Keybinds'] = "p",
        ['Prediction'] = 0.1283488324828432,
        ['AimpartType'] = "Nearest Part", -- // "Normal", "Nearest Part", "Nearest Point"
        ['Aimpart'] = "HumanoidRootPart",
        ['NormalAimpart'] = "HumanoidRootPart",
        ['IgnorePart'] = true,
        ['IgnoredParts'] = {"LeftFoot", "RightFoot"}
    },
    Sorter = {
        ['Enabled'] = false, 
        ['List'] = {"[Double Barrel]","[Phone]","[SprayCan]","Wallet","[Cookie]",}, 
    },
    Resolving = { -- // Note The Positive And Negetive Are Detection.
        ['Enabled'] = true,
        ['Type'] = "When Velocity is too high",
        ['Positive'] = 60,
        ['Negetive'] = 60,
    },
    FOV = {
        ['Enabled'] = true,
        ['Radius'] = 120,
        ['FOVType'] = "Static", -- // "Dynamic", "Static"
        ['FOVType2'] = "Cursor",
        ['Amount'] = 3000,
        ['Filled'] = false,
        ['Sides'] = 25,
        ['Thickness'] = 1,
        ['Transparency'] = 1,
        ['Color'] = Color3.fromRGB(74, 219, 0)
    },
    Camera = {
        Spin = {
            ['Enabled'] = true,
            ['Speed'] = 1000,
            ['Key'] = "x",
        }
    },
    Frames = {
        Unlock = {
            ['Enabled'] = true,
            ['Cap'] = 400,
            ['Boost'] = true,
        }
    },
    Spoofers = {
        Memory = {
            ['Enabled'] = true,
            ['Mininum'] = 852,
            ['Maxinum'] = 1123,
        },
        Ping = {
            ['Enabled'] = false,
            ['Mininum'] = 100,
            ['Maxinum'] = 2000,
        },
        Recv = {
            ['Enabled'] = true,
            ['Mininum'] = 10,
            ['Maxinum'] = 23,
        }
    },
    NoClip = {
        ['Enabled'] = true,
        ['Key'] = "t",
        ['GunName'] = "[Shotgun]",
        ['Delay'] = 0.1
    }
}

script_key= getgenv().Tonka.Options.Luarmor_Key;


local Players = game:GetService("Players")
local LP = Players["LocalPlayer"]
while not LP do
    Players["ChildAdded"]:Wait()
    LP = Players["LocalPlayer"]
end
local Char = LP["Character"]
while not Char do
    LP["CharacterAdded"]:Wait()
    Char = LP["Character"]
end

local Services = {
    Workspace = game:GetService("Workspace"),
    RunService = game:GetService("RunService"),
    Players = game:GetService("Players"),
    UserInputService = game:GetService("UserInputService"),
    GuiService = game:GetService("GuiService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage")
}

local Local = {
    Player = Services.Players.LocalPlayer,
    Camera = Services.Workspace.CurrentCamera,
    Mouse = Services.Players.LocalPlayer:GetMouse()
}

local AimlockTarget, RootPartPosition, Real_Magnitude, vis, ray, ignoreList, part, Velocity, Main, feign,
    AimlockTargetName, SilentTarget, Aimplace, SilentVelocity, CurrentPosition, Time, Distance, SilCurrentPosition,
    SilTime, SilDistance, pos, ac, idk

local Keybinds = {
    Aimbot = Enum.KeyCode.Q,
    Direction = Enum.KeyCode.P
}

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local SilPreviousPosition = Vector3.new()
local PreviousPosition = Vector3.new()
local FovToUse = getgenv().Tonka.FOV.Radius
local gunEquipedName = nil

local CamCircle = Drawing.new("Circle")
CamCircle.Color = getgenv().Tonka.FOV.Color
CamCircle.Thickness = getgenv().Tonka.FOV.Thickness
CamCircle.Transparency = getgenv().Tonka.FOV.Transparency
CamCircle.NumSides = getgenv().Tonka.FOV.Sides
CamCircle.Radius = getgenv().Tonka.FOV.Radius
CamCircle.Visible = getgenv().Tonka.FOV.Enabled
CamCircle.Filled = getgenv().Tonka.FOV.Filled

local SilentCircle = Drawing.new("Circle")
SilentCircle.Visible = getgenv().Tonka.FOV.Enabled
SilentCircle.Transparency = getgenv().Tonka.FOV.Transparency
SilentCircle.Radius = getgenv().Tonka.FOV.Radius
SilentCircle.Thickness = getgenv().Tonka.FOV.Thickness
SilentCircle.Color = getgenv().Tonka.FOV.Color
SilentCircle.NumSides = getgenv().Tonka.FOV.Sides
SilentCircle.Filled = getgenv().Tonka.FOV.Filled

local function IsOnScreen(a, Setting)
    if Setting.Visible then
        local _, vis = Services.Workspace.CurrentCamera:WorldToScreenPoint(a.Position)
        if vis then
            return true
        else
            return false
        end
    else
        return true
    end
end

local function Wall(a, Setting)
    if Setting.Wall then
        ray = Ray.new(Local.Camera.CFrame.Position, a.HumanoidRootPart.Position - Local.Camera.CFrame.Position)
        ignoreList = {Local.Player.Character, a.Parent}
        part = Services.Workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
        if not part then
            return true
        end
        return false
    else
        return true
    end
end

local function IsInRadius(a, Setting)
    if Setting.InFOV then
        for _, v in pairs(a:GetChildren()) do
            if (v:IsA("Part") or v:IsA("MeshPart")) and v.Name ~= "HumanoidRootPart" then
                local pos = Local.Camera:WorldToViewportPoint(v.Position)
                local dis = (Vector2.new(Local.Mouse.X, Local.Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dis < SilentCircle.Radius then
                    return true
                end
            elseif v:IsA("Accessory") then
                local pos = Local.Camera:WorldToViewportPoint(v.Handle.Position)
                local dis = (Vector2.new(Local.Mouse.X, Local.Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dis < SilentCircle.Radius then
                    return true
                end
            end
        end
        return false
    else
        return true
    end
end

local function Grabbed(a, Setting)
    if Setting.Grabbed then
        if a:FindFirstChild("GRABBING_CONSTRAINT") ~= nil then
            return false
        else
            return true
        end
    else
        return true
    end
end


local function getClosestPartToCursor(a, Setting)
    local closestPart
    local shortestDistance = math.huge
    if Setting.IgnorePart then
        for _, v in pairs(a:GetChildren()) do
            if (not table.find(Setting.IgnoredParts, v.Name)) then
                if v:IsA("Part") or v:IsA("MeshPart") then
                    local WrldToViewportPointP = Services.Workspace.CurrentCamera:WorldToScreenPoint(v.Position)
                    local Distance = (Vector2.new(WrldToViewportPointP.X, WrldToViewportPointP.Y) -
                                         Vector2.new(Local.Mouse.X, Local.Mouse.Y)).Magnitude
                    if Distance < shortestDistance then
                        shortestDistance = Distance
                        closestPart = v
                    end
                end
            end
        end
        return closestPart
    elseif not Setting.IgnorePart then
        for _, v in next, a:GetChildren() do
            if v:IsA("Part") or v:IsA("MeshPart") then
                local WrldToViewportPointP = Services.Workspace.CurrentCamera:WorldToScreenPoint(v.Position)
                local Distance = (Vector2.new(WrldToViewportPointP.X, WrldToViewportPointP.Y) -
                                     Vector2.new(Local.Mouse.X, Local.Mouse.Y)).Magnitude
                if Distance < shortestDistance then
                    shortestDistance = Distance
                    closestPart = v
                end
            end
        end
        return closestPart
    end
end

if getgenv().Tonka.Frames.Unlock.Enabled == true then
setfpscap(getgenv().Tonka.Frames.Unlock.Cap)
end

if getgenv().Tonka.Spoofers.Memory.Enabled == true then
    local Memory
    game:GetService("RunService").RenderStepped:Connect(function()
        pcall(function()
            for i,v in pairs(game:GetService("CoreGui").RobloxGui.PerformanceStats:GetChildren()) do
                if v.Name == "PS_Button" then
                    if v.StatsMiniTextPanelClass.TitleLabel.Text == "Mem" then
                        v.StatsMiniTextPanelClass.ValueLabel.Text = tostring(Memory) ..  " MB"
                    end
                end
            end
        end)
        pcall(function()
            if game:GetService("CoreGui").RobloxGui.PerformanceStats["PS_Viewer"].Frame.TextLabel.Text == "Memory" then
                for i,v in pairs(game:GetService("CoreGui").RobloxGui.PerformanceStats["PS_Viewer"].Frame:GetChildren()) do
                   if v.Name == "PS_DecoratedValueLabel" and string.find(v.Label.Text, 'Current') then
                     v.Label.Text = "Current: " .. Memory .. " MB"
                   end
                   if v.Name == "PS_DecoratedValueLabel" and string.find(v.Label.Text, 'Average') then
                     v.Label.Text = "Average: " .. Memory .. " MB"
                   end
                end
            end
        end)
        pcall(function()
            game:GetService("CoreGui").DevConsoleMaster.DevConsoleWindow.DevConsoleUI.TopBar.LiveStatsModule["MemoryUsage_MB"].Text = math.round(tonumber(Memory)) .. " MB"
        end)
    end)
    task.spawn(function()
        Memory = math.random(getgenv().Tonka.Spoofers.Memory.Mininum, getgenv().Tonka.Spoofers.Memory.Maxinum) .. "." .. tostring(math.random(10, 99))
        while task.wait(1) do
        Memory = math.random(getgenv().Tonka.Spoofers.Memory.Mininum, getgenv().Tonka.Spoofers.Memory.Maxinum) .. "." .. tostring(math.random(10, 99))
        end
    end)
    end
    
    
      if getgenv().Tonka.Spoofers.Ping.Enabled == true then
    local Ping
    game:GetService("RunService").RenderStepped:Connect(function()
        pcall(function()
            for i,v in pairs(game:GetService("CoreGui").RobloxGui.PerformanceStats:GetChildren()) do
                if v.Name == "PS_Button" then
                    if v.StatsMiniTextPanelClass.TitleLabel.Text == "Ping" then
                        v.StatsMiniTextPanelClass.ValueLabel.Text = tostring(Ping) ..  " ms"
                    end
                end
            end
        end)
        pcall(function()
                if game:GetService("CoreGui").RobloxGui.PerformanceStats["PS_Viewer"].Frame.TextLabel.Text == "Ping" then
                for i,v in pairs(game:GetService("CoreGui").RobloxGui.PerformanceStats["PS_Viewer"].Frame:GetChildren()) do
                   if v.Name == "PS_DecoratedValueLabel" and string.find(v.Label.Text, 'Current') then
                     v.Label.Text = "Current: " .. Ping .. " ms"
                   end
                   if v.Name == "PS_DecoratedValueLabel" and string.find(v.Label.Text, 'Average') then
                     v.Label.Text = "Average: " .. Ping .. " ms"
                   end
                end
            end
        end)
    end)
    task.spawn(function()
        Ping = math.random(getgenv().Tonka.Spoofers.Memory.Mininum, getgenv().Tonka.Spoofers.Memory.Maxinum) .. "." .. tostring(math.random(10, 99))
        while task.wait(1) do
            Ping = math.random(getgenv().Tonka.Spoofers.Memory.Mininum, getgenv().Tonka.Spoofers.Memory.Maxinum) .. "." .. tostring(math.random(10, 99))
        end
    end)
    end

    if getgenv().Tonka.Spoofers.Recv.Enabled == true then
    local Recv
    game:GetService("RunService").RenderStepped:Connect(function()
        pcall(function()
            for i,v in pairs(game:GetService("CoreGui").RobloxGui.PerformanceStats:GetChildren()) do
                if v.Name == "PS_Button" then
                    if v.StatsMiniTextPanelClass.TitleLabel.Text == "Recv" then
                        v.StatsMiniTextPanelClass.ValueLabel.Text = tostring(Recv) ..  " KB/s"
                    end
                end
            end
        end)
        pcall(function()
            if game:GetService("CoreGui").RobloxGui.PerformanceStats["PS_Viewer"].Frame.TextLabel.Text == "Received\n(Network)" then
                for i,v in pairs(game:GetService("CoreGui").RobloxGui.PerformanceStats["PS_Viewer"].Frame:GetChildren()) do
                   if v.Name == "PS_DecoratedValueLabel" and string.find(v.Label.Text, 'Current') then
                     v.Label.Text = "Current: " .. Recv .. " KB/s"
                   end
                   if v.Name == "PS_DecoratedValueLabel" and string.find(v.Label.Text, 'Average') then
                     v.Label.Text = "Average: " .. Recv .. " KB/s"
                   end
                end
            end
        end)
    end)
    task.spawn(function()
        Recv = math.random(getgenv().Tonka.Spoofers.Recv.Mininum, getgenv().Tonka.Spoofers.Memory.Maxinum) .. "." .. tostring(math.random(10, 99))
        while task.wait(1) do
            Recv = math.random(getgenv().Tonka.Spoofers.Memory.Mininum, getgenv().Tonka.Spoofers.Memory.Maxinum) .. "." .. tostring(math.random(10, 99))
        end
    end)
end

            if getgenv().Tonka.Direction.Enabled and SilentTarget then
                local Vel1 = SilentTarget.Character[getgenv().Tonka.Direction.NormalAimpart]
                if getgenv().Tonka.Checks.Direction.Ground and Vel1.Velocity.Y < -30 then
                    pcall(function()
                        Vel1.Velocity = Vector3.new(Vel1.Velocity.X, (Vel1.Velocity.Y + 35), Vel1.Velocity.Z)
                        Vel1.AssemblyLinearVelocity = Vector3.new(Vel1.Velocity.X, (Vel1.Velocity.Y + 35), Vel1.Velocity.Z)
                    end)
                end
                if Vel1.Velocity.Magnitude > 55 then
                    pcall(function()
                        Vel1.Velocity = Vector3.new(0,0,0)
                        Vel1.AssemblyLinearVelocity = Vector3.new(0,0,0)
                    end)
                end
                if Vel1.Velocity.Y > -50 then
                    pcall(function()
                        Vel1.Velocity = Vector3.new(Vel1.Velocity.X,0,Vel1.Velocity.Z)
                        Vel1.AssemblyLinearVelocity = Vector3.new(Vel1.Velocity.X,0,Vel1.Velocity.Z)
                    end)
                elseif Vel1.Velocity.Y < 50 then
                    pcall(function()
                        Vel1.Velocity = Vector3.new(Vel1.Velocity.X,0,Vel1.Velocity.Z)
                        Vel1.AssemblyLinearVelocity = Vector3.new(Vel1.Velocity.X,0,Vel1.Velocity.Z)
                    end)
                end
            end
    
local function getClosestPointOnPart(Part)
    local mouseray = Local.Mouse.UnitRay
    mouseray = mouseray.Origin + (mouseray.Direction * (Part.Position - mouseray.Origin).Magnitude)
    local point =
        (mouseray.Y >= (Part.Position - Part.Size / 2).Y and mouseray.Y <= (Part.Position + Part.Size / 2).Y) and
            (Part.Position + Vector3.new(0, -Part.Position.Y + mouseray.Y, 0)) or Part.Position
    local check = RaycastParams.new()
    check.FilterType = Enum.RaycastFilterType.Whitelist
    check.FilterDescendantsInstances = {Part}
    local ray = Services.Workspace:Raycast(mouseray, (point - mouseray), check)
    if ray then
        return ray.Position
    else
        return Local.Mouse.Hit.Position
    end
end

local function SelfAlive(Setting)
    if game.PlaceId == 12442317726 then
        if Setting.SelfAlive then
            if Local.Player.Character:FindFirstChild("BodyEffects")["KO"].Value == false then
                return true
            else
                return false
            end
        else
            return true
        end
    else
        if Setting.SelfAlive then

            if Local.Player.Character:FindFirstChild("BodyEffects")["K.O"].Value == false then
                return true
            else
                return false
            end
        else
            return true
        end
    end
end

local function TargetKO(a, Setting)
    if game.PlaceId == 10355218822 or game.PlaceId == 12154107359 then
        if Setting.KO then
            if a:FindFirstChild("DEAD") ~= nil or a.Health < 3 then
                return false
            else
                return true
            end
        else
            return true
        end
    elseif game.PlaceId == 12442317726 then
        if Setting.KO then
            if a:FindFirstChild("BodyEffects")["KO"].Value == false then
                return true
            else
                return false
            end
        else
            return true
        end
    else
        if Setting.KO then
            if a:FindFirstChild("BodyEffects")["K.O"].Value == false then
                return true
            else
                return false
            end
        else
            return true
        end
    end
end

local function SilentHitChance()
    if math.random(0, 100) <= getgenv().Tonka.Checks.Direction.HitChance then
        return true
    else
        return false
    end
end

local function TargetForceField(a, Setting)
    if Setting.ForceField then
        if not (a:FindFirstChildOfClass("ForceField")) then
            return true
        else
            return false
        end
    else
        return true
    end
end

local function SelfReload(Setting)
    if Setting.SelfReload then
        if game.PlaceId ~= 9825515356 then
            if Local.Player.Character.BodyEffects.Reload.Value == false then
                return true
            else
                return false
            end
        else
            if Local.Player.Character.BodyEffects.Reloading.Value == false then
                return true
            else
                return false
            end
        end
    else
        return true
    end
end

local function Crew(b, Setting)
    if Setting.Crew then
        if Local.Player.DataFolder.Information:FindFirstChild('Crew').Value ~= "" and
            Services.Players[b].DataFolder.Information:FindFirstChild('Crew').Value ~= "" then
            if Local.Player.DataFolder.Information.Crew.Value ~= Services.Players[b].DataFolder.Information.Crew.Value then
                return true
            else
                return false
            end
        else
            return true
        end
    else
        return true
    end
end

local function IsInFirstPerson(Setting)
    if Setting.FirstPerson and Setting.AllowThirdPersonShiftLock == false then
        if (Local.Camera.CFrame.p - Local.Camera.Focus.p).Magnitude < 0.7 then
            return true
        else
            return false
        end
    elseif Setting.FirstPerson and Setting.AllowThirdPersonShiftLock then
        if (Local.Camera.CFrame.p - Local.Camera.Focus.p).Magnitude < 0.7 or Services.UserInputService.MouseBehavior ==
            Enum.MouseBehavior.LockCenter then
            return true
        else
            return false
        end
    end
    return true
end

local function IsInThirdPerson(Setting)
    if Setting.ThirdPerson then
        if (Local.Camera.CFrame.p - Local.Camera.Focus.p).Magnitude > 0.7 then
            return true
        else
            return false
        end
    end
    return true
end


local function aimbot(feign)
    if getgenv().Tonka.Aimbot.Smoothing then
        Local.Camera.CFrame = Local.Camera.CFrame:Lerp(Main, getgenv().Tonka.Aimbot.Smoothness,
            Enum.EasingStyle.Quad, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    end
end

local function getClosestPlayerToCursor(Setting)
    local Target, Closest = nil, 1 / 0
    for _, v in pairs(Services.Players:GetPlayers()) do
        if (v.Character and v ~= Local.Player and v.Character:FindFirstChild("HumanoidRootPart")) and
            IsOnScreen(v.Character:FindFirstChild("HumanoidRootPart"), getgenv().Tonka.Direction) and
            Wall(v.Character, getgenv().Tonka.Direction) then
            local Position, OnScreen = Local.Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
            local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Local.Mouse.X, Local.Mouse.Y)).Magnitude
            if (Setting > Distance and Distance < Closest and OnScreen) then
                Closest = Distance
                Target = v
            end
        end
    end
    return Target
end

Services.UserInputService.InputBegan:Connect(function(input)
    if not (Services.UserInputService:GetFocusedTextBox()) then
        if input.KeyCode == Keybinds.Aimbot and AimlockTarget == nil then
            if getgenv().Tonka.Aimbot.Locking ~= true then
                getgenv().Tonka.Aimbot.Locking = true
            end
            local Target;
            if game.PlaceId == 10355218822 or game.PlaceId == 12154107359 then
                if Target ~= nil then
                    AimlockTarget = Services.Workspace.NPC.Dummy
                    AimlockTargetName = Services.Workspace.NPC.Dummy.Name
                end
            else
                Target = getClosestPlayerToCursor(700)
                if Target ~= nil then
                    AimlockTarget = Target.Character
                    AimlockTargetName = Target.Name
                end
            end

        elseif input.KeyCode == Keybinds.Aimbot and AimlockTarget ~= nil then
            if AimlockTarget ~= nil then
                AimlockTarget = nil
            end
            if getgenv().Tonka.Aimbot.Locking ~= false then
                getgenv().Tonka.Aimbot.Locking = false
            end
        end
    end
end)

if not LPH_OBFUSCATED then
    LPH_JIT_MAX = function(...)
        return ...
    end
end

local Velocity = nil;
local lastPosition = Vector3.new(0, 0, 0)
local lastTime = tick()
local SilentlastPosition = Vector3.new(0, 0, 0)
local SilentlastTime = tick()

Services.RunService.Heartbeat:Connect(LPH_JIT_MAX(function()
    if getgenv().Tonka.Aimbot.Enabled == true and getgenv().Tonka.Aimbot.Locking == true and AimlockTarget and
        AimlockTarget:FindFirstChild(getgenv().Tonka.Aimbot.Aimpart) then
        if getgenv().Tonka.FOV.Enabled then
            CamCircle.Radius = getgenv().Tonka.FOV.Radius
            CamCircle.Visible = getgenv().Tonka.FOV.Enabled
            CamCircle.Position = Vector2.new(Services.UserInputService:GetMouseLocation().X,
                Services.UserInputService:GetMouseLocation().Y)
        elseif getgenv().Tonka.FOV.Enabled == false then
            if CamCircle.Visible ~= false then
                CamCircle.Visible = getgenv().Tonka.FOV.Enabled
            end
        end
        if getgenv().Tonka.Aimbot.AimpartType == "Normal" then
            getgenv().Tonka.Aimbot.Aimpart = getgenv().Tonka.Aimbot.NormalAimpart
        end
        if getgenv().Tonka.Aimbot.AimpartType == "Nearest Part" then
            getgenv().Tonka.Aimbot.Aimpart = tostring(
                getClosestPartToCursor(AimlockTarget, getgenv().Tonka.Aimbot))
        end
        if getgenv().Tonka.FOV.FOVType == "Dynamic" then
            if Local.Player.Character:FindFirstChild("HumanoidRootPart") then
                feign = (Local.Camera.CFrame.Position - AimlockTarget.HumanoidRootPart.Position).magnitude
                getgenv().Tonka.FOV.Radius = (getgenv().Tonka.FOV.Amount / feign)
            end
        end
        if SelfAlive(getgenv().Tonka.Checks.Aimbot) and TargetKO(AimlockTarget, getgenv().Tonka.Checks.Aimbot) and
            IsOnScreen(AimlockTarget[getgenv().Tonka.Aimbot.Aimpart], getgenv().Tonka.Checks.Aimbot) and
            Wall(AimlockTarget, getgenv().Tonka.Checks.Aimbot) and
            IsInRadius(AimlockTarget, getgenv().Tonka.Checks.Aimbot) and
            TargetForceField(AimlockTarget, getgenv().Tonka.Checks.Aimbot) and
            Crew(AimlockTargetName, getgenv().Tonka.Checks.Aimbot) and SelfReload(getgenv().Tonka.Checks.Aimbot) and
            IsInFirstPerson(getgenv().Tonka.Checks.Aimbot) and IsInThirdPerson(getgenv().Tonka.Checks.Aimbot) and
            Grabbed(AimlockTarget, getgenv().Tonka.Checks.Aimbot) and
            AimlockTarget:FindFirstChild("HumanoidRootPart") then
            if getgenv().Tonka.Aimbot.AimpartType == "Nearest Part" or
                getgenv().Tonka.Aimbot.AimpartType == "Normal" then
                ac = AimlockTarget[getgenv().Tonka.Aimbot.Aimpart].Position
            elseif getgenv().Tonka.Aimbot.AimpartType == "Nearest Point" then
                getgenv().Tonka.Aimbot.Aimpart = tostring(
                    getClosestPartToCursor(AimlockTarget, getgenv().Tonka.Aimbot))
                ac = getClosestPointOnPart(AimlockTarget[getgenv().Tonka.Aimbot.Aimpart])
            end
            pcall(function()
                local currentPosition = AimlockTarget.HumanoidRootPart.Position
                local currentTime = tick()
                local deltaPos = currentPosition - lastPosition
                local deltaTime = currentTime - lastTime
                if getgenv().Tonka.Resolving.Enabled then
                    if getgenv().Tonka.Resolving.Type == "When Velocity is too high" then
                        if (AimlockTarget.HumanoidRootPart.Velocity).magnitude >
                            getgenv().Tonka.Resolving.Positive or
                            (AimlockTarget.HumanoidRootPart.Velocity).magnitude <
                            -getgenv().Tonka.Resolving.Negetive then
                            if deltaTime >= 0.03 then
                                Velocity = deltaPos / deltaTime
                                lastPosition = currentPosition
                                lastTime = currentTime
                            end
                            if getgenv().Tonka.Checks.Aimbot.YAxis == false then
                                Velocity = Vector3.new(Velocity.X, 0, Velocity.Z)
                            end
                        else
                            if getgenv().Tonka.Checks.Aimbot.YAxis == false then
                                Velocity = Vector3.new(AimlockTarget.HumanoidRootPart.Velocity.X, 0,
                                    AimlockTarget.HumanoidRootPart.Velocity.Z)
                            else
                                Velocity = AimlockTarget.HumanoidRootPart.Velocity
                            end
                        end
                    else
                        if deltaTime >= 0.03 then
                            Velocity = deltaPos / deltaTime
                            lastPosition = currentPosition
                            lastTime = currentTime
                        end
                        if getgenv().Tonka.Checks.Aimbot.YAxis == false then
                            Velocity = Vector3.new(Velocity.X, 0, Velocity.Z)
                        end
                    end
                else
                    if getgenv().Tonka.Checks.Aimbot.YAxis == false then
                        Velocity = Vector3.new(AimlockTarget.HumanoidRootPart.Velocity.X, 0,
                            AimlockTarget.HumanoidRootPart.Velocity.Z)
                    else
                        Velocity = AimlockTarget.HumanoidRootPart.Velocity
                    end
                end
                if getgenv().Tonka.Aimbot.Shake then
                    if getgenv().Tonka.Aimbot.Predict then
                        Main = CFrame.new(Local.Camera.CFrame.p, ac +
                            Vector3.new(
                                math.random(-getgenv().Tonka.Aimbot.Value,
                                    getgenv().Tonka.Aimbot.Value) * 0.01,
                                math.random(-getgenv().Tonka.Aimbot.Value,
                                    getgenv().Tonka.Aimbot.Value) * 0.1, math.random(
                                    -getgenv().Tonka.Aimbot.Value,
                                    getgenv().Tonka.Aimbot.Value) * 0.1) +
                            (Vector3.new(Velocity.X, Velocity.Y, Velocity.Z)) *
                            getgenv().Tonka.Aimbot.PredictAmmount)
                    else
                        Main = CFrame.new(Local.Camera.CFrame.p, ac +
                            Vector3.new(
                                math.random(-getgenv().Tonka.Aimbot.Value,
                                    getgenv().Tonka.Aimbot.Value) * 0.01,
                                math.random(-getgenv().Tonka.Aimbot.Value,
                                    getgenv().Tonka.Aimbot.Value) * 0.1, math.random(
                                    -getgenv().Tonka.Aimbot.Value,
                                    getgenv().Tonka.Aimbot.Value) * 0.1))
                    end
                else
                    if getgenv().Tonka.Aimbot.Predict then
                        Main = CFrame.new(Local.Camera.CFrame.p,
                            ac + (Vector3.new(Velocity.X, Velocity.Y, Velocity.Z)) *
                                getgenv().Tonka.Aimbot.PredictAmmount)
                    else
                        Main = CFrame.new(Local.Camera.CFrame.p, ac)
                    end
                end
                if getgenv().Tonka.Aimbot.Smoothness then
                    aimbot(Main)
                else
                    if getgenv().Tonka.Aimbot.Predict then
                        Local.Camera.CFrame = CFrame.new(Local.Camera.CFrame.Position, ac +
                            (Vector3.new(Velocity.X, Velocity.Y, Velocity.Z)) *
                            getgenv().Tonka.Aimbot.PredictAmmount)
                    else
                        Local.Camera.CFrame = CFrame.new(Local.Camera.CFrame.Position, ac)
                    end
                end
            end)
        end
    else
        getgenv().Tonka.Aimbot.Locking = false
        AimlockTarget = nil
        CamCircle.Visible = false
    end
    if getgenv().Tonka.Direction.Enabled then
        SilentTarget = getClosestPlayerToCursor(700)
        if SilentTarget and SilentTarget.Character and SilentTarget.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                local SilentcurrentPosition = SilentTarget.Character.HumanoidRootPart.Position
                local SilentcurrentTime = tick()
                local SilentdeltaPos = SilentcurrentPosition - SilentlastPosition
                local SilentdeltaTime = SilentcurrentTime - SilentlastTime
                if getgenv().Tonka.Resolving.Enabled then
                    if getgenv().Tonka.Direction.Type == "When Velocity is too high" then
                        if (SilentTarget.Character.HumanoidRootPart.Velocity).magnitude >
                            getgenv().Tonka.Resolving.Positive or
                            (SilentTarget.Character.HumanoidRootPart.Velocity).magnitude <
                            -getgenv().Tonka.Resolving.Negetive then
                            if SilentdeltaTime >= 0.03 then
                                SilentVelocity = SilentdeltaPos / SilentdeltaTime
                                SilentlastPosition = SilentcurrentPosition
                                SilentlastTime = SilentcurrentTime
                            end
                            if getgenv().Tonka.Checks.Direction.YAxis == false then
                                SilentVelocity = Vector3.new(SilentVelocity.X, 0, SilentVelocity.Z)
                            end
                        else
                            if getgenv().Tonka.Checks.Direction.YAxis == false then
                                SilentVelocity = Vector3.new(SilentTarget.Character.HumanoidRootPart.Velocity.X, 0,
                                    SilentTarget.Character.HumanoidRootPart.Velocity.Z)
                            else
                                SilentVelocity = SilentTarget.Character.HumanoidRootPart.Velocity
                            end
                        end
                    else
                        if SilentdeltaTime >= 0.03 then
                            SilentVelocity = SilentdeltaPos / SilentdeltaTime
                            SilentlastPosition = SilentcurrentPosition
                            SilentlastTime = SilentcurrentTime
                        end
                        if getgenv().Tonka.Checks.Direction.YAxis == false then
                            SilentVelocity = Vector3.new(Velocity.X, 0, Velocity.Z)
                        end
                    end
                else
                    if getgenv().Tonka.Checks.Direction.YAxis == false then
                        SilentVelocity = Vector3.new(SilentTarget.Character.HumanoidRootPart.Velocity.X, 0,
                            SilentTarget.Character.HumanoidRootPart.Velocity.Z)
                    else
                        SilentVelocity = SilentTarget.Character.HumanoidRootPart.Velocity
                    end
                end
                if getgenv().Tonka.Direction.AimpartType == "Nearest Part" then
                    getgenv().Tonka.Direction.Aimpart =
                        tostring(getClosestPartToCursor(SilentTarget.Character, getgenv().Tonka.Direction))
                    Aimplace = (SilentTarget.Character[getgenv().Tonka.Direction.Aimpart].Position) +
                                   (SilentVelocity * getgenv().Tonka.Direction.Prediction)
                elseif getgenv().Tonka.Direction.AimpartType == "Normal" then
                    getgenv().Tonka.Direction.Aimpart = getgenv().Tonka.Direction.NormalAimpart
                    Aimplace = (SilentTarget.Character[getgenv().Tonka.Direction.Aimpart].Position) +
                                   (SilentVelocity * getgenv().Tonka.Direction.Prediction)
                elseif getgenv().Tonka.Direction.AimpartType == "Nearest Point" then
                    getgenv().Tonka.Direction.Aimpart =
                        tostring(getClosestPartToCursor(SilentTarget.Character, getgenv().Tonka.Direction))
                    Aimplace = (getClosestPointOnPart(
                        SilentTarget.Character[getgenv().Tonka.Direction.Aimpart]) +
                                   (SilentVelocity * getgenv().Tonka.Direction.Prediction))
                end
            end)
        end
        if getgenv().Tonka.FOV.Enabled then
            SilentCircle.Radius = getgenv().Tonka.FOV.Radius
            if getgenv().Tonka.FOV.FOVType2 == "Cursor" then
                SilentCircle.Visible = getgenv().Tonka.FOV.Enabled
                SilentCircle.Position = Vector2.new(Local.Mouse.X, Local.Mouse.Y + Services.GuiService:GetGuiInset().Y)
            else
                if SilentTarget then
                    local PlayerPosition = SilentTarget.Character.HumanoidRootPart.Position + SilentVelocity *
                                               getgenv().Tonka.Direction.Prediction
                    local OnScreenPosition = Local.Camera:WorldToViewportPoint(PlayerPosition)
                    SilentCircle.Position = (Vector2.new(OnScreenPosition.X, OnScreenPosition.Y))
                    SilentCircle.Visible = getgenv().Tonka.FOV.Enabled
                else
                    SilentCircle.Visible = false
                end
            end
        else
            SilentCircle.Visible = getgenv().Tonka.FOV.Enabled
        end
        if SilentTarget and SilentTarget.Character and SilentTarget.Character.HumanoidRootPart then
            if getgenv().Tonka.FOV.FOVType == "Dynamic" then
                if Local.Player.Character:FindFirstChild("HumanoidRootPart") then
                    idk = (Local.Camera.CFrame.Position - SilentTarget.Character.HumanoidRootPart.Position).magnitude
                    getgenv().Tonka.FOV.Radius = (getgenv().Tonka.FOV.Amount / idk)
                end
            end
        end
    else
        if SilentCircle.Visible ~= false then
            SilentCircle.Visible = false
        end
    end
end))

local function getgamesnamecall()
    if game.PlaceId == 2788229376 or game.PlaceId == 4106313503 or game.PlaceId == 12442317726 then
        return "UpdateMousePos"
    elseif game.PlaceId == 5602055394 or game.PlaceId == 7951883376 then
        return "MousePos"
    elseif game.PlaceId == 9825515356 then
        return "GetMousePos"
    else
        return "UpdateMousePos"
    end
end
    if getgenv().CheckIfScriptLoaded == true then
        game.StarterGui:SetCore("SendNotification", {
        Title = "tonka.cc | .gg/tonkacc",
        Text = "New Sets Loaded! | ColloperWasHere ",
        Duration = 5,
        })
        return
   end

getgenv().CheckIfScriptLoaded = true


local function MainEventLocate()
    for _, v in pairs(Services.ReplicatedStorage:GetChildren()) do
        if v.Name == "MainEvent" then
            return v
        end
    end
end

local function SilentActivator(Place)
    if getgenv().Tonka.Direction.Enabled then
        if SilentTarget and SilentTarget.Character and SilentVelocity then
            if TargetKO(SilentTarget.Character, getgenv().Tonka.Checks.Direction) and
                IsOnScreen(SilentTarget.Character[getgenv().Tonka.Direction.Aimpart],
                    getgenv().Tonka.Checks.Direction) and
                Wall(SilentTarget.Character, getgenv().Tonka.Checks.Direction) and
                IsInRadius(SilentTarget.Character, getgenv().Tonka.Checks.Direction) and
                TargetForceField(SilentTarget.Character, getgenv().Tonka.Checks.Direction) and
                Crew(SilentTarget.Name, getgenv().Tonka.Checks.Direction) and
                Grabbed(SilentTarget.Character, getgenv().Tonka.Checks.Direction) and
                SilentTarget.Character:FindFirstChild("HumanoidRootPart") then
                MainEventLocate():FireServer(getgamesnamecall(), Place)
            end
        end
    end
end

Local.Player.Character.ChildAdded:Connect(LPH_JIT_MAX(function(tool)
    if tool:IsA("Tool") and
        (tool:FindFirstChild("Script") or tool:FindFirstChild("GunScript") or tool:FindFirstChild("weaponInfo")) then
        tool.Activated:Connect(function()
            SilentActivator(Aimplace)
        end)
    end
end))

Local.Player.CharacterAdded:Connect(LPH_JIT_MAX(function(Character)
    Character.ChildAdded:Connect(function(tool)
        if tool:IsA("Tool") and
            (tool:FindFirstChild("Script") or tool:FindFirstChild("GunScript") or tool:FindFirstChild("weaponInfo")) then
            tool.Activated:Connect(function()
                SilentActivator(Aimplace)
            end)
        end
    end)
end))

Services.UserInputService.InputBegan:Connect(LPH_JIT_MAX(function(input)
    if not (Services.UserInputService:GetFocusedTextBox()) then
        if input.KeyCode == Keybinds.Direction then
            if getgenv().Tonka.Direction.Enabled then
                getgenv().Tonka.Direction.Enabled = false
            elseif getgenv().Tonka.Direction.Enabled == false then
                getgenv().Tonka.Direction.Enabled = true
            end
        end
    end
end))
if getgenv().Tonka.Options.Intro then
    local Tracer = Drawing.new("Image")
    local Blur = Instance.new("BlurEffect")
    local screenSize = Services.Workspace.CurrentCamera.ViewportSize
    local centerPosition = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
    Tracer.Position = centerPosition
    Tracer.Size = Vector2.new(0, 0)
    Tracer.Visible = true
    Tracer.Data = game:HttpGet("https://i.imgur.com/rkMgDJG.png")
    Blur.Size = 0
    Blur.Parent = Services.Workspace.CurrentCamera
    for i = 1, 100 do
        Tracer.Size = Tracer.Size + (Vector2.new(540, 540) - Tracer.Size) / 20
        Tracer.Position = centerPosition - Tracer.Size / 2
        if Blur.Size ~= 10 then
            Blur.Size = Blur.Size + 1
        end
        task.wait()
    end
    Tracer.Size = Vector2.new(540, 540)
    Tracer.Position = centerPosition - Tracer.Size / 2
    wait(0.75)
    for i = 1, 85 do
        if Tracer.Transparency ~= 0 then
            Tracer.Transparency = Tracer.Transparency - 0.01
        end
        if Blur.Size ~= 0 then
            Blur.Size = Blur.Size - 1
        end
        task.wait()
    end
    Tracer.Size = Vector2.new(0, 0)
    Blur:Destroy()
end

wait(0.5)


-- // Misc

-- // Macro

local SpeedGlitch = false
Mouse.KeyDown:Connect(function(Key)
    if Key == (getgenv().Tonka.Macro.Keybind) and getgenv().Tonka.Macro.Type == "Third" then
        SpeedGlitch = not SpeedGlitch
        if SpeedGlitch == true then
            repeat
                task.wait(getgenv().Tonka.Macro.Speed / 100)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "I", false, game)
                task.wait(getgenv().Tonka.Macro.Speed / 100)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "O", false, game)
                task.wait(getgenv().Tonka.Macro.Speed / 100)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "I", false, game)
                task.wait(getgenv().Tonka.Macro.Speed / 100)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "O", false, game)
                task.wait(getgenv().Tonka.Macro.Speed / 100)
            until SpeedGlitch == false
        end
    end
end)
Mouse.KeyDown:Connect(function(Key)
    if Key == (getgenv().Tonka.Macro.Keybind) and getgenv().Tonka.Macro.Type == "First" then
        SpeedGlitch = not SpeedGlitch
        if SpeedGlitch == true then
            repeat
                task.wait(getgenv().Tonka.Macro.Speed / 100)
                game:GetService("VirtualInputManager"):SendMouseWheelEvent("0", "0", true, game)
                task.wait(getgenv().Tonka.Macro.Speed / 100)
                game:GetService("VirtualInputManager"):SendMouseWheelEvent("0", "0", false, game)
                task.wait(getgenv().Tonka.Macro.Speed / 100)
                game:GetService("VirtualInputManager"):SendMouseWheelEvent("0", "0", true, game)
                task.wait(getgenv().Tonka.Macro.Speed / 100)
                game:GetService("VirtualInputManager"):SendMouseWheelEvent("0", "0", false, game)
                task.wait(getgenv().Tonka.Macro.Speed / 100)
            until SpeedGlitch == false
        end
    end
end)

-- // 360 Keybind
if getgenv().Tonka.Camera.Spin.Enabled == true then
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local Toggle = false
local RotationSpeed = getgenv().Tonka.Camera.Spin.Speed
local Keybind = getgenv().Tonka.Camera.Spin.Key

local function OnKeyPress(Input, GameProcessedEvent)
    if Input.KeyCode == Enum.KeyCode[Keybind:upper()] and not GameProcessedEvent then
        Toggle = not Toggle
    end
end

UserInputService.InputBegan:Connect(OnKeyPress)

local LastRenderTime = 0
local FullCircleRotation = 2 * math.pi
local TotalRotation = 0

local function RotateCamera()
    if Toggle then
        local CurrentTime = tick()
        local TimeDelta = math.min(CurrentTime - LastRenderTime, 0.01)
        LastRenderTime = CurrentTime

        local Rotation = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), math.rad(RotationSpeed * TimeDelta))
        Camera.CFrame = Camera.CFrame * Rotation

        TotalRotation = TotalRotation + math.rad(RotationSpeed * TimeDelta)
        if TotalRotation >= FullCircleRotation then
            Toggle = false
            TotalRotation = 0
        end
    end
end

RunService.RenderStepped:Connect(RotateCamera)

-- // NoClip

if getgenv().Tonka.NoClip.Enabled == true then
    local Keybind = getgenv().Tonka.NoClip.Key
    while true do
        local function OnKeyPress(Input)
            if Input.KeyCode == Enum.KeyCode[Keybind:upper()] then
                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == getgenv().Tonka.NoClip.GunName then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                        task.wait(getgenv().Tonka.NoClip.Delay)
                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                    end
                end
            end
        end
        task.wait(getgenv().Tonka.NoClip.Delay)
    end
end
end
