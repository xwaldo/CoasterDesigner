local Line = require(script.Parent.Parent.Components.Line)
local TabMenu = require(script.Parent.Parent.Components.TabMenu)
local Fusion = require(script.Parent.Parent.Packages.Fusion)
local Settings = require(script.Parent.Parent.Settings)

return function(props)
    local InfoSelected = Fusion.Value(false)
    local element = Fusion.New("Frame"){
        Size = UDim2.new(1,0,0,25),
        BackgroundTransparency = 1,
        [Fusion.Children] = {

            TabMenu{
                Position = UDim2.new(0,0),
                Size = UDim2.new(1,0,1,0),
                Content = {"TRACK","SUPPORTS","LAYOUT"},
                Default = 1,
            },
            
            Line(),
            
        }
    }
    
    return element
end

