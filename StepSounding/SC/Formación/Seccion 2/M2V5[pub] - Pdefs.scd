/*
Composición algorítmica con supercollider
Cristian Bañuelos y Mauro Herrera

Módulo 2, video 5

RECORDATORIOS IMPORTANTES
Un Pdefs asocia a un Pbind con un símbolo
que nos permite manipularlo en tiemporeal
bajo una misma instancia.
El TempoClock.defalut se hecha a andar cuando
prendes el servidor.
*/

//---------------------------------------------------
// Pdefs
//---------------------------------------------------
(
// Asignamos a una variable para poder manipularlo
~pb1 = Pbind(

	// Utilicemos el instrumento que supercollider
	// tiene por omisión
    \instrument, \default,
	// Y Generemeos un patrón sencillo
    \degree, Pseq([0,3,4,7,5,1,0], inf),
	\amp, 0.5
).play
)

~pb1.stop

//---------------------------------------------------------

(
~pb1 = Pbind(
    \instrument, \default,
    \degree, Pseq([0,3,4,7,5,1,0], inf),
	//Cuando lo quiero editar...
	\dur, Pseq([0.25, 0.75, 0.25, 0.25],inf)
).play
)

~pb1.stop



//---------------------------------------------------------
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
~pd2.play

//---------------------------------------------------------
// Relojes

//---------------------------------------------------------
SystemClock.sched(3, {
	"ya pasaron 3 segundos".postln;
})


//---------------------------------------------------------
(
var dt = 0, nt = 2;

SystemClock.sched(nt, {arg time;
	dt = dt + nt;
	("ya pasaron otros " ++ nt ++ " segundos").postln;
	("y " ++ dt ++" han transcurrido en total").postln;
	("Este es el tiempo desde que inició el sistema:" ++ time).postln;
	nt // El tiempo en que se agendará la siguiente acción
})
)

//--------------------------------------------------------
// Podriamos utilizar este tipo de estructura para agendar sonidos


(
var dt = 0;
~sck = SystemClock.sched(0, {arg time;
	var delta;
	// Escoje un tiempo para reagendar el siguiente evento;
	delta = [0.25, 0.5, 0.75].choose;
	// Manten cuenta del tiempo transcurrido
	dt = dt + delta;
	// Ejecuta un sonido
	{Blip.ar(rrand(42, 60).midicps, Line.kr(1,8,0.5,doneAction:2), 0.2)}.play;
	// Despliega textos en la ventana.
	("ya pasaron otros " ++ delta ++ " segundos").postln;
	("y " ++ dt ++" han transcurrido en total").postln;
	("Este es el tiempo desde que inició el sistema:" ++ time).postln;
	// El tiempo en que se agendará la siguiente acción
	delta
})
)

// Limpiamos la agenda del SystemClock
~sck.clear

//------------------------------------------------------------
// TempoClock


t = TempoClock.default

// ".beats" Nos indica cuantas pulsaciones han pasado desde que se echó a andar
t.beats

// ".tempo" Nos indica en qué tempo está.
t.tempo

//-------------------------------------------------------------

(

(
~pd1 = Pdef(\nombre, Pbind(
	\instrument, \default,
	\degree, Pseq([0,3,4,7,\r,5,1,7], inf),
	\dur, Pseq([0.25, 0.25, 0.75, 0.25, 0.5], inf),
	\legato, 0.25,
	\amp, 0.4)
)
);

(
~pd2 = Pdef(\nombre2, Pbind(
     \instrument, \default,
	\degree, Pseq(2+[0,3,4,7,\r,5,1,7], inf),
	\dur, Pseq([0.25, 0.25, 0.75, 0.25, 0.5].reverse, inf),
	\legato, 0.25,
	\amp, 0.4
));
);

(
~pd3 = Pdef(\nombre3, Pbind(
     \instrument, \default,
	\degree, Pseq(-12+4+[0,3,4,7,\r,5,1,7],inf),
	\dur, Pseq([0.25, 0.25, 0.75, 0.25, 0.5].reverse, inf),
	\legato, 0.25,
	\amp, 0.4
));
)

)
// Agrega al método play una instacia de TempoClock

