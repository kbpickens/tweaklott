minetest.register_alias("lottother:blue_torch", "lottblocks:elf_torch")
minetest.register_alias("lottother:orc_torch", "lottblocks:orc_torch")
minetest.register_alias("lottother:lamp_wood", "lottblocks:lamp_wood")
minetest.register_alias("lottother:lamp_middle_wood", "lottblocks:lamp_middle_wood")
minetest.register_alias("lottother:lamp_top_wood", "lottblocks:lamp_top_wood")
minetest.register_alias("lottother:tiny_lamp_wood", "lottblocks:small_lamp_wood")
minetest.register_alias("lottother:lamp_wood_alder", "lottblocks:lamp_alder")
minetest.register_alias("lottother:lamp_middle_wood_alder", "lottblocks:lamp_middle_alder")
minetest.register_alias("lottother:lamp_top_wood_alder", "lottblocks:lamp_top_alder")
minetest.register_alias("lottother:tiny_lamp_wood_alder", "lottblocks:small_lamp_alder")
minetest.register_alias("lottother:lamp_wood_birch", "lottblocks:lamp_birch")
minetest.register_alias("lottother:lamp_middle_wood_birch", "lottblocks:lamp_middle_birch")
minetest.register_alias("lottother:lamp_top_wood_birch", "lottblocks:lamp_top_birch")
minetest.register_alias("lottother:tiny_lamp_wood_birch", "lottblocks:small_lamp_birch")
minetest.register_alias("lottother:lamp_wood_lebethron", "lottblocks:lamp_lebethron")
minetest.register_alias("lottother:lamp_middle_wood_lebethron", "lottblocks:lamp_middle_lebethron")
minetest.register_alias("lottother:lamp_top_wood_lebethron", "lottblocks:lamp_top_lebethron")
minetest.register_alias("lottother:tiny_lamp_wood_lebethron", "lottblocks:small_lamp_lebethron")
minetest.register_alias("lottother:lamp_wood_mallorn", "lottblocks:lamp_mallorn")
minetest.register_alias("lottother:lamp_middle_wood_mallorn", "lottblocks:lamp_middle_mallorn")
minetest.register_alias("lottother:lamp_top_wood_mallorn", "lottblocks:lamp_top_mallorn")
minetest.register_alias("lottother:tiny_lamp_wood_mallorn", "lottblocks:small_lamp_mallorn")

