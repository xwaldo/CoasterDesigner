local Fusion = require(script.Parent.Parent.Packages.Fusion)
local PluginHeader = require(script.Parent.PluginHeader)

return function(widget)
    local element = Fusion.New("Frame"){
        Parent = widget,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1,1),
        [Fusion.Children] = {
            Fusion.New("UIListLayout"){
                
            },
            PluginHeader()
        }
    }
    return function()
        element:Destroy()
    end
end

