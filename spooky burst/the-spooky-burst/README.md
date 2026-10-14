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
- PLAY GAME asks whoever pressed it which character to play: the picker pops up at their spot over the empty
  graveyard, open on their favourite, and wave 1 starts when they shoot. B / Start / Back goes back to the title.
- Start, Esc or Backspace opens the game menu if you're playing. If you aren't, the same picker pops up at
  your spot while the game keeps going: left / right picks, A (or shoot on the keyboard) joins,
  B / Start / Back cancels. Once you own 2 or more characters there's a ? at the end that picks one at random.
  A pick is for that game only; your favourite stays what PLAYER SETUP says.
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
- Each slot also has a colour box: move right onto it and press to open a swatch of white, blue, purple, pink,
  orange, yellow and green, each in dark, normal and light. It colours that player's shots and character
  (the Cat's tummy, the Zombie's shirt, the Ghost's and Skeleton's tint, the Jester's colour parts).
- Right again is the slot's FAVOURITE: the character it usually plays, shown as its icon. Press to open a
  drop-down of every character with its icon and name; ones not bought are greyed out, and RANDOM is at the
  bottom once the slot owns 2 or more. The favourite is what the picker opens on at PLAY and when joining.
  Normal white is each character's own look. Slots start white, green, blue and orange, and the choice is saved.
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
  them at a time. A wave calms down as you clear it. Attacks come in volleys with rests between them, and
  nothing attacks until the formation has settled.
- How hard a wave hits follows a cadence within each stage: the first set of waves (1-4) is relaxed, the
  second medium, the third hard, the fourth harder, and by the fifth you find the gaps or get hit. The wave
  right after a boss is a breather with one row fewer. Every stage beaten adds a step on top, smaller each
  time but never below a floor, so it never stops getting harder and never jumps.
- Everything is on a doubled scale: orbs do 2 damage before boosts. SPECTRAL SHOT and PUNCH THROUGH halve
  each time they go through an enemy and stop once under 1 damage.
- Every 5th wave is a boss, in this order: PRIMAL BAT, BLACK WIDOW, VAMPIRE LORD, WITCH QUEEN,
  PUMPKIN KING. Each boss's own kind fills the waves before the next one:
  - Waves 1-4 ease in (bats, then witches, then vampires; spiders from wave 3).
  - After the PRIMAL BAT: vampires, witches and 3 rows of bats. In these waves (just before the
    BLACK WIDOW) a killed spider is replaced, up to 6.
  - Before the VAMPIRE LORD the top bat row is vampires instead, before the WITCH QUEEN it's witches
    instead, and before the PUMPKIN KING it's witches, vampires, witches, vampires and one row of bats.
  - Beating the PUMPKIN KING shows STAGE 1 COMPLETE, then comes the HAUNTED MANSION (below). Beating the
    GRIM REAPER there shows STAGE 2 COMPLETE, and it starts over in the graveyard from wave 1's lineup.
    Every stage beaten makes every enemy after it +1 HP.
- The wave counter counts 1-25 in each stage: the graveyard, then the mansion starts again at WAVE 1. The game
  over screen and BEST WAVE say which stage too (STAGE 2 WAVE 7), and the stages keep counting round the loop.
- The PRIMAL BAT swoops down at you, flies off one side and comes back in from the other to strafe across
  the whole screen dropping slow sound waves at you, fires spreads and 3-shots of dark orbs, and calls
  swarms of bats into formation. The BLACK WIDOW hangs on her thread, spits venom, dangles spiders down
  at you and leaves them hanging partway back up, spins web walls and calls spiders. The VAMPIRE LORD
  launches bats at you and calls bats into formation and vampires. The WITCH QUEEN calls witches; her
  next attack waits until her last one's shots are past you (except her aimed 3-shot), then for a short
  random breather, and her candy corn rain always leaves a clear lane.
  The PUMPKIN KING calls a batch of one kind at a time, in turn: bats, witches, vampires, spiders,
  and they act just like the ones in a normal wave.
- THE HAUNTED MANSION (Sammie's level 2), stage 2, waves 1-25: a room inside the mansion, where spiders, possessed dolls
  and ghosts take the place of the bats, witches and vampires (4 to a row in a checkerboard). Waves 1-4 ease
  in: mostly spiders with a couple of dolls, then more dolls, then ghosts, then the full room.
  Every mansion attack has a tell: a spider wiggles and lets out a bit of thread, then drops straight down on
  it and hangs at your height for a moment. A doll lifts and pauses, then swoops down in a U that bottoms out
  above where you were when it started and comes back up on the far side; dolls also shoot buttons at you.
  A ghost's eyes glow, then it cries three tears that fall straight down its column.
  The pick-ups are candles: a candelabra for the power-up pumpkin and a brass candle for the treat bucket.
  Its bosses: SPIDER BEAST (wave 5) throws sticky webs that slow you down for a second and pounces: a green
  circle blinks on the floor where it will land, then it drops straight down on its thread, hangs at your
  height and climbs back (step out of the circle). BAT CAT (10) slides over you, drops straight down and
  leaves one dark scratch under itself for half a second, then rests; it calls bats (the mansion's bats, in
  the PRIMAL BAT's colours). PUPPET DOLL (15) shoots big buttons and sewing needles. THE TWINS (20) shoot
  mirror-image bows (their crossing walls are four bows a line with a lane between, and their streams take
  turns). The GRIM REAPER is a skull in a ragged black cloak with a scythe; it
  (25) warns on half the floor, then slashes across it, borrows the others' webs, needles and bows,
  and calls spiders, dolls and ghosts into the room. In the waves before BAT CAT, the PUPPET DOLL and the GRIM
  REAPER, half the enemies are their kind. After the GRIM REAPER it's back to the graveyard.

## Candy and upgrades
- Whoever catches candy keeps it (treat buckets and boss candy too). WIGGLE TAIL, GRAVE ROBBER and
  SOUL MATE help you get more of it.
- The treat bucket gives 5 candy (40%), 10 candy (10%), 300 points (10%), an extra life (15%), a TRICK of
  three bats (15%), a POWER TREAT (5%: one of the pumpkin's small boosts) or an ability or SHOP upgrade (5%),
  drawn the way a pumpkin draws one; a boost once it's all held.
- Each character has a SPECIAL, its own boost worth 2 steps: the Ghost's fire rate, the Cat's move speed, the
  Zombie's damage, the Skeleton's shot speed, the Jester's safe time after a hit. Its CHARACTERS page names it.
- SUGAR RUSH: once the PUMPKIN KING has been beaten on this save, when a boss dies it tosses a cotton candy high
  into the air (two if 3 or 4 players are alive at that moment). It falls beside the boss's candy, never through it, so you choose which to go for. Whoever catches one gets +1 to their SPECIAL, up to 10, so it can reach +12. The HUD shows
  SUG 1 to SUG 10 on the prestige line under your power-up codes. It's lost with your power-ups and boosts when
  you're out of lives.
- Once the Jester is bought he pops out of the pumpkin on the right of the title screen, bobbing like a
  jack-in-the-box with the pumpkin's top on his head. While he's locked he isn't there at all: no silhouette.
- The pumpkin the centre ghost holds on the title screen has the PUMPKIN KING's face (Sammie's). In play, each
  glowing power-up pumpkin is a coin flip between that face and the plain carved one, and the pumpkin it drops
  keeps the face it had.
- An enemy drops candy a quarter of the time. GRAVE ROBBER (for everyone's kills while anyone has it) or a
  HEAVY FIST killing blow raises that to a third, and both together to half. A third of all candy, boss candy
  too, is a gumball worth 2.
- Spend it in CHARACTERS on the title screen. There's a tab for each player: LB / RB on a controller,
  left / right or Q / E on the keyboard. Switching tabs stays on the character you're looking at.
  Characters cost 500 candy and upgrades cost 100 (CHAR_COST and POW_COST at the top of main.gd).
  The Ghost starts free. Each character's page shows a line about what it's a bit better at:
  the Ghost shoots 10% faster, the Black Cat moves 8% faster, the Zombie does 10% more damage, the Skeleton's
  shots fly 8% faster, and the Jester stays safe 12% longer after a hit (each worth 2 boosts, stacking with
  everything else).
- PRESTIGE: once you own a character and all its upgrades, a PRESTIGE row shows at the bottom of its page.
  Confirming relocks the character and all its upgrades, and gives that character +1 of every boost
  for good, up to PRESTIGE 10/10 (so 10 more on top of the 10 a run can give). Each prestige level makes
  that character and its upgrades cost 10% of the base price more. After the first prestige the row
  always shows its level, greyed out until everything is bought again. You can't prestige your only
  character unless you have the candy to buy one back. In a game, PRE 1 and so on shows under your upgrades.
- Pick a character to see its upgrades: bought ones switch ON or OFF. Who you play is set in PLAYER SETUP
  (your favourite) and asked at PLAY, not here.
- Nothing unlocks during a game. Every run starts with no upgrades; shoot the glowing pumpkin each wave and
  it drops one. Whoever catches it gets one of their bought, ON upgrades straight away.
  The pumpkin flies in below the lowest enemy still alive, so clearing the bottom rows lets it come in higher.
  About 1 wave in 6 a bonus pumpkin also flies across above all the enemies.
- Once you have all of those, pumpkins give small boosts for the rest of the run instead, picked at random.
  Each one stacks up to 10 times and stays below the character upgrade it matches, stacking on top of it
  (so the Black Cat with LUCKY COIN has the biggest shots):
  DM damage +5% each, FR fire rate +5%, SS shot speed +4%, MS move speed +4%, OS orb size, LS longer safe time +6%.
  ORB SIZE shows every 5: first a bigger look, then the normal look a size up, then the bigger one a size up.
  Your boosts show in blue above your upgrades. When all six are maxed, pumpkins give 300 points.
- This version saves to a new file (spooky_burst_v2.cfg), so everyone starts fresh. Reset Save erases one player
  (their candy, characters, upgrades and prestige) or everything.

## Characters
- The Black Cat is black for every player; players 2-4 have a coloured tummy matching their orbs.
- NINE LIVES shows as the cat's tail curled up over his head while the shield is ready.
- LUCKY COIN shoots big gold coins that flip as they fly. Every hit is a coin flip: half the time it knocks the
  enemy away from you (4 px per point of damage), the other half it does double damage. Knocks add up and the
  enemy drifts back slowly, so keeping at one drives it up or off to the side, never off the screen. It keeps
  moving and attacking. Bosses can be knocked too.
- WIGGLE TAIL collects candy, power-ups, buckets and apples up to one cat width beyond him, as high as his head.
  His tail swipes the full reach up over his back on that side, or with NINE LIVES the curled tail leans over and back.
- HEAVY FIST makes the Zombie's shots little fists that do double damage, and enemies they finish off drop
  candy more often. PUNCH THROUGH lets them go through enemies like SPECTRAL SHOT,
  and through a web tile they break (halving the same way). ROT CLOUD slows every enemy shot to 75%; each
  further Zombie with one adds half the last slow (63%, 56%, 53%), so a crowd of them can't freeze the screen.
- BONE THROW joins the Skeleton's pair of orbs into one bone; if one end hits something, the other flies on alone.
  RIBBED SHOT shows a faint rib between the two side shots as they leave.
- The Jester is black and white; players 2-4 have their colour on his left bell, his diamonds and his right leg.
  The glint in his eyes looks the way he's moving. He shoots jingle bells, straight up.
- TRICK SHOT turns the shots into balls that do 1 damage and can hit any number of times, angled 30 degrees the
  way you're moving (straight up when still), 45 degrees once you've kept going that way for half a second, so
  they catch the sides of enemies. They bounce off enemies and webs (damaging the webs too), leaning a little
  toward the next enemy, but not off the sides or the floor. Each time one goes off the top it falls back down,
  speeding up as it falls and drifting 1-2 character widths left or right at random. A ball that comes down onto
  whoever threw it bounces back up off them (not off other players), so you can keep one in the air by staying
  under it.
- WICKED CLOWN gives him a life back the moment he's down to 1 (even if he catches it while already on 1),
  then it's used up until a pumpkin gives it again. NEEDS FOOD BADLY pulls nearby candied apples and power-ups to
  him while he's on 1 life; with more lives it only pulls what's within half a character width, fading out by a
  full one.
- JUGGLING BALLS gives him a green, a blue and an orange ball that sit on the ground until someone walks into
  one, kicking it 1-2 rows up toward another player, then the Jester, then a random spot, in turn. They block
  enemy shots, do the Jester's orb damage to enemies they touch (DAMAGE UP counts, and ORB SIZE grows their
  reach) and never leave the play area. A kick can go up to 1 px higher for every step of LONGER SAFETY from his
  SPECIAL, prestige and SUGAR RUSH, so a maxed Jester juggles up to about 22 px higher. A ball that has come to a stop
  rolls back to the Jester and stops a step short of him, ready to kick again. They roll as they go and spin
  in the air.
- I'M NOT A PINATA: when he loses a life he tosses up a gift box of up to 8 pieces of candy, some of them gumballs.
  It costs him half of what it's worth (rounded up). The box rises until it's within 12 px of an enemy on any
  side, or 12 px short of the top row's height, then bursts; the pieces hit enemies on the way out (1 damage,
  gumballs 2), then rain down for anyone to catch. With less candy he throws only what he can
  pay for, with none nothing.
- The pause menu (Esc, P or Start in a game) has CHARACTERS and POWER UPS next to PLAYER SETUP. CHARACTERS
  is the real shop over the paused game, on the tab of whoever paused: buy characters and upgrades with the
  candy you have, and a new character is in the JOIN picker straight away. A fresh upgrade is ON; switching ON
  or OFF and PRESTIGE wait for the main menu (greyed, with a note). POWER UPS lists each player in the game
  with their icon and what they hold right now, and only that: each ability as its code and name, their
  boosts, prestige, SUGAR RUSH and the Little Girl's random +1s.
- THE SHOP: a character's page has a SHOP row above PRESTIGE once it's bought (only characters with upgrades
  written so far show it; the Jester is first). The SHOP page lists two upgrades under each ability, 250 candy
  each, and you can only buy one once that ability is unlocked. Bought ones can be switched ON or OFF from the
  main menu (buy only from the pause). They're saved apart from the abilities, so PRESTIGE leaves them bought:
  they sit dormant until the ability is bought back. In a run, the glowing pumpkin picks at random across
  everything available: abilities you don't hold, plus the bought, ON upgrades of the abilities you do hold.
  Boosts start once all of that is held, so it's about fifteen pumpkins to a full set. An upgrade is lost with
  its ability (death, SECOND WIND, WICKED CLOWN used up). The HUD code gains a count, TRK, TRK1, TRK2, and
  POWER UPS lists the upgrades under their ability. The Little Girl has no SHOP page: a borrowed ability brings
  whatever that slot has bought and switched ON for it.
- The Jester's SHOP: TRICK SHOT: BOUNCE OFF ANY PLAYER (balls bounce back up off any player, not just him);
  CROSS SCREEN (balls go off one side and in the other, and still fall through the floor). NEEDS FOOD BADLY:
  INCREASE RANGE (half again as far); PULL CANDY (candy too). WICKED CLOWN: EXTRA USE (works twice before a
  pumpkin is needed); X2 SAFETY (the hit that fires it leaves him safe twice as long, other hits not). JUGGLING
  BALLS: EXTRA BOUNCY (balls bounce higher and longer before settling); EXTRA HIGH (kicks 12 px higher and 2 px
  per LONGER SAFETY step instead of 1). I'M NOT A PINATA: ALL GUMBALLS (every piece is a gumball, so a box
  costs more); JAW BREAKER (the pieces keep hurting all the way down, one hit per enemy, drawn as the rainbow
  jaw breaker ball, and turn back into candy near the ground).
- Gumballs are a glossy pink ball now; the old rainbow ball is the JAW BREAKER.
- The Little Girl's present costs her bag the same candy it costs her stash, so catching her own pieces can't
  fill it for her.
- THE LITTLE GIRL is a secret sixth character: pigtails, a dress in the player's colour, green eyes and her
  trick or treat bucket. While a slot doesn't own her, picking RANDOM (the "?" in the picker, or RANDOM as the
  favourite) rolls her 1 time in 10. She has no SPECIAL stat and no abilities of her own. At the start of a
  run she gets +1 to two stats picked at random, and every SUGAR RUSH she catches is
  +1 to a random stat; the HUD shows them as DM+1, LS+1 and so on on her prestige line. The glowing pumpkin
  hands her an ability from any other character, drawn from the ones that slot has bought and switched ON, up
  to five at a time; after that, boosts as usual. A slot she loses (death, SECOND WIND, WICKED CLOWN firing) is
  open again, and the next pumpkin fills it with another random draw. She puts on a mask of whichever character
  her first ability came from (each mask is that character's face, her green eyes showing through the holes)
  and takes it off once she holds nothing. Candy caught while playing her fills her trick or treat bag, shown
  under the candy total with a small bucket, counting down from 1000; full, the slot owns her for good and she
  shows in CHARACTERS, the picker and the favourite list like anyone. Her CHARACTERS page has nothing to buy,
  just PRESTIGE: it relocks her (a secret again, bag back to 1000) for +1 to all stats, like anyone's prestige.
  Her sprite is Hero's; a mask is drawn over her face the way hats are drawn on the title ghosts.

## Where things are
- `main.gd` holds the whole game. The sprites are the blocks of letters near the top: each letter is one pixel, and the palettes next to them say which colour each letter is.
- Each character's power-ups are listed in `_build_chars()`.
- `audio/` holds the music and sound effects as .wav files. Replace a file with your own of the same name to change a sound.
  `audio/laugh.wav` (the Pumpkin King's laugh) is "Evil Laugh 2" by AntumDeluge from OpenGameArt.org, CC0 (free to use).
- Your save is stored by Godot in its user data folder, and Reset Save on the menu erases it.
