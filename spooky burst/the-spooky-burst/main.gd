extends Node2D
# The Spooky Burst - a Halloween arcade shooter.
# Everything is drawn in code: the scene is a 320x240 pixel canvas drawn at 2x,
# and text/menus are drawn on top at the full 640x480 resolution.

# a new save file for the candy shop version, so everyone starts fresh (the old spooky_burst.cfg is left alone)
const SAVE_PATH := "user://spooky_burst_v2.cfg"
# what things cost in the UPGRADES menu, before PRESTIGE: each prestige level of a character
# adds 10% of these to its price and its upgrades' prices
const CHAR_COST := 500
const POW_COST := 100
# PRESTIGE: relock a character and all its upgrades for +1 of every boost for it, up to this many times
const PRESTIGE_MAX := 10
const PRESTIGE_LOCKED := true

# ---------------------------------------------------------------- sprites
const GHOST := ["...XXXXXX...", "..XXXXXXXX..", ".XXXXXXXXXX.", ".XXoXXXXoXX.", "XXXoXXXXoXXX", "XXbXXXXXXbXX", "XXXXXmmXXXXX",
	"XXXXXXXXXXXX", "XXXXXXXXXXXX", "XXXXXXXXXXXX", "XXXXXXXXXXXX", "XX.XXX.XXX.X", "X...X...X..."]
const FACE_ROWS := [
	[".XXoXXXXoXX.", "XXXoXXXXoXXX", "XXbXXXXXXbXX", "XXXXXmmXXXXX"],
	[".XXoXXXXoXX.", "XXXoXXXXoXXX", "XXXXXmmXXXXX", "XXXXXmmXXXXX"],
	[".XXXXXXXoXX.", "XXooXXXXoXXX", "XXbXXXXXXbXX", "XXXXmmmmXXXX"],
	[".XXXXXXXXXX.", "XXooXXXXooXX", "XXbXXXXXXbXX", "XXXXXmmXXXXX"],
	[".XoXXXXXXoX.", "XXXoXXXXoXXX", "XXXmXXXXmXXX", "XXXXmmmmXXXX"],
	[".XXoXXXXoXX.", "XXXoXXXXoXXX", "XXbXXmmXXbXX", "XXXXXXbXXXXX"]]
const HATS := {
	"witch": {"ov": 1, "r": ["......P.....", ".....PP.....", "....PPPP....", "....OOOO....", "..PPPPPPPP.."]},
	"top": {"ov": 1, "r": ["....KKKK....", "....KKKK....", "....RRRR....", "..KKKKKKKK.."]},
	"lid": {"ov": 0, "r": [".....G......", "....OOOO....", "...OOOOOO..."]}}
const HATPAL := {"P": "#7a35d6", "O": "#ff8a1f", "K": "#5a5285", "R": "#e0364f", "B": "#ff7fb5", "G": "#3d8b3a", "W": "#fffaf0", "Y": "#ffd92e"}
const HANGBAT := ["...X.X...", "...XXX...", "..XXXXX..", ".XXXXXXX.", ".XXXXXXX.", ".XXXXXXX.", ".XXXXXXX.", "..XXXXX..", "..XlXrX..", "..XXXXX..", "..X...X.."]
const BATA := ["X...X.X...X", "XX.XXXXX.XX", "XXXXXXXXXXX", ".XXXeXeXXX.", "..X.XXX.X.."]
const BATB := ["....X.X....", "...XXXXX...", ".XXXeXeXXX.", "XXXXXXXXXXX", "XX..XXX..XX", "X.........X"]
# the witch enemy: a small witch riding a broomstick, facing right (WITCH) or left (WITCH_L)
const WITCH := ["P...........", ".PP.........", "..PPP.......", "..OOOO......", "PPPPPPPP....", "...GkGGG....", "..PPPPP.....", "YYYBBBBBBBBB", "YY..PPk....."]
const WITCH_L := ["...........P", ".........PP.", ".......PPP..", "......OOOO..", "....PPPPPPPP", "....GGGkG...", ".....PPPPP..", "BBBBBBBBBYYY", ".....kPP..YY"]
const VAMP := ["...KKKKK...", "...SSSSS...", "...SrSrS...", "...SWSWS...", ".RRKKKKKRR.", "RRRKKRKKRRR", "RRRKKKKKRRR", "R.R.K.K.R.R"]
const VLORD := ["....KKKKKKK....", "...KKKKKKKKK...", "...KSSSSSSSK...", "...SrrSSSrrS...", "...SSSSSSSSS...", "...SWSmmmSWS...", "R...SSSSSSS...R",
	"RR.KKKRRRKKK.RR", "RRRKKKKRKKKKRRR", "RRRKKKKYKKKKRRR", "RRRRKKKKKKKRRRR", "RR.RKKKKKKKR.RR", "R...KK...KK...R"]
const WQUEEN := [".......P.......", "......PPP......", ".....PPPPP.....", "....PPYYYPP....", "..PPPPPPPPPPP..", "....GGGGGGG....", "....GkGGGkG....",
	"....GGGmGGG....", ".....GGGGG.....", "...PPPPPPPPP...", "..PPPPPPPPPPP..", "BBBBBBBBBBBBYYY", "..P.........YYY"]
const CROWN := ["Y.Y.Y", "YYYYY"]
const EPAL := {"X": "#8a66e0", "e": "#ffe45c", "P": "#7a35d6", "O": "#ff8a1f", "G": "#8fd66a", "k": "#1b0f33", "B": "#a8743a", "Y": "#ffd92e",
	"K": "#4a4170", "S": "#e6dcf5", "r": "#ff3355", "W": "#ffffff", "R": "#b3122e", "m": "#3a1420"}
const BUCKET := ["..KKKKKK..", ".K......K.", "OOOOOOOOOO", "OOOOOOOOOO", ".OyOOOOyO.", ".OOOOOOOO.", ".OOyyyyOO.", "..OOOOOO..", "..OOOOOO.."]
const BUCKETPAL := {"K": "#c9b8ee", "O": "#ff8a1f", "y": "#ffe45c"}
# the extra life drop: a candied apple on a stick, dipped in caramel at a slope with one drip
const APPLE := [".....S.....", ".....s.....", ".RRR.s.RRr.", "RCRRRRRRRRr", "CLhRRRRRRRr", "CLCCRRRRRRr", "CLCCCCCRRRr",
	"CLCCCCCCCRr", ".CLCCCCCCD.", ".CLCCCCCCD.", "..CLCCCCD..", "...DDDDD...", "......D...."]
const APPLEPAL := {"R": "#e0213f", "r": "#9c1030", "h": "#ffd0dc", "s": "#c8955a", "S": "#8a5a2e",
	"C": "#d99a3a", "D": "#a8661f", "L": "#f5cf7a"}
const CAT := ["KK........KK", "KKK......KKK", "KKKKKKKKKKKK", "KKKKKKKKKKKK", "KKyyKKKKyyKK", "KKyoKKKKoyKK", "KKKKKppKKKKK", "KKKKKKKKKKKK",
	".KKKKKKKKKK.", ".KKKccccKKK.", ".KKKccccKKK.", ".KK.KKKK.KK.", ".KK.KKKK.KK."]
const ZOMB := ["..dddddddd..", ".dddddddddd.", ".GGGGGGGGGG.", ".GGoGGGGoGG.", ".GGoGGGGGGG.", ".GGGGGGGGGG.", ".GGGmmmmGGG.", "..GGGGGGGG..",
	"GGSSSSSSSSGG", "GGSSSSSSSSGG", "..SSSSSSSS..", "..PPP..PPP..", "..PPP..PPP.."]
const SKEL := ["..WWWWWWWW..", ".WWWWWWWWWW.", ".WWkkWWkkWW.", ".WWkkWWkkWW.", ".WWWWkkWWWW.", "..WWWWWWWW..", "..WkWkWkWW..", "....WWWW....",
	"W.WWWWWWWW.W", "W..kWWWWk..W", "W.WWWWWWWW.W", "...WW..WW...", "...WW..WW..."]
const GPAL := {"X": "#f6f1ff", "o": "#1b0f33", "b": "#ff9ec2", "m": "#1b0f33"}
# GHOST SHOT orbs are little ghosts in the shot colour (c)
const GSHOT := [".ccc.", "ckckc", "ccccc", "cckcc", "ccccc", "c.c.c"]
# SOUL MATE's bow and GHOSTRESS's black rose clip, drawn on top of a small ghost at (x + 3, y - 2) and (x + 6, y - 2)
const BOW := ["BB.BB", "BBdBB", ".B.B."]
const ROSE := ["gg...", "gRRR.", ".RrR.", ".RRRg", "...gg"]
const ACCPAL := {"B": "#ff4f9a", "d": "#b02670", "R": "#140a1a", "r": "#7a5a8e", "g": "#3d8b3a"}
const TREE := [[28, 206, 30, 120, 9], [30, 120, 34, 90, 6], [32, 112, 60, 96, 4], [60, 96, 84, 92, 2], [50, 101, 56, 84, 2],
	[30, 128, 8, 112, 3], [8, 112, 0, 100, 2], [34, 90, 46, 66, 3], [46, 66, 58, 60, 2], [34, 90, 22, 68, 3],
	[22, 68, 14, 58, 2], [22, 68, 28, 56, 1], [56, 84, 62, 78, 1], [20, 206, 10, 210, 3], [34, 206, 46, 210, 3]]
const BOSS_NAMES := ["VAMPIRE LORD", "WITCH QUEEN", "PUMPKIN KING"]
const MENU := [["PLAY GAME", "play"], ["HIGH SCORE", "score"], ["UPGRADES", "shop"], ["PLAYER SETUP", "setup"], ["SETTINGS", "settings"],
	["RESET SAVE", "reset"], ["QUIT", "quit"]]
# where each player's character picker shows when they press Start to join (640x480 screen x)
const PICK_X := [80, 240, 400, 560]
# Once a player has every power-up that's ON, pumpkins give small boosts for the rest of the run instead.
# Each stays below the character power-up it matches (HEAVY ORB, RESTLESS SHOT, QUICK BONES, CAT REFLEXES,
# BIG ORB, THICK SKIN) and stacks on top of it. [key, name, what one does, HUD code]
const BOOSTS := [["dmg", "DAMAGE UP", "+5% ORB DAMAGE", "DM"], ["rate", "FIRE RATE UP", "+5% FASTER SHOOTING", "FR"],
	["shot", "SHOT SPEED UP", "+4% FASTER ORBS", "SS"], ["move", "MOVE SPEED UP", "+4% FASTER MOVING", "MS"],
	["size", "ORB SIZE UP", "SLIGHTLY BIGGER ORBS", "OS"], ["safe", "LONGER SAFETY", "+6% LONGER SAFE TIME AFTER A HIT", "LS"]]
const BOOST_MAX := 10
# co-op: up to 4 players. Each player slot has its own orb colour (slot 1 uses the character's),
# its own quarter along the bottom, P1 to P4 left to right, for lives (x of the first life, step)
# and power-up codes (x, text align).
const MAX_PLAYERS := 4
const SHOT_COLS := ["", "#228b22", "#4169e1", "#ff7518"]
const LIFE_X := [[6, 14], [86, 14], [166, 14], [246, 14]]
const CODE_X := [[13, 0], [173, 0], [333, 0], [493, 0]]
# GHOST SHOT: two shots that split a little and weave side to side, leaning up to LEAN_MAX degrees
# the way the shooter is moving, building up over LEAN_TIME seconds of moving the same way.
const GS_SPLIT := 18.0
const WEAVE_A := 5.0
const WEAVE_F := 11.0
const LEAN_MAX := 15.0
const LEAN_TIME := 1.0
# SOUL MATE and GHOSTRESS: small ghosts that trail you along the ground. HELP_Y is the middle of them.
const HELP_Y := 212.0
# SOUL MATE fires 3 volleys back for every enemy shot or enemy that touches her, this far apart
const SOUL_GAP := 0.07

# 5x7 pixel font, drawn in code so the project needs no font file.
const GLYPHS := {
	"A": ".###./#...#/#...#/#####/#...#/#...#/#...#", "B": "####./#...#/#...#/####./#...#/#...#/####.",
	"C": ".###./#...#/#..../#..../#..../#...#/.###.", "D": "####./#...#/#...#/#...#/#...#/#...#/####.",
	"E": "#####/#..../#..../####./#..../#..../#####", "F": "#####/#..../#..../####./#..../#..../#....",
	"G": ".###./#...#/#..../#.###/#...#/#...#/.###.", "H": "#...#/#...#/#...#/#####/#...#/#...#/#...#",
	"I": "#####/..#../..#../..#../..#../..#../#####", "J": "..###/...#./...#./...#./...#./#..#./.##..",
	"K": "#...#/#..#./#.#../##.../#.#../#..#./#...#", "L": "#..../#..../#..../#..../#..../#..../#####",
	"M": "#...#/##.##/#.#.#/#.#.#/#...#/#...#/#...#", "N": "#...#/##..#/#.#.#/#..##/#...#/#...#/#...#",
	"O": ".###./#...#/#...#/#...#/#...#/#...#/.###.", "P": "####./#...#/#...#/####./#..../#..../#....",
	"Q": ".###./#...#/#...#/#...#/#.#.#/#..#./.##.#", "R": "####./#...#/#...#/####./#.#../#..#./#...#",
	"S": ".####/#..../#..../.###./....#/....#/####.", "T": "#####/..#../..#../..#../..#../..#../..#..",
	"U": "#...#/#...#/#...#/#...#/#...#/#...#/.###.", "V": "#...#/#...#/#...#/#...#/#...#/.#.#./..#..",
	"W": "#...#/#...#/#...#/#.#.#/#.#.#/##.##/#...#", "X": "#...#/#...#/.#.#./..#../.#.#./#...#/#...#",
	"Y": "#...#/#...#/.#.#./..#../..#../..#../..#..", "Z": "#####/....#/...#./..#../.#.../#..../#####",
	"0": ".###./#...#/#..##/#.#.#/##..#/#...#/.###.", "1": "..#../.##../..#../..#../..#../..#../.###.",
	"2": ".###./#...#/....#/...#./..#../.#.../#####", "3": "####./....#/....#/.###./....#/....#/####.",
	"4": "...#./..##./.#.#./#..#./#####/...#./...#.", "5": "#####/#..../####./....#/....#/#...#/.###.",
	"6": ".###./#..../#..../####./#...#/#...#/.###.", "7": "#####/....#/...#./..#../.#.../.#.../.#...",
	"8": ".###./#...#/#...#/.###./#...#/#...#/.###.", "9": ".###./#...#/#...#/.####/....#/....#/.###.",
	":": "...../..#../..#../...../..#../..#../.....", ".": "...../...../...../...../...../.##../.##..",
	",": "...../...../...../...../..#../..#../.#...", "!": "..#../..#../..#../..#../..#../...../..#..",
	"?": ".###./#...#/....#/...#./..#../...../..#..", "-": "...../...../...../#####/...../...../.....",
	"+": "...../..#../..#../#####/..#../..#../.....", "/": "....#/....#/...#./..#../.#.../#..../#....",
	">": "#..../.#.../..#../...#./..#../.#.../#....", "'": "..#../..#../...../...../...../...../.....",
	"<": "....#/...#./..#../.#.../..#../...#./....#", "%": "##..#/##..#/...#./..#../.#.../#..##/#..##",
	"(": "...#./..#../.#.../.#.../.#.../..#../...#.", ")": ".#.../..#../...#./...#./...#./..#../.#..."}

# ---------------------------------------------------------------- state
var chars: Array = []
var tcache := {}
var gcache := {}
var stars: Array = []
var things: Array = []
var t := 0.0
var mode := "menu"      # menu, game, pause, over
var panel := ""         # menu panel: "", score, shop, settings, reset, quit
var sel := 0
var stab := 0           # UPGRADES menu: which player's tab
var sch := -1           # UPGRADES menu: -1 on the character list, else the character whose upgrades are open
var scur := 0           # UPGRADES menu: cursor
var smsg := ""          # UPGRADES menu: a short message like NEED 500 CANDY
var spre := -1          # UPGRADES menu: the PRESTIGE confirm, -1 closed, else its cursor (0 NO, 1 YES)
var rsel := 0
var ssel := 0
var qsel := 0
var cur := 0            # player 1's character, for the title screen
var G := {}
var cfg := ConfigFile.new()
var pads := {}
var prev_pads := {}
var banner := ""
var muted := false
var music: AudioStreamPlayer
var tracks: Array = []
var track := -1
var sfx_players := {}
var open_cache: Array = [true, false, false, false]
var open_cache_t := -99.0
var lcg := 7
# PLAYER SETUP, only for this session: player slot -> the device that plays it ({"pad", "side"})
var assign := {}
var setup_sel := 0

