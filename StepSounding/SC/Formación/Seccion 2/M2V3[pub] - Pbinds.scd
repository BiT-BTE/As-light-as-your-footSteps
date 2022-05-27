/*
Composición algorítmica con supercollider
Cristian Bañuelos y Mauro Herrera

Módulo 2, video 3

RECORDATORIOS IMPORTANTES
Pseq declara un patron con un arreglo y
el número de veces que se repetirá.
Pseq([patron],numRepeticiones)
*/

// Introducción a la secuenciación con Pbinds
// Ambiente.
// ------------------------------------------------------
~vu = 1;
~du = 2;


currentEnvironment

// Identity Dictionary
Environment[ (vu -> 1), (du -> 2)]

// Pares identitarios
// --------------------------------------------------------

(vu -> 1)
(du -> 2)

// --------------------------------------------------------

(
// Se va al servidor
SynthDef(\identificador, {|freq 600, dur 0.7, amp 0.5|
	//función gráfica de UGens
	var sig;

	sig = Blip.ar(freq,
		Line.kr(1, 8, dur, doneAction:2),
		amp)!2 * Decay.ar(Impulse.ar(0), dur);
	Out.ar(0, sig);

}).add
)

Synth(\identificador)

// Se va al cliente
SynthDescLib.global[\identificador]


// Evento
// ------------------------------------------------------

// Ejemplo
(
// Usemos este sinte
d = SynthDef(\dong, {|freq = 220, gate = 1, amp = 0.5|
	var ns, filt, shift, rev, env;

	// Envolvente
	env = EnvGen.kr(Env.asr(0.05, 0.9, 0.25), gate, doneAction:2);

	// Ruido Cafe
	ns =  BrownNoise.ar(0.05)*Decay.ar(Impulse.ar(0), 0.5);

	// Resonador
	filt= Ringz.ar(ns,
		(2*freq*[-12,0,17,43].midiratio)+LFNoise0.kr(16).range(30),
		0.95, 0.3).mean;

	// Pitch Shift
	shift=PitchShift.ar(filt, pitchRatio:0.75)+filt;

	// Reverberation
	rev = FreeVerb.ar(shift, 0.6, 0.75, 0.1)!2;

	Out.ar(0, (rev*env*amp));

}
).add
)


~dng = Synth(\dong);           // Instanciamos el sintetizador
~dng.set(\freq, 770);          // cambiamos la frecuencia
~dng.set(\gate, 0)             // echamos a andar el segmento de
                               // liberación (release)
                               // para quitar el nodo del sinte.

// Sintaxis
// ------------------------------------------------------
(
Pbind(
	\instrument, \dong,    // Declaramos el instrumento que
	                       // queremos que sea controlado
	                       // Su amplitud con un valor
	\amp, 0.7,             // Explícito
	                       // Controlamos su frecuencia con
	\freq, Pseq([ 500, 600, 750 ], inf), // un Patrón
	\dur, Pseq([0.25, 0.75]*0.5, inf)    // Y su duración
).play
)

// Default Event
// ------------------------------------------------------



// Controles del tiempo del Default Event

//delta
        El tiempo hasta el siguiente evento,
        Generalmente determinado por:

       //dur
              El tiempo hasta el siguiente evento en
              una secuencia de eventos.

       //stretch
              Escala los tiempos del evento
              (i.e. stretch == 2,
	          las duraciones son del doble)

//sustain
       La duración del sinte, típicamente
       determinado (en unidades del identificador
	   strech) por:

       //legato
               La relación entre la duración del
               sinte y la duración del evento.







//Ejemplos:
// ------------------------------------------------------

// Delta
(
(
Pbind(
	\instrument, \dong,
	\freq, Pseq([ 220, 220*7.midiratio, 220 ], inf),
	\amp, Pseq([ 1, 0.6, 0.8 ], inf),
	\delta, Pseq([1, 0.75, 0.25, 0.5], inf)
).play
);


// Dur
// ------------------------------------------------------
(
Pbind(
	\instrument, \dong,
	\freq, Pseq(0.75*[ 220, 220*5.midiratio, 220 ], inf),
	\amp, Pseq([ 1, 0.6, 0.8 ], inf),
	\dur,  Pseq(0.5*[1, 0.75, 0.25, 0.5], inf)
).play
)
)


