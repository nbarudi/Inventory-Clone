moat_droptable_names_tier = {}
moat_droptable_names_unique = {}
moat_weapontable_names = {}
moat_talenttable_names = {}

function d3a_initTableName()
    if MOAT_DROPTABLE == nil or weapons.GetList() == nil or MOAT_TALENTS == nil then
        timer.Simple(1, d3a_initTableName)
        return 
    end
    for index, item in pairs(MOAT_DROPTABLE) do
        if item.Kind == "tier" then
            moat_droptable_names_tier[item.Name] = item.ID
        elseif item.Kind == "Unique" then
            moat_droptable_names_unique[item.Name] = item.ID
        end
    end
    for index, weapon in pairs(weapons.GetList()) do
        if weapon.Base == "weapon_tttbase" then
            if(weapon.PrintName == nil) then
                continue 
            end
            moat_weapontable_names[weapon.PrintName:lower()] = weapon.ClassName
        end
    end
    for index, talent in pairs(MOAT_TALENTS) do
        moat_talenttable_names[talent.Name] = talent.ID
    end
    moat_talenttable_names["random"] = 0
    moat_talenttable_names["None"] = 0
end

d3a_initTableName()