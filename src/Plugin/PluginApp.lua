local CoasterCreator = require(script.Parent.Parent.Coaster.CoasterCreator)
local CoasterHeader = require(script.Parent.Parent.Coaster.CoasterHeader)
local Fusion = require(script.Parent.Parent.Packages.Fusion)
local Styles = require(script.Parent.Parent.Styles)
local PluginHeader = require(script.Parent.PluginHeader)

local function LoadCoaster(Folder)
    local Name = Folder.Name
    local CreatedTime = Folder.CreatedTime.Value
    local Points = Fusion.ForValues(Folder.Points:GetChildren(), function(Points)  
        return {}--LoadPoints(Points)
    end)
    return {
        Name = Name,
        CreatedTime = CreatedTime,
        Points = Points
    }
end

return function(widget)
	local CurrentCoaster = Fusion.Value(nil)
    local Coasters = Fusion.Value(Fusion.ForPairs(GetCoasterFolders(), function(_,folder)  
		return LoadCoaster(folder)
	end))
	local CoastersToSelect = Fusion.ForPairs(Coasters, function(_, coaster)  
		return coaster.TimeCreated, coaster.name
	
	end)
	local element = Fusion.New("Frame")({
		Parent = widget,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		[Fusion.Children] = {
			Fusion.New("UIListLayout")({}),
			PluginHeader({
				Coasters = CoastersToSelect,
				CurrentCoaster = CurrentCoaster,
			}),
            CoasterCreator({
                CurrentCoaster = CurrentCoaster,
            }),
			Fusion.New("Frame")({
				Visible = Fusion.Computed(function()
					return CurrentCoaster:get() ~= nil
				end),
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 0),
				[Fusion.Children] = {
					Fusion.New("UIListLayout")({}),
					Fusion.New("UIFlexItem")({
						FlexMode = Enum.UIFlexMode.Fill,
					}),
					CoasterHeader({
						CurrentCoaster = CurrentCoaster,
					}),
				},
			}),
		},
	})
    
	return function()
		element:Destroy()
	end
end