function lottblocks.register_lamp(material, description, inv_texture, post1_texture, post2_texture, top_texture, texture, material_code_name, race)
	local node_bottom = "lottblocks:lamp_" .. material
	local node_middle = "lottblocks:lamp_middle_" .. material
	local node_top = "lottblocks:lamp_top_" .. material
	local node_small = "lottblocks:small_lamp_" .. material
	minetest.register_node(node_bottom, {
		drop = "",
		description = description .. " Lamppost",
		tiles = {post1_texture},
		inventory_image = inv_texture,
		wield_image = inv_texture,
		groups = {choppy=2,oddly_breakable_by_hand=1,flammable=2},
		paramtype = "light",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.15,-0.5,-0.15,0.15,0.4,0.15},
				{-0.1,0.4,-0.1,0.1,0.5,0.1}
			}
		},
		on_place = function(itemstack, placer, pointed_thing)
	    	local pos = pointed_thing.above;
	    	if(minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air") or (minetest.get_node({x=pos.x, y=pos.y+2, z=pos.z}).name ~= "air") then
	    		minetest.chat_send_player( placer:get_player_name(), 'Not enough space for lamppost to be placed' )
	    		return;
	    	end
	    	return minetest.item_place(itemstack, placer, pointed_thing);
		end,
		after_place_node = function(pos,placer,itemstack)
			minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = node_middle})
			minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},{name = node_top})
		end,
	})
	minetest.register_node(node_middle, {
		drop = "",
		groups = {choppy=2,oddly_breakable_by_hand=1,flammable=2, not_in_creative_inventory = 1},
		tiles = {post2_texture},
		paramtype = "light",
		drawtype = "nodebox",
		pointable = false,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.1,-0.5,-0.1,0.1,0.5,0.1}
			}
		}
	})
	minetest.register_node(node_top, {
		drop = "lottblocks:lamp_" .. material,
		groups = {choppy=2,oddly_breakable_by_hand=1,flammable=2, not_in_creative_inventory = 1},
			tiles = {
				top_texture, top_texture,
				{
					image = texture,
					backface_culling = false,
					animation = {
						type = "vertical_frames",
						aspect_w = 16,
						aspect_h = 16,
						length = 1.5
					},
	        	}
			},
		paramtype = "light",
		drawtype = "nodebox",
		light_source = 14,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
				{-0.3,-0.4,-0.3,0.3,0.5,0.3}
			}
		},
		selection_box = 	{
			type = "fixed",
			fixed = {
				{-0.3,0.5,-0.3,0.3,-2.5,0.3},
			}
		},
		after_dig_node = function(pos)
			minetest.remove_node({x = pos.x, y = pos.y - 1, z = pos.z})
			minetest.remove_node({x = pos.x, y = pos.y - 2, z = pos.z})
		end
	})
	minetest.register_node(node_small, {
		description = description .. " Small Lamp",
		groups = {choppy=2,oddly_breakable_by_hand=1,flammable=2},
		tiles = {
			top_texture, top_texture,
			{
				image = texture,
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 1.5
				},
	       	},
		},
		paramtype = "light",
		drawtype = "nodebox",
		light_source = 14,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
				{-0.3,-0.4,-0.3,0.3,0.5,0.3}
			}
		},
		selection_box = 	{
			type = "fixed",
			fixed = {
				{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
				{-0.3,-0.4,-0.3,0.3,0.5,0.3}
			}
		},
	})
	if race == "elf" then
		minetest.register_craft({
			output = node_bottom,
			recipe = {
				{node_small},
				{material_code_name},
				{"default:stonebrick"},
			}
		})
		minetest.register_craft({
			output = node_small,
			recipe = {
				{material_code_name, material_code_name, material_code_name},
				{material_code_name, "lottblocks:elf_torch", material_code_name},
				{material_code_name, material_code_name, material_code_name},
			}
		})
	elseif race == "orc" then
		minetest.register_craft({
			output = node_bottom,
			recipe = {
				{node_small},
				{material_code_name},
				{"lottblocks:orc_brick"},
			}
		})
		minetest.register_craft({
			output = node_small,
			recipe = {
				{material_code_name, material_code_name, material_code_name},
				{material_code_name, "lottblocks:orc_torch", material_code_name},
				{material_code_name, material_code_name, material_code_name},
			}
		})
	end
end

lottblocks.register_lamp("wood", "Wood", "lottblocks_lamp_inv_wood.png", "default_stone_brick.png", "default_wood.png", "default_wood.png", "lottblocks_lamp_active_wood.png",  "default:wood", "elf")
lottblocks.register_lamp("alder", "Alder", "lottblocks_lamp_inv_alder.png", "default_stone_brick.png", "lottplants_alderwood.png", "lottplants_alderwood.png", "lottblocks_lamp_active_alder.png",  "lottplants:alderwood", "elf")
lottblocks.register_lamp("junglewood", "Junglewood", "lottblocks_lamp_inv_junglewood.png", "default_stone_brick.png", "default_junglewood.png", "default_junglewood.png", "lottblocks_lamp_active_junglewood.png",  "default:junglewood", "elf")
lottblocks.register_lamp("birch", "Birch", "lottblocks_lamp_inv_birch.png", "default_stone_brick.png", "lottplants_birchwood.png", "lottplants_birchwood.png", "lottblocks_lamp_active_birch.png",  "lottplants:birchwood", "elf")
lottblocks.register_lamp("pine", "Pine", "lottblocks_lamp_inv_pine.png", "default_stone_brick.png", "lottplants_pinewood.png", "lottplants_pinewood.png", "lottblocks_lamp_active_pine.png",  "lottplants:pinewood", "elf")
lottblocks.register_lamp("lebethron", "Lebethron", "lottblocks_lamp_inv_lebethron.png", "default_stone_brick.png", "lottplants_lebethronwood.png", "lottplants_lebethronwood.png", "lottblocks_lamp_active_lebethron.png",  "lottplants:lebethronwood", "elf")
lottblocks.register_lamp("mallorn", "Mallorn", "lottblocks_lamp_inv_mallorn.png", "default_stone_brick.png", "lottplants_mallornwood.png", "lottplants_mallornwood.png", "lottblocks_lamp_active_mallorn.png",  "lottplants:mallornwood", "elf")

