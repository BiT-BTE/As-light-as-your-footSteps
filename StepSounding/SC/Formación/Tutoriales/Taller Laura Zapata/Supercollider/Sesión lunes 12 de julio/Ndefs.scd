
(
SynthDef(\alonso,{arg piu=48;
 var snd, freq;
	freq = \freq.kr(440) * (Env.perc(0.001, 0.08, curve: -1)).ar*piu.midiratio;
	snd=Saw.ar(freq);
	Out.ar(0,snd);
}).add;
)

~a=Synth(\alonso);
~a.set(\piu, 20);
~a.set(\gate, 0);

~a.free;

(
Ndef(\alonso1,{arg piu=48, amp=0.2, pospan=0;
 var snd, freq, pan;
	freq = \freq.kr(440) * (Env.perc(0.001, 0.08, curve: -1).circle(2)).ar*piu.midiratio;
	snd=Saw.ar(freq,amp);
	pan= Pan2.ar(snd,pospan);
	Out.ar(0,pan);
}).add;
)

Ndef(\alonso1).gui;

Ndef(\alonso1).clear;

(
Ndef(\mic,{| mul=0.08,maxdelay=5, delaytime=6, room=0.3,freq=20|
	var sin,reverb;
	sin =DelayL.ar(SoundIn.ar(0,mul)*SinOsc.ar(freq),maxdelay, delaytime,mul);
	reverb= FreeVerb.ar(sin,0.33,room,mul);
	Out.ar(0,Pan2.ar(reverb,0));
}).add;
)



Ndef(\mic).gui;

Ndef(\mic).clear;