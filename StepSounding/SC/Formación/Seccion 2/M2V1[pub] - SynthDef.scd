/*
Composición algorítmica con supercollider
Cristian Bañuelos y Mauro Herrera

Módulo 2, video 1

RECORDATORIOS IMPORTANTES
Puedes utilizar los paréntesis para
seleccionar un grupo de código y
ejecutarlo
*/


// Sintáxis de un SynthDef

SynthDef(\simbolo, {función}).add;

s.boot


// Ejemplo:
// --------------------------------------------------------
(
SynthDef(\sinte1, {|freq = 330, amp = MouseX.kr(0, 4000, 0.0, 1.0)|
	var sin;

	sin = SinOsc.ar(432,0,0.2);
	Out.ar(0, sin);

}).add
)

~snt1 = Synth(\sinte1);
~snt1.set(\gate, 0);
// --------------------------------------------------------

// Envolventes
// --------------------------------------------------------
Env.adsr(1, 0.2, 0.8, 5).plot
EnvGen.kr(Env.adsr(1, 0.2, 1, 5), gate, doneAction:2)

// --------------------------------------------------------
(
SynthDef(\sinte1, {|freq = 330, gate = 1, amp = 0.4|
	var sin, env;

	env = EnvGen.kr(Env.adsr(1,0.2,1,5), gate, doneAction:2);
	sin = SinOsc.ar(432,0,0.2);
	Out.ar(0, sin*env);

}).add
)

~snt1 = Synth(\sinte1);
~snt1.set(\gate, 0);
// --------------------------------------------------------

// Asignación y liberación de nodos
s.plotTree

~snt1 = Synth(\sinte1);
~snt2 = Synth(\sinte1);
~snt3 = Synth(\sinte1);

~snt1.set(\gate, 0);
~snt2.set(\gate, 0);
~snt3.set(\gate, 0);

// Paneo de una señal
// --------------------------------------------------------
(
SynthDef(\sinte2, {|freq = 330, gate = 1, amp = 0.4|
	var sin, env, pan;

	env = EnvGen.kr(Env.adsr(1,0.2,1,5), gate, doneAction:2);
	sin = SinOsc.ar(432,0,0.2);
	//pan = Pan2.ar(sin, MouseX.kr(-1, 1));
	pan = LinPan2.ar(sin, MouseX.kr(-1, 1));

	Out.ar(0, pan*env);

}).add
)

~snt2 = Synth(\sinte2);
~snt2.set(\gate, 0);

// ---------------------------------------------
// FM:
// Implementación del sinte de FM con el que se
// ejemplifican las funcioens
(
SynthDef(\fm, {|freqMod = 330, freqPorta = 432, deltaFreq = 200, amp = 0.5, gate = 1|
	var env, modulador, portadora;

	env = EnvGen.kr(Env.adsr(0.5, 0.2, 1, 5), gate, doneAction:2);

	modulador = SinOsc.ar(freqMod, 0, deltaFreq);
	portadora = SinOsc.ar(freqPorta+modulador, 0, 1);

	Out.ar(0, portadora*amp*env);

}).add
)


~fm = Synth(\fm);
~fm.set(\freqMod, 363);
~fm.set(\freqPorta, 207);
~fm.set(\deltaFreq, 350);
~fm.set(\gate, 0);
