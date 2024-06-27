local Fusion = require(script.Parent.Parent.Packages.Fusion)

local Value, ForValues,ForPairs,OnEvent,Computed,Hydrate,Children,New = Fusion.Value, Fusion.ForValues,Fusion.ForPairs, Fusion.OnEvent, Fusion.Computed, Fusion.Hydrate, Fusion.Children,Fusion.New

local function Button(props)
    local Hover = Fusion.Value(false)
    local Selected = Computed(function()
        return props.Selected:get() == props.LayoutOrder
    end)
    local Element = New("TextButton"){
        AnchorPoint = Vector2.new(0.5,0.5),

        LayoutOrder = props.LayoutOrder,
        BackgroundColor3 = Computed(function() 
            return if Selected:get() or Hover:get() then Color3.fromHex("#2c2c2c") else Color3.fromHex("353535")
        end),

        Size = UDim2.new(props.Width,-1,1,-1),

        [OnEvent("Activated")] = function()
            props.Selected:set(props.LayoutOrder)
        end,
        [OnEvent("MouseEnter")] = function()
            Hover:set(true)
        end,
        [OnEvent("MouseLeave")] = function()
            Hover:set(false)
        end,
        [Children] = {
            Fusion.New("TextLabel"){
                Size = UDim2.new(1,-6,1,-4),
                AnchorPoint = Vector2.new(0.5,0.5),
                Position = UDim2.fromScale(0.5,0.5),
                Font = Enum.Font.SourceSansSemibold,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = props.Label,
                TextSize = 14,
                TextColor3 = Computed(function() 
                    return if Selected:get() then Color3.new(1,1,1) else Color3.fromHex("aaaaaa")
                end),
                BackgroundTransparency = 1,

            },
            --[[Fusion.New("UIFlexItem"){ RELEASE FLEXITEM PLEASE :c
                FlexMode = Enum.UIFlexMode.Fill
            }]]
        }
    }
    return Element
end

local function TabMenu(props)
    local Selected = Value(props.Default)
    local Element = New("Frame"){
        LayoutOrder = props.LayoutOrder,
        BackgroundTransparency = 1,
        BackgroundColor3 = Color3.fromHex("353535"),
        Position = props.Position,
        Size = props.Size,
        [Children] = {
            New("UIListLayout"){
                Padding = UDim.new(0,1),
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal
            },
            ForPairs(props.Content, 
                function(key,value)   
                    return key,Button{
                        LayoutOrder = key,
                        Selected = Selected,
                        Width = 1/#props.Content,
                        Label = value
                    }
                end,
                function(value)  
                    value:Destroy() 
                end
            ),
        }
    }
	return Element
end


return TabMenu
