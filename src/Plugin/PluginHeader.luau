local Fusion = require(script.Parent.Parent.Packages.Fusion)
local Settings = require(script.Parent.Parent.Settings)

return function(parent)
    local element = Fusion.New("Frame"){
        Parent = parent,
        Size = UDim2.new(1,0,0,25),
        BackgroundTransparency = 1,
        [Fusion.Children] = {
            
            Fusion.New("Frame"){
                LayoutOrder = 0,
                BackgroundColor3 = Color3.fromHex("222222"),
                Position = UDim2.fromScale(0,1),
                AnchorPoint = Vector2.new(0,1),
                Size = UDim2.new(1,0,0,1),
            },
            Fusion.New("Folder"){
                [Fusion.Children] = {
                    Fusion.New("UIListLayout"){
                        FillDirection = Enum.FillDirection.Horizontal,
                        SortOrder = Enum.SortOrder.LayoutOrder, 
                        Padding = UDim.new(0,5),
                        VerticalAlignment = Enum.VerticalAlignment.Center
                    }, 
                    Fusion.New("Frame"){LayoutOrder = 0},

                    Fusion.New("ImageLabel"){
                        LayoutOrder = 1,
                        BackgroundTransparency = 1,
                        Image = "http://www.roblox.com/asset/?id=18214930989",

                        Size = UDim2.new(0,20,0,20),
                    },
                    Fusion.New("TextLabel"){
                        LayoutOrder = 2,
                        Text = "Coaster Designer  ",
                        Font = Enum.Font.SourceSansSemibold,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextColor3 = Color3.new(1.000000, 1.000000, 1.000000),
                        BackgroundTransparency = 1,
                        --TextWrapped = true,
                        TextTruncate = Enum.TextTruncate.SplitWord,
                        Size = UDim2.new(0.3,0,1,-4),
                        --AutomaticSize = Enum.AutomaticSize.X
                    },
                    Fusion.New("TextLabel"){
                        LayoutOrder = 3,
                        Text = "v"..Settings.Version,
                        Font = Enum.Font.SourceSans,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextColor3 = Color3.new(1.000000, 1.000000, 1.000000),
                        BackgroundTransparency = 1,
                        --TextWrapped = true,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Size = UDim2.new(0,40,1,-4),
                    },
                    Fusion.New("ImageLabel"){
                        LayoutOrder = 4,
                        BackgroundTransparency = 1,
                        Image = "http://www.roblox.com/asset/?id=18214930989",

                        Size = UDim2.new(0,20,0,20),
                    },
                }
            }
            
        }
    }
    return element
end