--Orc lamps

lottblocks.register_lamp("wood_orc", "Mordor Wooden", "lottblocks_orc_lamp_inv.png", "lottblocks_orc_brick.png", "default_wood.png", "default_wood.png", "lottblocks_orc_lamp_active.png",  "default:wood", "orc")
lottblocks.register_lamp("alder_orc", "Mordor Alder", "lottblocks_orc_lamp_inv_alder.png", "lottblocks_orc_brick.png", "lottplants_alderwood.png", "lottplants_alderwood.png", "lottblocks_orc_lamp_active_alder.png",  "lottplants:alderwood", "orc")
lottblocks.register_lamp("junglewood_orc", "Mordor Junglewood", "lottblocks_orc_lamp_inv_junglewood.png", "lottblocks_orc_brick.png", "default_junglewood.png", "default_junglewood.png", "lottblocks_orc_lamp_active_junglewood.png",  "default:junglewood", "orc")
lottblocks.register_lamp("birch_orc", "Mordor Birch", "lottblocks_orc_lamp_inv_birch.png", "lottblocks_orc_brick.png", "lottplants_birchwood.png", "lottplants_birchwood.png", "lottblocks_orc_lamp_active_birch.png",  "lottplants:birchwood", "orc")
lottblocks.register_lamp("pine_orc", "Mordor Pine", "lottblocks_orc_lamp_inv_pine.png", "lottblocks_orc_brick.png", "lottplants_pinewood.png", "lottplants_pinewood.png", "lottblocks_orc_lamp_active_pine.png",  "lottplants:pinewood", "orc")
lottblocks.register_lamp("lebethron_orc", "Mordor Lebethron", "lottblocks_orc_lamp_inv_lebethron.png", "lottblocks_orc_brick.png", "lottplants_lebethronwood.png", "lottplants_lebethronwood.png", "lottblocks_orc_lamp_active_lebethron.png",  "lottplants:lebethronwood", "orc")

-- minetest.register_node("lottblocks:elf_torch", {
-- 	description = "Elf Torch",
-- 	drawtype = "nodebox",
-- 	tiles = {
-- 		{name = "lottblocks_torch_elf_top.png",    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 5.0}},
-- 		{name = "lottblocks_torch_elf_bottom.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 5.0}},
-- 		{name = "lottblocks_torch_elf_side.png",   animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 5.0}},
-- 	},
-- 	inventory_image = "lottblocks_torch_elf_inv.png",
-- 	wield_image = "lottblocks_torch_elf_inv.png",
-- 	wield_scale = {x = 1, y = 1, z = 1.25},
-- 	paramtype = "light",
-- 	paramtype2 = "wallmounted",
-- 	sunlight_propagates = true,
-- 	is_ground_content = false,
-- 	walkable = false,
-- 	light_source = LIGHT_MAX - 1,
-- 	node_box = {
-- 		type = "wallmounted",
-- 		wall_top    = {-0.0625, -0.0625, -0.0625, 0.0625, 0.5   , 0.0625},
-- 		wall_bottom = {-0.0625, -0.5   , -0.0625, 0.0625, 0.0625, 0.0625},
-- 		wall_side   = {-0.5   , -0.5   , -0.0625, -0.375, 0.0625, 0.0625},
-- 	},
-- 	selection_box = {
-- 		type = "wallmounted",
-- 		wall_top    = {-0.25, -0.0625, -0.25, 0.25, 0.5   , 0.25},
-- 		wall_bottom = {-0.25, -0.5   , -0.25, 0.25, 0.0625, 0.25},
-- 		wall_side   = {-0.25, -0.5  , -0.25, -0.5, 0.0625, 0.25},
-- 	},
-- 	groups = {choppy = 2, dig_immediate = 3, flammable = 1, attached_node = 1, hot = 2},
-- 	sounds = default.node_sound_wood_defaults(),
-- })

