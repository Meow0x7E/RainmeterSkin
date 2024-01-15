---让这个方法全局可用
function _G.RequireFile(FileName)
    return dofile(SKIN:GetVariable("@") .. "\\Lua\\" .. FileName)
end

File = {}

function Initialize()
    File = RequireFile("File")

    ProcessPath = SKIN:MakePathAbsolute("Process.inc")
    MeasureAudioLevel = GetMeasureAudioLevel()

    if (GetEnforce() or GetNowBands() ~= GetOldBands() or File.isNotExists(ProcessPath)) then
        UpdateProcess()
        SetEnforce(false)
    end
end

function UpdateProcess()
    WriteToProcess(BuildProcess(GetNowBands()))
    SKIN:Bang("!Refresh")
end

function ReadFile(path)
    local f = File.openFile(SKIN:MakePathAbsolute(path), "r")
    local s = f:read("*a")
    f:close()
    return s
end

function GetMeasureAudioLevel()
    return SKIN:GetMeasure("MeasureAudioLevel")
end

function GetNowBands()
    return math.floor(MeasureAudioLevel:GetNumberOption("Bands", 40))
end

function GetOldBands()
    return math.floor(tonumber(SKIN:GetVariable("OldBands", 0)))
end

function GetVariablesStr()
    return ReadFile("Resources\\Variables.txt")
end

function GetBandStr()
    return ReadFile("Resources\\Band.txt")
end

function GetBarStr()
    return ReadFile("Resources\\Bar.txt")
end

function GetEnforce()
    if (tonumber(SKIN:GetVariable("Enforce", 0)) > 0) then
        return true
    end
    return false
end

function SetEnforce(newValue)
    local tmp = nil
    if (newValue) then
        tmp = 1
    else
        tmp = 0
    end
    SKIN:Bang("!SetVariable", "Enforce", tmp)
    SKIN:Bang("!WriteKeyValue", "Variables", "Enforce", tmp)
end

function BuildProcess(total)
    local bandStr, barStr = GetBandStr(), GetBarStr()
    local band, bar, barMirror = "", "", ""
    for i = 0, total - 1, 1 do
        band = band .. bandStr:format(i, i)
        bar = bar .. barStr:format("", i, "", i)
        barMirror = barMirror .. barStr:format("Mirror", i, " | StyleBarMirror", i)
        if (i == 0) then
            bar = bar .. "X=0\n"
            barMirror = barMirror .. "X=0\n"
        end
    end
    return (
        GetVariablesStr():format(total) ..
        band ..
        bar ..
        barMirror
    )
end

function WriteToProcess(string)
    local f = File.openFile(ProcessPath, "w")
    f:write(string)
    f:flush()
    f:close()
end