# ---------------------------------------------------------------- setup
func _ready() -> void:
	randomize()
	cfg.load(SAVE_PATH)
	_build_chars()
	for i in 70:
		stars.append([int(_rnd() * 320), int(_rnd() * 160), _rnd() * 6.28, _rnd() < 0.2])
	_build_things()
	cur = char_pref(0)
	_build_audio()
	# older saves had one "display" choice: 0 was full screen, the bigger sizes become the biggest window that fits
	if not cfg.has_section_key("save", "fullscreen") and int(sv("display", -1)) >= 0:
		sv_set("fullscreen", int(sv("display", -1)) == 0)
		sv_set("winsize", max_win())
	apply_display()

func _rnd() -> float:
	lcg = (lcg * 16807) % 2147483647
	return float(lcg) / 2147483647.0

func _alt(base: Array, m: Dictionary) -> Array:
	var out := []
	for i in base.size():
		out.append(m[i] if m.has(i) else base[i])
	return out

func _build_chars() -> void:
	chars = [
		{"id": "ghost", "name": "GHOST", "spr": GHOST, "orb": "#ffffff",
			"spr2": _alt(GHOST, {11: "X.XXX.XXX.XX", 12: "..X...X...X."}),
			"pals": [GPAL, {"X": "#a8e6a0", "o": "#1b0f33", "b": "#ff9ec2", "m": "#1b0f33"},
				{"X": "#a8bcff", "o": "#1b0f33", "b": "#ff9ec2", "m": "#1b0f33"}, {"X": "#ffc08a", "o": "#1b0f33", "b": "#ff9ec2", "m": "#1b0f33"}],
			# tr: what each character is a bit better at, counted in boosts. desc shows in UPGRADES.
			"tr": {"rate": 2}, "desc": "FIRES QUICK AND HAS FRIENDS",
			# the save keys (triple, rapid...) are the old names, so upgrades already bought are kept
			"pow": [["triple", "GHOST SHOT", "TWO WAVY GHOST SHOTS", "GST"], ["rapid", "RESTLESS SHOT", "SHOOT MUCH FASTER", "RST"],
				["pierce", "SPECTRAL SHOT", "ORBS PASS THROUGH ENEMIES", "SPC"], ["magnet", "SOUL MATE", "CATCHES CANDY AND FIGHTS BACK", "SOL"],
				["twin", "GHOSTRESS", "SHE FOLLOWS AND COPIES SHOTS", "GHS"]]},
		{"id": "cat", "name": "BLACK CAT", "spr": CAT, "orb": "#ffe45c",
			"spr2": _alt(CAT, {0: "KK.......KK.", 1: "KKK.....KKK.", 12: "KK..KKKK..KK"}),
			# always a black cat; players 2-4 have a tummy (c) in their colour: forest green, royal blue, halloween orange
			"pals": [{"K": "#4a4170", "c": "#4a4170", "y": "#ffe45c", "o": "#1b0f33", "p": "#ff9ec2"},
				{"K": "#4a4170", "c": "#228b22", "y": "#ffe45c", "o": "#1b0f33", "p": "#ff9ec2"},
				{"K": "#4a4170", "c": "#4169e1", "y": "#ffe45c", "o": "#1b0f33", "p": "#ff9ec2"},
				{"K": "#4a4170", "c": "#ff7518", "y": "#ffe45c", "o": "#1b0f33", "p": "#ff9ec2"}],
			"tr": {"move": 2}, "desc": "AGILE AND DOESN'T LIKE BEING ATTACKED",
			"pow": [["big", "BIG ORB", "BIGGER ORBS THAT HIT MORE", "BIG"], ["home", "HOMING ORB", "ORBS CURVE TOWARD ENEMIES", "HOM"],
				["shield", "NINE LIVES", "BLOCKS ONE HIT, THEN RECHARGES", "9LV"], ["swift", "CAT REFLEXES", "MOVE MUCH FASTER", "SWF"],
				["dcandy", "DOUBLE CANDY", "EVERY CANDY COUNTS TWICE", "2XC"]]},
		{"id": "zombie", "name": "ZOMBIE", "spr": ZOMB, "orb": "#b6ff7a",
			"spr2": _alt(ZOMB, {7: "G.GGGGGGGG.G", 9: "..SSSSSSSS..", 12: ".PPP....PPP."}),
			"pals": [{"d": "#5a4a3a", "G": "#8fd66a", "o": "#1b0f33", "m": "#3a1420", "S": "#3a3450", "P": "#6a5a8a"},
				{"d": "#5a4a3a", "G": "#b4d66a", "o": "#1b0f33", "m": "#3a1420", "S": "#228b22", "P": "#6a5a8a"},
				{"d": "#5a4a3a", "G": "#8fd6a8", "o": "#1b0f33", "m": "#3a1420", "S": "#4169e1", "P": "#6a5a8a"},
				{"d": "#5a4a3a", "G": "#a8d66a", "o": "#1b0f33", "m": "#3a1420", "S": "#ff7518", "P": "#6a5a8a"}],
			"tr": {"dmg": 2}, "desc": "POWERFUL AND NOT AFRAID OF DEATH",
			"pow": [["regen", "REGROW", "GET A LIFE BACK EVERY 2 WAVES", "RGN"], ["heavy", "HEAVY ORB", "ORBS DO DOUBLE DAMAGE", "HVY"],
				["slow", "ROT CLOUD", "ENEMY SHOTS MOVE SLOWER", "ROT"], ["longinv", "THICK SKIN", "STAY SAFE LONGER AFTER A HIT", "SKN"],
				["score", "BRAIN FOOD", "DOUBLE POINTS", "2XP"]]},
		{"id": "skeleton", "name": "SKELETON", "spr": SKEL, "orb": "#f3efe0",
			"spr2": _alt(SKEL, {7: "W...WWWW...W", 9: "...kWWWWk...", 10: "..WWWWWWWW..", 12: "..WW....WW.."}),
			"pals": [{"W": "#f3efe0", "k": "#1b0f33"}, {"W": "#b8e8b0", "k": "#1b0f33"}, {"W": "#b8c8ff", "k": "#1b0f33"}, {"W": "#ffcf9e", "k": "#1b0f33"}],
			"tr": {"shot": 2}, "desc": "HAS A BONE TO PICK WITH HIS FOES",
			"pow": [["fan", "BONE FAN", "TWO EXTRA ORBS OUT TO THE SIDES", "FAN"], ["more", "DEEP POCKETS", "TWO ORBS SIDE BY SIDE", "MOR"],
				["fast", "QUICK BONES", "ORBS FLY FASTER", "QCK"], ["cdrop", "GRAVE ROBBER", "ENEMIES DROP MORE CANDY", "ROB"],
				["revive", "SECOND WIND", "COME BACK ONCE WITH 2 LIVES", "2ND"]]}]
	# SOUL MATE is each player's ghost colour blended slightly pink, GHOSTRESS slightly purple
	for tint in [["smp", "#ff9ec2"], ["grp", "#b07cff"]]:
		chars[0][tint[0]] = chars[0].pals.map(func(pal):
			var o: Dictionary = pal.duplicate()
			o.X = "#" + Color(pal.X).lerp(Color(tint[1]), 0.2).to_html(false)
			return o)
	for ch in chars:
		var sil := {}
		for k in ch.pals[0].keys():
			sil[k] = "#241b44"
		ch["sil"] = sil

func _build_things() -> void:
	things = [
		{"k": "p", "x": 104, "y": 182, "rx": 7, "ry": 5, "cv": false}, {"k": "p", "x": 140, "y": 178, "rx": 5, "ry": 4, "cv": true},
		{"k": "p", "x": 186, "y": 180, "rx": 6, "ry": 5, "cv": false}, {"k": "p", "x": 226, "y": 177, "rx": 5, "ry": 4, "cv": true},
		{"k": "p", "x": 300, "y": 181, "rx": 7, "ry": 5, "cv": false}, {"k": "p", "x": 160, "y": 200, "rx": 10, "ry": 8, "cv": true},
		{"k": "p", "x": 66, "y": 214, "rx": 11, "ry": 9, "cv": true}, {"k": "p", "x": 232, "y": 222, "rx": 12, "ry": 9, "cv": false},
		{"k": "p", "x": 120, "y": 230, "rx": 9, "ry": 7, "cv": false}, {"k": "p", "x": 296, "y": 232, "rx": 10, "ry": 8, "cv": true},
		{"k": "p", "x": 16, "y": 232, "rx": 9, "ry": 7, "cv": false}, {"k": "p", "x": 196, "y": 234, "rx": 7, "ry": 6, "cv": true},
		{"k": "g", "x": 268, "y": 196, "s": 2, "tint": "#f6f1ff", "cv": true, "ph": 0.0, "face": 0, "hat": "witch", "ch": 0},
		{"k": "g", "x": 108, "y": 206, "s": 2, "tint": "#cfe9ff", "cv": false, "ph": 1.7, "face": 1, "hat": "", "ch": 1},
		{"k": "g", "x": 204, "y": 208, "s": 2, "tint": "#d9ffdc", "cv": true, "ph": 3.1, "face": 2, "hat": "", "ch": 2},
		{"k": "g", "x": 34, "y": 200, "s": 2, "tint": "#ffe0ef", "cv": false, "ph": 4.4, "face": 3, "hat": "", "ch": 3},
		{"k": "g", "x": 268, "y": 236, "s": 3, "tint": "#fff3c9", "cv": false, "ph": 2.3, "face": 4, "hat": "top", "ch": 0},
		{"k": "g", "x": 156, "y": 238, "s": 3, "tint": "#f6f1ff", "cv": true, "ph": 5.2, "face": 5, "hat": "lid", "ch": 0}]
	things.sort_custom(func(a, b): return a.y < b.y)
	for o in things:
		if o.k == "g":
			var rows := GHOST.slice(0, 3)
			rows.append_array(FACE_ROWS[o.face])
			rows.append_array(GHOST.slice(7))
			o["rows"] = rows
			o["pal"] = {"X": o.tint, "o": "#1b0f33", "b": "#ff9ec2", "m": "#1b0f33"}
			o["palb"] = {"X": o.tint, "o": o.tint, "b": "#ff9ec2", "m": "#1b0f33"}

func _build_audio() -> void:
	music = AudioStreamPlayer.new()
	music.volume_db = -6.0
	add_child(music)
	for n in ["music_menu", "music_game", "music_boss"]:
		var st = load("res://audio/%s.wav" % n)
		if st is AudioStreamWAV:
			st.loop_mode = AudioStreamWAV.LOOP_FORWARD
			st.loop_begin = 0
			st.loop_end = int(st.get_length() * st.mix_rate)
		tracks.append(st)
	for n in ["move", "select", "back", "deny", "shoot0", "shoot1", "pop", "bosshit", "hurt", "shield", "roar", "clear", "unlock",
			"life", "treat", "candy", "gameover", "cackle", "squeak", "trick", "join", "boom", "spread", "dash", "ring"]:
		var p := AudioStreamPlayer.new()
		p.stream = load("res://audio/%s.wav" % n)
		p.max_polyphony = 4
		p.volume_db = -4.0
		add_child(p)
		sfx_players[n] = p

func sfx(n: String) -> void:
	if muted or not sfx_players.has(n):
		return
	sfx_players[n].play()

func _update_music() -> void:
	var want := 0
	if (mode == "game" or mode == "pause") and not G.is_empty():
		want = 1
		for e in G.en:
			if e.ty == "B":
				want = 2
	if want != track:
		track = want
		if tracks[track] != null:
			music.stream = tracks[track]
			music.play()
	music.stream_paused = muted

# ---------------------------------------------------------------- save
func sv(key: String, default):
	return cfg.get_value("save", key, default)

func sv_set(key: String, val) -> void:
	cfg.set_value("save", key, val)
	cfg.save(SAVE_PATH)

func lst(key: String) -> Array:
	return Array(sv(key, []))

func to_obj(a: Array) -> Dictionary:
	var o := {}
	for k in a:
		o[k] = true
	return o

# ---------------------------------------------------------------- player profiles
# Each player number (P1-P4) has its own candy, characters, upgrades and ON/OFF settings.
# Saved as "p0.candy", "p0.chars", "p0.char", "p0.own.ghost", "p0.off.ghost" and so on.
func pkey(n: int, key: String) -> String:
	return "p%d.%s" % [n, key]

func candy_of(n: int) -> int:
	return int(sv(pkey(n, "candy"), 0))

func add_candy(n: int, c: int) -> void:
	sv_set(pkey(n, "candy"), candy_of(n) + c)

# the Ghost starts free (until it's prestiged, then it's bought back like the rest), the rest are bought
func has_char(n: int, i: int) -> bool:
	if i == 0:
		return not sv(pkey(n, "ghost.gone"), false)
	return lst(pkey(n, "chars")).has(chars[i].id)

func owned_chars(n: int) -> Array:
	return range(chars.size()).filter(func(i): return has_char(n, i))

# the character this player chose: -1 means RANDOM (only offered once they own 2 or more)
func char_pref(n: int) -> int:
	var i := int(sv(pkey(n, "char"), 0))
	if i < 0 and owned_chars(n).size() >= 2:
		return -1
	i = clampi(i, 0, chars.size() - 1)
	if has_char(n, i):
		return i
	var o := owned_chars(n)
	return o[0] if not o.is_empty() else 0

# the character they actually play this time (RANDOM picks one of theirs)
func pick_char(n: int) -> int:
	var i := char_pref(n)
	return pick(owned_chars(n)) if i < 0 else i

# what the join picker cycles through: their characters, then "?" for random
func pick_opts(n: int) -> Array:
	var o := owned_chars(n)
	if o.size() >= 2:
		o.append(-1)
	return o

# upgrades this player owns for a character
func owns(n: int, ch: int) -> Dictionary:
	return to_obj(lst(pkey(n, "own." + chars[ch].id)))

# how many times this player has prestiged a character
func prestige(n: int, ch: int) -> int:
	if PRESTIGE_LOCKED:
		return 0
	return int(sv(pkey(n, "pre." + chars[ch].id), 0))

func char_cost(n: int, ch: int) -> int:
	return CHAR_COST + CHAR_COST / 10 * prestige(n, ch)

func pow_cost(n: int, ch: int) -> int:
	return POW_COST + POW_COST / 10 * prestige(n, ch)

func is_on(n: int, ch: int, k: String) -> bool:
	return owns(n, ch).has(k) and not lst(pkey(n, "off." + chars[ch].id)).has(k)

# ---------------------------------------------------------------- drawing helpers
func R(x, y, w, h, col: String, a := 1.0) -> void:
	var c := Color(col)
	c.a = a
	draw_rect(Rect2(x, y, w, h), c)

