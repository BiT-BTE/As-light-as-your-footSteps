{SinOsc.ar(440.0, 0, 1, 0)}.play;

{Saw.ar(432, MouseX.kr(0, 1), MouseY.kr(-1, 1))}.scope;

{SoundIn.ar(0)*SinOsc.ar(MouseX.kr(80, 640).poll)}.play;