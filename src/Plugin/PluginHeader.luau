local Line = require(script.Parent.Parent.Components.Line)
local TabMenu = require(script.Parent.Parent.Components.TabMenu)
local Fusion = require(script.Parent.Parent.Packages.Fusion)
local Settings = require(script.Parent.Parent.Settings)
local PluginCoasterDropdown = require(script.Parent.PluginCoasterDropdown)

return function(props)
    local CurrentCoaster = props.CurrentCoaster
    local element = Fusion.New("Frame"){
        Size = UDim2.new(1,0,0,25),
        BackgroundTransparency = 1,
        [Fusion.Children] = {
            Fusion.New("ImageButton"){
                LayoutOrder = 4,
                BackgroundTransparency = 1,
                AutoButtonColor = true,
                Image = "http://www.roblox.com/asset/?id=12298448247",
                AnchorPoint = Vector2.new(1,0.5),
                Position = UDim2.new(1,-4,0.5,0),
                Size = UDim2.new(0,20,0,20),
                [Fusion.OnEvent("Activated")] = function()
                
                end
            },
            PluginCoasterDropdown{
                CurrentCoaster = CurrentCoaster,
                Position = UDim2.new(0,30,0.5,0),
            },
            Fusion.New("ImageLabel"){
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Image = "http://www.roblox.com/asset/?id=18214930989",
                Position = UDim2.new(0,4,0.5,0),
                Size = UDim2.new(0,20,0,20),
                AnchorPoint = Vector2.new(0,0.5),
            },
            
            Line(),
            
        }
    }
    
    return element
end

