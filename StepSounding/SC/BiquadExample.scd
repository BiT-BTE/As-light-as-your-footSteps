s.boot;
(
z = { // toy around with boost/cut
BLowShelf.ar(
    SoundIn.ar([0,1]),
    MouseX.kr(40, 6000, \exponential),
    1.0, // rs
    MouseY.kr(24.0, -24.0, \linear),
    0.5); // mul
}.play)
z.release;

(
z = { // toy around with rs
BLowShelf.ar(
    SoundIn.ar([0,1]),
    MouseX.kr(20, 6000, \exponential),
    MouseY.kr(0.1, 1.0, \linear), // rs
    6,
    0.5); // mul
}.play)
s.scopebuf;
z.release;