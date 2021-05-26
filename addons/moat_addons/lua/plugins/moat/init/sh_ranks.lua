MOAT_RANKS = MOAT_RANKS or {}
MOAT_RANKS["guest"] = {"", Color(185, 187, 190), true, false, false}
MOAT_RANKS["user"] = {"", Color(255, 255, 255), true, false, false}
MOAT_RANKS["vip"] = {"VIP", Color(0, 255, 67), true, true, false}
MOAT_RANKS["partner"] = {"Partner", Color(255, 249, 30), true, true, false}
MOAT_RANKS["bugboomer"] = {"Bug Boomer", Color(43, 255, 198), true, true, false}
MOAT_RANKS["trialstaff"] = {"Trial Staff", Color(0, 182, 255), true, true, true}
MOAT_RANKS["moderator"] = {"Moderator", Color(31, 139, 76), true, true, true}
MOAT_RANKS["admin"] = {"Administrator", Color(155, 61, 255), true, true, true}
MOAT_RANKS["senioradmin"] = {"Senior Administrator", Color(203, 61, 255), true, true, true}
MOAT_RANKS["developer"] = {"Developer", Color(203, 61, 255), true, true, true}
MOAT_RANKS["headadmin"] = {"Head Administrator", Color(255, 51, 148), true, true, true}
MOAT_RANKS["operationslead"] = {"Operations Lead", Color(255, 51, 148), true, true, true}
MOAT_RANKS["techlead"] = {"Tech Lead", Color(255, 51, 51), true, true, true}
MOAT_RANKS["communitylead"] = {"Community Lead", Color(255, 51, 51), true, true, true}
MOAT_RANKS["owner"] = {"owner", Color(255, 51, 51), true, true, true}
MOAT_RANKS["techartist"] = {"Technical Artist", Color(255, 51, 51), true, true, true}
MOAT_RANKS["audioengineer"] = {"Audio Engineer", Color(255, 51, 51), true, true, true}
MOAT_RANKS["softwareengineer"] = {"Software Engineer", Color(255, 51, 51), true, true, true}
MOAT_RANKS["gamedesigner"] = {"Game Designer", Color(255, 51, 51), true, true, true}
MOAT_RANKS["creativedirector"] = {"Creative Director", Color(255, 51, 51), true, true, true}

MOAT_RANKS["communitylead"].check = true
MOAT_RANKS["techlead"].check = true
MOAT_RANKS["operationslead"].check = true
MOAT_RANKS["headadmin"].check = true

COMMUNITY_LEADS 	= 	COMMUNITY_LEADS or {}
TECH_LEADS 			= 	TECH_LEADS or {}
OPERATION_LEADS 	= 	OPERATION_LEADS or {}
HEAD_ADMINS 		= 	HEAD_ADMINS or {}


/* Community Leads */
COMMUNITY_LEADS["76561198119253489"] 	= true 	-- andrew
COMMUNITY_LEADS["76561198174950070"] 	= true 	-- chad

HEAD_ADMINS["76561198864382186"] 	= true 	-- axel


