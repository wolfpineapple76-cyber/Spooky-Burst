THE SPOOKY BURST: GAME DESIGN DOCUMENT

Attack pattern rules. Every enemy, shot and boss attack follows these.

Here's what the design side says. Most of it comes from the shmup community wiki, Sparen's danmaku guide and a few developer essays, so it's practitioner wisdom rather than science, but it's consistent across sources.

The core idea: design the gap, not the danger. The guides keep coming back to this. A pattern feels fair when the player can see the way through before the bullets arrive, and unfair when the screen looks exciting but the escape can't be read. Difficulty should come from the gap being narrow or in an awkward place, never from it being hidden or absent. We already have this as a rule ("every boss attack must leave a hole"), and the research says it applies to ordinary enemies too.

Readable beats random. Single stray bullets at odd angles are the thing players hate most, because there's nothing to read. Bullets grouped into lines, rings, fans or curtains are easier to dodge even when there are far more of them, because you dodge the shape instead of each bullet. Random spread should be small and inside a shape; rain is fine, random rain is not.

Aimed and unaimed shots do different jobs, and the mix matters.

An aimed shot is fair by nature: it goes where you were, so any small move dodges it. Its job is pressure and to make you move. The classic answer is "streaming": tap sideways a little, and every aimed shot lands just behind you.
A static pattern (the same every time, ignoring the player) has fixed safe spots that can be learned.
The trap is firing aimed shots from many enemies at once, which fills the lanes you'd stream into. The guides say keep aimed fire to a few sources at a time, and give unaimed curtains clear lanes.
Odd-numbered aimed fans have a bullet dead on you (move a tap), even-numbered ones bracket you (don't move). Mixing both in one wave is a cheap way to make the player think.
Telegraph in proportion to the punishment. The harder or bigger the attack, the longer and clearer the warning: a thin line before a laser, a pause before a burst splits, a colour change or sound before a dive. The tell must be consistent (the same warning always means the same attack) and must be visible under load, so cut other effects during the windup. A hit the player couldn't see coming reads as random punishment no matter how fair it was. Our Grim Reaper's half-floor warning is exactly this.

Bullet speed, player speed and hitbox are one system. Narrow gaps only work if bullets are slow and the hitbox is small. Fast bullets need wide gaps. The practical rule: the gap must be reachable at the player's speed in the time the bullets take to arrive. Our players have different speeds and SLOW exists, so the slowest player at the worst moment is the one to design for.

Bullets must be visible. Enemy shots drawn on top of explosions, pickups and enemies, in colours that contrast with the background, and distinct from player shots and candy. Directional bullets (that point where they're going) read better than round ones.

Dives follow the same rules. A Galaga dive is just a slow, big, aimed bullet. It's fair because the enemy loops first (the tell), comes down a smooth arc (readable), and is aimed at where you were when it started (streamable). The Goei's weave is the "hard" version, and it's still a shape. An enemy that just turns and homes in on you is the dive equivalent of a random bullet.

Pacing and rhythm. Fire comes in cadences with rests. The guides describe a wave as a positional puzzle: where do I stand and what do I kill first. Waves that never stop firing stop being fun. A common trick is enemies firing more as their numbers drop (the Space Invaders speed-up), which makes the end of a wave the climax instead of a mop-up. Some games use a hidden "rank" that rises as you do well and falls when you die, so a struggling player gets a quieter game.

THE FLOW OF A STAGE

My general Idea of the flow of the game would be

Although each "Stage" would be harder than the last, the waves and bosses should have a difficulty cadence.

The first waves coming up to the first boss should be easy, a little relaxed, showcasing some enemies and a bit of a breather. The first Boss of each stage is kind of easy maybe showing off some new effects or attacks not seen in the previous stage.

The second set of waves would be getting a little harder so at this point medium difficulty, you have to dodge but it doesn't feel like hell and the second boss is a bit more challenging than the first. With approx. half the enemies leading up to him matching his theme a bit.

Then after the second boss it starts getting hard, dodging each wave is starting to become necessary and you start feeling the pressure, the boss is a bit of challenge laying some pressure on you. At this point if you're not paying attention you will probably die.

The fourth set of waves and fourth boss continues this pattern but by the fifth set of waves if you have not gotten good and find the gaps or kill the enemies then you're getting hit.

The final boss's job is to test your skills with all of the enemies and new attack types of this stage it can fairly put into the fight and its second form is to check if you have mastered this stage and are ready to move on.

Keep in mind also the first sets of waves will likely be dealt with by less players who have less power ups due to death. So, hopefully by the 3rd to 4th boss it has let you breathe enough to build back up some.

THE SHOP

Each ability has two upgrades in a SHOP, 250 candy each, bought only once the ability is unlocked and kept through prestige. In a run they come from the pumpkin like abilities do, drawn at random alongside the abilities not yet held, so a full set is about fifteen pumpkins and the small boosts come after. An upgrade adds to what the ability does and never takes away an effect the normal shot or ability already has.

THE LITTLE GIRL

A secret sixth character, rolled 1 in 10 on RANDOM until a slot owns her. She has no SPECIAL stat and no abilities of her own: +1 to two random stats each run (her SUGAR RUSH is random too; prestige is +1 to all, like anyone's), and pumpkins hand her other characters' abilities, only the ones that slot has bought and switched ON, five at a time, each lost slot refilled at random. She wears the mask of the character her first ability came from until she holds none. Unlocked for good by catching 1000 candy as her (her trick or treat bag); prestige makes her a secret again. The design rule she follows: nothing is handed out that the player hasn't earned on the other characters, and her power is a surprise, not a bigger number.