func tex(rows: Array, pal: Dictionary) -> ImageTexture:
	var key := str(rows.hash()) + "_" + str(pal.hash())
	if tcache.has(key):
		return tcache[key]
	var w: int = rows[0].length()
	var img := Image.create(w, rows.size(), false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	for y in rows.size():
		var r: String = rows[y]
		for x in w:
			var ch := r[x]
			if pal.has(ch):
				img.set_pixel(x, y, Color(pal[ch]))
	var tx := ImageTexture.create_from_image(img)
	tcache[key] = tx
	return tx

func spr(rows: Array, pal: Dictionary, x, y, s, white := false) -> void:
	var tx := tex(rows, pal)
	var rect := Rect2(x, y, tx.get_width() * s, tx.get_height() * s)
	if white:
		# draw a white flash by drawing the silhouette brighter
		draw_texture_rect(tx, rect, false, Color(8, 8, 8, 1))
	else:
		draw_texture_rect(tx, rect, false)

func ellipse(cx: int, cy: int, rx: int, ry: int, col: String, a := 1.0) -> void:
	for dy in range(-ry, ry + 1):
		var hw := int(round(rx * sqrt(maxf(0.0, 1.0 - float(dy * dy) / (ry * ry + 0.01)))))
		R(cx - hw, cy + dy, hw * 2 + 1, 1, col, a)

func pline(x0: float, y0: float, x1: float, y1: float, w: int, col: String) -> void:
	var n := int(maxf(absf(x1 - x0), absf(y1 - y0)))
	if n < 1:
		n = 1
	for i in n + 1:
		var x := x0 + (x1 - x0) * i / n
		var y := y0 + (y1 - y0) * i / n
		R(round(x - w / 2.0), round(y - w / 2.0), w, w, col)

func pumpkin(cx: int, cy: int, rx: int, ry: int, carved: bool, tt: float, seed_v: float) -> void:
	var fl := 0.0
	if carved:
		fl = (sin(tt * 9 + seed_v * 7) + sin(tt * 5.3 + seed_v)) * 0.5
		ellipse(cx, cy, rx + 7, ry + 6, "#ff9a2e", 0.10 + 0.04 * fl)
		ellipse(cx, cy, rx + 3, ry + 3, "#ffb84a", 0.14 + 0.05 * fl)
	ellipse(cx, cy, rx, ry, "#c2520c")
	ellipse(cx, cy - 1, rx - 1, ry - 1, "#ee7a14")
	ellipse(cx - int(round(rx / 3.0)), cy - int(round(ry / 3.0)), maxi(1, int(round(rx / 3.0))), maxi(1, int(round(ry / 3.0))), "#ff9a33")
	var off := int(round(rx / 2.0))
	for o in [-off, off]:
		var h := int(round(ry * sqrt(1.0 - float(o * o) / (rx * rx)))) - 1
		R(cx + o, cy - h, 1, h * 2, "#b4480a")
	R(cx - 1, cy - ry - 3, 2, 3, "#3d6b2a")
	R(cx + 1, cy - ry - 3, 2, 1, "#3d6b2a")
	if carved:
		var col := "#ffe45c" if fl > 0 else "#ffc23a"
		var e := maxi(1, int(round(rx / 4.0)))
		var ex := int(round(rx / 2.0))
		var ey := cy - int(round(ry / 3.0))
		for i in e + 1:
			R(cx - ex - i, ey + i - e, i * 2 + 1, 1, col)
			R(cx + ex - i, ey + i - e, i * 2 + 1, 1, col)
		var my := cy + int(round(ry / 3.0))
		var mw := int(round(rx * 0.6))
		R(cx - mw, my, mw * 2 + 1, maxi(1, e), col)
		var x := cx - mw + 1
		while x < cx + mw:
			R(x, my, 1, 1, "#ee7a14")
			x += 3
		if e > 1:
			x = cx - mw + 2
			while x < cx + mw:
				R(x, my + e - 1, 1, 1, "#ee7a14")
				x += 3

func draw_tree(flip: bool, oy: int) -> void:
	for l in TREE:
		var xa: float = 320 - l[0] if flip else l[0]
		var xb: float = 320 - l[2] if flip else l[2]
		pline(xa, l[1] + oy, xb, l[3] + oy, l[4], "#05030c")
	var hl := [[31, 200, 33, 124], [36, 108, 58, 96], [36, 86, 45, 68]]
	for l in hl:
		var xa: float = 320 - l[0] if flip else l[0]
		var xb: float = 320 - l[2] if flip else l[2]
		pline(xa, l[1] + oy, xb, l[3] + oy, 1, "#2b1a4d")

func draw_sky(tt: float) -> void:
	var bands := ["#0c0620", "#110828", "#150b30", "#1a0e3a", "#211244", "#29164c"]
	for i in bands.size():
		R(0, i * 28, 320, 28, bands[i])
	R(0, 168, 320, 72, "#29164c")
	for s in stars:
		var a := 0.45 + 0.55 * sin(tt * 1.6 + s[2])
		if a < 0.25:
			continue
		var col := "#ffe9a8" if s[3] else "#e9defc"
		R(s[0], s[1], 1, 1, col, a)
		if s[3] and a > 0.85:
			R(s[0] - 1, s[1], 3, 1, col, a)
			R(s[0], s[1] - 1, 1, 3, col, a)

# text: 5x7 glyphs in a 6x8 cell, scaled by s. align 0 left, 1 center, 2 right.
func glyph(ch: String) -> ImageTexture:
	if gcache.has(ch):
		return gcache[ch]
	var img := Image.create(5, 7, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	if GLYPHS.has(ch):
		var rows: PackedStringArray = GLYPHS[ch].split("/")
		for y in 7:
			for x in 5:
				if rows[y][x] == "#":
					img.set_pixel(x, y, Color.WHITE)
	var tx := ImageTexture.create_from_image(img)
	gcache[ch] = tx
	return tx

func text_w(s: String, sc: int) -> int:
	return s.length() * 6 * sc

func T(s: String, x: float, y: float, sc: int, col: String, align := 0, shadow := true) -> void:
	s = s.to_upper()
	var px := x
	if align == 1:
		px = x - text_w(s, sc) / 2.0
	elif align == 2:
		px = x - text_w(s, sc)
	var c := Color(col)
	for i in s.length():
		var ch := s[i]
		if ch == " ":
			continue
		var tx := glyph(ch)
		var rect := Rect2(px + i * 6 * sc, y, 5 * sc, 7 * sc)
		if shadow:
			draw_texture_rect(tx, Rect2(rect.position + Vector2(sc, sc), rect.size), false, Color(0, 0, 0, 0.9))
		draw_texture_rect(tx, rect, false, c)

# the title: candy corn stripes that shift letter by letter over a purple glow
func draw_title() -> void:
	var s := "SPOOKY BURST"
	var sc := 6
	var x0 := 320 - text_w(s, sc) / 2.0
	var y0 := 58.0
	var cols := [Color("#fffaf0"), Color("#ff8a1f"), Color("#ffd92e")]
	for i in s.length():
		var ch := s[i]
		if ch == " ":
			continue
		var rows: PackedStringArray = GLYPHS[ch].split("/")
		var gx := x0 + i * 6 * sc
		var ph := int(floor(t * 1.7 - i * 0.45))
		for pass_i in 3:
			for y in 7:
				for x in 5:
					if rows[y][x] != "#":
						continue
					var r := Rect2(gx + x * sc, y0 + y * sc, sc, sc)
					if pass_i == 0:
						draw_rect(Rect2(r.position - Vector2(3, 3), r.size + Vector2(6, 6)), Color(0.63, 0.24, 1.0, 0.16))
					elif pass_i == 1:
						draw_rect(Rect2(r.position + Vector2(3, 3), r.size), Color("#4a1690"))
					else:
						var band := 0 if y < 2 else (1 if y < 5 else 2)
						draw_rect(r, cols[posmod(band + ph, 3)])
	T("THE", 320, 32, 2, "#ff8a1f", 1)

# ---------------------------------------------------------------- start screen
func draw_patch_figure(o: Dictionary) -> void:
	var s: int = o.s
	var bob := int(round(sin(t * 2 + o.ph) * 2))
	var w := 12 * s
	var h := 13 * s
	var gx := int(round(o.x - w / 2.0))
	var gy: int = o.y - h - 3 + bob
	ellipse(o.x, o.y, int(round(w / 2.0)), 2, "#000000", 0.25)
	var hand: String = o.tint
	if o.ch > 0:
		var C: Dictionary = chars[o.ch]
		var frame: Array = C.spr2 if int(floor(t * 3 + o.ph)) % 2 == 1 else C.spr
		var unlocked: bool = open_cache[o.ch]
		spr(frame, C.pals[0] if unlocked else C.sil, gx, gy, s)
		hand = C.pals[0].values()[0] if unlocked else "#241b44"
	else:
		var blink := fmod(t + o.ph * 3, 4.0) < 0.15
		spr(o.rows, o.palb if blink else o.pal, gx, gy, s)
		if HATS.has(o.hat):
			var hat: Dictionary = HATS[o.hat]
			spr(hat.r, HATPAL, gx, gy - (hat.r.size() - hat.ov) * s, s)
	var pr := int(round(3.2 * s))
	var py := gy + 9 * s
	pumpkin(o.x, py, pr, pr - 1, o.cv, t, o.ph)
	R(o.x - pr - s, py, s, s, hand)
	R(o.x + pr + 1, py, s, s, hand)

func draw_menu_scene() -> void:
	draw_sky(t)
	ellipse(250, 176, 120, 14, "#0b0718")
	ellipse(60, 178, 110, 12, "#0b0718")
	var x := 96
	while x < 320:
		R(x, 158, 3, 12, "#05030c")
		R(x + 1, 156, 1, 2, "#05030c")
		x += 9
	R(96, 162, 224, 1, "#05030c")
	R(96, 166, 224, 1, "#05030c")
	R(0, 168, 320, 72, "#0f0b1c")
	var y := 174
	while y < 240:
		R(0, y, 320, 2, "#17122a")
		y += 11
	for i in 46:
		var vx := (i * 53) % 320
		var vy := 172 + ((i * 37) % 64)
		R(vx, vy, 4, 1, "#1f3a1c")
		R(vx + 3, vy - 1, 2, 1, "#1f3a1c")
	draw_tree(false, 0)
	# the bat hanging upside down
	var cyc := fmod(t, 7.0)
	var l_open := cyc > 4.6 and cyc < 6.2
	var r_open := cyc > 5.2 and cyc < 5.9
	var flap := cyc > 5.9 and cyc < 6.4 and int(floor(t * 10)) % 2 == 0
	var bx := 57
	var by := 96
	if flap:
		R(bx - 4, by + 6, 6, 8, "#3a2860")
		R(bx + 16, by + 6, 6, 8, "#3a2860")
		R(bx - 6, by + 8, 2, 4, "#3a2860")
		R(bx + 22, by + 8, 2, 4, "#3a2860")
	spr(HANGBAT, {"X": "#4b3578", "l": "#ffe45c" if l_open else "#241640", "r": "#ffe45c" if r_open else "#241640"}, bx, by, 2)
	R(bx + 2, by + 6, 2, 8, "#35235a")
	R(bx + 14, by + 6, 2, 8, "#35235a")
	for i in things.size():
		var o: Dictionary = things[i]
		if o.k == "p":
			pumpkin(o.x, o.y - o.ry, o.rx, o.ry, o.cv, t, i)
		else:
			draw_patch_figure(o)

# ---------------------------------------------------------------- graveyard
func draw_graveyard(boss_here: bool) -> void:
	draw_sky(0.9)
	ellipse(56, 46, 34, 34, "#fff6c8", 0.08)
	ellipse(56, 46, 27, 27, "#fff6c8", 0.14)
	ellipse(56, 46, 21, 21, "#f6efc9")
	ellipse(54, 44, 19, 19, "#fffbe6")
	ellipse(48, 40, 4, 3, "#e2d9ae")
	ellipse(63, 52, 3, 3, "#e2d9ae")
	ellipse(58, 36, 2, 2, "#e2d9ae")
	ellipse(47, 54, 2, 2, "#e2d9ae")
	ellipse(230, 226, 150, 18, "#0e0a1c")
	ellipse(70, 228, 120, 14, "#0e0a1c")
	draw_tree(true, 18)
	for s in [[18, 12, 20, 1], [52, 14, 26, 0], [96, 11, 16, 2], [134, 13, 22, 1], [176, 12, 18, 0], [214, 14, 24, 2], [250, 10, 15, 1]]:
		var x: int = s[0]
		var w: int = s[1]
		var h: int = s[2]
		var top := 226 - h
		R(x, top, w, h, "#1d1636")
		ellipse(x + w / 2, top, w / 2, 4, "#1d1636")
		R(x, top, 1, h, "#30265a")
		if s[3] == 1:
			R(x + w / 2 - 1, top + 2, 2, 9, "#0f0a22")
			R(x + w / 2 - 3, top + 4, 6, 2, "#0f0a22")
		elif s[3] == 0:
			R(x + 3, top + 4, w - 6, 1, "#0f0a22")
			R(x + 3, top + 7, w - 7, 1, "#0f0a22")
			R(x + 3, top + 10, w - 8, 1, "#0f0a22")
		else:
			R(x + 3, top + 5, w - 6, 1, "#0f0a22")
	R(0, 224, 320, 16, "#0b0816")
	if boss_here:
		R(0, 0, 320, 240, "#ff1133", 0.07)
		ellipse(56, 46, 21, 21, "#d1122e", 0.6)

# ---------------------------------------------------------------- game helpers
func say(s: String, dur: float) -> void:
	banner = s
	G.bt = dur

# n: player number (0 = P1), which is also whose profile they use. own: upgrades this player has bought
# for their character. eq: upgrades they have this run. bo: how many of each boost this run. got: candy this run.
func mk_player(x: float, n: int, kb: String, pad: int, ch: int) -> Dictionary:
	return {"x": x, "cd": 0.0, "inv": 1.5, "lives": 5, "n": n, "kb": kb, "pad": pad, "out": false,
		"own": owns(n, ch), "eq": {}, "bo": {}, "ch": ch, "got": 0, "sh": 0.0, "revived": false,
		"ld": 1, "md": 0, "mv": 0.0}

func bo(p: Dictionary, k: String) -> int:
	return int(p.bo.get(k, 0))

# how many boosts' worth of k a player has: this run's boosts (up to 10), their character's trait,
# and +1 for each time they've prestiged that character (up to 10 more)
func lvl(p: Dictionary, k: String) -> int:
	return bo(p, k) + int(chars[p.ch].tr.get(k, 0)) + prestige(p.n, p.ch)

func add_player(x: float, pad: int, kb: String, ch: int, slot: int) -> Dictionary:
	var np := mk_player(x, slot, kb, pad, ch)
	G.players.append(np)
	return np

# the lowest player number nobody is using or about to use
# the slot a device joins as: its PLAYER SETUP slot if that's free, otherwise the lowest free slot
# that isn't set up for a different device. -1 if there's none.
func free_slot(dev: Dictionary) -> int:
	var used := func(s): return not G.players.filter(func(p): return p.n == s).is_empty() or not G.picks.filter(func(k): return k.slot == s).is_empty()
	var a := slot_of(dev)
	if a >= 0 and not used.call(a):
		return a
	for s in MAX_PLAYERS:
		if not used.call(s) and not assign.has(s):
			return s
	return -1

func same_dev(a: Dictionary, b: Dictionary) -> bool:
	return a.pad == b.pad and (a.pad >= 0 or a.side == b.side)

# the slot PLAYER SETUP gave this device, or -1
func slot_of(dev: Dictionary) -> int:
	for s in assign:
		if same_dev(assign[s], dev):
			return s
	return -1

# the spot furthest from everyone already playing
func open_x() -> float:
	var best := 160.0
	var gap := -1.0
	for x in [40.0, 100.0, 160.0, 220.0, 280.0]:
		var d := 999.0
		for p in live():
			d = minf(d, absf(p.x - x))
		if d > gap:
			gap = d
			best = x
	return best

func live() -> Array:
	return G.players.filter(func(p): return not p.out)

func nearest(x: float) -> Dictionary:
	var best = null
	for p in live():
		if best == null or absf(p.x - x) < absf(best.x - x):
			best = p
	return best if best != null else G.players[0]

func any_eq(key: String) -> bool:
	for p in G.players:
		if p.eq.has(key):
			return true
	return false

func pts(n: int) -> void:
	G.score += n * (2 if any_eq("score") else 1)

func pick(arr: Array):
	return arr[randi() % arr.size()]

func burst(x: float, y: float, col: String, n: int) -> void:
	for i in n:
		var a := randf() * TAU
		var s := 30 + randf() * 70
		G.parts.append({"x": x, "y": y, "vx": cos(a) * s, "vy": sin(a) * s, "life": 0.35 + randf() * 0.3, "col": col})

func new_enemy(ty: String, hx: float, hy: float, x: float, y: float, hp: int, st: String) -> Dictionary:
	return {"ty": ty, "hx": hx, "hy": hy, "x": x, "y": y, "hp": hp, "max": hp, "st": st, "t": randf() * 6.0, "vx": 0.0, "flash": 0.0,
		"dead": false, "dir": 1, "fy": 120.0, "pass": 0, "drop": 0.3, "bk": 0, "at": 1.5, "n": 0, "ph": 0.0, "dz": 0.0,
		"sp": 0.0, "spt": 0.0, "spa": 0.0, "raged": false}

func start_game(pad: int, side := "wasd") -> void:
	G = {"players": [], "shots": [], "eb": [], "en": [], "candy": [], "parts": [], "drops": [],
		"wave": 0, "score": 0, "t": 0.0, "dive": 2.4, "wt": 1.5, "wf": 2.5, "vt": 3.0, "bt": 0.0, "clearing": 0.0,
		"high": int(sv("high", 0)), "pks": [], "pk_t": 5.0, "pk_done": false, "bonus_t": -1.0,
		"shake": 0.0, "boom": null, "toast": null, "menu": null, "picks": [], "bm": 1.0, "slow": 1.0}
	var slot := maxi(0, free_slot({"pad": pad, "side": side}))
	# everyone they had is prestiged and not bought back yet: off to UPGRADES to buy one
	if owned_chars(slot).is_empty():
		panel = "shop"
		stab = slot
		sch = -1
		scur = 0
		spre = -1
		smsg = "P%d HAS NO CHARACTERS: BUY ONE TO PLAY." % (slot + 1)
		sfx("deny")
		return
	add_player(160, pad, "" if pad >= 0 else "both", pick_char(slot), slot)
	mode = "game"
	panel = ""
	next_wave()

func next_wave() -> void:
	G.wave += 1
	var w: int = G.wave
	G.pk_t = 4.0 + randf() * 4.0
	G.pk_done = false
	# about 1 wave in 6 a bonus pumpkin also flies across above all the enemies
	G.bonus_t = 6.0 + randf() * 6.0 if randf() < 1.0 / 6.0 else -1.0
	if w > 1 and w % 2 == 1:
		for p in G.players:
			if not p.out and p.eq.has("regen") and p.lives < 5:
				p.lives += 1
	if w % 5 == 0:
		G.bm = boss_mult()
		var hp := int(round((36 + w * 4) * G.bm))
		var b := new_enemy("B", 160, 66, 160, -30, hp, "enter")
		b.bk = (w / 5 - 1) % 3
		b.t = 0.0
		G.en.append(b)
		say(BOSS_NAMES[b.bk], 2.2)
		sfx("roar")
		G.shake = 1.0
		return
	var rows := []
	if w >= 4:
		rows.append("v")
	if w >= 2:
		rows.append("w")
	rows.append("b")
	rows.append("b")
	if w >= 6:
		rows.append("b")
	for r in rows.size():
		var ty: String = rows[r]
		for q in 8:
			if ty == "v" and (q < 2 or q > 5):
				continue
			G.en.append(new_enemy(ty, 62 + q * 28, 44 + r * 22, 62 + q * 28, 44 + r * 22 - 160 - r * 18 - q * 6, 3 if ty == "v" else 1, "enter"))
	say("WAVE %d" % w, 1.4)

# ---------------------------------------------------------------- co-op
# Lives are shared, never created: a player joining takes lives one at a time from whoever has
# the most (a random one on a tie) until everyone is within one life of each other.
func share_lives(np: Dictionary) -> void:
	np.lives = 0
	while true:
		var top := 0
		for p in live():
			if not is_same(p, np):
				top = maxi(top, p.lives)
		if top < np.lives + 2:
			break
		var rich := live().filter(func(p): return not is_same(p, np) and p.lives == top)
		var d: Dictionary = pick(rich)
		d.lives -= 1
		np.lives += 1

# a player leaving hands their lives to whoever has the fewest, up to 5 each
func give_lives(n: int) -> void:
	for i in n:
		var low := 99
		for p in live():
			low = mini(low, p.lives)
		if low >= 5:
			return
		var poor := live().filter(func(p): return p.lives == low)
		var d: Dictionary = pick(poor)
		d.lives += 1

func spare_life() -> bool:
	for p in live():
		if p.lives >= 2:
			return true
	return false

# bosses get 50% more health for each extra player, and change when players join or leave
func boss_mult() -> float:
	return 1.0 + 0.5 * maxi(0, live().size() - 1)

func rescale_boss() -> void:
	var m := boss_mult()
	for e in G.en:
		if e.ty == "B":
			e.hp = maxi(1, int(round(e.hp * m / G.bm)))
			e.max = int(round(e.max * m / G.bm))
	G.bm = m

# a device is a controller (pad >= 0) or one side of the keyboard (side "wasd" or "arrows").
# One keyboard player uses both sides ("both"); a second one splits it.
func dev_player(dev: Dictionary):
	for p in G.players:
		if dev.pad >= 0 and p.pad == dev.pad:
			return p
		if dev.pad < 0 and (p.kb == "both" or (p.kb != "" and p.kb == dev.side)):
			return p
	return null

# why this device can't join right now, or "" if it can
func join_block(dev: Dictionary) -> String:
	if dev_pick(dev) != null:
		return "ALREADY PICKING"
	var p = dev_player(dev)
	if p != null and not p.out and not (dev.pad < 0 and p.kb == "both"):
		return "ALREADY PLAYING"
	if (p == null or not p.out) and G.players.size() + G.picks.filter(func(k): return k.rejoin == null).size() >= MAX_PLAYERS:
		return "%d PLAYERS MAX" % MAX_PLAYERS
	if (p == null or not p.out) and free_slot(dev) < 0:
		return "NO FREE PLAYER SLOT"
	if owned_chars(p.n if p != null and p.out else free_slot(dev)).is_empty():
		return "BUY A CHARACTER FIRST"
	if not spare_life():
		return "NO LIVES TO SHARE"
	return ""

# Joining shows a little character picker at that player's spot while the game keeps going:
# left / right picks one of their characters, shoot joins, Start / Back (Esc / Backspace) cancels.
func dev_pick(dev: Dictionary):
	for k in G.picks:
		if k.dev.pad == dev.pad and (dev.pad >= 0 or k.dev.side == dev.side or not k.split):
			return k
	return null

func open_picker(dev: Dictionary) -> void:
	var p = dev_player(dev)
	var rejoin = p if p != null and p.out else null
	# a second keyboard player takes the arrow keys, so the first one moves to WASD while they pick
	var split: bool = dev.pad < 0 and p != null and not p.out and p.kb == "both"
	if split:
		p.kb = "wasd"
	var slot: int = rejoin.n if rejoin != null else free_slot(dev)
	var ch: int = rejoin.ch if rejoin != null else char_pref(slot)
	G.picks.append({"dev": dev, "slot": slot, "ch": ch, "rejoin": rejoin, "split": split})
	sfx("select")

func pick_cycle(k: Dictionary, d: int) -> void:
	var opts := pick_opts(k.slot)
	k.ch = opts[posmod(opts.find(k.ch) + d, opts.size())]
	sfx("move")

func close_picker(k: Dictionary) -> void:
	G.picks = G.picks.filter(func(o): return not is_same(o, k))
	if k.split and G.players.filter(func(q): return q.kb == "arrows").is_empty():
		for q in G.players:
			if q.kb == "wasd":
				q.kb = "both"

func pick_cancel(k: Dictionary) -> void:
	close_picker(k)
	sfx("back")

func pick_ok(k: Dictionary) -> void:
	close_picker(k)
	if not spare_life():
		say("NO LIVES TO SHARE", 1.2)
		sfx("deny")
		return
	if k.split:
		for q in G.players:
			if q.kb == "both":
				q.kb = "wasd"
	sv_set(pkey(k.slot, "char"), k.ch)
	var ch: int = k.ch if k.ch >= 0 else pick(owned_chars(k.slot))
	var np: Dictionary
	if k.rejoin != null:
		np = k.rejoin
		if np.ch != ch:
			np.ch = ch
			np.own = owns(np.n, np.ch)
			np.eq = {}
		np.x = open_x()
		np.out = false
	else:
		var kb := ""
		if k.dev.pad < 0:
			kb = "arrows" if k.split else "both"
		np = add_player(open_x(), k.dev.pad, kb, ch, k.slot)
	np.inv = 2.0
	share_lives(np)
	rescale_boss()
	say("PLAYER %d JOINED" % (np.n + 1) + (": " + chars[ch].name if k.ch < 0 else ""), 1.6)
	sfx("join")

func leave(p: Dictionary) -> void:
	G.players = G.players.filter(func(q): return not is_same(q, p))
	G.shots = G.shots.filter(func(s): return s.o != p.n)
	if not p.out:
		give_lives(p.lives)
	if p.kb == "wasd" or p.kb == "arrows":
		for q in G.players:
			if q.kb != "":
				q.kb = "both"
	rescale_boss()
	say("PLAYER %d LEFT" % (p.n + 1), 1.2)
	sfx("back")
	if live().is_empty():
		game_over()

# Start / Esc / Backspace during a game: someone already playing gets the menu, anyone else
# (a new controller, the free side of the keyboard, or a player who is out) gets the character picker.
func menu_key(dev: Dictionary) -> void:
	var open = dev_pick(dev)
	if open != null:
		pick_cancel(open)
		return
	var p = dev_player(dev)
	var playing: bool = p != null and not p.out and not (dev.pad < 0 and dev.side == "arrows" and p.kb == "both")
	if playing:
		open_menu(dev)
		return
	var why := join_block(dev)
	if why == "":
		open_picker(dev)
	else:
		say(why, 1.2)
		sfx("deny")

# the game menu, run by whichever device opened it
func open_menu(dev: Dictionary) -> void:
	G.menu = {"dev": dev, "sel": 0}
	mode = "pause"
	sfx("select")

func close_menu() -> void:
	G.menu = null
	mode = "game"
	sfx("back")

func pause_rows() -> Array:
	var dev: Dictionary = G.menu.dev
	return [["RESUME", "", false], ["JOIN", "", join_block(dev) != ""], ["PLAYER SETUP", "", false], ["QUIT", "", dev_player(dev) == null],
		["MAIN MENU", "", false]]

func pause_move(d: int) -> void:
	G.menu.sel = posmod(G.menu.sel + d, pause_rows().size())
	sfx("move")

func pause_choose() -> void:
	var m: Dictionary = G.menu
	if pause_rows()[m.sel][2]:
		sfx("deny")
		return
	if m.sel == 2:
		m.setup = true
		setup_sel = 0
		sfx("select")
		return
	G.menu = null
	mode = "game"
	if m.sel == 0:
		sfx("select")
	elif m.sel == 1:
		open_picker(m.dev)
	elif m.sel == 3:
		leave(dev_player(m.dev))
	else:
		sfx("back")
		to_menu()

func to_menu() -> void:
	mode = "menu"
	panel = ""
	banner = ""

# Shooting the glowing pumpkin drops a power-up. Whoever catches it gets one they don't have yet
# this run, picked from the upgrades they've bought and switched ON in the UPGRADES menu.
# Nothing is unlocked in game. No pop-up: the name shows for a moment instead.
func award(p: Dictionary) -> void:
	var left := []
	for w in chars[p.ch].pow:
		if not p.eq.has(w[0]) and is_on(p.n, p.ch, w[0]):
			left.append(w)
	if left.is_empty():
		give_boost(p)
		return
	var pw: Array = pick(left)
	p.eq[pw[0]] = true
	G.toast = {"key": pw[0], "title": pw[1], "desc": pw[2], "n": p.n, "t": 2.6}
	sfx("unlock")

# a random boost that isn't maxed yet; once every boost is maxed, points instead
func give_boost(p: Dictionary) -> void:
	var opts := BOOSTS.filter(func(b): return bo(p, b[0]) < BOOST_MAX)
	if opts.is_empty():
		pts(300)
		say("BONUS %d" % (600 if any_eq("score") else 300), 1.2)
		return
	var b: Array = pick(opts)
	p.bo[b[0]] = bo(p, b[0]) + 1
	G.toast = {"key": b[0], "title": b[1], "desc": "%s  (%d/%d)" % [b[2], p.bo[b[0]], BOOST_MAX], "n": p.n, "t": 2.6}
	sfx("unlock")

func kill(e: Dictionary) -> void:
	e.dead = true
	if e.ty == "B":
		pts(2000)
		for i in 6:
			burst(e.x + (randf() - 0.5) * 50, e.y + (randf() - 0.5) * 36, "#b3122e" if i % 2 == 1 else "#ffd92e", 14)
		for i in 6:
			G.candy.append({"x": e.x + (i - 2.5) * 16, "y": e.y, "dead": false})
		for o in G.en:
			if not o.dead:
				o.dead = true
				burst(o.x, o.y, "#8a66e0", 8)
		for b in G.eb:
			b.dead = true
		G.clearing = 2.4
		say(BOSS_NAMES[e.bk] + " DEFEATED", 2.0)
		sfx("roar")
		G.shake = 1.2
		G.boom = {"x": e.x, "y": e.y, "t": 1.2, "n": 0.0}
		return
	var base: int = {"b": 50, "w": 80, "v": 150}[e.ty]
	pts(base * (2 if e.st == "dive" else 1))
	burst(e.x, e.y, {"b": "#8a66e0", "w": "#8fd66a", "v": "#b3122e"}[e.ty], 10)
	if randf() < (0.56 if any_eq("cdrop") else 0.28):
		G.candy.append({"x": e.x, "y": e.y, "dead": false})
	sfx("pop")

func hurt(p: Dictionary) -> void:
	if p.eq.has("shield") and p.sh <= 0:
		p.sh = 15.0
		p.inv = 1.0
		burst(p.x, 209, "#7df2ff", 14)
		sfx("shield")
		return
	p.lives -= 1
	p.inv = (4.0 if p.eq.has("longinv") else 2.0) * (1.0 + 0.06 * lvl(p, "safe"))
	burst(p.x, 209, "#ffffff", 16)
	sfx("hurt")
	G.shake = 0.25
	if p.lives <= 0:
		if p.eq.has("revive") and not p.revived:
			# SECOND WIND: wiped just like dying (power-ups and boosts gone), then back with 2 lives
			p.eq = {}
			p.bo = {}
			p.sh = 0.0
			p.revived = true
			p.lives = 2
			say("SECOND WIND", 1.5)
		else:
			# out of lives: every power-up and boost from this run is lost, and nobody else gets them.
			# Candy is already saved to their profile, so they keep that.
			p.out = true
			p.eq = {}
			p.bo = {}
			p.sh = 0.0
			p.revived = false
	if live().is_empty():
		game_over()

func game_over() -> void:
	mode = "over"
	banner = ""
	sfx("gameover")
	sv_set("high", maxi(G.high, G.score))
	sv_set("wave", maxi(int(sv("wave", 0)), G.wave))

func launch_pk(y: float, bob: float) -> void:
	var d := 1 if randf() < 0.5 else -1
	G.pks.append({"x": -12.0 if d > 0 else 332.0, "y": y, "base": y, "bob": bob, "dir": d, "hp": 2, "flash": 0.0})

# the normal pumpkin flies in somewhere between just below the lowest enemy still alive (or below the boss)
# and its old height, so it's never hidden behind the formation; clearing the bottom rows lets it fly higher
func pk_height() -> float:
	var low := 30.0
	for e in G.en:
		if e.dead:
			continue
		if e.ty == "B":
			low = maxf(low, minf(e.y, 92.0) + 40.0)
		else:
			low = maxf(low, e.hy + 22.0)
	return randf_range(minf(low, 160.0), 160.0)

func corn(e: Dictionary) -> void:
	G.eb.append({"x": e.x, "y": e.y + 8, "vx": 0.0, "vy": 85.0 + G.wave * 3, "k": "c", "ph": randf() * TAU, "dead": false})

# cap: a boss shot that only drifts sideways for 2 character widths (24 px), then falls straight down
func bshot(e: Dictionary, vx: float, vy: float, k: String, x = null, y = null, cap := false) -> void:
	var sx: float = e.x if x == null else x
	G.eb.append({"x": sx, "y": e.y + 20 if y == null else y, "vx": vx, "vy": vy, "k": k, "ph": randf() * TAU, "dead": false,
		"x0": sx, "cap": cap})

func wave_drop() -> void:
	var low := false
	var hurt_any := false
	for p in live():
		if p.lives <= 2:
			low = true
		if p.lives < 5:
			hurt_any = true
	var r := randf()
	var k := ""
	if hurt_any and r < (0.7 if low else 0.35):
		k = "h"
	elif r < 0.85:
		k = "b"
	if k != "":
		G.drops.append({"x": 40 + randf() * 240, "y": -10.0, "k": k, "dead": false})

func catch_drop(d: Dictionary, p: Dictionary) -> void:
	d.dead = true
	if d.k == "p":
		award(p)
		return
	if d.k == "h":
		if p.lives < 5:
			p.lives += 1
		say("CANDIED APPLE: +1 LIFE", 1.4)
		sfx("life")
		return
	var r := randf()
	if r < 0.5:
		var c := 10 if p.eq.has("dcandy") else 5
		add_candy(p.n, c)
		p.got += c
		pts(100)
		say("TREAT: %d CANDY" % c, 1.4)
		sfx("treat")
	elif r < 0.7:
		pts(300)
		say("TREAT: 300 POINTS", 1.4)
		sfx("treat")
	elif r < 0.85:
		if p.lives < 5:
			p.lives += 1
		say("TREAT: EXTRA LIFE", 1.4)
		sfx("life")
	else:
		for i in 3:
			G.en.append(new_enemy("b", 62 + (randi() % 8) * 28, 44, d.x + (i - 1) * 16, d.y - 24, 1, "return"))
		say("TRICK!", 1.2)
		sfx("trick")

func boss(e: Dictionary, dt: float) -> void:
	if e.st == "enter":
		e.y += 45 * dt
		if e.y >= 66:
			e.y = 66
			e.st = "form"
			e.at = 1.2
		return
	var rage: bool = e.hp < e.max / 2.0
	var K := "r" if e.bk == 0 else "c"
	if rage and not e.raged:
		e.raged = true
		say("ENRAGED!", 1.2)
		sfx("roar")
		G.shake = 0.6
	e.ph += dt * (1.25 if rage else 1.0)
	var bx := 0.0
	var by := 0.0
	if e.bk == 1:
		bx = 160 + sin(e.ph * 1.0) * 112
		by = 70 + sin(e.ph * 2.0) * 18
	elif e.bk == 2:
		bx = 160 + sin(e.ph * 1.1) * 108
		by = 62 + absf(sin(e.ph * 2.4)) * 26
	else:
		bx = 160 + sin(e.ph * 0.7) * 112
		by = 66 + sin(e.ph * 1.9) * 10
	if e.dz > 0:
		e.dz -= dt
		by += sin(PI * (1.0 - maxf(0.0, e.dz) / 1.6)) * 112
	e.x = bx
	e.y = by
	if e.sp > 0:
		e.sp -= dt
		e.spt -= dt
		if e.spt <= 0:
			e.spt = 0.09
			e.spa += 0.5
			var a := sin(e.spa) * 1.15
			bshot(e, sin(a) * 95, cos(a) * 95, K)
	if e.dz > 0 or e.sp > 0:
		return
	e.at -= dt
	if e.at > 0:
		return
	e.at = 0.95 if rage else 1.5
	e.n += 1
	var m: int = e.n % 5
	if m == 1:
		var angs := [-0.9, -0.6, -0.3, 0.0, 0.3, 0.6, 0.9] if e.bk == 2 else [-0.6, -0.3, 0.0, 0.3, 0.6]
		for a in angs:
			bshot(e, sin(a) * 85, cos(a) * 85, K)
		sfx("spread")
	elif m == 2:
		var alive_p := live()
		if not alive_p.is_empty():
			var tg: Dictionary = pick(alive_p)
			for i in 3:
				var dx: float = tg.x - e.x + (i - 1) * 26
				var dy: float = 209 - e.y
				var d := maxf(1.0, sqrt(dx * dx + dy * dy))
				# only the WITCH QUEEN's aimed shots stop drifting sideways after a bit
				bshot(e, dx / d * 105, dy / d * 105, K, null, null, e.bk == 1)
		sfx("spread")
	elif m == 3:
		if e.bk == 1:
			for i in 2:
				var w := new_enemy("w", 62 + (randi() % 8) * 28, 118, e.x, e.y + 10, 1, "fly")
				w.dir = 1 if i == 1 else -1
				w.fy = 120.0 + i * 24
				G.en.append(w)
			sfx("cackle")
		else:
			for i in (4 if rage else 3):
				G.en.append(new_enemy("b", 62 + (randi() % 8) * 28, 118 + (randi() % 2) * 22, e.x + (i - 1) * 18, e.y + 14, 1, "dive"))
			sfx("squeak")
	elif m == 4:
		if e.bk == 0:
			e.dz = 1.6
			sfx("dash")
		elif e.bk == 1:
			for i in 9:
				bshot(e, 0, 95 + randf() * 30, "c", 20 + randf() * 280, -8 - randf() * 40)
			sfx("cackle")
		else:
			for i in 12:
				var a := i / 12.0 * TAU
				bshot(e, cos(a) * 80, sin(a) * 80, "c")
			sfx("ring")
			G.shake = 0.3
	else:
		e.sp = 1.4
		e.spt = 0.0

func formed(ty: String) -> Array:
	return G.en.filter(func(e): return e.ty == ty and e.st == "form")

# sideways speeds of one volley's orbs (before DEEP POCKETS pairs them)
func vxs_of(p: Dictionary) -> Array:
	var vxs := [-GS_SPLIT, GS_SPLIT] if p.eq.has("triple") else [0.0]
	if p.eq.has("fan"):
		vxs.append(-95.0)
		vxs.append(95.0)
	return vxs

func orb_dmg(p: Dictionary) -> float:
	return (2.0 if p.eq.has("heavy") else 1.0) * (1.0 + 0.05 * lvl(p, "dmg"))

# one volley of p's orbs from x, y. lean (degrees, + is right) only bends GHOST SHOT.
# helper is true for SOUL MATE's and GHOSTRESS's volleys.
func volley(p: Dictionary, x: float, y: float, ln: float, helper: bool) -> void:
	var xs := [x]
	# DEEP POCKETS: every orb comes out as a pair side by side
	if p.eq.has("more"):
		xs = [x - 4, x + 4]
	var gs: bool = p.eq.has("triple")
	var vxs := vxs_of(p)
	var col: String = chars[p.ch].orb if p.n == 0 else SHOT_COLS[p.n]
	var sp := (360.0 if p.eq.has("fast") else 230.0) * (1.0 + 0.04 * lvl(p, "shot"))
	var lv := sp * tan(deg_to_rad(ln)) if gs else 0.0
	for ox in xs:
		for i in vxs.size():
			# the two GHOST SHOTs weave as mirror images of each other
			G.shots.append({"x": ox, "y": y, "vx": vxs[i] + lv, "o": p.n, "col": col, "pc": 3 if p.eq.has("pierce") else 1, "big": p.eq.has("big"),
				"grow": 0.4 * lvl(p, "size"), "hm": p.eq.has("home"), "dmg": orb_dmg(p), "sp": sp, "last": null, "dead": false,
				"h": helper, "gs": gs, "ph": PI * i})

# how long o (a player or a helper ghost) has kept moving the same way; v is its speed this frame
func track_lean(o: Dictionary, v: float, dt: float) -> void:
	var d := 0 if absf(v) < 15 else int(signf(v))
	if d == 0 or d != o.md:
		o.mv = 0.0
	else:
		o.mv += dt
	o.md = d

func lean(o: Dictionary) -> float:
	return LEAN_MAX * minf(1.0, o.mv / LEAN_TIME) * o.md

# SOUL MATE ("sm") and GHOSTRESS ("gr") trail behind you on springs, so they catch up and slightly
# pass you when you stop or turn. SOUL MATE also veers off for falling candy and drops, and fights back:
# every enemy shot that passes through her and every enemy that touches her adds 3 volleys to fire.
# She can't be hurt, and enemy shots keep going. An enemy touching her also takes one volley's damage.
func helpers(p: Dictionary, dt: float) -> void:
	for k in ["magnet", "twin"]:
		var key := "sm" if k == "magnet" else "gr"
		if not p.eq.has(k):
			p.erase(key)
			continue
		if not p.has(key):
			p[key] = {"x": p.x, "v": 0.0, "md": 0, "mv": 0.0, "q": 0, "qt": 0.0}
		var h: Dictionary = p[key]
		var tx: float = p.x - p.ld * (14.0 if key == "sm" else 26.0)
		if key == "sm":
			var best = null
			for o in G.candy + G.drops:
				if o.y > 120 and absf(o.x - h.x) < 70 and (best == null or absf(o.x - h.x) < absf(best.x - h.x)):
					best = o
			if best != null:
				tx = best.x
		h.v += (tx - h.x) * (18.0 if key == "sm" else 14.0) * dt
		h.v = clampf(h.v - h.v * (4.0 if key == "sm" else 3.5) * dt, -220, 220)
		h.x = clampf(h.x + h.v * dt, 6, 314)
		track_lean(h, h.v, dt)
		if key == "gr":
			continue
		var tag := "s%d" % p.n
		for b in G.eb:
			if not b.dead and not b.has(tag) and absf(b.x - h.x) < 6 and absf(b.y - HELP_Y) < 7:
				b[tag] = true
				h.q += 3
		for e in G.en:
			var big: bool = e.ty == "B"
			var on: bool = not e.dead and absf(e.x - h.x) < (30 if big else 10) and absf(e.y - HELP_Y) < (28 if big else 11)
			if not on:
				e.erase(tag)
			elif not e.has(tag):
				e[tag] = true
				h.q += 3
				e.hp -= orb_dmg(p) * vxs_of(p).size() * (2 if p.eq.has("more") else 1)
				e.flash = 0.1
				if e.hp <= 0:
					kill(e)
				else:
					sfx("bosshit")
		h.qt -= dt
		if h.q > 0 and h.qt <= 0:
			volley(p, h.x, HELP_Y - 8, lean(h), true)
			h.q -= 1
			h.qt = SOUL_GAP
			sfx("shoot1" if p.n % 2 == 1 else "shoot0")

# the player whose SOUL MATE is under falling candy or a drop o, if any. She sits lower than a
# player, so falling things reach a player standing under them first.
func soul_catch(o: Dictionary):
	for p in live():
		if p.has("sm") and absf(o.x - p.sm.x) < 8 and absf(o.y - HELP_Y) < 7:
			return p
	return null

# dir is -1 to 1: keys and the d-pad are always full speed, the left stick gives finer speeds
func player_input(p: Dictionary) -> Dictionary:
	var dir := 0.0
	var fire := false
	if p.kb != "":
		var w: bool = p.kb != "arrows"
		var a: bool = p.kb != "wasd"
		if (w and Input.is_key_pressed(KEY_A)) or (a and Input.is_key_pressed(KEY_LEFT)):
			dir -= 1
		if (w and Input.is_key_pressed(KEY_D)) or (a and Input.is_key_pressed(KEY_RIGHT)):
			dir += 1
		if (w and (Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_W))) or (a and (Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_ENTER))):
			fire = true
	if p.pad >= 0 and pads.has(p.pad):
		var g: Dictionary = pads[p.pad]
		dir += g.mx
		if g.ok:
			fire = true
	return {"dir": clampf(dir, -1, 1), "fire": fire}

