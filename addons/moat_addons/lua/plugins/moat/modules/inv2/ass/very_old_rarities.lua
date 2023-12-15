MOAT_RARITIES = {[0] = {
	ID = 0,
	Name = "Stock",
	Rarity = 0,
	Deconstruct = {min = 10, max = 20}
}}

function m_AddInventoryRarity( name_, desconstruct_, rarity_, enum_, chance_)

	local tbl = {}

	tbl.ID = enum_

	tbl.Name = name_

	tbl.Rarity = rarity_

	if(not chance_) then
		tbl.Chance = rarity_
	else
		tbl.Chance = chance_
	end

	tbl.Deconstruct = desconstruct_

	table.insert( MOAT_RARITIES, tbl )

	table.sort( MOAT_RARITIES, function( a, b ) return a.Rarity < b.Rarity end )

end

m_AddInventoryRarity( "Worn", { min = 10, max = 20 }, 1, 1)

m_AddInventoryRarity( "Standard", { min = 20, max = 40 }, 2, 2)

m_AddInventoryRarity( "Specialized", { min = 60, max = 120 }, 3, 3)

m_AddInventoryRarity( "Superior", { min = 240, max = 480 }, 4, 4)

m_AddInventoryRarity( "High-End", { min = 1200, max = 2400 }, 5, 5)

m_AddInventoryRarity( "Ascended", { min = 7200, max = 14400 }, 6, 6)

m_AddInventoryRarity( "Cosmic", { min = 25200, max = 50400 }, 7, 7)

m_AddInventoryRarity( "Extinct", { min = 2, max = 5000 }, 8, 8)

m_AddInventoryRarity( "Planetary", { min = 25200, max = 50400 }, 9, 9)

m_AddInventoryRarity( "Chaotic", { min = 32500, max = 64600}, 10, 10, 8)

m_AddInventoryRarity( "Angelic", { min = 32500, max = 64600}, 11, 11, 2)