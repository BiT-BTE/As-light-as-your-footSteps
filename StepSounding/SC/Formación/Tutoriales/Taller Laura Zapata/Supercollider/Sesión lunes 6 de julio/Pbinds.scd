//PBINDS

Los Pbinds son una estructura de Supercollider que nos permiten asociar los valores producidos por un patrón con símbolos que representan parámetros del sonido, como por ejemplo, los argumentos de un sintetizador.






// Ejemplo
(
// Usemos este sinte                                                                                     /////SynthDef por UNAM
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
~dng.set(\freq, 1170);          // cambiamos la frecuencia
~dng.set(\gate, 0);             // echamos a andar el segmento de
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





// Eventos por defecto
// ------------------------------------------------------



// Controles del tiempo del Default Event.

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


// Dur
// ------------------------------------------------------
(
Pbind(
	\instrument, \dong,
	\freq, Pseq([ 220, 220*5.midiratio, 220 ], inf),
	\amp, Pseq([ 1, 0.6, 0.8 ], inf),
	\dur,  Pseq([1, 0.75, 0.25, 0.5], inf)
).play
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
a = Pbind(
	\instrument, \dong,
	\freq, Pseq([ 220, 220*12.midiratio, 220*7.midiratio, 220*5.midiratio], inf),
	\amp, Pseq([ 0.5, 0.9, 0.7, 0.7, 1 ], inf),
	\dur, Pseq([0.5, 0.375, 0.125, 0.25, 0.25,0.25], inf),
	\legato, 1.75,
	\stretch, 2

);
)


(
b = Pbind(
	\instrument, \dong,
	\freq,Pseq([110, 110*(-12.midiratio), 110*12.midiratio], inf),
	\amp, Pseq([ 0.5, 0.9, 0.7, 0.7, 0.6, 1 ], inf),
	\dur, Pseq([0.5, 0.375, 0.125, 0.25, 0.25,0.25], inf),
	\legato, 1.0,
	\stretch, 4
);
)


(
a.play(quant:3);
b.play(quant:1);
)



//Controles de Tono.
// ------------------------------------------------------

// degree
//degree difine el grado de nota por una escala
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

Scale.directory

~scale = Scale.harmonicMinor.degrees

(
b = Pbind(
	\instrument, \dong,
	\octave, 2,
	\scale, ~scale,
	\degree,Pseq([0,1,2,3,4,5,6], inf),
	\amp, 0.7,
	\dur, 0.25,
	\legato, 1.25,
).play;
)

// Midi Note

\midinote, define una nota en la escala midi (0 al 127).
(
b = Pbind(
	\instrument, \dong,
	\midinote,Pseq([48,49,50,51,52,53,54,55,56,57,58,59,60], inf),
	\amp, 0.7,
	\dur, 1,
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
	\stretch, 1.5 //Declara un valor que multiplica la duración, escalando su valor por esa magnitud.

)
);

(
b = Pbind(
	\instrument, \dong,
	\octave, 3,  // define el número de octava en el que nos encontramos
	\scale, ~scale, //escala
	\degree,Pseq([-5, 6, -6, 2], inf),
	\amp, Pseq([ 0.5, 0.9, 0.7, 0.7, 0.6, 1 ], inf),
	\dur, Pseq([0.25, 0.5, 0.25, 0.5] , inf),
	\legato, 1.75,
	\stretch, 3
)
)
)


// otros:
/*\root, define tónica del o al 11 en escala cromática.
\note, nota escrita en una escala del 0 al 11 (pitch class).
\freq, frecuencia de un sonido con tono. */

(
a.play(quant:0);
b.play(quant:8);
)



//======================================================
// Ejemplos de patrones


veamos patrones que generan valores con distintas distribuciones de probabilidad, lo cual, nos implica diferentes tipos de sonidos.

Silencio→ \r
Pseq→ valores de lista uno a uno.
Pshuf → nos regresa una permutación del mismo que la repite "n" veces.
Prand→ toma un arreglo y elige uno de los elementos al azar.
Pxrand → Similar a Prand pero no repite ningún emento dos veces seguidas.
Ejercicio: aplicarlo en ritmo.



//  pseq
(
Pbind(
	\note, Pseq([0,3,7,12,3,7,12,15,7,12,3,7],7),
	\dur, 0.25
).play;
)