# ---------------------------------------------------------------- game update
func update(dt: float) -> void:
	if G.shake > 0:
		G.shake -= dt
	if G.boom != null:
		var o: Dictionary = G.boom
		o.t -= dt
		o.n -= dt
		if o.n <= 0:
			o.n = 0.1
			burst(o.x + (randf() - 0.5) * 60, o.y + (randf() - 0.5) * 48, "#ffd92e" if randf() < 0.5 else "#ff8a1f", 12)
			sfx("boom")
		if o.t <= 0:
			G.boom = null
	G.t += dt
	G.slow = 1.0
	for p in G.players:
		if not p.out and p.eq.has("slow"):
			G.slow = 0.65
	if G.bt > 0:
		G.bt -= dt
		if G.bt <= 0:
			banner = ""
	if G.toast != null:
		G.toast.t -= dt
		if G.toast.t <= 0:
			G.toast = null

	# players
	for p in G.players:
		if p.out:
			continue
		var I := player_input(p)
		var ox: float = p.x
		p.x += I.dir * (205.0 if p.eq.has("swift") else 135.0) * (1.0 + 0.04 * lvl(p, "move")) * dt
		if p.sh > 0:
			p.sh -= dt
		p.x = clampf(p.x, 14, 306)
		track_lean(p, (p.x - ox) / dt if dt > 0 else 0.0, dt)
		if I.dir != 0:
			p.ld = int(signf(I.dir))
		p.cd -= dt
		p.inv -= dt
		helpers(p, dt)
		# how many orbs can be out at once: 3 per stream, +1 per 3 FIRE RATE UP boosts, doubled by RESTLESS SHOT
		# (otherwise faster shooting just hits the limit) and DEEP POCKETS.
		# SOUL MATE's and GHOSTRESS's shots don't count toward it.
		var per := 3 + lvl(p, "rate") / 3
		var lim := per * vxs_of(p).size() * (2 if p.eq.has("more") else 1) * (2 if p.eq.has("rapid") else 1)
		var mine := 0
		for s in G.shots:
			if s.o == p.n and not s.h:
				mine += 1
		if I.fire and p.cd <= 0 and mine < lim:
			volley(p, p.x, 194.0, lean(p), false)
			if p.has("gr"):
				volley(p, p.gr.x, HELP_Y - 8, lean(p.gr), true)
			p.cd = (0.13 if p.eq.has("rapid") else 0.26) / (1.0 + 0.05 * lvl(p, "rate"))
			sfx("shoot1" if p.n % 2 == 1 else "shoot0")

	# orbs
	for s in G.shots:
		if s.hm:
			var best = null
			for e in G.en:
				if e.y < s.y and (best == null or absf(e.x - s.x) < absf(best.x - s.x)):
					best = e
			if best != null:
				s.vx = clampf(s.vx + signf(best.x - s.x) * 500 * dt, -130, 130)
		s.y -= s.sp * dt
		s.x += s.vx * dt
		if s.gs:
			s.ph += WEAVE_F * dt
			s.x += cos(s.ph) * WEAVE_A * WEAVE_F * dt
		if s.y < -6 or s.x < -6 or s.x > 326:
			s.dead = true

	# the glowing pumpkins that carry a power-up: one each wave, plus a rare bonus one up high
	if not G.pk_done:
		G.pk_t -= dt
		if G.pk_t <= 0:
			G.pk_done = true
			launch_pk(pk_height(), 8.0)
	if G.bonus_t > 0:
		G.bonus_t -= dt
		if G.bonus_t <= 0:
			launch_pk(26.0, 3.0)
	for k in G.pks.duplicate():
		k.x += k.dir * 55 * dt
		k.y = k.base + sin(G.t * 3) * k.bob
		k.flash -= dt
		if k.x < -16 or k.x > 336:
			G.pks = G.pks.filter(func(o): return not is_same(o, k))
			continue
		for s in G.shots:
			if not s.dead and absf(s.x - k.x) < 11 and absf(s.y - k.y) < 10:
				s.dead = true
				k.hp -= 1
				k.flash = 0.1
				if k.hp <= 0:
					burst(k.x, k.y, "#ffb84a", 14)
					G.pks = G.pks.filter(func(o): return not is_same(o, k))
					G.drops.append({"x": k.x, "y": k.y, "k": "p", "dead": false})
				break

	# enemies
	var sway := sin(G.t * 0.8) * 22
	var w: int = G.wave
	for e in G.en.duplicate():
		e.t += dt
		e.flash -= dt
		if e.ty == "B":
			boss(e, dt)
			continue
		var tx: float = e.hx + sway
		var ty: float = e.hy
		if e.st == "form":
			e.x = tx
			e.y = ty
			if e.ty == "w":
				e.x += sin(e.t * 1.7) * 10
				e.y += sin(e.t * 3.4) * 5
		elif e.st == "fly":
			# witches face the way they're flying, and keep that facing in formation
			e.face = e.dir
			e.x += e.dir * 105 * dt
			e.y += ((e.fy + sin(e.t * 5) * 14) - e.y) * minf(1.0, 4 * dt)
			e.drop -= dt
			if e.drop <= 0:
				corn(e)
				e.drop = 0.5
			if (e.dir > 0 and e.x > 304) or (e.dir < 0 and e.x < 16):
				e.dir = -e.dir
				e.pass += 1
				if e.pass >= 2:
					e.st = "return"
		elif e.st == "dive":
			var tg := nearest(e.x)
			e.vx = clampf(e.vx + signf(tg.x - e.x) * 220 * dt, -95, 95)
			e.x += (e.vx + sin(e.t * 6) * 45) * dt
			e.y += (95 + w * 6) * dt
			if e.y > 252:
				e.y = -14
				e.x = tx
				e.st = "return"
		else:
			var dx: float = tx - e.x
			var dy: float = ty - e.y
			var d := sqrt(dx * dx + dy * dy)
			if absf(dx) > 2:
				e.face = int(signf(dx))
			if d < 4:
				e.st = "form"
			else:
				var sp := minf(d, 150 * dt)
				e.x += dx / d * sp
				e.y += dy / d * sp

	G.dive -= dt
	if G.dive <= 0:
		var bats := formed("b")
		if not bats.is_empty():
			var e: Dictionary = pick(bats)
			e.st = "dive"
			e.vx = 0.0
			sfx("squeak")
		G.dive = maxf(0.55, 2.1 - w * 0.14)
	G.wt -= dt
	if G.wt <= 0:
		var ws := formed("w")
		if not ws.is_empty():
			corn(pick(ws))
		G.wt = maxf(0.45, 1.25 - w * 0.07)
	G.wf -= dt
	if G.wf <= 0:
		var ws := formed("w")
		if not ws.is_empty():
			var e: Dictionary = pick(ws)
			e.st = "fly"
			e.dir = 1 if e.x < 160 else -1
			e.fy = 118 + randf() * 30
			e.pass = 0
			e.drop = 0.3
			sfx("cackle")
		G.wf = maxf(1.6, 3.6 - w * 0.2)
	G.vt -= dt
	if G.vt <= 0:
		var vs := formed("v")
		var alive_p := live()
		if not vs.is_empty() and not alive_p.is_empty():
			var e: Dictionary = pick(vs)
			var tg: Dictionary = pick(alive_p)
			var dx: float = tg.x - e.x
			var dy: float = 209 - e.y
			var d := maxf(1.0, sqrt(dx * dx + dy * dy))
			G.eb.append({"x": e.x, "y": e.y + 8, "vx": dx / d * 70, "vy": dy / d * 70, "k": "r", "ph": 0.0, "dead": false})
		G.vt = maxf(1.2, 2.8 - w * 0.1)

	for b in G.eb:
		if b.k == "c":
			b.x += cos(G.t * 5 + b.ph) * 22 * dt
		b.x += b.vx * dt * G.slow
		b.y += b.vy * dt * G.slow
		if b.get("cap", false) and b.vx != 0.0 and absf(b.x - b.x0) >= 24.0:
			b.x = b.x0 + signf(b.x - b.x0) * 24.0
			b.vx = 0.0
		if b.y > 246 or b.y < -60 or b.x < -6 or b.x > 326:
			b.dead = true

	# orbs hitting enemies
	for s in G.shots:
		if s.dead:
			continue
		for e in G.en:
			if e.dead or is_same(e, s.last):
				continue
			var hw: float = (27 if e.ty == "B" else 11) + (6 if s.big else 0) + s.grow
			var hh: float = (20 if e.ty == "B" else 9) + (3 if s.big else 0) + s.grow / 2.0
			if absf(s.x - e.x) < hw and absf(s.y - e.y) < hh:
				s.pc -= 1
				s.last = e
				if s.pc <= 0:
					s.dead = true
				e.hp -= s.dmg
				e.flash = 0.1
				if e.hp <= 0:
					kill(e)
				else:
					sfx("bosshit")
				break

	# things hitting players
	for p in G.players:
		if p.out or p.inv > 0 or mode != "game":
			continue
		var was_hit := false
		for b in G.eb:
			if not b.dead and absf(b.x - p.x) < 7 and absf(b.y - 209) < 10:
				b.dead = true
				hurt(p)
				was_hit = true
				break
		if was_hit:
			continue
		for e in G.en:
			if e.dead:
				continue
			if e.ty != "B" and e.st == "dive" and absf(e.x - p.x) < 14 and absf(e.y - 209) < 13:
				kill(e)
				hurt(p)
				break
			if e.ty == "B" and absf(e.x - p.x) < 30 and absf(e.y - 209) < 28:
				hurt(p)
				break

	# candy
	for k in G.candy:
		k.y += 45 * dt
		var catcher = null
		for p in live():
			if absf(k.x - p.x) < 13 and absf(k.y - 209) < 14:
				catcher = p
		if catcher == null:
			catcher = soul_catch(k)
		if catcher != null:
			k.dead = true
			var c := 2 if catcher.eq.has("dcandy") else 1
			add_candy(catcher.n, c)
			catcher.got += c
			pts(10)
			sfx("candy")
		elif k.y > 246:
			k.dead = true
	for p in G.parts:
		p.x += p.vx * dt
		p.y += p.vy * dt
		p.life -= dt
	for d in G.drops:
		d.y += (45 if d.k == "p" else 80) * dt
		var got = null
		for p in live():
			if absf(d.x - p.x) < 14 and absf(d.y - 209) < 14:
				got = p
		if got == null:
			got = soul_catch(d)
		if got != null:
			catch_drop(d, got)
		elif d.y > 248:
			d.dead = true

	var keep := func(o): return not o.dead
	G.shots = G.shots.filter(keep)
	G.eb = G.eb.filter(keep)
	G.en = G.en.filter(keep)
	G.candy = G.candy.filter(keep)
	G.drops = G.drops.filter(keep)
	G.parts = G.parts.filter(func(o): return o.life > 0)

	if mode == "game":
		if G.en.is_empty() and G.clearing <= 0:
			G.clearing = 1.7
			say("WAVE %d CLEARED" % w, 1.5)
			wave_drop()
			sfx("clear")
		if G.clearing > 0 and G.en.is_empty() and G.drops.is_empty():
			G.clearing -= dt
			if G.clearing <= 0:
				G.clearing = 0.0
				next_wave()

