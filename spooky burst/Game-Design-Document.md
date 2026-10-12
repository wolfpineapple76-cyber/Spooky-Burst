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