// Pshuf
(
Pbind(
	\note, Pshuf([0,3,7,12],8),
	\dur, 1/8
).play;
)

// Ejemplo Permutaciones de [1,2,3]
[1,3,2];
[2,1,3];
[2,3,1];
[3,1,2];
[3,2,1];

// Prand
(
Pbind(
	\note, Prand([0,3,7,12],inf).poll,
	\dur, 1/8
).play;
)

// Pxrand
(
Pbind(
	\note, Pxrand([0,\r,4,\r,9,10,\r],inf).poll,
	\dur, 1/8
).play;
)

// Para duraciones
(
Pbind(
	\note, 0,
	\dur,Pxrand([0.5,0.5,0.25,0.25,1]/2,inf).poll,
).play;
)

//======================================================
// Distribuciones de probabilidad

Pbrown→ movimiento browniano para la generación de sus elementos. se debe indicar el límite superior e inferior, tamaño de paso y el número de elementos que deseamos.
Pwhite→ nos devuelve valores con una distribución uniforme entre dos números. Es decir, que los números entre los límites tienen la misma posibilidad de aparecer.
Pgauss→ Existe una tendencia a elegir valores en el centro de un rango de acuerdo a la gráfica conocida como campana de Gauss.


// Pbrown
(
Pbind(
	\note, Pbrown(0,12,1,inf), //un paso en medios tonos.
	\dur, 1/8
).play;
)

// Movimiento por terceras menores en un rango de 2 octavas
(
Pbind(
	\note, Pbrown(-12,12,3,inf).poll, //3 son terceras menores, en un rango de dos octavas.
	\dur, 1/8,
).play;
)

// Dinámicas graduales con Pbrown
(
Pbind(
	\note, Pseq([0,2,4,5,7,9,10,12]++[2,4,5,7,9,10].reverse,inf), //concatenación de escala mayor.
	\dur, 1/8,
	\amp, Pbrown(0,1,0.1,inf).poll
).play;
)

// Concatenación de arreglos
[1,2,3]++[4,5,6];

//======================================================
// Pwhite


(
Pbind(
	\note, Pwhite(0,12,inf).poll,
	\dur, 1/8
).play;
)

// Aleatorios con decimales
(
Pbind(
	\note, Pwhite(0,12.0,inf).poll, // con decimales serían equivalentes a microtones en el ámbito musical.
	\dur, 1/8,
).play;
)

// Distribución gausiana
(
Pbind(
	\note, Pgauss(0,3,inf).asInt.poll,
	\dur, 1/8
).play;
)

// Diferente desviación
(
Pbind(
	\note, Pgauss(0,10,inf).asInt.poll,
	\dur, 1/8
).play;
)

//======================================================
// Patrones de repetición


Pstutter → uno le indica un patrón base y un número de repeticiones que indica que cada nuevo elemento se repetirá ese número de veces.
Pn → Pn es otro patrón es similar a stutter, pero con la diferencia que no repite cada elemento un número n de veces, sino que repite el patrón completo.
Pseries→ nos genera una lista, comenzando en un valor y aumentando regularmente con un tamaño de paso especificado. Por ejemplo, para generar una escala cromática, podríamos comenzar en 0, con un paso de 1 y terminar a los 12 elementos, como en este ejemplo.



// Stutter
(
Pbind(
	\note, Pstutter(1, Pseq([0,2,3,5,7],inf)).poll,
	\dur, 1/4
).play;
)

(
Pbind(
	\note, Pstutter(2, Pseq([0,2,3,5,7],inf)).poll,
	\dur, 1/8
).play;
)

(
Pbind(
	\note, Pstutter(3, Pseq([0,2,3,5,7],inf)).poll,
	\dur,1/6
).play;
)

(
Pbind(
	\note, Pstutter(4, Pseq([0,2,3,5,7],inf)).poll,
	\dur,1/8
).play;
)

// Sutter para otros patrones
(
Pbind(
	\note, Pstutter(3, Pbrown(0,12,1)).poll,
	\dur,1/6
).play;
)

//======================================================
// Repetición de secciones


// Pn
(
Pbind(
	\note, Pn(Pwhite(0,12,4),5).poll,
	\dur, 1/8
).play;
)