# ---------------------------------------------------------------- game drawing
func draw_game() -> void:
	var gt: float = G.t
	var B = null
	for e in G.en:
		if e.ty == "B":
			B = e
	draw_graveyard(B != null)
	for i in stars.size():
		if i % 3 == 0:
			var s: Array = stars[i]
			R(s[0], s[1], 1, 1, "#ffffff", 0.5 + 0.5 * sin(gt * 2 + s[2]))
	for k in G.candy:
		var x := int(round(k.x))
		var y := int(round(k.y))
		R(x - 2, y - 2, 5, 4, "#ff7fb5")
		R(x - 5, y - 2, 2, 4, "#7df2ff")
		R(x + 4, y - 2, 2, 4, "#7df2ff")
		R(x - 1, y - 1, 1, 1, "#ffffff")
		if int(floor(gt * 6)) % 2 == 1:
			R(x + 5, y - 5, 1, 1, "#ffffff")
	for e in G.en:
		var fl: bool = e.flash > 0
		var x := int(round(e.x)) - 11
		if e.ty == "B":
			var bx := int(round(e.x)) - 30
			var by := int(round(e.y)) - 26
			var rg: bool = e.raged and int(floor(gt * 6)) % 2 == 1
			ellipse(bx + 30, by + 26, 40, 34, "#ff2244" if rg else "#a13cff", 0.16)
			if e.bk == 2:
				var wv := int(round(sin(gt * 5) * 6))
				pline(bx + 4, by + 30, bx - 12, by + 22 + wv, 3, "#3d8b3a")
				pline(bx - 12, by + 22 + wv, bx - 18, by + 12 + wv, 2, "#3d8b3a")
				pline(bx + 56, by + 30, bx + 72, by + 22 - wv, 3, "#3d8b3a")
				pline(bx + 72, by + 22 - wv, bx + 78, by + 12 - wv, 2, "#3d8b3a")
				pumpkin(bx + 30, by + 28, 28, 21, true, gt, 1)
				spr(CROWN, EPAL, bx + 18, by - 6, 5)
				if fl:
					ellipse(bx + 30, by + 28, 28, 21, "#ffffff", 0.6)
			else:
				spr(WQUEEN if e.bk == 1 else VLORD, EPAL, bx, by, 4, fl)
				if e.bk == 0:
					spr(CROWN, EPAL, bx + 20, by - 8, 4, fl)
		elif e.ty == "b":
			var f := int(floor(e.t * (10 if e.st == "dive" else 5))) % 2
			spr(BATB if f == 1 else BATA, EPAL, x, int(round(e.y)) - 6, 2, fl)
		else:
			if e.ty == "w":
				spr(WITCH if e.get("face", 1) > 0 else WITCH_L, EPAL, x - 1, int(round(e.y)) - 9, 2, fl)
			else:
				spr(VAMP, EPAL, x, int(round(e.y)) - 8, 2, fl)
	for d in G.drops:
		var x := int(round(d.x))
		var y := int(round(d.y))
		if d.k == "b":
			spr(BUCKET, BUCKETPAL, x - 10, y - 9, 2)
		elif d.k == "p":
			ellipse(x, y, 10, 9, "#ffb84a", 0.18 + 0.1 * sin(gt * 8))
			pumpkin(x, y, 6, 5, true, gt * 2, 4)
		else:
			spr(APPLE, APPLEPAL, x - 5, y - 7, 1)
		if int(floor(gt * 6)) % 2 == 1:
			R(x + 9, y - 9, 1, 1, "#ffffff")
			R(x - 10, y + 3, 1, 1, "#ffffff")
	for k in G.pks:
		pumpkin(int(round(k.x)), int(round(k.y)), 8, 6, true, gt * 2, 3)
		if k.flash > 0:
			ellipse(int(round(k.x)), int(round(k.y)), 8, 6, "#ffffff", 0.6)
	for b in G.eb:
		var x := int(round(b.x))
		var y := int(round(b.y))
		if b.k == "c":
			R(x - 2, y - 3, 5, 2, "#ffd92e")
			R(x - 1, y - 1, 3, 2, "#ff8a1f")
			R(x, y + 1, 1, 2, "#fffaf0")
		else:
			R(x - 1, y - 1, 3, 4, "#ff2244")
			R(x, y - 3, 1, 2, "#ff2244")
			R(x - 1, y, 1, 1, "#ff8fa0")
	for s in G.shots:
		var x := int(round(s.x))
		var y := int(round(s.y))
		var col: String = s.col
		# GHOST SHOT has no glow trail, which made it look like a sign on a post
		if s.gs:
			spr(GSHOT, {"c": col, "k": "#1b0f33"}, x - 2, y - 3, 1)
			continue
		R(x - 3, y - 3, 7, 7, "#cfe0ff", 0.25)
		R(x - 1, y + 4, 3, 6, "#cfe0ff", 0.25)
		R(x - 2, y - 1, 5, 3, col)
		R(x - 1, y - 2, 3, 5, col)
		# ORB SIZE boosts show a little at 5+, always smaller than BIG ORB, and grow BIG ORB further
		var g := 1 if s.grow >= 2.0 else 0
		if s.big:
			R(x - 4 - g, y - 2, 9 + g * 2, 5, col)
			R(x - 2, y - 4 - g, 5, 9 + g * 2, col)
		elif g > 0:
			R(x - 3, y - 1, 7, 3, col)
			R(x - 1, y - 3, 3, 7, col)
	for i in G.players.size():
		var p: Dictionary = G.players[i]
		if p.out or mode == "over":
			continue
		var C: Dictionary = chars[p.ch]
		# SOUL MATE and GHOSTRESS can't be hurt, so they don't blink with you
		for h in [["gr", "grp", ROSE, 6, -2], ["sm", "smp", BOW, 3, -2]]:
			if p.has(h[0]):
				var hx := int(round(p[h[0]].x)) - 6
				var hb := 206 + int(round(sin(gt * 5 + i + h[3]) * 1))
				spr(C.spr, C[h[1]][p.n], hx, hb, 1)
				spr(h[2], ACCPAL, hx + h[3], hb + h[4], 1)
		if p.inv > 0 and int(floor(gt * 12)) % 2 == 0:
			continue
		var px := int(round(p.x))
		var bob := int(round(sin(gt * 4 + i * 2) * 1.5))
		if p.eq.has("shield") and p.sh <= 0:
			draw_tail(px, 196 + bob, C.pals[p.n].values()[0], gt)
		spr(C.spr2 if int(floor(gt * 4 + i)) % 2 == 1 else C.spr, C.pals[p.n], px - 12, 196 + bob, 2)
	for p in G.parts:
		R(int(round(p.x)), int(round(p.y)), 2, 2, p.col, minf(1.0, p.life * 3))
	for i in 5:
		var fx := fmod(gt * (6 + i * 2) + i * 97, 420.0) - 50
		ellipse(int(round(fx)), 232 + (i % 2) * 3, 46, 6, "#cbbcff", 0.10)
	R(0, 232, 320, 8, "#cbbcff", 0.10)
	# lives, drawn as little copies of each player's character
	for p in G.players:
		var C: Dictionary = chars[p.ch]
		var lx: Array = LIFE_X[p.n]
		for i in p.lives:
			spr(C.spr, C.pals[p.n], lx[0] + i * lx[1], 225, 1)
	if B != null:
		R(98, 5, 124, 9, "#ffd92e")
		R(99, 6, 122, 7, "#1b0f33")
		R(100, 7, maxi(0, int(round(120.0 * B.hp / B.max))), 5, "#ff8fa0" if (B.raged and int(floor(gt * 8)) % 2 == 1) else "#ff2244")
		var tx := 112
		while tx < 220:
			R(tx, 7, 1, 5, "#1b0f33")
			tx += 12

