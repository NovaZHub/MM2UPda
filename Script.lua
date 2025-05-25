--[[
Murder Mystery 2 GUI Script - Estilo Redz Hub (Mobile + PC)
Funções incluídas: ESP colorido, Radar, Configurações, Segurança, Atualizações, Música, Notificador, AutoCoin, SpeedHack
Compatível: Apenas Murder Mystery 2
Segurança: Detecta executores inseguros e impede uso
--]]

if game.PlaceId ~= 142823291 then
    return game.Players.LocalPlayer:Kick("Script exclusivo para Murder Mystery 2")
end

local SafeExecutors = {"ArceusX", "KRNL", "Cryptic"}
local UnsafeExecutors = {"Delta", "Codex", "Fluxus"}
local executor = identifyexecutor and identifyexecutor() or "Desconhecido"

if table.find(UnsafeExecutors, executor) then
    local choice = Instance.new("Hint", workspace)
    choice.Text = "Executor inseguro detectado: "..executor..". Use KRNL para segurança."
    wait(5)
    game.Players.LocalPlayer:Kick("Eu te avisei >:(")
end

-- GUI Setup
local GuiLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/watermark%20lib"))()
local Window = GuiLib:CreateWindow("ChatGptHub | MM2")

-- Tabs
local TabESP = Window:CreateTab("ESP")
local TabRadar = Window:CreateTab("Radar")
local TabConfig = Window:CreateTab("Config")
local TabSecurity = Window:CreateTab("Segurança")
local TabMusic = Window:CreateTab("Música")
local TabUpdates = Window:CreateTab("Atualizações")

-- ESP Function
local function applyESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local color = Color3.fromRGB(0, 255, 0)
            if player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife") then
                color = Color3.fromRGB(255, 0, 0) -- Assassin
            elseif player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun") then
                color = Color3.fromRGB(0, 0, 255) -- Sheriff
            end
            if not player.Character.HumanoidRootPart:FindFirstChild("ESP") then
                local esp = Instance.new("BillboardGui")
                esp.Name = "ESP"
                esp.Size = UDim2.new(0, 100, 0, 40)
                esp.AlwaysOnTop = true
                esp.Parent = player.Character.HumanoidRootPart
                local tag = Instance.new("TextLabel")
                tag.Text = player.Name
                tag.Size = UDim2.new(1, 0, 1, 0)
                tag.TextColor3 = color
                tag.BackgroundTransparency = 1
                tag.Parent = esp
            end
        end
    end
end
TabESP:CreateButton("Ativar ESP", applyESP)

-- Radar (placeholder)
TabRadar:CreateLabel("Radar em desenvolvimento...")

-- Configurações
TabConfig:CreateDropdown("Tamanho da GUI", {"Small", "Medium", "Large"}, function(size)
    if size == "Small" then
        GuiLib:SetSize(300, 200)
    elseif size == "Medium" then
        GuiLib:SetSize(500, 300)
    else
        GuiLib:SetSize(700, 400)
    end
end)

TabConfig:CreateButton("Pegar moedas instantâneo", function()
    for _, coin in pairs(workspace:GetDescendants()) do
        if coin.Name == "Coin" and coin:IsA("Part") then
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, coin, 0)
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, coin, 1)
        end
    end
end)

TabConfig:CreateSlider("Velocidade", 30, 60, 30, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

-- Segurança
TabSecurity:CreateLabel("Executores seguros:")
for _, exec in pairs(SafeExecutors) do
    TabSecurity:CreateLabel("- " .. exec)
end
TabSecurity:CreateLabel("Executores perigosos como Delta, Codex e Fluxus serão bloqueados.")

-- Música
TabMusic:CreateTextbox("ID da Música", "Coloque o ID aqui", true, function(id)
    local Sound = Instance.new("Sound", game.Workspace)
    Sound.SoundId = "rbxassetid://" .. id
    Sound:Play()
end)

-- Atualizações
TabUpdates:CreateLabel("Última atualização: 25/05/2025")
TabUpdates:CreateLabel("- Adicionado Auto Coin")
TabUpdates:CreateLabel("- Proteção contra executores inseguros")
TabUpdates:CreateLabel("- Sistema de segurança com aviso e kick")
TabUpdates:CreateLabel("- Sistema de tamanho ajustável na aba Config")

-- Notificador
TabESP:CreateButton("Ativar Notificador", function()
    game:GetService("RunService").RenderStepped:Connect(function()
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer and plr.Character and (plr.Character:FindFirstChild("Knife") or plr.Backpack:FindFirstChild("Knife")) then
                local dist = (plr.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                if dist < 20 then
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "Cuidado!",
                        Text = plr.Name .. " está próximo e pode ser o assassino!",
                        Duration = 3
                    })
                end
            end
        end
    end)
end)

print("ChatGptHub MM2 Script carregado com sucesso!")
