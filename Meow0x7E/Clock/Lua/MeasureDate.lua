function Initialize()
    Week = { "一", "二", "三", "四", "五", "六", "日" }
    -- 我一定是闲的蛋疼才这么干
    for k, v in pairs(Week) do
        Week[k] = "星期" .. v
    end
end

function Update()
    Time = os.time()
    return ("%s %s"):format(FormatDate(), FormatDay())
end

function FormatDate()
    return os.date("%Y年%m月%d日", Time)
end

function FormatDay()
    return Week[tonumber(os.date("%w", Time))]
end
