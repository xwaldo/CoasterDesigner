local Fusion = require(script.Parent.Parent.Packages.Fusion)
local Styles = require(script.Parent.Parent.Styles)

local function DropdownMenu(props)
	local Selected = props.Selected
	local Active = Fusion.Value(false)
	local Hover = Fusion.Value(false)
	local function Button(id)
		local ButtonSelected = Fusion.Computed(function()
			return Selected:get() == id
		end)
		local Hover = Fusion.Value(false)
		return Fusion.New("TextButton")({
			BackgroundColor3 = Fusion.Computed(function()
				return if Hover:get() or ButtonSelected:get()
					then Color3.fromHex("2c2c2c")
					else Color3.fromHex("353535")
			end),
			BorderColor3 = Color3.fromHex("2c2c2c"),
			[Fusion.OnEvent("Activated")] = function()
				Active:set(false)

				Selected:set(id)
			end,
			[Fusion.OnEvent("MouseEnter")] = function()
				Hover:set(true)
			end,
			[Fusion.OnEvent("MouseLeave")] = function()
				Hover:set(false)
			end,
			[Fusion.Children] = {
				Fusion.New("TextLabel")({
					TextColor3 = Styles.BasicText.TextColor3,
					TextXAlignment = Enum.TextXAlignment.Left,
					Text = id or "<None>",
					Position = UDim2.new(0, 5, 0, 0),
					Size = UDim2.new(1, -10, 1, 0),
					BackgroundTransparency = 1,
				}),
			},
			BackgroundTransparency = 0,
			BorderSizePixel = 1,
			Size = UDim2.new(1, 0, 0, 20),
		})
	end
	local function ScrollingFrame()
		local Tween = Fusion.Tween(
			Fusion.Computed(function()
				local currentActive = Active:get()
				return if currentActive then UDim2.new(1, 0, 0, 80) else UDim2.new(1, 0, 0, 0)
			end),
			TweenInfo.new(0.2)
		)

		return Fusion.New("TextButton")({

			Selectable = false,
			Active = false,
			Visible = Active,
			Position = UDim2.new(0, 0, 1, 0),
			--           CanvasSize = UDim2.new(0,0,0,25),
			BackgroundTransparency = 1,
			Size = Tween,

			[Fusion.Children] = {
				Fusion.New("ScrollingFrame")({
					ScrollBarImageTransparency = Fusion.Computed(function()
						local currentTween = Tween:get()
						return if currentTween == UDim2.new(1, 0, 0, 80) then 0 else 1
					end),
					ScrollBarImageColor3 = Color3.fromHex("#222222"),
					TopImage = "rbxasset://textures/ui/scrollbuttonUp.png",
					BottomImage = "rbxasset://textures/ui/scrollbuttonDown.png",
					MidImage = "rbxasset://textures/ui/scroll-middle.png",
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					BorderSizePixel = 1,
					BorderColor3 = Color3.fromHex("222222"),
					Size = UDim2.fromScale(1, 1),
					BackgroundColor3 = Color3.fromHex("353535"),
					[Fusion.Children] = {
						Fusion.New("UIListLayout")({
							Padding = UDim.new(0, 0),
							FillDirection = Enum.FillDirection.Vertical,
							SortOrder = Enum.SortOrder.LayoutOrder,
						}),
						Button(),

						Fusion.ForValues(props.Content, function(coaster)
							return Button(coaster)
						end, Fusion.cleanup),
					},
				}),
			},
		})
	end

	local element = Fusion.New("TextButton")({
		ZIndex = 2,
		BackgroundColor3 = Fusion.Computed(function()
			return if Hover:get() then Color3.fromHex("2c2c2c") else Color3.fromHex("353535")
		end),
		BorderSizePixel = 1,
		BorderColor3 = Color3.fromHex("222222"),
		Size = UDim2.new(0, 0, 1, 0),

		[Fusion.OnEvent("MouseEnter")] = function()
			Hover:set(true)
		end,
		[Fusion.OnEvent("MouseLeave")] = function()
			Hover:set(false)
		end,
		[Fusion.OnEvent("Activated")] = function()
			Active:set(not Active:get())
		end,
		[Fusion.Children] = {
			Fusion.New("Folder")({
				[Fusion.Children] = {
					ScrollingFrame(),
				},
			}),
			Fusion.New("UIListLayout")({
				Padding = UDim.new(0, 2),
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
			Fusion.New("Frame")({}),
			Fusion.New("TextLabel")({
				Text = Fusion.Computed(function()  
                    return Selected:get() or "<None>"
                end),
				TextColor3 = Styles.BasicText.TextColor3,

				TextTruncate = Enum.TextTruncate.AtEnd,
				LayoutOrder = 0,
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromHex("222222"),
				BorderSizePixel = 1,
				Size = UDim2.fromScale(1, 1),
				[Fusion.Children] = {
					Fusion.New("UIFlexItem")({
						FlexMode = Enum.UIFlexMode.Fill,
					}),
				},
			}),
			Fusion.New("Frame")({
				LayoutOrder = 1,
				BorderColor3 = Color3.fromHex("222222"),
				BorderSizePixel = 1,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				[Fusion.Children] = {
					Fusion.New("ImageLabel")({
						ScaleType = Enum.ScaleType.Fit,
						BackgroundTransparency = 1,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.fromScale(0.5, 0.5),
						Size = UDim2.fromScale(0.5, 0.5),
						Image = "rbxassetid://5279719038",
						ImageColor3 = Styles.BasicText.TextColor3,
					}),
					Fusion.New("UIAspectRatioConstraint")({ AspectRatio = 0.8 }),
				},
			}),
			Fusion.New("UIFlexItem")({
				FlexMode = Enum.UIFlexMode.Fill,
			}),
		},
	})

	return element
end

return function(props)
	local CurrentCoaster = props.CurrentCoaster
	local Coasters = props.Coasters

	local element = Fusion.New("Frame")({
		ZIndex = 2,
		Position = props.Position,
		Size = UDim2.new(1, -60, 1, -6),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		[Fusion.Children] = {
			Fusion.New("UIListLayout")({
				VerticalAlignment = Enum.VerticalAlignment.Center,
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			Fusion.New("TextLabel")({
				LayoutOrder = 0,
				BackgroundTransparency = 1,
				TextColor3 = Styles.BasicText.TextColor3,
				Font = Styles.BasicText.Font,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Position = UDim2.new(0, 0, 0, 0),
				Size = UDim2.new(0.2, 15, 1, 0),
				Text = "Coaster:",
			}),
			DropdownMenu({
				Content = Coasters,
				Selected = CurrentCoaster,
			}),
		},
	})

	return element
end
