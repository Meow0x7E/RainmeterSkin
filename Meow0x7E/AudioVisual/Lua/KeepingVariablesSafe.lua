ErrorNumber = 0

function Initialize()
    if (GetSpacingFactor() < 0) then
        PrintAndAddErrorNumber("SpacingFactor cannot be less than to 0!")
    end
    if (GetMinValue() < 0 or GetMinValue() > 1) then
        PrintAndAddErrorNumber("MinValue cannot be less than 0 or greater than 1!")
    end
    if (GetMaxValue() < 0 or GetMaxValue() > 1) then
        PrintAndAddErrorNumber("MaxValue cannot be less than 0 or greater than 1!")
    end
    if (GetMinValue() >= GetMaxValue()) then
        PrintAndAddErrorNumber("MinValue cannot be greater than or equal to MaxValue.")
    end
    if (ErrorNumber > 0) then
        error("Warning, 3 variables are not set correctly! Please check the debug messages for details.")
    end
end

function PrintAndAddErrorNumber(s)
    print(s)
    ErrorNumber = ErrorNumber + 1
end

function GetSpacingFactor()
    return tonumber(SKIN:GetVariable("SpacingFactor", 0))
end

function GetMinValue()
    return tonumber(SKIN:GetVariable("MinValue", 0))
end

function GetMaxValue()
    return tonumber(SKIN:GetVariable("MaxValue", 0))
end