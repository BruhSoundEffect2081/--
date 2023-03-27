--[[

Made by SamKogos#1157


]]

if not game:IsLoaded() then repeat task.wait() until game:IsLoaded() end
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

game:GetService("Players").LocalPlayer.Idled:connect(function()
   game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

getgenv().Testing = false
if not syn and Testing then
    Testing = false
end
if Testing then
    rconsolename("SE:R Testing Output")
    rconsoleinfo("-")
    rconsoleclear()
end

local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/BruhSoundEffect2081/--/main/----.lua"))()
local Window = SolarisLib:New({
    Name = "Soul Eater Reso - SamKogos#1157",
    FolderToSave = "SERGayScript"
})

local AFTab = Window:Tab("AutoFarm")
local NotifTab = Window:Tab("Notifications")
local ESPTab = Window:Tab("ESP")
local TPTab = Window:Tab("Teleports")
local VisualTab = Window:Tab("Visuals/Other")

local AFSec = AFTab:Section("-")
local NotifSec = NotifTab:Section("-")
local ESPSec = ESPTab:Section("-")
local TPSec = TPTab:Section("-")
local VisualSec = VisualTab:Section("-")

-- AFSec:Label("Only use 1")
AFSec:Label("Only use if you dont care about speed. Overnight this :>")
AFSec:Label("Long delay every 3 quests cause game is annoying and wont-")
AFSec:Label("-let you do these too fast :/")

local DeliveryAF = false
local NPCs = Workspace.radiantNpcs
local DeliveryFolder = Workspace.miscObjects.heroDelivery
local QuestCounter = 1
local QuestCD = 10
local CurrentQuestCD = 15
local FinishedQuest = false

AFSec:Toggle("Farm Hero Delivery ( VERY SLOW )", false,"af1", function(t)
    DeliveryAF = t
    CurrentQuestCD = 0
    FinishedQuest = false
    while DeliveryAF do
        if DeliveryAF then
            if Testing then
                rconsoleinfo("quest cd | "..QuestCounter.." | "..CurrentQuestCD)
            end
            task.wait(CurrentQuestCD)
            for _,NPC in pairs(NPCs:GetChildren()) do
                if string.find(NPC.Name,"Delivery") and NPC:FindFirstChild("HumanoidRootPart") and NPC:FindFirstChild("ProximityPrompt") and DeliveryAF then
                    local NPCHRP = NPC.HumanoidRootPart
                    local NPCPrompt = NPC.ProximityPrompt
                    local HRP = Players.LocalPlayer.Character.HumanoidRootPart or Players.LocalPlayer.CharacterAdded:Wait():FindFirstChild("HumanoidRootPart")
                    local Dist = (NPCHRP.Position - HRP.Position).magnitude
                    repeat
                        HRP.CFrame = NPCHRP.CFrame * CFrame.new(0,0,2)
                        Dist = (NPCHRP.Position - HRP.Position).magnitude
                        if Dist < 10 then
                            Dist = (NPCHRP.Position - HRP.Position).magnitude
                            repeat
                                fireproximityprompt(NPCPrompt)
                                if LocalPlayer.PlayerGui.ScreenGui.dialogue.Visible then
                                    for _,con in pairs(getconnections(LocalPlayer.PlayerGui.ScreenGui.dialogue.check.MouseButton1Down)) do
                                        con:Fire()
                                    end
                                end
                                task.wait()
                            until LocalPlayer.PlayerGui.ScreenGui.questMsg.Visible or not DeliveryAF or Dist < 10
                            wait(1)
                            if LocalPlayer.PlayerGui.ScreenGui.questMsg.Visible then
                                if Testing then
                                    rconsoleinfo("got quest | "..QuestCounter)
                                end
                                for _,del in pairs(DeliveryFolder:GetChildren()) do
                                    local Officer = del:FindFirstChildWhichIsA("Model")
                                    if Officer then
                                        if Officer:WaitForChild("owner").Value == LocalPlayer.Name then
                                            if Testing then
                                                rconsoleinfo("found officer, waiting for prox prompt | "..QuestCounter)
                                            end
                                            repeat
                                                repeat
                                                    task.wait()
                                                until Officer:FindFirstChildWhichIsA("ProximityPrompt")
                                                HRP.CFrame = del.zone.CFrame
                                                wait(1)
                                                fireproximityprompt(Officer:FindFirstChildWhichIsA("ProximityPrompt"))
                                                if LocalPlayer.PlayerGui.ScreenGui.dialogue.Visible then
                                                    wait(1)
                                                    for _,con in pairs(getconnections(LocalPlayer.PlayerGui.ScreenGui.dialogue.check.MouseButton1Down)) do
                                                        con:Fire()
                                                    end
                                                    wait()
                                                    FinishedQuest = true
                                                end
                                                wait()
                                            until FinishedQuest or not DeliveryAF
                                            if Testing then
                                                rconsoleinfo("finished quest | #"..QuestCounter)
                                            end
                                            QuestCounter = QuestCounter + 1
                                            if QuestCounter%3 == 0 then
                                                CurrentQuestCD = 61
                                            else
                                                CurrentQuestCD = 15
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        wait()
                    until FinishedQuest or not DeliveryAF
                    FinishedQuest = false
                    break
                end
            end
            wait()
        end
    end
end)

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotOreoz/huh/main/youshouldNOW.lua"))()
ESP.Tracers = false
ESP.Names = true
ESP.Boxes = false
ESP.Players = false
ESP.Color = Color3.fromRGB(255,0,0)
ESP.Thickness = 1
ESP:Toggle(true)

local SpecialEdClass = {
    ["Maki"] = false,
    ["The deaf kid"] = false,
    ["Eater-man"] = false,
    ["Cultist Witch"] = false
}

for _,v in pairs(SpecialEdClass) do
    NotifSec:Toggle(_, false, "hmm", function(t)
        SpecialEdClass[_] = t
        for _,v in pairs(game:GetService("Workspace").characters:GetChildren()) do
            if v:FindFirstChild("Head") and v.Head:FindFirstChild("overheadGui") then
                local VName = v.Head.overheadGui:WaitForChild("healthBar"):WaitForChild("charName")
                if tostring(VName.Text) == tostring(_) then
                    notif(VName.Text.." Spawned","-",15)
                    if v:FindFirstChild("HumanoidRootPart") then
                        ESP:Add(v:FindFirstChild("HumanoidRootPart"), {
                            Name = VName.Text,
                            IsEnabled = "BOSSESP",
                            Color = Color3.fromRGB(148, 48, 255)
                        })
                    end
                end
            end
        end
    end)
end

game:GetService("Workspace").characters.ChildAdded:Connect(function(v)
    wait(.5)
    if v.Head and v.Head:FindFirstChild("overheadGui") then
        local VName = v.Head.overheadGui:WaitForChild("healthBar"):WaitForChild("charName")
        if SpecialEdClass[VName.Text] then
            notif(VName.Text.." Spawned!","-",15)
            if v:FindFirstChild("HumanoidRootPart") then
                ESP:Add(v:FindFirstChild("HumanoidRootPart"), {
                    Name = VName.Text,
                    IsEnabled = "BOSSESP",
                    Color = Color3.fromRGB(148, 48, 255)
                })
                -- ESP.BOSSESP = true
            end
        end
    end
end)

-- this part gave me brain damage copy paste go BRRR R :)

