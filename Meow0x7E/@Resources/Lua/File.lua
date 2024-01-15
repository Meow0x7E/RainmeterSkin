---@class File
local this = {}

function this.openFile(fileName, mode)
    if (type(fileName) ~= "string") then
        error("Desired type is string", 2)
    end

    local f = io.open(fileName, mode)

    if (io.type(f) ~= "file") then
        error("Cannot open file handles", 2)
    end
    return f
end

function this.isExists(file)
    return this.openFile(file, "r") ~= nil
end

function this.isNotExists(file)
    return this.openFile(file, "r") == nil
end

return this