t = TempoClock.default

(
~pd1.play(t, quant:1);
~pd2.play(t, quant:1);
~pd3.play(t, quant:1);
)
//

t.tempo_(2)


// .........

t.schedAbs(0, {e = TempoClock.new(1, 0)})
e.beats
e.seconds

t.schedAbs(0, {m = TempoClock.new(1, 0)})
m.beats
m.seconds

// ..........

t.beats.postln;
e.beats.postln;
m.beats.postln;

// Imprime el mismo valor

(
~pd1.play(t, quant:1);
~pd2.play(e, quant:1);
~pd3.play(m, quant:1);
)
// Ahora puedes cambiar el tempo da cada reloj por separado

t.schedAbs(t.nextBar, {e.tempo = 6/4});
t.schedAbs(t.nextBar, {m.tempo = 3/4})

t.beats.postln;
e.beats.postln;
m.beats.postln;

// Vuelve a sincronizarlos
t.schedAbs(t.nextBar, {e.tempo = 1});
t.schedAbs(t.nextBar, {m.tempo = 1});
t.schedAbs(t.nextBar, {t.tempo = 1});


~pd1.stop.reset;
~pd2.stop.reset;
~pd3.stop.reset;


// Arreglos para sonar notas simultáneas
(
~pd1 = Pdef(\nombre, Pbind(
	\instrument, \default,
	// Cada arreglo en el Pseq es un acorde
	\degree, Pseq([[0,2,4],[3,5,7],[2,4,6]], inf),
	\dur, Pseq([0.25, 0.25, 0.75, 0.25, 0.5], inf),
	\legato, 0.25,
	\amp, 0.4)
)
);

~pd1.play
~pd1.reset
~pd1.stop

// Patrones de patrones
(
~pd1 = Pdef(\nombre, Pbind(
	\instrument, \default,
	\degree, Pseq([Pseq([0,2,4],3),Pseq([3,5,7],3),Pseq([2,4,6],3)], inf),
	\dur, Pseq([0.25, 0.25, 0.75, 0.25, 0.5], inf),
	\legato, 0.25,
	\amp, 0.4)
)
);

~pd1.play
~pd1.stop;


// Hagamos un ejemplo

// Arreglo con 7 triadas consecutivas

m = Array.fill(7, {|i| (i+[0,2,4])%7})


// Arreglo con 4 Pseqs, cada uno con una copia de m reordenada al azar.

(
~chrSpace = Array.fill(4, {

	var pat = m.scramble;
	pat.postln;
	Pseq(pat,1);

});
)

//-----------------------------------------------------------------------
// Ejemplo con patrones anidados
(
~pd3 = Pdef(\nombre3, Pbind(
	\instrument, \default,
	\octave, Pseq([Pseq([4], 21),Pseq([5],7), Pseq([4], 14),Pseq([5],14)], inf),
	\scale, Pseq(
		[Pseq([Scale.phrygian.degrees], 21),
		Pseq([Scale.mixolydian.degrees],7),
		Pseq([Scale.major.degrees], 14),
		Pseq([Scale.phrygian.degrees],14)
		], inf),
	\degree, Pseq(~chrSpace, inf),
	\dur, Pseq(
		[Pseq([0.25, 0.25, 0.75, 0.25, 0.5, 0.75, 0.25], 3),
		Prand([0.25, 0.25, 0.75, 0.25, 0.5,  0.75, 0.25], 1),
		Pseq([0.75, 0.75, 0.25, 0.25, 0.75, 0.25, 0.5], 3),
		Prand([0.25, 0.25, 0.75, 0.25, 0.5,  0.75, 0.25
			], 1)
	    ], inf),
	\legato, Prand([0.60, 1.25, 0.70, 1.0, 0.9], inf),
	\stretch, 1,
	\amp, 0.5
));
)


~pd3.play
~pd3.stop

PdefAllGui(5)