// Legato
// ------------------------------------------------------
(
Pbind(
	\instrument, \dong,
	\freq, Pseq([ 220, 220*7.midiratio, 220*4.midiratio ], inf),
	\amp, Pseq([ 0.5, 0.3, 0.7 ], inf),
	\dur, Pseq([0.5, 0.375, 0.125, 0.25], inf),
	\legato, 0.3
).play
)


// Strech
// ------------------------------------------------------

(
(
a = Pbind(
	\instrument, \dong,
	\freq, Pseq([ 220, 220*12.midiratio, 220*7.midiratio, 220*5.midiratio], inf),
	\amp, Pseq([ 0.5, 0.9, 0.7, 0.7, 1 ], inf),
	\dur, Pseq([0.5, 0.375, 0.125, 0.25, 0.25,0.25], inf),
	\legato, 1.75,
	\stretch, 2

)
);

(
b = Pbind(
	\instrument, \dong,
	\freq,Pseq([110, 110*(-12.midiratio), 110*12.midiratio], inf),
	\amp, Pseq([ 0.5, 0.9, 0.7, 0.7, 0.6, 1 ], inf),
	\dur, Pseq([0.5, 0.375, 0.125, 0.25, 0.25,0.25], inf),
	\legato, 1.0,
	\stretch, 4
)
)
)

(
a.play(quant:3);
b.play(quant:1);
)

//Controles de Tono.
// ------------------------------------------------------

// degree
// ------------------------------------------------------

(
b = Pbind(
	\instrument, \dong,
	\degree,Pseq([0,1,2,3,4,5,6,7], inf),
	\amp, 0.5,
	\dur, 0.25,
	\legato, 1.25,
).play;
)


// scale
// ------------------------------------------------------
Scale.directory
~scale = Scale.harmonicMinor.degrees

(
b = Pbind(
	\instrument, \dong,
	\octave, Pseq([Pseq([3], 7),Pseq([4], 7),Pseq([5], 7)], 2),
	\scale, ~scale,
	\degree,Pseq([0,1,2,3,4,5,6], inf),
	\amp, 0.7,
	\dur, 0.25,
	\legato, 1.25,
).play;
)

// Midi Note
// ------------------------------------------------------
(
b = Pbind(
	\instrument, \dong,
	\octave, Pseq([Pseq([3], 7),Pseq([4], 7),Pseq([3], 7)], inf),
	\scale, ~scale,
	\midinote,Pseq([48,49,50,51,52,53,54,55,56,57,58,59,60], inf),
	\amp, 0.7,
	\dur, 0.25,
	\legato, 1.25,
).play;
)




// Para explorar...
// ------------------------------------------------------
(
~scale = Scale.indian.degrees;
(
a = Pbind(
	\instrument, \dong,
	\octave, 6,
	\scale, ~scale,
	\degree, Pseq([Pseq([0, 5, 3, 3, 0, 0], 2), Pseq([3, 0, 7, 0, 5, 5], 2), Pseq([0, 3, 3, 0, 0, 5], 2)],inf),
	\amp, Pseq([ 0.5, 0.9, 0.7, 0.7, 1 ], inf),
	\dur, Pseq([0.125, 0.25, 0.125, 0.25, 0.125, 0.125], inf),
	\legato, 1.0,
	\stretch, 1.5

)
);

(
b = Pbind(
	\instrument, \dong,
	\octave, 3,
	\scale, ~scale,
	\degree,Pseq([-5, 6, -6, 2], inf),
	\amp, Pseq([ 0.5, 0.9, 0.7, 0.7, 0.6, 1 ], inf),
	\dur, Pseq([0.25, 0.5, 0.25, 0.5] , inf),
	\legato, 1.75,
	\stretch, 3
)
)
)


(
a.play(quant:0);
b.play(quant:0);
)


// También hay un pequeño modelo de amplitud.
amp
       Synth amplitude
       (typically ranging from 0 to 1),
       often determined by:

       db
            Amplitude in decibels




