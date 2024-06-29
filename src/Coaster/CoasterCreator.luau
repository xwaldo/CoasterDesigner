local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Fusion = require(script.Parent.Parent.Packages.Fusion)
local Styles = require(script.Parent.Parent.Styles)



function GetCoasterFolders()
    return ServerStorage.CoasterDesignerData.Coasters:GetChildren()
end
function GetNewCoasterName()
    
end




function CoasterCreator(props)

    local Coasters = props.Coasters

	local CurrentCoaster = props.CurrentCoaster

    local newPoints = Fusion.Value({})
    local newName = Fusion.Value(GetNewCoasterName())


    local function CreateButton(props)
        local Hover = Fusion.Value(false)
        
        return Fusion.New("TextButton")({
            [Fusion.OnEvent("MouseEnter")] = function()
                Hover:set(true)
            end,
            [Fusion.OnEvent("MouseLeave")] = function()
                Hover:set(false)
            end,
            [Fusion.OnEvent("Activated")] = function()
            end,
            BorderSizePixel = 1,
            BorderColor3 = Color3.fromHex("222222"),
            BackgroundColor3 = Fusion.Computed(function()  
                return if Hover:get() then Color3.fromHex("#62ec0b")else Color3.fromHex("#6ac730") 
            end),
            LayoutOrder = 2,
            Text = "CREATE",
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextColor3 = Color3.new(1,1,1),
            Font = Enum.Font.SourceSansBold,
            Size = UDim2.new(1, 0, 0, 20),
        })
    end
    local function ValueLine(props)
        local Button
        local Focus = Fusion.Value(false)
        local Hover = Fusion.Value(false)
        if props.Type == "Text" then
            function Button()
                local element = Fusion.New("TextBox"){
                    Text =  newName,
                    [Fusion.Out("Text")] = newName, 
                    [Fusion.OnEvent("MouseEnter")] = function()
                        Hover:set(true)
                    end,
                    [Fusion.OnEvent("MouseLeave")] = function()
                        Hover:set(false)
                    end,
                    [Fusion.OnEvent("Focused")] = function()
                        Focus:set(true)
                    end,
                    [Fusion.OnEvent("FocusLost")] = function(enterPressed)

                        Focus:set(false)
                    end,
                    BackgroundColor3 = Fusion.Computed(function()
                        return if Hover:get() or Focus:get() then Color3.fromHex("2c2c2c") else Color3.fromHex("353535")
                    end),
                    
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    PlaceholderText = props.PlaceholderText,
                    TextColor3 = Color3.fromHex("aaaaaa"),
                    PlaceholderColor3 = Color3.fromHex("#616161"),
                    BorderColor3 = Color3.fromHex("222222"),
                    BorderSizePixel = 1,
                    Position = UDim2.new(0.1,24,0,0),
                    Size = UDim2.new(0.9,-24,1,0),
                }
                return element
            end
        end
            
        local element = Fusion.New("Frame"){
            BorderColor3 = Color3.fromHex("222222"),
            BackgroundColor3 = Color3.fromHex("353535"),
            Size = UDim2.new(1,0,0,20),
            [Fusion.Children] = {
                Fusion.New("TextLabel"){
                    BackgroundTransparency = 1,
                    Text = props.Label.. ": ",
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextXAlignment = Enum.TextXAlignment.Right,
					TextColor3 = Styles.BasicText.TextColor3,
					Font = Enum.Font.SourceSans,
                    Position = UDim2.new(0,4,0,0),
                    Size = UDim2.new(0.1,18,1,0),
                },
                Button(),
                props.Children
            }
        }
        return element
    end
    local element = Fusion.New("Frame")({
		Visible = Fusion.Computed(function()
			return CurrentCoaster:get() == nil
		end),
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		[Fusion.Children] = {

			Fusion.New("Frame")({
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.new(0.5, 0, 0, 5),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -10, 0, 20),
				[Fusion.Children] = {
					Fusion.New("UIListLayout")({
                        FillDirection = Enum.FillDirection.Vertical,
						SortOrder = Enum.SortOrder.LayoutOrder,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
					}),
					Fusion.New("TextLabel")({
						BorderSizePixel = 1,
						BorderColor3 = Color3.fromHex("222222"),
						BackgroundColor3 = Color3.fromHex("353535"),
						LayoutOrder = 0,
						Text = "Create new coaster",
						TextTruncate = Enum.TextTruncate.SplitWord,
						TextColor3 = Styles.BasicText.TextColor3,
						Font = Styles.BasicText.Font,
						Size = UDim2.new(1, 0, 0, 20),
					}),
					Fusion.New("Frame")({
						BorderSizePixel = 1,
						BorderColor3 = Color3.fromHex("222222"),
						BackgroundColor3 = Color3.fromHex("353535"),
						LayoutOrder = 1,
						--Text = "Name:",
						--TextColor3 = Styles.BasicText.TextColor3,
						--Font = Enum.Font.SourceSans,
                        AutomaticSize = Enum.AutomaticSize.Y,
						Position = UDim2.new(),
						Size = UDim2.new(1, 0, 0, 20),
                        [Fusion.Children] = {
                            Fusion.New("UIListLayout")({
                                FillDirection = Enum.FillDirection.Vertical,
                                SortOrder = Enum.SortOrder.LayoutOrder,
                            }),
                            ValueLine({
                                Label = "Name",
                                PlaceholderText = "New Coaster",
                                Type = "Text"
                            }),
                            ValueLine({
                                Label = "Points",
                                PlaceholderText = "New Coaster",
                                Type = "Text"
                            }),
                        }
					}),
                    CreateButton()
				},
			}),
			Fusion.New("UIFlexItem")({
				FlexMode = Enum.UIFlexMode.Fill,
			}),
		},
	})

	return element
end

return CoasterCreator
