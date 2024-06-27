local RunService = game:GetService("RunService")

if RunService:IsRunning() or not RunService:IsEdit() then
	return
end

local PluginApp = require(script.Plugin.PluginApp)
local Settings = require(script.Settings)

local pluginName = 
	"Coaster Designer" .. if Settings.DevMode then " [DEV]" else ""

local toolbar = plugin:CreateToolbar(pluginName)

local widgetInfo =  DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, true)
local widget = plugin:CreateDockWidgetPluginGui(pluginName, widgetInfo)
widget.Name = pluginName
widget.Title = pluginName.."  v"..Settings.Version
widget.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local button = toolbar:CreateButton("Launch Coaster Designer", "Open Coaster Designer", "http://www.roblox.com/asset/?id=18214930989")

local click = button.Click:Connect(function()
	widget.Enabled = not widget.Enabled
end)

local App = nil

if widget.Enabled then
	App = PluginApp(widget)
end

local enabled = widget:GetPropertyChangedSignal("Enabled"):Connect(function()
	button:SetActive(widget.Enabled)

	if widget.Enabled and App == nil then
		App = PluginApp(widget)
	end

end)

plugin.Unloading:Connect(function()
	if App then
		App()
	end
	click:Disconnect()
	enabled:Disconnect()
end)


