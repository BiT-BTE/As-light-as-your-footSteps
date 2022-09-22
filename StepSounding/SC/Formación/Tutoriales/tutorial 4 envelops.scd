// Envelops

s.boot;

s.plotTree;

s.freeAll;

(
{
	var sig, env;
	env = EnvGen.kr(Env.new(
		[0, 1, 0.2, 0],
		[0.5, 1, 2],
		[3, -3, 0]),
	    doneAction:2);
	sig = Pulse.ar(ExpRand(30, 500)) * env;
}.play;
)

Env.new([0, 1, 0.2, 0], [0.5, 1, 2], [3, -3, 0]).plot;


(
x = {
	arg t_gate = 0;
	var sig, env;
	env = EnvGen.kr(Env.new(
		[0, 1, 0.2, 0],
		[0.5, 1, 2],
		[3, -3, 0]),
	    t_gate);
	sig = Pulse.ar(LFPulse.kr(8).range(600, 900)) * env;
}.play;
)

x.set(\t_gate, 1);
x.free;

///// ADSR

(
x = {
	arg gate = 0;
	var sig, env;
	env = EnvGen.kr(Env.adsr, gate);
	sig = VarSaw.ar(SinOsc.kr(16).range(500, 1000)) * env;
}.play;
)

x.set(\gate, 1);
x.free;
s.freeAll;


(
y = {
	arg gate = 0;
	var sig, env, freq;
	freq = EnvGen.kr(Env.adsr(1), gate, 200, 0.1);
	env = EnvGen.kr(Env.adsr, gate, doneAction: 2);
	sig = VarSaw.ar(SinOsc.kr(freq).range(500, 1000)) * env;
}.play;
)

y.set(\gate, 0);
y.free;