# NINE LIVES shield: the tail comes out from behind, up the side and curls over the head.
# Drawn before the cat so it sits behind him. by is the top of the sprite.
func draw_tail(px: int, by: int, col: String, gt: float) -> void:
	var sw := int(round(sin(gt * 3) * 1))
	var pts := [Vector2(px + 8, by + 20), Vector2(px + 14, by + 15), Vector2(px + 16, by + 6), Vector2(px + 14, by - 2),
		Vector2(px + 8 + sw, by - 7), Vector2(px + sw, by - 9), Vector2(px - 6 + sw, by - 8), Vector2(px - 9 + sw, by - 4)]
	for j in pts.size() - 1:
		pline(pts[j].x, pts[j].y, pts[j + 1].x, pts[j + 1].y, 3 if j < 4 else 2, col)

func draw_hud() -> void:
	T("STATS", 13, 12, 2, "#ff8a1f")
	draw_texture_rect(tex(BUCKET, BUCKETPAL), Rect2(13, 32, 20, 18), false)
	# each player's own candy (what they have to spend in the UPGRADES menu)
	var ps: Array = G.players.duplicate()
	ps.sort_custom(func(a, b): return a.n < b.n)
	if ps.size() == 1:
		T("CANDY: %d" % candy_of(ps[0].n), 40, 34, 2, "#f6f1ff")
	else:
		for i in ps.size():
			T("P%d CANDY: %d" % [ps[i].n + 1, candy_of(ps[i].n)], 40, 30 + i * 11, 1, "#f6f1ff")
	T("SCORE %06d" % G.score, 627, 12, 2, "#ffd92e", 2)
	T("HIGH %06d" % maxi(G.high, G.score), 627, 30, 2, "#ffd92e", 2)
	T("WAVE %d" % G.wave, 627, 48, 2, "#ffd92e", 2)
	for p in G.players:
		var codes := ""
		for w in chars[p.ch].pow:
			if p.eq.has(w[0]):
				codes += w[3] + " "
		T(codes.strip_edges(), CODE_X[p.n][0], 420, 1, "#ffd92e", CODE_X[p.n][1])
		# their prestige level for this character, which counts for every stat
		var pr := prestige(p.n, p.ch)
		if pr > 0:
			T("PRE %d" % pr, CODE_X[p.n][0], 430, 1, "#c9a8ff", CODE_X[p.n][1])
		var boosts := ""
		for b in BOOSTS:
			if bo(p, b[0]) > 0:
				boosts += "%s%d " % [b[3], bo(p, b[0])]
		T(boosts.strip_edges(), CODE_X[p.n][0], 408, 1, "#7df2ff", CODE_X[p.n][1])
	if G.players.size() == 1 and mode == "game":
		T("TO JOIN: START ON A CONTROLLER, OR BACKSPACE ON THE KEYBOARD", 320, 466, 1, "#9d8cc4", 1)
	if G.toast != null and mode == "game":
		draw_toast(G.toast)
	if mode == "game":
		for k in G.picks:
			draw_picker(k)
	if banner != "" and mode != "pause":
		T(banner, 320, 200, 3, "#ffd92e", 1)

# ---------------------------------------------------------------- panels
func draw_box(y: float, h: float) -> void:
	draw_rect(Rect2(60, y, 520, h), Color(0.024, 0.016, 0.05, 0.95))
	draw_rect(Rect2(60, y, 520, h), Color("#a13cff"), false, 3.0)

func draw_panel(title: String, rows: Array, footer: String, cursor := -1, note := "") -> void:
	var h := 62 + rows.size() * 26 + (24 if note != "" else 0) + (26 if footer != "" else 0)
	var y := 140.0
	draw_box(y, h)
	T(title, 80, y + 18, 3, "#ff8a1f")
	var ry := y + 54
	for i in rows.size():
		var r: Array = rows[i]
		var dim: bool = r.size() > 2 and r[2]
		var left: String = ("> " if cursor == i else ("  " if cursor >= 0 else "")) + str(r[0])
		T(left, 80, ry, 2, "#9d8cc4" if dim and cursor != i else "#f6f1ff")
		if str(r[1]) != "":
			T(str(r[1]), 560, ry + 3, 1 if str(r[1]).length() > 14 else 2, "#9d8cc4" if dim else "#ffd92e", 2)
		ry += 26
	if note != "":
		T(note, 80, ry + 4, 1, "#f6f1ff")
		ry += 24
	if footer != "" and int(floor(t * 2)) % 2 == 0:
		T(footer, 80, ry + 6, 1, "#9d8cc4")

