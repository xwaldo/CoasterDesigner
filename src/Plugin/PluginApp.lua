local CoasterHeader = require(script.Parent.Parent.Coaster.CoasterHeader)
local Fusion = require(script.Parent.Parent.Packages.Fusion)
local Styles = require(script.Parent.Parent.Styles)
local PluginHeader = require(script.Parent.PluginHeader)

return function(widget)
    local CurrentCoaster = Fusion.Value(nil)

    local element = Fusion.New("Frame"){
        Parent = widget,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1,1),
        [Fusion.Children] = {
            Fusion.New("UIListLayout"){
                
            },
            PluginHeader{
                CurrentCoaster = CurrentCoaster
            },
            Fusion.New("Frame"){
                Visible = Fusion.Computed(function()  
                    return if CurrentCoaster:get() then false else true
                end),
                BackgroundTransparency = 1,
                Size = UDim2.new(1,0,0,0),
                [Fusion.Children] = {
                    Fusion.New("UIListLayout"){
                        VerticalAlignment = Enum.VerticalAlignment.Center
                    },
                    Fusion.New("Frame"){
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1,0,0.5,0),
                        [Fusion.Children] = {
                            Fusion.New("UIListLayout"){},
                            Fusion.New("TextLabel"){
                                LayoutOrder = 0,
                                Text = "Create new coaster",
                                TextColor3 = Styles.BasicText.TextColor3,
                                Font = Styles.BasicText.Font,
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1,0,0,20),
                            },
                            Fusion.New("TextLabel"){
                                LayoutOrder = 0,
                                Text = "Name:",
                                TextColor3 = Styles.BasicText.TextColor3,
                                Font = Enum.Font.SourceSans,
                                BackgroundTransparency = 0,
                                Position = UDim2.new(),
                                Size = UDim2.new(1,-4,0,20),
                            }
                        },
                    },
                    Fusion.New "UIFlexItem" {
                        FlexMode = Enum.UIFlexMode.Fill
                    },
                }

            },
            Fusion.New("Frame"){
                Visible = Fusion.Computed(function()  
                    return if CurrentCoaster:get() then true else false
                end),
                BackgroundTransparency = 1,
                Size = UDim2.new(1,0,0,0),
                [Fusion.Children] = {
                    Fusion.New("UIListLayout"){},
                    Fusion.New "UIFlexItem" {
                        FlexMode = Enum.UIFlexMode.Fill
                    },
                    CoasterHeader{
                        CurrentCoaster = CurrentCoaster
                    }
                }

            }
        }
    }

    return function()
        element:Destroy()
    end
end

