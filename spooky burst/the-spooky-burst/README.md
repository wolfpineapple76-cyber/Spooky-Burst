# The Spooky Burst (Godot 4)

A Halloween arcade shooter. Made for Godot 4.3 or newer.

## How to open it
1. Install Godot 4 from godotengine.org (the standard version, not .NET).
2. Unzip this folder.
3. Open Godot, click Import, and pick the `project.godot` file in this folder.
4. Press F5 (or the Play button, top right) to run the game.

## Controls
- Menus: arrow keys or D-pad to move, Space or A/X/Y to select, Esc or B to go back.
  (During play A/B/X/Y all shoot. On the title's main list B does nothing; use QUIT, Esc or Start to quit.)
- Keyboard left side: A and D to move, Space (or W) to shoot, Esc (or P) for the game menu.
- Keyboard right side: left and right arrows to move, Enter (or up arrow) to shoot, Backspace for the game menu.
  One keyboard player can use both sides. A second keyboard player presses Backspace to join and gets the right side.
- Xbox controller: D-pad or left stick to move (the stick moves slower when only pushed partway),
  A/B/X/Y or the right trigger (R2) to shoot, Start for the game menu.
- Start, Esc or Backspace opens the game menu if you're playing. If you aren't, a little character picker
  pops up at your spot while the game keeps going: left / right picks, A (or shoot on the keyboard) joins,
  B / Start / Back cancels. Once you own 2 or more characters there's a ? at the end that picks one at random.
- Game menu: Resume, Join, Player Setup, Quit (that player leaves, the others keep playing) and Main Menu.
- QUIT on the title screen (or Esc / Start there) asks if you want to quit the game.
- Settings: full screen or windowed, the window size, and pixel perfect. Use left / right to change them.
  Window sizes are whole multiples of the 640x480 game (640x480, 1280x960...) so the pixels stay square,
  and only sizes that fit your screen are listed. Full screen uses your monitor's own resolution.
  Pixel perfect only scales by whole numbers, so every pixel is the same size, with a bigger border.
- F11 or Alt+Enter switches full screen on and off anywhere.
- M turns sound off and on.

## Co-op
- Up to 4 players. Each player number (P1-P4) has its own candy, characters, upgrades and ON/OFF settings,
  so whoever joins second uses P2's unless PLAYER SETUP says otherwise. The high score is shared by the team.
- PLAYER SETUP (title menu or game menu) sets which controller or keyboard side plays P1-P4: pick a slot,
  then press A on that controller, Space (left keys) or Enter (right keys). Pressing again on its own slot
  clears it. It lasts until the game is closed. In a game it moves that player's controls straight over.
  Anyone not set up joins as the lowest slot nobody else is set up for.
- Lives are shared, never created. Someone joining takes lives one at a time from whoever has the most
  until everyone is within one life of each other. Someone leaving hands their lives to whoever has the fewest.
- A player who runs out of lives can press Start (or their menu key) to pick a character and join again,
  as long as someone has a life to spare.
- Bosses get 50% more health for each extra player.
- Running out of lives costs you every power-up and boost from that run (nobody else gets them),
  so a player who rejoins starts with nothing. You keep all the candy you caught.
- SECOND WIND (Skeleton) wipes you the same way, then brings you straight back with 2 lives.

## Waves and enemies
- Bats (2 HP) stream in fast from the top corners and dive at you. Witches (2 HP) swoop in low from the
  sides, dropping a slow shot or two, then drop candy corn and swoop across. Vampires (12 HP) drop in
  as dark red-eyed bats, turn back into vampires in their spot and shoot at you. Vampire rows are spaced
  out and staggered: 4 in one row, 5 in the next.
- Spiders (6 HP, from wave 3) lower themselves on threads at the top corners and the top middle. Each
  one webs the spot just below a front enemy (up to 2 webs each); once its webs are up it spits green
  venom that falls faster and faster. A web tile soaks up 4 damage of your shots, piercing ones too,
  and sways with the rows. Enemies and their shots pass straight through webs.
- Every enemy has its own chance to attack, so more of a kind means more attacks, about one per row of
  them at a time. A wave calms down as you clear it.
- Everything is on a doubled scale: orbs do 2 damage before boosts. SPECTRAL SHOT halves each time it
  goes through an enemy and stops once it's under 1 damage (or after 3 enemies).
- Every 5th wave is a boss, in this order: PRIMAL BAT, BLACK WIDOW, VAMPIRE LORD, WITCH QUEEN,
  PUMPKIN KING. Each boss's own kind fills the waves before the next one:
  - Waves 1-4 ease in (bats, then witches, then vampires; spiders from wave 3).
  - After the PRIMAL BAT: vampires, witches and 3 rows of bats; a killed spider is replaced, up to 6.
  - After the BLACK WIDOW the top bat row turns to vampires, after the VAMPIRE LORD the next one to
    witches, and after the WITCH QUEEN it's witches, vampires, witches, vampires and one row of bats.
  - After the PUMPKIN KING it loops back to the full lineup before the PRIMAL BAT, and every enemy
    has +1 HP for each PUMPKIN KING beaten.
- The PRIMAL BAT swoops, screeches rings of sound and calls swarms of bats into formation. The BLACK
  WIDOW hangs on her thread, spits venom, drops down at you, spins web walls and calls spiders. The
  VAMPIRE LORD launches bats at you and sometimes calls vampires. The WITCH QUEEN calls witches.
  The PUMPKIN KING calls a batch of one kind at a time, in turn: bats, witches, vampires, spiders,
  and they act just like the ones in a normal wave.

## Candy and upgrades
- Whoever catches candy keeps it (treat buckets and boss candy too). DOUBLE CANDY, GRAVE ROBBER and
  SOUL MATE help you earn it faster.
- Spend it in UPGRADES on the title screen. There's a tab for each player: LB / RB on a controller,
  left / right or Q / E on the keyboard. Switching tabs stays on the character you're looking at.
  Characters cost 500 candy and upgrades cost 100 (CHAR_COST and POW_COST at the top of main.gd).
  The Ghost starts free. Each character's page shows a line about what it's a bit better at:
  the Ghost shoots 10% faster, the Black Cat moves 8% faster, the Zombie does 10% more damage
  and the Skeleton's orbs fly 8% faster (each worth 2 boosts, stacking with everything else).
- PRESTIGE: once you own a character and all its upgrades, a PRESTIGE row shows at the bottom of its page.
  Confirming relocks the character and all its upgrades, and gives that character +1 of every boost
  for good, up to PRESTIGE 10/10 (so 10 more on top of the 10 a run can give). Each prestige level makes
  that character and its upgrades cost 10% of the base price more. After the first prestige the row
  always shows its level, greyed out until everything is bought again. You can't prestige your only
  character unless you have the candy to buy one back. In a game, PRE 1 and so on shows under your upgrades.
- Pick a character to see its upgrades: PLAY AS chooses it, and bought upgrades switch ON or OFF.
  With 2 or more characters there's also RANDOM, which picks one of yours each game.
- Nothing unlocks during a game. Every run starts with no upgrades; shoot the glowing pumpkin each wave and
  it drops one. Whoever catches it gets one of their bought, ON upgrades straight away.
  The pumpkin flies in below the lowest enemy still alive, so clearing the bottom rows lets it come in higher.
  About 1 wave in 6 a bonus pumpkin also flies across above all the enemies.
- Once you have all of those, pumpkins give small boosts for the rest of the run instead, picked at random.
  Each one stacks up to 10 times and stays below the character upgrade it matches, stacking on top of it
  (so the Black Cat with BIG ORB has the biggest orbs):
  DM damage +5% each, FR fire rate +5%, SS shot speed +4%, MS move speed +4%, OS orb size, LS longer safe time +6%.
  Your boosts show in blue above your upgrades. When all six are maxed, pumpkins give 300 points.
- This version saves to a new file (spooky_burst_v2.cfg), so everyone starts fresh. Reset Save erases one player
  (their candy, characters, upgrades and prestige) or everything.

## Characters
- The Black Cat is black for every player; players 2-4 have a coloured tummy matching their orbs.
- NINE LIVES shows as the cat's tail curled up over his head while the shield is ready.

## Where things are
- `main.gd` holds the whole game. The sprites are the blocks of letters near the top: each letter is one pixel, and the palettes next to them say which colour each letter is.
- Each character's power-ups are listed in `_build_chars()`.
- `audio/` holds the music and sound effects as .wav files. Replace a file with your own of the same name to change a sound.
- Your save is stored by Godot in its user data folder, and Reset Save on the menu erases it.
