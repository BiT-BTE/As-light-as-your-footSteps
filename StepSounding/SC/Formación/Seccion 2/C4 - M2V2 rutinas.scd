/*
Composición algorítmica con supercollider
Cristian Bañuelos
Mauro Herrera

Módulo 2, video 2

RECORDATORIOS IMPORTANTES
Para correr una línea o ejecutar sonido correr
Control Enter en Windows y Linux
Comand Enter en Mac

Para detener el sonido
Control Punto en Windows y Linux
Comand Punto en Mac
*/

// Doble diagonal es un comentario de línea

/*
Este es un comentario
de bloque
*/

//======================================================
// Rutinas
//======================================================

~r = Routine({});

(
~r = Routine({
	"Texto 1".postln;
	1.wait;
	"Texto 2".postln;
	1.wait;
	"Texto 3".postln;
	1.wait;
	"Texto 4".postln;
	1.wait;
	"Texto 5".postln;
	2.wait;
	"Fin de textos".postln;
});
)

~r.play;

~r.reset;

~r.stop;

//======================================================
// Rutinas y Synths
//======================================================

(
SynthDef(\sin, {|freq, amp=0.3|
	var sin, env;
	env = EnvGen.kr(
		Env.perc(0.05, 1, 1, -4),
		doneAction:2);
	sin=SinOsc.ar([freq,freq], 0, 1);
	Out.ar(0, sin*amp*env);
}).add;
)

(
~r = Routine({
	Synth(\sin,[\freq,60.midicps]);
	(rrand(0.25,1)).wait;
	Synth(\sin,[\freq,61.midicps]);
	(rrand(0.25,1)).wait;
	Synth(\sin,[\freq,62.midicps]);
	(rrand(0.25,1)).wait;
	Synth(\sin,[\freq,64.midicps]);
	(rrand(0.25,1)).wait;
	Synth(\sin,[\freq,65.midicps]);
	(rrand(0.25,1)).wait;
	"Fin de rutina".postln;
});
~r.play;
)
~r.reset;
~r.play;
~r.stop;

//======================================================
// Cíclos
//======================================================

~lista = [20,30,50,80];

// Cíclo vacío
~lista.do({});

// Cíclo para imprimir los elementos
(
~lista.do({arg val;
	val.postln;
});
)

// Cíclo para imprimir los elementos entre 10
(
~lista.do({arg val;
	(val/10).postln;
});
)

// Cíclo que imprime índice y elemento
(
~lista.do({arg val, indice;
	"----------".postln;
	indice.postln;
	val.postln;
});
)

~nombres = ["Elisa","Mary","Manuel","Carolina"];
(
~nombres.do({arg val, indice;
	"----------".postln;
	indice.postln;
	val.postln;
});
)

//======================================================
// Rutinas y cíclos
//======================================================

// Cíclos sobre números
(
4.do({arg val;
	val.postln;
});
)

// El anterior es equivalente a este.
(
[0,1,2,3].do({arg val;
	val.postln;
});
)

// Rutina que ejectua un cíclo
(
~r = Routine({
	40.do({arg val;
		Synth(\sin,[\freq,(val+40).midicps,\amp,0.3]);
		0.2.wait;
	});
});
~r.play;
)
~r.reset;
~r.play;
~r.stop;

// Cíclo collect

~listaMidi = [60,69,67,62];

(
~listaFrecuencias = ~listaMidi.collect({arg val;
	val.midicps;
});
)

~listaFrecuencias.postln;

//======================================================
// Streams y Patrones
//======================================================

// next, reset

// Patrón Pseq
Pseq([0,4,5],1);

// Stream resultante
Pseq([0,4,5],1).asStream;

// Guardar stream en una variable
~pat = Pseq([0,4,5],1).asStream;

//intenten correr esta línea varias veces
~pat.next;

// Ahora un patrón infinito
~pat = Pseq([0,4,5],inf).asStream;

~pat.next;

// Pedir varios valores al mismo tiempo
~a = ~pat.nextN(10);

