# tweaklott
These adjustments are to make [Lord of the Test](https://github.com/minetest-LOTR/Lord-of-the-Test) v1.1.0 (otherwise known as Alpha) work with [Minetest](https://www.minetest.net/) v5.1.0.

---
## Beds
### Problem
On install of LotT, beds didn't let you sleep and required tools to break.  Minetest's beds were functioning properly.
### Fix
1. Copy the `beds` directory from the `games/minetest-game/mods` directory. (This gets the beds API and functions.)
2. Run `perl -p -i -e "s/bed_(top|bottom)_(red|green|blue)/bed_\2_\1/g" <filename_here>` for each `.we` file in the `games/Lord-of-the-Test-1.1.0/mods/lottmapgen/schems` directory.
3. Replace `games/Lord-of-the-Test-1.1.0/mods/lottblocks/beds.lua`. (This replaces the non-functioning bed blocks.)
4. Add `beds` to `games/Lord-of-the-Test-1.1.0/mods/lottblocks/mod.conf`. (This ensures the code is imported.)
### Result
Beds work and break properly.  The beds aren't as pretty as the original LotT beds (the sides are slabs rather than legs), but they work and have colours.

TODO: Correct craft recipes for coloured beds.

---
## Torches
### Problem
Wall mount torches don't look like torches (just two dots of light).

TODO: Develop fix.
