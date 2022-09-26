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
	//Mix.new(sig).dup(2) * 0.25;
	Splay.ar(sig) * 0.25;
}.play;
)

y.free;

h = {PinkNoise.ar(0.5!2)}.play;
h.free;

// synth
(
SynthDef.new(\multi, {
	var sig, amp;
	amp = SinOsc.kr([7, 1, 2, 0.2, 6]).range(0, 1);
	sig = SinOsc.ar([300, 500, 700, 900, 1100]);
	sig = sig * amp;
	sig = Splay.ar(sig) * 0.25;
	Out.ar(0, sig);
}).add;
)

p = Synth.new(\multi);
p.free;

// un arreglo con cuatro copias iguales
rrand(13, 55)!4;

// un arreglo con cuatro numeros diferentes
{rrand(13, 55)}!4;


// synth con multi expansion
(
SynthDef.new(\multi2, {
	var sig, amp, env;
	env = EnvGen.kr(
		Env.new([0, 1, 0], [10, 10], [-1, 1]),
		doneAction:2
	);
	amp = SinOsc.kr({ExpRand(0.2, 13)}!8).range(0, 1);
	sig = SinOsc.ar({ExpRand(50, 1200)}!8);
	sig = sig * amp;
	sig = Splay.ar(sig) * 0.25;
	Out.ar(0, sig);
}).add;
)

k = Synth.new(\multi2);

k.free;

s.freeAll;
s.scope;
// create a new analyzer
FreqScope.new(400, 200, 0, server: s);
​