local lottblocks_list = {
	{ "Orc Torch", "orc", "300" },
	{ "Elf Torch", "elf", "003" },
}

for i in ipairs(lottblocks_list) do
	local torchdesc = lottblocks_list[i][1]
	local race = lottblocks_list[i][2]
	local colour = lottblocks_list[i][3]
	local alpha = "128"
	
-- local S = default.get_translator

local function on_flood(pos, oldnode, newnode)
	minetest.add_item(pos, ItemStack("lottblocks:"..race.."_torch 1"))
	-- Play flame-extinguish sound if liquid is not an 'igniter'
	local nodedef = minetest.registered_items[newnode.name]
	if not (nodedef and nodedef.groups and
			nodedef.groups.igniter and nodedef.groups.igniter > 0) then
		minetest.sound_play(
			"default_cool_lava",
			{pos = pos, max_hear_distance = 16, gain = 0.1}
		)
	end
	-- Remove the torch node
	return false
end

minetest.register_node("lottblocks:"..race.."_torch", {
	description = torchdesc,
	drawtype = "mesh",
	mesh = "torch_floor.obj",
	inventory_image = "lottblocks_torch_"..race.."_inv.png",
	wield_image = "lottblocks_torch_"..race.."_inv.png",
	tiles = {{
		    -- name = "lottblocks_torch_"..race.."_side.png", 
		    name = "default_torch_on_floor_animated.png^[colorize:#"..colour..":"..alpha,
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	liquids_pointable = false,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, attached_node=1, torch=1},
	drop = "lottblocks:"..race.."_torch",
	selection_box = {
		type = "wallmounted",
		wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
	},
	sounds = default.node_sound_wood_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local def = minetest.registered_nodes[node.name]
		if def and def.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
			return def.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end

		local above = pointed_thing.above
		local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
		local fakestack = itemstack
		if wdir == 0 then
			fakestack:set_name("lottblocks:"..race.."_torch_ceiling")
		elseif wdir == 1 then
			fakestack:set_name("lottblocks:"..race.."_torch")
		else
			fakestack:set_name("lottblocks:"..race.."_torch_wall")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("lottblocks:"..race.."_torch")

		return itemstack
	end,
	floodable = true,
	on_flood = on_flood,
})

minetest.register_node("lottblocks:"..race.."_torch_wall", {
	drawtype = "mesh",
	mesh = "torch_wall.obj",
	tiles = {{
		    -- name = "lottblocks_torch_"..race.."_side.png", 
		    name = "default_torch_on_floor_animated.png^[colorize:#"..colour..":"..alpha,
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "lottblocks:"..race.."_torch",
	selection_box = {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/8, -1/8, 1/8, 1/8},
	},
	sounds = default.node_sound_wood_defaults(),
	floodable = true,
	on_flood = on_flood,
})

minetest.register_node("lottblocks:"..race.."_torch_ceiling", {
	drawtype = "mesh",
	mesh = "torch_ceiling.obj",
	tiles = {{
		    -- name = "lottblocks_torch_"..race.."_side.png", 
		    name = "default_torch_on_floor_animated.png^[colorize:#"..colour..":"..alpha,
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "lottblocks:"..race.."_torch",
	selection_box = {
		type = "wallmounted",
		wall_top = {-1/8, -1/16, -5/16, 1/8, 1/2, 1/8},
	},
	sounds = default.node_sound_wood_defaults(),
	floodable = true,
	on_flood = on_flood,
})

minetest.register_lbm({
	name = "lottblocks:"..race.."_3dtorch",
	nodenames = {"lottblocks:"..race.."_torch", "lottblocks:"..race.."_torch_floor", "lottblocks:"..race.."_torch_wall"},
	action = function(pos, node)
		if node.param2 == 0 then
			minetest.set_node(pos, {name = "lottblocks:"..race.."_torch_ceiling",
				param2 = node.param2})
		elseif node.param2 == 1 then
			minetest.set_node(pos, {name = "lottblocks:"..race.."_torch",
				param2 = node.param2})
		else
			minetest.set_node(pos, {name = "lottblocks:"..race.."_torch_wall",
				param2 = node.param2})
		end
	end
})
end

minetest.register_craft({
	output = 'lottblocks:elf_torch 2',
	recipe = {
		{'lottores:rough_rock_lump'},
		{'group:stick'},
	}
})

-- minetest.register_node("lottblocks:orc_torch", {
-- 	description = "Orc Torch",
-- 	drawtype = "nodebox",
-- 	tiles = {
-- 		{name = "lottblocks_torch_orc_top.png",    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 5.0}},
-- 		{name = "lottblocks_torch_orc_bottom.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 5.0}},
-- 		{name = "lottblocks_torch_orc_side.png",   animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 5.0}},
-- 	},
-- 	inventory_image = "lottblocks_torch_orc_inv.png",
-- 	wield_image = "lottblocks_torch_orc_inv.png",
-- 	wield_scale = {x = 1, y = 1, z = 1.25},
-- 	paramtype = "light",
-- 	paramtype2 = "wallmounted",
-- 	sunlight_propagates = true,
-- 	is_ground_content = false,
-- 	walkable = false,
-- 	light_source = LIGHT_MAX - 2,
-- 	node_box = {
-- 		type = "wallmounted",
-- 		wall_top    = {-0.0625, -0.0625, -0.0625, 0.0625, 0.5   , 0.0625},
-- 		wall_bottom = {-0.0625, -0.5   , -0.0625, 0.0625, 0.0625, 0.0625},
-- 		wall_side   = {-0.5   , -0.5   , -0.0625, -0.375, 0.0625, 0.0625},
-- 	},
-- 	selection_box = {
-- 		type = "wallmounted",
-- 		wall_top    = {-0.25, -0.0625, -0.25, 0.25, 0.5   , 0.25},
-- 		wall_bottom = {-0.25, -0.5   , -0.25, 0.25, 0.0625, 0.25},
-- 		wall_side   = {-0.25, -0.5  , -0.25, -0.5, 0.0625, 0.25},
-- 	},
-- 	groups = {choppy = 2, dig_immediate = 3, flammable = 1, attached_node = 1, hot = 2},
-- 	sounds = default.node_sound_wood_defaults(),
-- })

minetest.register_craft({
	output = 'lottblocks:orc_torch 2',
	recipe = {
		{'bones:bone'},
		{'group:stick'},
	}
})

-- Made by lumidify - lottblocks_mithril_stonelamp.png
-- created by modifying darkage_lamp.png
minetest.register_node("lottblocks:mithril_stonelamp", {
	description = "Mithril Stonelamp",
	tiles = { "lottblocks_mithril_stonelamp.png" },
	paramtype = "light",
	sunlight_propagates = true,
	light_source = LIGHT_MAX,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "lottblocks:mithril_stonelamp 2",
	recipe = {
		{"default:stone", "default:stone","default:stone"},
		{"default:stone", "lottores:mithril_ingot", "default:stone"},
		{"default:stone", "default:torch", "default:stone"},
	}
})
