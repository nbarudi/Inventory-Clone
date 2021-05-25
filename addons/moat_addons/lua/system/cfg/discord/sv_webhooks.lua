-- todo replace relay
moat.cfg.webhook = "http://208.103.169.40:5059/"
moat.cfg.oldwebhook = "http://107.191.51.43:3000/"

moat.cfg.discord = {
    primarywebhook = "https://discord.com/api/webhooks/831053551631204363/GS36PVvjgVtAXlbKUWQY7qcQ9t9SqcYIHJKa32n6qm56EaYN_tvR6m12H7K3UrtrerwC"
}

discord.AddChannels {
	["general"] = "https://discord.com/api/webhooks/831053551631204363/GS36PVvjgVtAXlbKUWQY7qcQ9t9SqcYIHJKa32n6qm56EaYN_tvR6m12H7K3UrtrerwC",
	["ttt-bot"] = "https://discord.com/api/webhooks/831058008141725717/MYVu5FdDLe4MXfCJl_Zc7Bh6RiT_zWrE9zw-4CG4TcJIVScAdKSkZcuUUp2ivbgiVz0H",
	["tradinglounge"] = "https://discord.com/api/webhooks/831058217902669824/JLojb_oQCas92Nyv8egLDslEluqpvooeOYQS8a2pboGSJJVigrFZe5IUcmrzU-i83os1",
	["ttt-challenges"] = "https://discord.com/api/webhooks/831058369325301770/TabFOoBzGxl1EM70yTXVCZIljjt5zKUFP3mSOoul1_iyqM3jEzfO5R2ti-FKLWAnfX-6",
	["ttt-logs"] = "https://discord.com/api/webhooks/831058477551845437/-wCso0UOm761tp43cPpDwTgcy4BoNayuzCFOASL2Z4oluWvQkgi2RS1jZ0ebsjpBlWNo",
    ["staff-logs"] = "https://discord.com/api/webhooks/831058811196014592/nR3yqTWBRIcB6jPiA8ARN16PDUQEsQ5zai7kEjmPDbFNzvxns-raV4dc93b1N4MA5kfL",
    ["boss-logs"] = "https://discord.com/api/webhooks/831058902245310474/XZYL7Klaqhrxmz1opvZtdOX8ETb6y2RICNqo4EJ49oDHkOfvAdiOu0E05X-zHVK43COx",
    ["error-logs"] = "https://discord.com/api/webhooks/831059062208725013/TaIXjwbbuqcoHIUkgqjEX5uIrMCSx3I8THuqBQ9HilroXhCROz9ZNEWSDco9CiY6MUWJ",
    ["dev-logs"] = "https://discord.com/api/webhooks/831059477121073182/y3QCPafpFE4TfQFYOzH7No0vbpAMix5n-e7aZc35IkZssD-Ne80z19sjz09i8pORmMJb",
	["mga-logs"] = "https://discord.com/api/webhooks/831059360188071977/dZlw-9BvhCDt8Q5TKiCrH1hDUHaj1_2Zl16SLZcEub8or1d8ioTtTwOhMODpUPtOqABY",
	["toxic-logs"] = "https://discord.com/api/webhooks/831059583584698410/4E3-P4kdSZTU_XJxl-PlD5Q6OdvOQ-qPK1vI3EmG_9pGxn8sWEGxO-V_-KYMyvIJn5Y-",
    ["server-list"] = "https://discord.com/api/webhooks/831059904680034374/z4E3Jr5J4bD1qRnh9hyp05a4APyLmySs2V_RaBlEBBMRit6RuEt5JB3mzg9g2dXDG7bA",
    ["anticheat-logs"] = "https://discord.com/api/webhooks/831069949459693619/aRorQVuR4a0gdgL3NIOr8umvgMy_3kx-yWiJg4ssjpTflk2QRpjCBk_CUv0H2okMF-2t",
}

--discord.AddUsers("ttt-ingame", {"Moat TTT Announcements", "Lottery Announcements"}, true)
discord.AddUsers("general", {"Gritsky TTT Announcement", "Lottery Announcement"}, true)
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
                    name = "Gritsky ".. v.Name .. " Official Inventory | Alpha",
                    icon_url = "https://gritskygaming.net/public/img/logo.png"
                },
                description = "Join: " .. v.ConnectURL,
            })
            if k == #Servers.Roster then
                Server.IsDev = true
            end
        end)
    end
end