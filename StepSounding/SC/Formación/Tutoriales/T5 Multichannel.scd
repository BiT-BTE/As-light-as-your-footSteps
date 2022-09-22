/// SuperCollider Tutorial 5, Multichannel expansion

s.boot;
s.meter;
s.tree;

s.freeAll;

(
x = {
	var sig, amp;
	amp = SinOsc.kr([7, 0.1]).range(0, 1);
	sig = SinOsc.ar([300, 500]);
	sig = sig * amp;
}.play;
)

x.free;

(
y = {
	var sig, amp;
	amp = SinOsc.kr([7, 1, 2, 0.2, 6]).range(0, 1);
	sig = SinOsc.ar([300, 500, 700, 900, 1100]);
	sig = sig * amp;
	// [Mix.new(sig), Mix.new(sig)] * 0.25;
	Mix.new(sig).dup(2) * 0.25;
}.play;
)

y.free;