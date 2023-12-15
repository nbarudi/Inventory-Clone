COMMAND.Name = "SpawnUnique"
COMMAND.Flag = "h"

COMMAND.Args = {{"player", "Name/SteamID"}, {"string", "Item Name"}, {"string", "Custom Stats"}, {"number", "Damage Stat"}, {"number", "RPM Stat"}, {"number", "Ammo Stat"}, {"number", "Accuracy Stat"},
{"number", "Kick Stat"}, {"number", "Range Stat"}, {"number", "Weight Stat"}, {"number", "Reload Stat"}, {"number", "Deploy Stat"}, {"string", "Custom Talents"}, {"string", "Talent 1"}, {"string", "Talent 2"}, {"string", "Talent 3"},
{"string", "Talent 4"}, {"string", "Talent 5"}, {"string", "Hide Chat"}}

local string_to_bool = {
    ["True"] = true,
    ["False"] = false
}
//spawnunique player itemname doCustomStats dmgstat rpmstat ammostat accstat kickstat rangestat weightstat reloadstat deploystat doCustomTalents T1 T2 T3 T4 T5 hideChat

local function percToMySql(percent, item, type) 
    if(item.Stats[type] == nil) then
        return 0
    end
    mysql_val = (percent - item.Stats[type].min)/(item.Stats[type].max - item.Stats[type].min)
    return math.Round(mysql_val, 3)
end

COMMAND.Run = function(pl, args, supp)
    d3a_initTableName()
    local stats = nil
    local talents = nil
    if(string_to_bool[args[3]]) then
        stats = {}
        item = GetItemFromEnum(moat_droptable_names_unique[args[2]])
        if(args[4] ~= -1) then
            if(item.Stats.Damage ~= nil) then
                stats.d = percToMySql(args[4], item, "Damage")
            end
        else
            if(item.Stats.Damage ~= nil) then
                stats.d = math.Round(math.random(0, 1), 3)
            end
        end
        if(args[5] ~= -1) then
            if(item.Stats.Firerate ~= nil) then
                stats.f = percToMySql(args[5], item, "Firerate")
            end
        else
            if(item.Stats.Firerate ~= nil) then
                stats.f = math.Round(math.random(0, 1), 3)
            end
        end
        if(args[6] ~= -1) then
            if(item.Stats.Magazine ~= nil) then
                stats.m = percToMySql(args[6], item, "Magazine")
            end
        else
            if(item.Stats.Magazine ~= nil) then
                stats.m = math.Round(math.random(0, 1), 3)
            end
        end
        if(args[7] ~= -1) then
            if(item.Stats.Accuracy ~= nil) then
                stats.a = percToMySql(args[7], item, "Accuracy")
            end
        else
            if(item.Stats.Accuracy ~= nil) then
                stats.a = math.Round(math.random(0, 1), 3)
            end
        end
        if(args[8] ~= -1) then
            if(item.Stats.Kick ~= nil) then
                stats.k = percToMySql(args[8], item, "Kick")
            end
        else
            if(item.Stats.Kick ~= nil) then
                stats.k = math.Round(math.random(0, 1), 3)
            end
        end
        if(args[9] ~= -1) then
            if(item.Stats.Range ~= nil) then
                stats.r = percToMySql(args[9], item, "Range")
            end
        else
            if(item.Stats.Range ~= nil) then
                stats.r = math.Round(math.random(0, 1), 3)
            end
        end
        if(args[10] ~= -1) then
            if(item.Stats.Weight ~= nil) then
                stats.w = percToMySql(args[10], item, "Weight")
            end
        else
            if(item.Stats.Weight ~= nil) then
                stats.w = math.Round(math.random(0, 1), 3)
            end
        end
        if(args[11] ~= -1) then
            if(item.Stats.Reloadrate ~= nil) then
                stats.y = percToMySql(args[11], item, "Reloadrate")
            end
        else
            if(item.Stats.Reloadrate ~= nil) then
                stats.y = math.Round(math.random(0, 1), 3)
            end
        end
        if(args[12] ~= -1) then
            if(item.Stats.Deployrate ~= nil) then
                stats.z = percToMySql(args[12], item, "Deployrate")
            end
        else
            if(item.Stats.Deployrate ~= nil) then
                stats.z = math.Round(math.random(0, 1), 3)
            end
        end
    end
    if(string_to_bool[args[13]]) then
        talents = {}
        if(args[14] ~= "None") then
            table.insert(talents, args[14])
        end
        if(args[15] ~= "None") then
            table.insert(talents, args[15])
        end
        if(args[16] ~= "None") then
            table.insert(talents, args[16])
        end
        if(args[17] ~= "None") then
            table.insert(talents, args[17])
        end
        if(args[18] ~= "None") then
            table.insert(talents, args[18])
        end
    end
    if(stats ~= nil and talents ~= nil) then
        supp[1]:m_DropInventoryItem(args[2], "", nil, nil, string_to_bool[args[19]], talents, stats)
    elseif(stats ~= nil) then
        supp[1]:m_DropInventoryItem(args[2], "", nil, nil, string_to_bool[args[19]], nil, stats)
    elseif(talents ~= nil) then
        supp[1]:m_DropInventoryItem(args[2], "", nil, nil, string_to_bool[args[19]], talents)
    else
        supp[1]:m_DropInventoryItem(args[2], "", nil, nil, string_to_bool[args[19]], talents, stats)
    end
end