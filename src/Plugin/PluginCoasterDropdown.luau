local Fusion = require(script.Parent.Parent.Packages.Fusion)
local Styles = require(script.Parent.Parent.Styles)

return function(props)
    
    local CurrentCoaster = props.CurrentCoaster
    local Coasters = props.Coasters
    
    local Hover = Fusion.Value(false)
    local function DropdownMenu(props)
        local element = Fusion.New("TextButton"){
            BackgroundColor3 = Fusion.Computed(function()  
                return if Hover:get() then
                    Color3.fromHex("2c2c2c")
                else
                    Color3.fromHex("353535")
            end),
            BorderSizePixel = 1,
            BorderColor3 = Color3.fromHex("222222"),
            Size = UDim2.new(0,0,1,0),

            [Fusion.OnEvent("MouseEnter")] = function()
                Hover:set(true)
            end,
            [Fusion.OnEvent("MouseLeave")] = function()
                Hover:set(false)
            end,

            [Fusion.Children] = {
                Fusion.New("UIListLayout"){
                    Padding = UDim.new(0,2),
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                },
                Fusion.New("Frame"){},
                Fusion.New("TextLabel"){
                    Text = "IntaminLSMCoaster",
                    TextColor3 = Styles.BasicText.TextColor3,

                    TextTruncate = Enum.TextTruncate.AtEnd,
                    LayoutOrder = 0,
                    BackgroundTransparency = 1,
                    BorderColor3 = Color3.fromHex("222222"),
                    BorderSizePixel = 1,
                    Size = UDim2.fromScale(1, 1),
                    [Fusion.Children] = {
                        Fusion.New("UIFlexItem"){
                            FlexMode = Enum.UIFlexMode.Fill
                        }                    
                    }
                },
                Fusion.New("Frame"){
                    LayoutOrder = 1,
                    BorderColor3 = Color3.fromHex("222222"),
                    BorderSizePixel = 1,
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    [Fusion.Children] = {
                        Fusion.New "ImageLabel"{
                            BackgroundTransparency = 1,
                            AnchorPoint = Vector2.new(0.5,0.5),
                            Position = UDim2.fromScale(0.5,0.5),
                            Size = UDim2.fromScale(0.5, 0.5),
                            Image = "rbxassetid://5279719038",
                            ImageColor3 = Styles.BasicText.TextColor3,
                        },
                        Fusion.New("UIAspectRatioConstraint"){}
                    }
                },
                Fusion.New("UIFlexItem"){
                    FlexMode = Enum.UIFlexMode.Fill
                }
            }
        }

        return element
    end

    local element = Fusion.New("Frame"){
        Position = props.Position,
        Size = UDim2.new(1,-60,1,-6),
        AnchorPoint = Vector2.new(0,0.5),
        BackgroundTransparency = 1,
        [Fusion.Children] = {
            Fusion.New("UIListLayout"){
                VerticalAlignment = Enum.VerticalAlignment.Center,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder
            },
            Fusion.New("TextLabel"){
                LayoutOrder = 0,
                BackgroundTransparency = 1,
                TextColor3 = Styles.BasicText.TextColor3,
                Font = Styles.BasicText.Font,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Position = UDim2.new(0,0,0,0),
                Size = UDim2.new(0.2,15,1,0),
                Text = "Coaster:"
            },
            DropdownMenu{
                Content = Coasters,
                Selected = CurrentCoaster
            }

        }
    }
    
    return element
end
