local Fusion = require(script.Parent.Parent.Packages.Fusion)

return function()
    return Fusion.New("Frame"){
        LayoutOrder = 0,
        BackgroundColor3 = Color3.fromHex("222222"),
        Position = UDim2.fromScale(0,1),
        AnchorPoint = Vector2.new(0,1),
        Size = UDim2.new(1,0,0,1),
        
    }
end
