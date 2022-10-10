//// T7 Architecture

s.boot;
s.plotTree;
s.meter;

(
SynthDef.new(\blip, {
	arg out;
	var freq, trig, sig;
	freq = LFNoise0.kr(3).exprange(300, 1200).round(300);
	sig = SinOsc.ar(freq) * 0.25;
	trig = Dust.kr(2);
	sig = sig * EnvGen.kr(Env.perc(0.01, 0.2), trig);
	sig = Pan2.ar(sig, LFNoise1.kr(10));
	Out.ar(out, sig);
}).add;

SynthDef.new(\reverb, {
	arg in, out = 0;
	var sig;
	sig = In.ar(in, 2);
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2);
	Out.ar(out, sig);
}).add;

)

s.options.numAudioBusChannels;
s.options.numOutputBusChannels = 4;
s.options.numInputBusChannels = 2;

s.reboot;

y = Synth.new(\reverb, [\in, 6]);
x = Synth.new(\blip, [\out, 6]);

x.set(\out, 25);
y.set(\in, 25);

x = Synth.new(\blip, [\out, ~reverbBus2]);
y = Synth.new(\reverb, [\in, ~reverbBus2]);


~reverbBus = Bus.audio(s, 1);
~reverbBus.index;

~reverbBus2 = Bus.audio(s, 2);
~reverbBus3 = Bus.audio(s, 1);
~reverbBus3.index;

s.freeAll;


//////// order of execution