# ---------------------------------------------------------------- UPGRADES menu
# A tab for each player. The first page lists characters (buy for char_cost, or open one);
# a character's page lets you play as it and buy upgrades (pow_cost) or switch them ON / OFF.
# Once all its upgrades are bought, a PRESTIGE row shows at the bottom (and stays from then on):
# confirming relocks the character and its upgrades for +1 of every boost for that character.
func shop_rows() -> Array:
	var rows := []
	var c := candy_of(stab)
	if sch < 0:
		for i in chars.size():
			if not has_char(stab, i):
				rows.append([chars[i].name, "%d CANDY" % char_cost(stab, i), c < char_cost(stab, i)])
			else:
				rows.append([chars[i].name, "PLAYING" if char_pref(stab) == i else "OWNED", false])
		if owned_chars(stab).size() >= 2:
			rows.append(["RANDOM", "PLAYING" if char_pref(stab) < 0 else "", false])
	else:
		# switching tabs keeps this page open, so it may show a character this player hasn't bought yet:
		# then the top row buys it, and its upgrades stay greyed out until it's bought
		var got := has_char(stab, sch)
		if got:
			rows.append(["PLAY AS " + chars[sch].name, "PLAYING" if char_pref(stab) == sch else "", false])
		else:
			rows.append(["BUY " + chars[sch].name, "%d CANDY" % char_cost(stab, sch), c < char_cost(stab, sch)])
		var own := owns(stab, sch)
		var pc := pow_cost(stab, sch)
		for w in chars[sch].pow:
			if not own.has(w[0]):
				rows.append([w[1], "%d CANDY" % pc, not got or c < pc])
			else:
				var on := is_on(stab, sch, w[0])
				rows.append([w[1], "ON" if on else "OFF", not got or not on])
		if pre_shown(stab, sch):
			rows.append(["PRESTIGE %d/%d" % [prestige(stab, sch), PRESTIGE_MAX], "", pre_why(stab, sch) != ""])
	rows.append(["BACK", "", false])
	return rows

func maxed(n: int, ch: int) -> bool:
	return has_char(n, ch) and owns(n, ch).size() == chars[ch].pow.size()

# the PRESTIGE row: hidden at 0 until the character is maxed, always there after its first prestige
func pre_shown(n: int, ch: int) -> bool:
	if PRESTIGE_LOCKED:
		return false
	return prestige(n, ch) > 0 or maxed(n, ch)

# why this character can't be prestiged right now, or "" if it can
func pre_why(n: int, ch: int) -> String:
	if prestige(n, ch) >= PRESTIGE_MAX:
		return "%s IS AT PRESTIGE %d/%d, THE MOST THERE IS." % [chars[ch].name, PRESTIGE_MAX, PRESTIGE_MAX]
	if not maxed(n, ch):
		return "BUY %s AND ALL ITS UPGRADES TO PRESTIGE AGAIN." % chars[ch].name
	# their only character: only if they could buy one straight back (this one costs 10% more after)
	if owned_chars(n).size() <= 1:
		var cheapest := CHAR_COST + CHAR_COST / 10 * (prestige(n, ch) + 1)
		for i in chars.size():
			if i != ch:
				cheapest = mini(cheapest, char_cost(n, i))
		if candy_of(n) < cheapest:
			return "YOUR ONLY CHARACTER: SAVE %d CANDY TO BUY ONE BACK FIRST." % cheapest
	return ""

func shop_note() -> String:
	if smsg != "":
		return smsg
	if sch >= 0 and scur >= 1 and scur <= chars[sch].pow.size():
		return chars[sch].pow[scur - 1][2] + "."
	if sch >= 0 and scur == chars[sch].pow.size() + 1 and pre_shown(stab, sch):
		var why := pre_why(stab, sch)
		return why if why != "" else "RELOCK %s AND ITS UPGRADES FOR A +1 BOOST TO ALL STATS, PERMANENTLY." % chars[sch].name
	if sch < 0 and scur == chars.size() and owned_chars(stab).size() >= 2:
		return "PLAY A RANDOM ONE OF YOUR CHARACTERS EACH GAME."
	if sch >= 0 and not has_char(stab, sch):
		return "BUY %s TO PLAY AS IT AND BUY ITS UPGRADES." % chars[sch].name
	if sch >= 0:
		return "ON UPGRADES CAN COME FROM THE GLOWING PUMPKIN. OFF ONES NEVER DO."
	return "LB / RB OR LEFT / RIGHT: SWITCH PLAYER."

func draw_shop() -> void:
	var rows := shop_rows()
	var y := 104.0
	# a character's page has its description line under the name, so its rows start a bit lower
	var dy := 10 if sch >= 0 else 0
	draw_box(y, 116 + dy + rows.size() * 26)
	T("UPGRADES", 80, y + 18, 3, "#ff8a1f")
	T("LB", 318, y + 26, 1, "#9d8cc4", 1)
	for i in MAX_PLAYERS:
		T("P%d" % (i + 1), 356 + i * 46, y + 22, 2, "#ffd92e" if i == stab else "#5a4d80")
	T("RB", 556, y + 26, 1, "#9d8cc4", 1)
	T("CHARACTERS" if sch < 0 else chars[sch].name, 80, y + 52, 2, "#f6f1ff")
	if sch >= 0:
		T(chars[sch].desc, 80, y + 72, 1, "#9d8cc4")
	T("CANDY: %d" % candy_of(stab), 560, y + 52, 2, "#ffd92e", 2)
	var ry := y + 84 + dy
	for i in rows.size():
		var r: Array = rows[i]
		var dim: bool = r[2]
		T(("> " if scur == i else "  ") + r[0], 80, ry, 2, "#9d8cc4" if dim and scur != i else "#f6f1ff")
		if r[1] != "":
			T(r[1], 560, ry + 3, 2, "#9d8cc4" if dim else "#ffd92e", 2)
		ry += 26
	T(shop_note(), 80, ry + 4, 1, "#ff8a1f" if smsg != "" else "#f6f1ff")
	if spre >= 0:
		var n := prestige(stab, sch) + 1
		draw_panel("PRESTIGE", [["NO, KEEP IT", ""], ["YES, PRESTIGE", "%d/%d" % [n, PRESTIGE_MAX]]], "", spre,
			"RELOCK %s AND ALL %d UPGRADES FOR A +1 BOOST TO ALL STATS? PRICES GO UP 10%%." % [chars[sch].name, chars[sch].pow.size()])

func shop_choose() -> void:
	if spre >= 0:
		if spre == 1:
			do_prestige(stab, sch)
		else:
			sfx("back")
		spre = -1
		return
	var rows := shop_rows()
	smsg = ""
	if scur == rows.size() - 1:
		shop_back()
		return
	var c := candy_of(stab)
	if sch < 0 and scur == chars.size():
		sv_set(pkey(stab, "char"), -1)
		if stab == 0:
			cur = -1
		sfx("select")
		return
	if sch < 0:
		if has_char(stab, scur):
			sch = scur
			scur = 0
			sfx("select")
		else:
			buy_char(scur)
		return
	if not has_char(stab, sch):
		if scur == 0:
			buy_char(sch)
		else:
			smsg = "BUY %s FIRST." % chars[sch].name
			sfx("deny")
		return
	if scur == 0:
		sv_set(pkey(stab, "char"), sch)
		if stab == 0:
			cur = sch
		sfx("select")
		return
	if scur == chars[sch].pow.size() + 1:
		if pre_why(stab, sch) != "":
			sfx("deny")
		else:
			spre = 0
			sfx("select")
		return
	var k: String = chars[sch].pow[scur - 1][0]
	var id: String = chars[sch].id
	if not owns(stab, sch).has(k):
		var pc := pow_cost(stab, sch)
		if c >= pc:
			add_candy(stab, -pc)
			var own := lst(pkey(stab, "own." + id))
			own.append(k)
			sv_set(pkey(stab, "own." + id), own)
			smsg = chars[sch].pow[scur - 1][1] + " UNLOCKED!"
			sfx("unlock")
		else:
			smsg = "NEED %d CANDY, P%d HAS %d." % [pc, stab + 1, c]
			sfx("deny")
		return
	var off := lst(pkey(stab, "off." + id))
	if off.has(k):
		off.erase(k)
	else:
		off.append(k)
	sv_set(pkey(stab, "off." + id), off)
	sfx("select")

func buy_char(i: int) -> void:
	var c := candy_of(stab)
	var cost := char_cost(stab, i)
	if c < cost:
		smsg = "NEED %d CANDY, P%d HAS %d." % [cost, stab + 1, c]
		sfx("deny")
		return
	add_candy(stab, -cost)
	if i == 0:
		sv_set(pkey(stab, "ghost.gone"), false)
	else:
		var have := lst(pkey(stab, "chars"))
		have.append(chars[i].id)
		sv_set(pkey(stab, "chars"), have)
	smsg = chars[i].name + " UNLOCKED!"
	if stab == 0:
		cur = char_pref(0)
	sfx("unlock")

# relock the character and all its upgrades, and count one more prestige for it
func do_prestige(n: int, ch: int) -> void:
	var id: String = chars[ch].id
	sv_set(pkey(n, "pre." + id), prestige(n, ch) + 1)
	if ch == 0:
		sv_set(pkey(n, "ghost.gone"), true)
	else:
		var have := lst(pkey(n, "chars"))
		have.erase(id)
		sv_set(pkey(n, "chars"), have)
	sv_set(pkey(n, "own." + id), [])
	sv_set(pkey(n, "off." + id), [])
	if n == 0:
		cur = char_pref(0)
	scur = 0
	smsg = "%s IS NOW PRESTIGE %d/%d!" % [chars[ch].name, prestige(n, ch), PRESTIGE_MAX]
	sfx("unlock")

# switch player tab, staying on the same page and row
func shop_tab(d: int) -> void:
	if spre >= 0:
		return
	stab = posmod(stab + d, MAX_PLAYERS)
	smsg = ""
	scur = mini(scur, shop_rows().size() - 1)
	sfx("move")

# back from a character's page goes to the character list, from there out of the menu
func shop_back() -> void:
	smsg = ""
	if spre >= 0:
		spre = -1
	elif sch >= 0:
		scur = sch
		sch = -1
	else:
		panel = ""
	sfx("back")

func draw_ui() -> void:
	if mode == "menu":
		draw_title()
		if panel == "":
			for i in MENU.size():
				var y := 126 + i * 28
				T(MENU[i][0], 280, y, 3, "#ffd92e" if i == sel else "#9d8cc4")
				if i == sel:
					var bob := -4 if int(floor(t * 3)) % 2 == 1 else 0
					if cur < 0:
						T("?", 250, y - 4 + bob, 4, "#ffd92e", 1)
					else:
						draw_texture_rect(tex(chars[cur].spr, chars[cur].pals[0]), Rect2(238, y - 4 + bob, 24, 26), false)
			T("ARROWS OR D-PAD: MOVE   SPACE OR A: SELECT   ESC OR START: QUIT   M: MUSIC", 320, 466, 1, "#9d8cc4", 1)
		elif panel == "score":
			draw_panel("HIGH SCORE", [["HIGH SCORE", "%06d" % int(sv("high", 0))], ["BEST WAVE", str(int(sv("wave", 0)))],
				], "PRESS SPACE TO GO BACK")
		elif panel == "shop":
			draw_shop()
		elif panel == "setup":
			draw_setup()
		elif panel == "settings":
			var fs: bool = sv("fullscreen", false)
			var k := win_scale()
			var vals := ["FULLSCREEN" if fs else "WINDOWED", "%d X %d" % [640 * k, 480 * k], "ON" if sv("pixperf", false) else "OFF", ""]
			var rows := []
			var names := ["DISPLAY", "WINDOW SIZE", "PIXEL PERFECT", "BACK"]
			for i in names.size():
				var v: String = vals[i]
				if i == ssel and v != "":
					v = "< " + v + " >"
				rows.append([names[i], v, i == 1 and fs])
			var note := "LEFT / RIGHT TO CHANGE.  F11 OR ALT+ENTER: FULL SCREEN."
			if ssel == 2:
				note = "ON KEEPS EVERY PIXEL THE SAME SIZE, WITH A BIGGER BORDER."
			draw_panel("SETTINGS", rows, "", ssel, note)
		elif panel == "reset":
			var rr := [["NO, KEEP IT", ""]]
			for i in MAX_PLAYERS:
				rr.append(["ERASE P%d" % (i + 1), ""])
			rr.append(["ERASE ALL", ""])
			var note := "ERASE ONE PLAYER, OR EVERYTHING?"
			if rsel >= 1 and rsel <= MAX_PLAYERS:
				note = "ERASE P%d'S CANDY, CHARACTERS, UPGRADES AND PRESTIGE?" % rsel
			elif rsel == 5:
				note = "ERASE EVERY PLAYER, THE HIGH SCORE AND THE SETTINGS?"
			draw_panel("RESET SAVE", rr, "", rsel, note)
		elif panel == "quit":
			draw_panel("QUIT GAME", [["NO, KEEP PLAYING", ""], ["YES, QUIT", ""]], "", qsel, "CLOSE THE SPOOKY BURST?")
		return
	draw_hud()
	if mode == "pause" and G.menu != null:
		if G.menu.get("setup", false):
			draw_setup()
		else:
			draw_pause()
	elif mode == "over":
		var rows := [["SCORE", "%06d" % G.score], ["HIGH SCORE", "%06d" % maxi(G.high, G.score)], ["WAVE REACHED", str(G.wave)]]
		var ps: Array = G.players.duplicate()
		ps.sort_custom(func(a, b): return a.n < b.n)
		for p in ps:
			rows.append(["P%d CANDY" % (p.n + 1), "+%d" % p.got])
		draw_panel("GAME OVER", rows, "PRESS SPACE FOR MENU")

func draw_pause() -> void:
	var m: Dictionary = G.menu
	var rows := pause_rows()
	var who = dev_player(m.dev)
	var y := 110.0
	draw_box(y, 236)
	T("PAUSED", 80, y + 18, 3, "#ff8a1f")
	var tag := ""
	if who != null:
		tag = "PLAYER %d" % (who.n + 1)
	else:
		tag = "CONTROLLER" if m.dev.pad >= 0 else "KEYBOARD"
	T(tag, 560, y + 24, 1, "#9d8cc4", 2)
	var ry := y + 54
	for i in rows.size():
		var dim: bool = rows[i][2]
		T(("> " if i == m.sel else "  ") + rows[i][0], 80, ry, 2, "#9d8cc4" if dim and i != m.sel else "#f6f1ff")
		ry += 26
	var why := ""
	if m.sel == 1:
		why = join_block(m.dev)
	elif m.sel == 3 and who == null:
		why = "YOU ARE NOT PLAYING"
	if why != "":
		T(why, 300, y + 58 + m.sel * 26, 1, "#ff8a1f")
	ry += 8
	for line in ["KEYBOARD LEFT: A D MOVE, SPACE OR W SHOOT, ESC JOINS OR MENU", "KEYBOARD RIGHT: ARROWS MOVE, UP OR ENTER SHOOT, BACKSPACE JOINS OR MENU",
			"CONTROLLER: STICK OR D-PAD MOVE, A B X Y OR R2 SHOOT, START JOINS OR MENU",
			"BOOSTS: DM DAMAGE  FR FIRE RATE  SS SHOT SPEED  MS MOVE  OS ORB SIZE  LS SAFETY"]:
		T(line, 80, ry, 1, "#9d8cc4")
		ry += 16

# the little character picker for someone joining: their character, arrows either side, and how to join
func draw_picker(k: Dictionary) -> void:
	var cx: float = PICK_X[k.slot]
	var y := 318.0
	draw_rect(Rect2(cx - 58, y - 4, 116, 74), Color(0.024, 0.016, 0.05, 0.8))
	draw_rect(Rect2(cx - 58, y - 4, 116, 74), Color("#a13cff"), false, 2.0)
	T("P%d" % (k.slot + 1), cx, y + 2, 1, "#ffd92e", 1)
	var bob := -2 if int(floor(t * 3)) % 2 == 1 else 0
	if k.ch < 0:
		T("?", cx, y + 14 + bob, 4, "#ffd92e", 1)
	else:
		draw_texture_rect(tex(chars[k.ch].spr, chars[k.ch].pals[k.slot]), Rect2(cx - 12, y + 14 + bob, 24, 26), false)
	if pick_opts(k.slot).size() > 1:
		T("<", cx - 34, y + 22, 2, "#9d8cc4", 1)
		T(">", cx + 34, y + 22, 2, "#9d8cc4", 1)
	T("RANDOM" if k.ch < 0 else chars[k.ch].name, cx, y + 46, 1, "#f6f1ff", 1)
	if int(floor(t * 2)) % 2 == 0:
		T("SHOOT: JOIN", cx, y + 58, 1, "#9d8cc4", 1)

