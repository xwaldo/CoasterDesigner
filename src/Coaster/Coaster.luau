local Fusion = require(script.Parent.Parent.Packages.Fusion)

local Coaster = {}
Coaster.__index = Coaster

local function LoadPoints(Folder)
        
end
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

local function CreateCoaster(props)
    
end

function Coaster.new()
    
end

local function LoadPoints(Folder)
        
end
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

local function CreateCoaster(props)
    
end

local Coasters = Fusion.Value(Fusion.ForPairs(GetCoasterFolders(), function(_,folder)  
    return CreateCoaster(LoadCoaster(folder))
end))


return Coaster