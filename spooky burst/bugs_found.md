BUGS FOUND

Open
- The game over screen's WAVE REACHED and the saved best wave use the real wave number, not the stage's 1-25.
- test_pad (the controller test in the scratch project) fails on versions back to before the mansion; not yet
  looked into, nothing reported in play.

Fixed
- The mansion used the loop's 26-50 wave number for spider drop speed and button speed, so stage 2 opened with
  drops at 224 px/s. Fixed with the LEVEL system.
- Candy corn speed and dive speed used the real wave number with no cap, so the second lap (wave 51+) had corn
  at 238 px/s and dives at 401. Fixed with the LEVEL system.
