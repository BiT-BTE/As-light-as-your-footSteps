//// T7 Architecture

s.boot;
s.plotTree;
s.meter;

(
SynthDef.new(\blip, {
	arg out, fund=300, dens=2, decay=0.2;
	var freq, trig, sig;
	freq = LFNoise0.kr(3).exprange(fund, fund).round(fund);
	sig = SinOsc.ar(freq) * 0.25;
	trig = Dust.kr(dens);
	sig = sig * EnvGen.kr(Env.perc(0.01, decay), trig);
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
s.options.numOutputBusChannels = 2;
s.options.numInputBusChannels = 2;

s.reboot;

y = Synth.new(\reverb, [\in, 6]);
x = Synth.new(\blip, [\out, 6]);

x.set(\out, 25);
y.set(\in, 25);

x = Synth.new(\blip, [\out, ~reverbBus2]);
y = Synth.new(\reverb, [\in, ~reverbBus2]) ;


~reverbBus = Bus.audio(s, 1);
~reverbBus.index;

~reverbBus2 = Bus.audio(s, 2);
~reverbBus3 = Bus.audio(s, 3);
~reverbBus3.index;

s.freeAll;

x = Synth.new(\blip, [\out, ~reverbBus2], ~sourceGrp);
y = Synth.new(\reverb, [\in, ~reverbBus2], ~fxGrp);

~sourceGrp = Group.new;
~fxGrp = Group.after(~sourceGrp);

//////// order of execution

8.do{
	Synth.new(
	\blip,
	[
		\out, ~reverbBus2,
		\fund, exprand(60, 300).round(30)
	],
	~sourceGrp
);
}

~sourceGrp.set(\decay, 0.3);
~sourceGrp.set(\dens, 0.5);

~sourceGrp.freeAll;