-- for sql config
local mysql = {
	host = SERVER and "51.77.122.86" or "", -- "gamedb.moat.gg",
	database = SERVER and "gritskyg_ttt2" or "",
	username = SERVER and "gritskyg_gritskyttt" or "",
	password = SERVER and "4J*yOLSoe~Rf" or "",
	port = SERVER and 3306 or 420
}

-- This is ONLY for the Dallas servers that have a direct link with the web server.
mysql.directlink = {
	-- Dallas Node 1 in ID order
	["1.3.3.7:27015"] = true, -- TTT #3
}

if (not Server.IP) then
	Server.BuildAddress()
end

if (Server.IP and mysql.directlink[Server.IP]) then
	-- mysql.host = "direct-link-web"
end

moat.cfg.sql = mysql