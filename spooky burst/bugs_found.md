BUGS FOUND

Open
- (none)

Fixed
- The game over screen's WAVE REACHED and the saved BEST WAVE showed the real wave number, not the stage's 1-25.
  Now STAGE 2 WAVE 7, and the STAGE n COMPLETE banner counts on round the loop too.
- test_pad (the controller test) failed on every version: not the game, the test. Headless Godot has no
  controllers, so the fake stick events went nowhere. The test now tells Input a fake pad is plugged in.
- The mansion used the loop's 26-50 wave number for spider drop speed and button speed, so stage 2 opened with
  drops at 224 px/s. Fixed with the LEVEL system.
- Candy corn speed and dive speed used the real wave number with no cap, so the second lap (wave 51+) had corn
  at 238 px/s and dives at 401. Fixed with the LEVEL system.
