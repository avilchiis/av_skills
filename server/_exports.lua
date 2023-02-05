exports("addXP", function(src,skill,points)
    if not src or not skill or not points then
        print('^2[ERROR] addXP() missing arguments')
        return false 
    end
    return addXP(src,skill,points)
end)

exports("removeXP", function(src,skill,points)
    if not src or not skill or not points then
        print('^2[ERROR] removeXP() missing arguments')
        return false 
    end
    return removeXP(src,skill,points)
end)

exports("setXP", function(src,skill,points)
    if not src or not skill or not points then
        print('^2[ERROR] setXP() missing arguments')
        return false 
    end
    return setXP(src,skill,points)
end)

exports("getXP", function(src,skill)
    if not src or not skill then
        print('^2[ERROR] getXP() missing arguments')
        return false
    end
    return getXP(src,skill)
end)