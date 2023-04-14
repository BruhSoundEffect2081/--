local ChestTypesNames = {
    "Sailor Chest";"Great Sailor Chest";"Elite Sailor Chest";
    "Silver Chest";"Golden Chest";
    "Weapon Chest";"Great Weapon Chest";"Elite Weapon Chest";
    "Armor Chest";"Great Armor Chest";"Elite Armor Chest";
    "Scroll Chest";"Uncommon Scroll Chest";"Great Scroll Chest";"Elite Scroll Chest";
    "Food Crate";"Uncommon Food Crate";
    "Ingredient Bag";"Uncommon Ingredient Bag";"Rare Ingredient Bag";
}

local Chests = {}
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotOreoz/huh/main/youshouldNOW.lua"))()
ESP.Tracers = getgenv().Tracers
ESP.Names = true
ESP.Boxes = getgenv().Boxes
ESP.Players = getgenv().PlayerESP
ESP.Color = Color3.fromRGB(255,55,55)
ESP:Toggle(true)
local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/BruhSoundEffect2081/--/main/----.lua"))()
local Window = SolarisLib:New({Name = "Arcane Odyssey Chest ESP - SamKogos#1157",FolderToSave = ""})
local SetTab = Window:Tab("-") 
local MainSec = SetTab:Section("-") 
local Map = game:GetService("Workspace").Map
local function AddAllChests()
    for chesttype,enabled in pairs(ChestTypes) do
        ESP[chesttype] = enabled
    end
    for _,chest in pairs(Map:GetDescendants()) do
        if chest:IsA("Model") and getgenv().ChestTypes[chest.Name] then
            ESP:Add(chest:FindFirstChildWhichIsA("MeshPart"), {
                Name = chest.Name,
                IsEnabled = chest.Name,
                Color = getgenv().ChestESPColor,
                Size = Vector3.new(1,1,1)
            })
        end
    end
end

local function AddSpecificChest(chest)
    if chest:IsA("Model") and getgenv().ChestTypes[chest.Name] then
        ESP:Add(chest:FindFirstChildWhichIsA("MeshPart"), {
            Name = chest.Name,
            IsEnabled = chest.Name,
            Color = getgenv().ChestESPColor
        })
    end
end

Map.DescendantAdded:Connect(function(chest)
    wait()
    if string.find(chest.Name,"Chest") and chest.Parent then
        if string.find(v.Parent,Name,"Chest") then
            AddSpecificChest(chest)
        end
    end
end)

MainSec:Label("ESP Settings")

MainSec:Toggle("Player ESP", false, "a1", function(newval)
    ESP.Players = newval
end)

MainSec:Toggle("Tracers", false, "a1", function(newval)
    ESP.Tracers = newval
end)

MainSec:Toggle("Boxes", false, "a1", function(newval)
    ESP.Boxes = newval
end)
    
MainSec:Label("Chests/Bags/Crates")

for _,v in pairs(ChestTypesNames) do
    MainSec:Toggle(v, false, "a1", function(newval)
        ChestTypes[v] = newval
        AddAllChests()
    end)
end

AddAllChests()
