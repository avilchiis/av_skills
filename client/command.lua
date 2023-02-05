RegisterCommand(Config.Command, function()
    local options = {}
    for k, v in pairs(Config.Skills) do
        local lvl = v
        -- Don't ask me why but ox_lib don't render progressbar if value is 0
        if lvl <= 0 then lvl = 1 end
        options[#options+1]={
            title = firstToUpper(k),
            icon = Config.Icons[k] or false,
            progress = tonumber(lvl),
            colorScheme = "teal"
        }
    end
    lib.registerContext({
        id = 'skills',
        title = 'Player Skills',
        options = options
    })
    lib.showContext('skills')
end)