// Generación de series
(
Pbind(
	\note, Pseries(0,1,12).poll,
	\dur, 1/8
).play;
)

// Serie de intervalos de tercera
(
Pbind(
	\note, Pseries(0,3,12)++Pseries(30,-3,12).poll,
	\dur, 1/10
).play;
)

// Sintaxis del Pdef
(
Pdef(\nombre,
	Pbind(
     \instrument, \default,
     \degree, Pseq([0,3,4,7,5,1,0], inf)
)
);
)

Pdef(\nombre).play
Pdef(\nombre).stop


//------------------------------------------------
(
~pd1 = Pdef(\nombre, Pbind(
     \instrument, \default,
     \degree, Pseq([0,3,4,7,5,1,0], inf)
));
)

~pd1.play
~pd1.stop

//---------------------------------------------------------
(
~pd1 = Pdef(\nombre, Pbind(
     \instrument, \default,
     \degree, Pseq([0,3,4,7,5,1,0], inf),
	\dur, Pseq([0.25, 0.25, 0.75, 0.25, 0.5], inf)
));
)

//--------------------------------------------------------
(
~pd1 = Pdef(\nombre, Pbind(
	\instrument, \default,
	\degree, Pseq([0,3,4,7,\r,5,1,7], inf),
	\dur, Pseq([0.25, 0.25, 0.75, 0.25, 0.5], inf),
	\legato, 0.5,
	\amp, 0.4)
)
);

//--------------------------------------------------------

~rt = [0.25, 0.25, 0.75, 0.25, 0.5].reverse

(
~pd2 = Pdef(\nombre2, Pbind(
     \instrument, \default,
	\degree, Pseq(3+[0,3,4,7,\r,5,1,7], inf),
	\dur, Pseq(~rt, inf),
	\legato, 0.25,
	\amp, 0.4
));
)

~pd1.play;
~pd2.play;

~pd1.stop;
~pd2.stop;


///Pdef


Un Pdef asocia un Pbind, o un patrón, con un símbolo que lo identifica. Después podemos utilizar los Pdefs para asociarlos con un reloj, un TempoClock, que nos ayuda a cuantizar el sonido que está produciendo el patrón.
La sintaxis es simple, escribimos Pdef y abrimos un paréntesis. Dentro vamos a definir el símbolo que va a ser el identificador con el cual se registrará nuestro patrón. Separado por una coma, agregamos el Pbind y cerramos el paréntesis.
Nos permite ejecutar el Pbind, podemos actualizarlo y cambiar los patrones que alimentan sus valores sin necesidad de parar el instrumento o que se nos acumulen los sonidos.


// Sintaxis del Pdef
(
Pdef(\nombre,
	Pbind(
     \instrument, \default,
     \degree, Pseq([0,3,4,7,5,1,0], inf)
)
);
)

Pdef(\nombre).play
Pdef(\nombre).stop


//------------------------------------------------
(
~pd1 = Pdef(\nombre, Pbind(
     \instrument, \default,
     \degree, Pseq([0,3,4,7,5,1,0], inf)
));
)

~pd1.play
~pd1.stop

//---------------------------------------------------------
(
~pd1 = Pdef(\nombre, Pbind(
     \instrument, \default,
     \degree, Pseq([0,3,4,7,5,1,0], inf),
	\dur, Pseq([0.25, 0.25, 0.75, 0.25, 0.5], inf)
));
)

//--------------------------------------------------------
(
~pd1 = Pdef(\nombre, Pbind(
	\instrument, \default,
	\degree, Pseq([0,3,4,7,\r,5,1,7], inf),
	\dur, Pseq([0.25, 0.25, 0.75, 0.25, 0.5], inf),
	\legato, 0.5,
	\amp, 0.4)
)
);

//--------------------------------------------------------

~rt = [0.25, 0.25, 0.75, 0.25, 0.5].reverse

(
~pd2 = Pdef(\nombre2, Pbind(
     \instrument, \default,
	\degree, Pseq(3+[0,3,4,7,\r,5,1,7], inf),
	\dur, Pseq(~rt, inf),
	\legato, 0.25,
	\amp, 0.4
));
)

~pd1.play;
~pd2.play;

~pd1.stop;
~pd2.stop;