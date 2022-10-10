//SYNTHDEFS

Un sintetizador se compone de varios UGens interconectados o anidadas entre sí, para construir una señal más compleja.

En SuperCollider construimos sintetizadores utilizando la estructura SynthDef. SynthDef define un sintetizador, a partir de un símbolo que lo identifica y la definición de una función gráfica que representa cómo se interconectan los UGens entre sí. Se compila mediante el método ".add", es decir se envía al servidor para añadirlo a la lista de sintetizadores disponibles para sonar. El símbolo o nombre sirve para identificar al tipo de sintetizador y la función gráfica define la relación entre los UGens.



// Sintáxis de un SynthDef

SynthDef(\simbolo, {función}).add

s.boot


// Ejemplo:
// --------------------------------------------------------

(
SynthDef(\sinte1, {|freq = 330, amp = 0.4|
	var sin;
    sin = SinOsc.ar(freq,0,0.2);
	Out.ar(0, sin); // Se usa para mandar la señal al bus de salida.

}).add
)

// "Out.ar" es un objeto de suma importancia. Es el objeto que dirige las señales hacia el canal de salida de la tarjeta de audio que va a producir el sonido. Generalmente, utilizamos los dos primeros canales, comenzando a contar desde cero. Cero es el primer canal y uno, el segundo.

//Los argumentos están definidos dentro de un par de barras verticales y nos dan acceso a los valores que denotan para cambiarlos, una vez que el sintetizador se echa a andar.

~snt1 = Synth(\sinte1);
~snt1.set(\freq, 440);
~snt1.set(\gate, 1);
// --------------------------------------------------------

// Envolventes
// --------------------------------------------------------
Env.adsr(attackTime:0.03,decayTime: 0.5,sustainLevel:0.5, releaseTime:1,curve:-4).plot
EnvGen.kr(Env.adsr(1, 0.2, 1, 5), gate, doneAction:2)


// --------------------------------------------------------
(
SynthDef(\sinte1, {|freq = 330, gate = 1, amp = 0.4|  //es necesario poner gate =1 para activar el SynthDef.
	var sin, env;

	env = EnvGen.kr(Env.perc(0.01,1,0.5,-4.0).circle, gate,doneAction:2);
	sin = SinOsc.ar(freq,0,0.2);
	Out.ar(0, sin*env);  // recordemos que una multiplicación implica un escalamiento de la señal.

}).add
)

~snt1 = Synth(\sinte1);


~snt1.set(\gate, 1);
~snt1.set(\freq, 120);
// --------------------------------------------------------
s.freeAll;
//Para reproducir los sintetizadores, el servidor implementa un esquema de árbol. Ésto le permite mantener organizados los procesos. Cada vez que se reproduce un nuevo sintetizador, le asigna un número al nodo donde se está reproduciendo. Si se reproducen más sintetizadores, los números se van añadiendo de manera consecutiva.

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
	sin = SinOsc.ar(432,0,0.5);
	//pan = Pan2.ar(sin, MouseX.kr(-1, 1)); //Pan2 crea un tipo de paneo llamado "equal power pan" que mantiene la intensidad sonora percibida en un mismo nivel para cualquier posición de sonido.
	pan = LinPan2.ar(sin, MouseX.kr(-1, 1)); // baja de intensidad

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
	var env, modulador, portadora, pan;

	env = EnvGen.kr(Env.adsr(0.5, 0.2, 1, 2), gate, doneAction:2);

	modulador = SinOsc.ar(freqMod, 0, deltaFreq);
	portadora = SinOsc.ar(freqPorta+modulador, 0, 1);
	pan = Pan2.ar(portadora, MouseX.kr(-1, 1));


	Out.ar(0, pan*amp*env);

}).add
)


~fm = Synth(\fm);
~fm.set(\freqMod, 363);
~fm.set(\freqPorta, 207);
~fm.set(\deltaFreq, 100);
~fm.set(\gate, 0);