-- todo replace relay
moat.cfg.webhook = "http://208.103.169.40:5059/"
moat.cfg.oldwebhook = "http://107.191.51.43:3000/"

moat.cfg.discord = {
    primarywebhook = "https://discord.com/api/webhooks/1183903981307691018/nep5BrVGu3ngZYVR-F7IDAqUt8rnz95Lso9SWz8JeHXuJ1X3ru0qL2BVIxlVUjxFtLx1"
}

discord.AddChannels {
	["general"] = "https://discord.com/api/webhooks/1183904070273093782/lAc0McfxJRKSz4Uit8FOs9HdIsCbOpSrS6_ZKDrbr_NkW-I2DWCK88Mpjqnss3fXBxen",
	["ttt-bot"] = "https://discord.com/api/webhooks/1183904157648818277/plfyG72835hBYLSRn7D-G_MC-pUabk_S-ELkNp8Ue6UN5D7WGZ9iQlZEdlp60MD4F7wE",
	["tradinglounge"] = "https://discord.com/api/webhooks/1183904235532849283/zaQcnt_XGtmqe67NpsPUs4wF8vEqNR7UO6Vo9alnEsL0w5d6i2s_NZsELfjY7tbn0OiL",
	["ttt-challenges"] = "https://discord.com/api/webhooks/1183904304017453066/R_sVIrXY80Tmvb-BmF_7IthsZc_i_zSYq72UOskAuMK43nG1-dMfT2FmE39QEOuLgnuC",
	["ttt-logs"] = "https://discord.com/api/webhooks/1183904357322854410/aVhOycHHJKSuqnpr8BEu7cjmhgCTi1o6mmzpz2GriAA9R9DyQLCOKLH_YcKOiIoFnhLW",
    ["staff-logs"] = "https://discord.com/api/webhooks/1183904417976701028/9Z1lSa20DSo8SvAvvgurgQx6gMFqjrt1NoYIwDZpqBrGP-Ax393F8LFuzvXbIJYTI-uc",
    ["boss-logs"] = "https://discord.com/api/webhooks/1183904506250014880/tC_1bDcKcCV-MgQlVLc5-582enzFv4bIH_neePhUej38etSE4wkdiJTYlnaxcieKdLut",
    ["error-logs"] = "https://discord.com/api/webhooks/1183904565075124294/bIpceSMxDc2sDEsVwlbwwzrRBRLzfyh8LLvFDnIDjA5m4CWahjjkmry98Jv6eRM9jGQ1",
    ["dev-logs"] = "https://discord.com/api/webhooks/1183904632003645551/iV-pOGZ9Zv6569-t-alQ22TvyOOQpuHM8dyfCWxe7r3g14g59TQq_CPyXPAODhdOXWvp",
	["mga-logs"] = "https://discord.com/api/webhooks/1183904689612398654/guecqd8t7lauTpSJyJGYKfci2r5Q2g3oT9HC7ObsXMdRg2ONg_KuOv9AsLhLWBJSp7lX",
	["toxic-logs"] = "https://discord.com/api/webhooks/1183904740984238171/rypgrRUp6-wRQHEfTK0tVivzbZ-eG4hrebIypiZhcRJzYXrN0Sej0Xe8qxwoRlxgKV3h",
    ["server-list"] = "https://discord.com/api/webhooks/1183904793408852038/WICWCw5VImtaS2ndtOfaW0VbqYtpyHY2pB9ZUO6QRsY2AlT6_vyvTPNCg1CeGicHp7zm",
    ["anticheat-logs"] = "https://discord.com/api/webhooks/1183904852246544547/Blh-5GQJBEjAFcSbGWKAdBB078YSD2CQZ9UoESBklpk46PBASQob4CA57hpgSLkAHF6l",
}

--discord.AddUsers("ttt-ingame", {"Moat TTT Announcements", "Lottery Announcements"}, true)
discord.AddUsers("general", {"Bungo TTT Announcement", "Lottery Announcement"}, true)
discord.AddUsers("anticheat-logs", {"AntiCheat - Lua"}, true)
discord.AddUsers("ttt-bot", {"Event", "Drop"})
discord.AddUsers("tradinglounge", {"Events", "Drops"})
discord.AddUsers("ttt-challenges", {"Contracts", "Bounties", "Lottery"})
discord.AddUsers("ttt-logs", {"Lottery Win", "Gamble Win"}, true)
discord.AddUsers("staff-logs", {"Anti Cheat", "Past Offences", "Gamble Chat", "Gamble", "Server", "TTS"})
discord.AddUsers("boss-logs", {"Snap", "Skid", "Gamble Log", "Trade", "Bad Map", "ASN Check"})
discord.AddUsers("mga-logs", {"MGA Log"}, true)
discord.AddUsers("dev-logs", {"Developer"})
discord.AddUsers("toxic-logs", {"Toxic TTT Loggers"})
discord.AddUsers("error-logs", {"Server Error Reports"}, true)
discord.AddUsers("server-list", {"Servers"})

function post_discord_server_list()
    Server.IsDev = false
    for k,v in pairs(Servers.Roster) do
        timer.Simple(0.5 * k,function()
            discord.Embed("Servers",{
                author = {
                    name = "Bungo ".. v.Name .. " Official Inventory | Alpha",
                    icon_url = "https://tttweb.bungo.ca/public/img/logo.png"
                },
                description = "Join: " .. v.ConnectURL,
            })
            if k == #Servers.Roster then
                Server.IsDev = true
            end
        end)
    end
end