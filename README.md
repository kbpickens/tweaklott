# tweaklott
These adjustments are to make [Lord of the Test](https://github.com/minetest-LOTR/Lord-of-the-Test) v1.1.0 (otherwise known as Alpha) work with [Minetest](https://www.minetest.net/) v5.1.0.

---
## Beds
### Problem
On install of LotT, beds didn't let you sleep and required tools to break.  Minetest's beds were functioning properly.
### Fix
1. Copy the `beds` directory from the `games/minetest_game/mods` directory to `games/Lord-of-the-Test-1.1.0/mods`. (This gets the beds API and functions.)
2. Run `perl -p -i -e "s/bed_(top|bottom)_(red|green|blue)/bed_\2_\1/g" <filename_here>` for each `.we` file in the `games/Lord-of-the-Test-1.1.0/mods/lottmapgen/schems` directory. (This makes the building generation recognise the correct blocks because the API defines the blocks with top and bottom at the end instead of before the colours.)
3. Replace `games/Lord-of-the-Test-1.1.0/mods/lottblocks/beds.lua` with the version from this repo. (This replaces the non-functioning bed blocks.)
4. Add `beds` to `games/Lord-of-the-Test-1.1.0/mods/lottblocks/mod.conf`. (This ensures the code is imported.)
### Result
Beds work and break properly.  The beds aren't as pretty as the original LotT beds (the sides are slabs rather than legs), but they work and have colours.  The default beds are included.

### TODO
* Correct craft recipes for coloured beds.
* Ensure coloured beds are produced (default bed uses `group:wool`, coloured beds use `wool:<colour>`).
* Fix inventory/wield icons.

---
## Torches
### Problem
Wall mount torches don't look like torches (just two dots of light).
### Fix
1. Copy `games/minetest_game/mods/default/textures/default_torch_on_floor_animated.png` to `games/Lord-of-the-Test-1.1.0/mods/lottblocks/textures/default_torch_on_floor_animated.png`. (This is the basis for the animated torches.)
2. Copy the `models` directory from `games/minetest_game/default` directory to `games/Lord-of-the-Test-1.1.0/mods/default`. (This tells the engine how to shape the torch.)
3. Replace `games/Lord-of-the-Test-1.1.0/mods/lottblocks/lamps.lua` with the version in this repo. (This provides the Orc and Elf Torches.)
4. Place `mods/default/torch.lua` from this repo into `games/Lord-of-the-Test-1.1.0/mods/default`. (This provides the default Torch.)
5. Add `dofile(minetest.get_modpath("default").."/torch.lua")` to `games/Lord-of-the-Test-1.1.0/modes/default/init.lua`. (This allows the default Torch to load.)
6. Replace `games/Lord-of-the-Test-1.1.0/default/nodes.lua` with the version from this repo. (This prevents collisions between `default:torch` registrations.)
### Result
Torches look like torches.  Colours are applied over the entire animation (the Elf and Orc torches are coluorized with their flame colour from standard LotT).  Wall mounted torches placed by building generation may appear as floor mounted torches parrallel to the ground (won't be fixed, requires changes to `.we` files).

### TODO
* Maybe improve animations (replace with custom art). (Low priority.)
---
## Mobs
### Problem
One mob's (fireball-throwing thing in caverns) avatar occupies space from surface+1m to surface+3m; its selection box occupies space from surface to surface+2m.

### TODO
Let someone else fix it.
