function Sync()
    local data = lib.callback.await('av_skills:getData', false)
    for k, v in pairs(data) do
        Config.Skills[k] = v
    end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end