ESPSec:Toggle("Names", false, "a2", function(t) ESP.Names = t end)

ESPSec:Toggle("Tracers", false, "a3", function(t) ESP.Tracers = t end)

ESPSec:Toggle("Boxes", false, "a4", function(t) ESP.Boxes = t end)

ESPSec:Label("----------")

ESPSec:Toggle("Players", false, "a7", function(t) ESP.Players = t end)

ESPSec:Toggle("Bosses", false, "a8", function(t) ESP.BOSSESP = t end)


local TeleportCFrames = {
    ["High Land"] = CFrame.new(-381.877869, -5.9122963, 1211.42273, 0.999941766, 8.94621195e-08, -0.0107900938, -8.93488377e-08, 1, 1.09809264e-08, 0.0107900938, -1.00162048e-08, 0.999941766);
    ["DWMA"] = CFrame.new(-316.658936, 92.5031815, 502.138184, 0.999941766, 6.92736535e-08, -0.0107900938, -6.91859441e-08, 1, 8.50213944e-09, 0.0107900938, -7.75512188e-09, 0.999941766);
    ["Smallville"] = CFrame.new(-1043.50684, -10.8020048, 412.287445, 0.999941766, 1.08608475e-07, -0.0107900938, -1.08470971e-07, 1, 1.33286786e-08, 0.0107900938, -1.2157491e-08, 0.999941766);
    ["Church"] = CFrame.new(-317.443817, -6.40100193, -152.024216, 0.999941766, -7.26704243e-08, -0.0107900938, 7.25784233e-08, 1, -8.91769947e-09, 0.0107900938, 8.13405254e-09, 0.999941766);
    ["Desert"] = CFrame.new(826.852478, -5.55846691, 213.161667, 0.999941766, 3.66757256e-08, -0.0107900938, -3.66292952e-08, 1, 4.50061455e-09, 0.0107900938, -4.10511936e-09, 0.999941766);
}

