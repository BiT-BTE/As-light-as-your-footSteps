////// Tutorial 5 Iteration


(
x = Array.newClear(5);

[6, 4, 0.5, 10, 7].do{
	arg item, count;
	x[count] = item.squared;
}
)

x;

(
z  = [6, 4, 0.5, 10, 7].collect{
	arg item;
	item.squared;
}
)

// condensed form notation

z = [6, 4, 0.5, 10, 7].collect(_.squared);

5.do{arg item; item.postln};

[0, 1, 2, 3, 4].do{arg item; item.postln};


////////////////////// now iteration with music

s.boot;

k = {VarSaw.ar(40!2, 0, 0.05)}.play;

k.free;

(
SynthDef.new(\iter, {
	arg freq = 40;
	var temp, sum, env;
	sum = 0;
	env = EnvGen.kr(
		Env.perc(0.01, 5, 1, -2),
		doneAction:2
	);
	10.do{
		temp = VarSaw.ar(
			freq * {ExpRand(0.99, 1.02)}!2,
			{Rand(0.0, 1.0)}!2,
			{ExpRand(0.005, 0.05)}!2
		);
		sum = sum + temp;
	};
	sum = sum * 0.05* env;
	Out.ar(0, sum);
}).add;
)

k = Synth.new(\iter);
Synth.new(\iter, [\freq, 400]);
Synth.new(\iter, [\freq, 500]);
Synth.new(\iter, [\freq, 600]);
Synth.new(\iter, [\freq, 200]);
Synth.new(\iter, [\freq, 100]);

Synth.new(\iter, [\freq, 66.midicps]);
Synth.new(\iter, [\freq, 67.midicps]);
Synth.new(\iter, [\freq, 68.midicps]);
Synth.new(\iter, [\freq, 70.midicps]);
Synth.new(\iter, [\freq, 72.midicps]);


(
[54, 60, 64, 68].do{
	arg midinote;
	Synth.new(\iter, [\freq, midinote.midicps]);
}
)

(
SynthDef.new(\iter2, {
	arg freq = 200, dev = 1.02;
	var temp, sum;
	sum = 0;
	30.do{
		arg count;
		temp = SinOsc.ar(freq *
			(count + 1) *
			LFNoise1.ar({Rand(0.05, 0.2)}!2).range(dev.reciprocal, dev)
		);
		temp = temp * LFNoise1.kr({Rand(0.5, 8)}!2).exprange(0.01, 1);
		sum = sum + temp;
	};
	sum = sum * 0.05;
	Out.ar(0, sum);

}).add;
)

x = Synth.new(\iter2);

x.set(\freq, 50);
x.set(\dev, 1.05);

// un poco raro esto
(
var i = 10;
var fre = 200;
300.do{
	fre = fre + i;
	x.set(\freq, fre);

};
)

x.free;

k.free;
s.freeAll;