# shown for a moment when someone catches a power-up: the name biggest, what it does right under it,
# and who got it small underneath. The game keeps going.
func draw_toast(a: Dictionary) -> void:
	var y := 112.0
	draw_rect(Rect2(0, y - 10, 640, 76), Color(0.024, 0.016, 0.05, 0.55))
	T(a.title, 320, y, 3, "#ffd92e", 1)
	T(a.desc, 320, y + 30, 2, "#f6f1ff", 1)
	T("PLAYER %d" % (a.n + 1), 320, y + 52, 1, "#9d8cc4", 1)

func _draw() -> void:
	var off := Vector2.ZERO
	if mode != "menu" and not G.is_empty() and G.shake > 0:
		off = Vector2(round((randf() - 0.5) * 10), round((randf() - 0.5) * 10))
	draw_set_transform(off, 0.0, Vector2(2, 2))
	if mode == "menu":
		draw_menu_scene()
	else:
		draw_game()
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	draw_ui()

# ---------------------------------------------------------------- menu logic
# Display settings: full screen or windowed, the window size (whole multiples of the 640x480 game so the
# pixels stay square), and pixel perfect (only scale by whole numbers, leaving a border).
# Full screen always uses the monitor's own resolution.
func max_win() -> int:
	var r := DisplayServer.screen_get_usable_rect().size
	return maxi(1, mini(r.x / 640, (r.y - 40) / 480))

func win_scale() -> int:
	return clampi(int(sv("winsize", 2)), 1, max_win())

func apply_display() -> void:
	get_window().content_scale_stretch = Window.CONTENT_SCALE_STRETCH_INTEGER if sv("pixperf", false) else Window.CONTENT_SCALE_STRETCH_FRACTIONAL
	if sv("fullscreen", false):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		return
	var k := win_scale()
	var want := Vector2i(640 * k, 480 * k)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_size(want)
	var r := DisplayServer.screen_get_usable_rect()
	DisplayServer.window_set_position(r.position + (r.size - want) / 2)

func toggle_fullscreen() -> void:
	sv_set("fullscreen", not sv("fullscreen", false))
	apply_display()

func settings_change(d: int) -> void:
	if ssel == 0:
		toggle_fullscreen()
	elif ssel == 1:
		if sv("fullscreen", false):
			sfx("deny")
			return
		sv_set("winsize", posmod(win_scale() - 1 + d, max_win()) + 1)
		apply_display()
	elif ssel == 2:
		sv_set("pixperf", not sv("pixperf", false))
		apply_display()
	else:
		return
	sfx("select")

# left / right in the menus: settings rows, and the player tabs in UPGRADES
func menu_side(d: int) -> void:
	if mode == "menu" and panel == "settings":
		settings_change(d)
	elif mode == "menu" and panel == "shop":
		shop_tab(d)

func menu_move(d: int) -> void:
	if mode != "menu":
		return
	sfx("move")
	if panel == "":
		sel = posmod(sel + d, MENU.size())
	elif panel == "shop" and spre >= 0:
		spre = 1 - spre
	elif panel == "shop":
		scur = posmod(scur + d, shop_rows().size())
		smsg = ""
	elif panel == "reset":
		rsel = posmod(rsel + d, 6)
	elif panel == "quit":
		qsel = 1 - qsel
	elif panel == "settings":
		ssel = posmod(ssel + d, 4)

func menu_choose(pad: int, side := "wasd") -> void:
	if mode == "over":
		sfx("back")
		to_menu()
		return
	if mode != "menu":
		return
	if panel == "":
		var go: String = MENU[sel][1]
		sfx("select")
		if go == "play":
			start_game(pad, side)
		else:
			panel = go
			stab = 0
			sch = -1
			scur = 0
			smsg = ""
			spre = -1
			rsel = 0
			ssel = 0
			qsel = 0
			setup_sel = 0
	elif panel == "score":
		panel = ""
		sfx("back")
	elif panel == "shop":
		shop_choose()
	elif panel == "settings":
		if ssel == 3:
			panel = ""
			sfx("back")
		else:
			settings_change(1)
	elif panel == "reset":
		# 1-4 erase that player's candy, characters, upgrades and prestige; 5 erases everything
		if rsel == 5:
			cfg = ConfigFile.new()
			cfg.save(SAVE_PATH)
			sfx("deny")
		elif rsel >= 1:
			var pre := pkey(rsel - 1, "")
			if cfg.has_section("save"):
				for key in cfg.get_section_keys("save"):
					if key.begins_with(pre):
						cfg.erase_section_key("save", key)
			cfg.save(SAVE_PATH)
			sfx("deny")
		else:
			sfx("back")
		cur = char_pref(0)
		panel = ""
	elif panel == "quit":
		if qsel == 1:
			get_tree().quit()
		else:
			panel = ""
			sfx("back")

# Esc / Backspace / Start / Back: close a panel, or on the main list ask about quitting
func menu_back() -> void:
	if mode == "over":
		sfx("back")
		to_menu()
	elif mode == "menu" and panel == "shop":
		shop_back()
	elif mode == "menu" and panel != "":
		panel = ""
		sfx("back")
	elif mode == "menu":
		panel = "quit"
		qsel = 0
		sfx("select")

# ---------------------------------------------------------------- PLAYER SETUP
# From the title menu or the game menu: pick a slot (P1-P4), then press A on a controller, or Space
# (left keys) or Enter (right keys) on the keyboard, and that device plays that slot until the game
# is closed. A device that had another slot swaps with whoever had this one; pressing again on its
# own slot clears it. In a game it also moves that player's controls over straight away.
# Whoever opened it moves the cursor and backs out; any device can take a slot.
func dev_name(dev: Dictionary) -> String:
	if dev.pad >= 0:
		return "CONTROLLER %d" % (dev.pad + 1)
	return "KEYBOARD LEFT" if dev.side == "wasd" else "KEYBOARD RIGHT"

func setup_move(d: int) -> void:
	setup_sel = posmod(setup_sel + d, MAX_PLAYERS + 1)
	sfx("move")

func setup_back() -> void:
	if mode == "pause":
		G.menu.setup = false
	else:
		panel = ""
	sfx("back")

func setup_choose(dev: Dictionary) -> void:
	if setup_sel == MAX_PLAYERS:
		setup_back()
		return
	var s := setup_sel
	if assign.has(s) and same_dev(assign[s], dev):
		assign.erase(s)
		sfx("back")
		return
	var old := slot_of(dev)
	var prev = assign.get(s)
	assign[s] = dev
	if old >= 0:
		if prev != null:
			assign[old] = prev
		else:
			assign.erase(old)
	if mode == "pause":
		move_controls(s, dev)
	sfx("select")

# in a game: the player in slot s now plays with dev, and whoever used dev gets s's old controls
func move_controls(s: int, dev: Dictionary) -> void:
	var p = null
	for q in G.players:
		if q.n == s:
			p = q
	if p == null:
		return
	var q = dev_player(dev)
	if q != null and is_same(q, p):
		return
	var was := {"pad": p.pad, "kb": p.kb}
	p.pad = dev.pad
	p.kb = "" if dev.pad >= 0 else dev.side
	if q != null:
		q.pad = was.pad
		q.kb = was.kb

func setup_key(k: int) -> void:
	if k == KEY_SPACE or k == KEY_ENTER:
		setup_choose({"pad": -1, "side": "wasd" if k == KEY_SPACE else "arrows"})
	elif mode == "pause" and G.menu.dev.pad >= 0:
		return
	elif k == KEY_UP or k == KEY_W:
		setup_move(-1)
	elif k == KEY_DOWN or k == KEY_S:
		setup_move(1)
	elif k == KEY_ESCAPE or k == KEY_BACKSPACE or k == KEY_P:
		setup_back()

func setup_pad(d: int, hit: Callable) -> void:
	if hit.call("sel"):
		setup_choose({"pad": d, "side": ""})
	elif mode == "pause" and G.menu.dev.pad != d:
		return
	elif hit.call("up"):
		setup_move(-1)
	elif hit.call("down"):
		setup_move(1)
	elif hit.call("b") or hit.call("start") or hit.call("back"):
		setup_back()

func draw_setup() -> void:
	var rows := []
	for s in MAX_PLAYERS:
		rows.append(["P%d" % (s + 1), dev_name(assign[s]) if assign.has(s) else "NONE", not assign.has(s)])
	rows.append(["BACK", "", false])
	draw_panel("PLAYER SETUP", rows, "", setup_sel, "A ON A CONTROLLER, SPACE (LEFT KEYS) OR ENTER (RIGHT KEYS) TAKES THE SLOT.")

# ---------------------------------------------------------------- input
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		on_key(event.keycode)

func on_key(k: int) -> void:
	if k == KEY_M:
		muted = not muted
		return
	if k == KEY_F11 or (k == KEY_ENTER and Input.is_key_pressed(KEY_ALT)):
		toggle_fullscreen()
		return
	if (mode == "pause" and G.menu.get("setup", false)) or (mode == "menu" and panel == "setup"):
		setup_key(k)
		return
	if mode == "pause":
		if G.menu.dev.pad >= 0:
			return
		if k == KEY_UP or k == KEY_W:
			pause_move(-1)
		elif k == KEY_DOWN or k == KEY_S:
			pause_move(1)
		elif k == KEY_SPACE or k == KEY_ENTER:
			pause_choose()
		elif k == KEY_ESCAPE or k == KEY_P or k == KEY_BACKSPACE:
			close_menu()
		return
	if mode == "game":
		# a keyboard player choosing their character: the arrow side only if they're the second keyboard player
		var kp = null
		for o in G.picks:
			if o.dev.pad < 0:
				kp = o
		if kp != null:
			var ar: bool = kp.split
			if k == KEY_LEFT or (k == KEY_A and not ar):
				pick_cycle(kp, -1)
				return
			if k == KEY_RIGHT or (k == KEY_D and not ar):
				pick_cycle(kp, 1)
				return
			if k == KEY_ENTER or k == KEY_UP or ((k == KEY_SPACE or k == KEY_W) and not ar):
				pick_ok(kp)
				return
			if k == KEY_BACKSPACE or (k == KEY_ESCAPE and not ar):
				pick_cancel(kp)
				return
		if k == KEY_ESCAPE or k == KEY_P:
			menu_key({"pad": -1, "side": "wasd"})
		elif k == KEY_BACKSPACE:
			menu_key({"pad": -1, "side": "arrows"})
		return
	if k == KEY_UP or k == KEY_W:
		menu_move(-1)
	elif k == KEY_DOWN or k == KEY_S:
		menu_move(1)
	elif k == KEY_LEFT or k == KEY_A:
		menu_side(-1)
	elif k == KEY_RIGHT or k == KEY_D:
		menu_side(1)
	elif (k == KEY_Q or k == KEY_E) and mode == "menu" and panel == "shop":
		shop_tab(-1 if k == KEY_Q else 1)
	elif k == KEY_SPACE or k == KEY_ENTER:
		menu_choose(-1, "wasd" if k == KEY_SPACE else "arrows")
	elif k == KEY_ESCAPE or k == KEY_BACKSPACE:
		menu_back()

# A, X and Y select in menus, B goes back. During play all four and R2 shoot ("ok").
# mx is how far to move in play: the d-pad is full speed, the left stick is finer the less it's pushed.
const PAD_OFF := {"up": false, "down": false, "left": false, "right": false, "ok": false, "sel": false, "b": false,
	"start": false, "back": false, "lb": false, "rb": false, "mx": 0.0}
# left stick in play: ignored inside STICK_DEAD (so a resting stick doesn't drift), full speed from STICK_FULL
const STICK_DEAD := 0.2
const STICK_FULL := 0.9

func poll_pads() -> void:
	pads = {}
	for d in Input.get_connected_joypads():
		var ax := Input.get_joy_axis(d, JOY_AXIS_LEFT_X)
		var ay := Input.get_joy_axis(d, JOY_AXIS_LEFT_Y)
		var a := Input.is_joy_button_pressed(d, JOY_BUTTON_A)
		var b := Input.is_joy_button_pressed(d, JOY_BUTTON_B)
		var xy := Input.is_joy_button_pressed(d, JOY_BUTTON_X) or Input.is_joy_button_pressed(d, JOY_BUTTON_Y)
		var rt := Input.get_joy_axis(d, JOY_AXIS_TRIGGER_RIGHT) > 0.5
		var dl := Input.is_joy_button_pressed(d, JOY_BUTTON_DPAD_LEFT)
		var dr := Input.is_joy_button_pressed(d, JOY_BUTTON_DPAD_RIGHT)
		var mx := signf(ax) * clampf((absf(ax) - STICK_DEAD) / (STICK_FULL - STICK_DEAD), 0, 1)
		if dl != dr:
			mx = -1.0 if dl else 1.0
		var now := {
			"up": Input.is_joy_button_pressed(d, JOY_BUTTON_DPAD_UP) or ay < -0.5,
			"down": Input.is_joy_button_pressed(d, JOY_BUTTON_DPAD_DOWN) or ay > 0.5,
			"left": dl or ax < -0.35,
			"right": dr or ax > 0.35,
			"ok": a or b or xy or rt, "sel": a or xy, "b": b, "mx": mx,
			"start": Input.is_joy_button_pressed(d, JOY_BUTTON_START),
			"back": Input.is_joy_button_pressed(d, JOY_BUTTON_BACK),
			"lb": Input.is_joy_button_pressed(d, JOY_BUTTON_LEFT_SHOULDER),
			"rb": Input.is_joy_button_pressed(d, JOY_BUTTON_RIGHT_SHOULDER)}
		var pv: Dictionary = prev_pads.get(d, PAD_OFF)
		pads[d] = now
		prev_pads[d] = now
		pad_buttons(d, now, pv)

# what one controller's newly pressed buttons do (now: held this frame, pv: held last frame)
func pad_buttons(d: int, now: Dictionary, pv: Dictionary) -> void:
	var hit := func(k): return now[k] and not pv[k]
	if (mode == "pause" and G.menu.get("setup", false)) or (mode == "menu" and panel == "setup"):
		setup_pad(d, hit)
		return
	if mode == "pause":
		if G.menu.dev.pad != d:
			return
		if hit.call("up"):
			pause_move(-1)
		if hit.call("down"):
			pause_move(1)
		if hit.call("sel"):
			pause_choose()
		elif hit.call("start") or hit.call("back") or hit.call("b"):
			close_menu()
	elif mode == "game":
		var dev := {"pad": d, "side": ""}
		var kp = dev_pick(dev)
		if kp != null:
			if hit.call("left"):
				pick_cycle(kp, -1)
			elif hit.call("right"):
				pick_cycle(kp, 1)
			elif hit.call("sel"):
				pick_ok(kp)
			elif hit.call("start") or hit.call("back") or hit.call("b"):
				pick_cancel(kp)
		elif hit.call("start"):
			menu_key(dev)
	else:
		if hit.call("up"):
			menu_move(-1)
		if hit.call("down"):
			menu_move(1)
		# on a controller the UPGRADES tabs use LB / RB, so left / right is left alone there
		var in_shop: bool = mode == "menu" and panel == "shop"
		if hit.call("left") and not in_shop:
			menu_side(-1)
		if hit.call("right") and not in_shop:
			menu_side(1)
		if in_shop and hit.call("lb"):
			shop_tab(-1)
		if in_shop and hit.call("rb"):
			shop_tab(1)
		if hit.call("sel"):
			menu_choose(d)
		elif hit.call("b"):
			# B goes back out of a panel or the game-over screen, but does nothing on the title's main list
			if mode == "over" or panel != "":
				menu_back()
		elif hit.call("start") or hit.call("back"):
			menu_back()

func _process(delta: float) -> void:
	var dt := minf(0.05, delta)
	t += delta
	poll_pads()
	if mode == "game":
		update(dt)
	if mode == "menu" and t - open_cache_t > 0.8:
		open_cache_t = t
		open_cache = []
		for i in chars.size():
			open_cache.append(has_char(0, i))
	_update_music()
	queue_redraw()