for _,v in pairs(TeleportCFrames) do
    TPSec:Button(_, function()
        LocalPlayer.Character.HumanoidRootPart.CFrame = TeleportCFrames[_]
    end)
end

--VisualTab

local A = nil
local AC = false
local FBT = false

VisualSec:Toggle("Show Hitboxes", false, "a9", function(t) 
    if t then
        A = game:GetService("Workspace").hitboxes.ChildAdded:Connect(function(v)
            v.Transparency = 0.80
            v.Color = Color3.fromRGB(255, 0, 0)
            v.Material = Enum.Material.SmoothPlastic
        end)
    else
        if A then
            A:Disconnect()
        end
    end
end)

VisualSec:Button("Instakill Meister (WEAPON)", function()
    for i = 1, 50 do
        game:GetService("ReplicatedStorage").remotes.remoteEvent:FireServer("resonate",{false})
    end
end)

local ARES = false
VisualSec:Toggle("Auto Resonane (WEAPON)", false, "a9", function(t) 
    ARES = t 
    while ARES do 
        if ARES then
            game:GetService("ReplicatedStorage").remotes.remoteEvent:FireServer("resonate",{true})
            wait()
        end
    end
end)

VisualSec:Toggle("Fullbright", false, "a10", function(t) 
    FBT = t
    while FBT do
        Lighting.Ambient = Color3.fromRGB(133,133,133)
        Lighting.GlobalShadows = false
        Lighting.Brightness = 1
        Lighting.FogEnd = math.huge
        if Workspace.Camera:FindFirstChild("Blur") then
            LWorkspace.Camera.Blur.Enabled = false
        end
        if Workspace.Camera:FindFirstChild("DepthOfField") then
            Workspace.Camera.DepthOfField.Enabled = false
        end
        wait(1)
    end
    Lighting.FogEnd = 1750
    Lighting.GlobalShadows = true
    Lighting.Ambient = Color3.fromRGB(70,70,70)
    if Workspace.Camera:FindFirstChild("Blur") then
        Workspace.Camera.Blur.Enabled = true
    end
    if Workspace.Camera:FindFirstChild("DepthOfField") then
        Workspace.Camera.DepthOfField.Enabled = true
    end
end)

VisualSec:Toggle("Autoclick Color Wheel", false, "a11", function(t) 
    AC = t
    if AC then
        while AC do
            wait()
            game:GetService("ReplicatedStorage").remotes.remoteEvent:FireServer("clickSpin")
        end
    end
end)
