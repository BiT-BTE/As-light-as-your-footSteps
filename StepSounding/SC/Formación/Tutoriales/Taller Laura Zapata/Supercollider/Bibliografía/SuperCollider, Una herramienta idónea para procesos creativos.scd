"SuperCollider: Ambiente de programación"


SuperCollider, es un ambiente de programación diseñado para la creación musical y de arte sonoro. Consiste en dos partes principales; un servidor de síntesis al que llamaremos "SC sint" y al ambiente de programación conocido como "SC lang".

///////////Partes:

Lado izquierdo: Pantalla para escribir el código.
Lado derecho superior: Menú de ayuda.
Lado derecho inferior: Consola (muestra información útil de los procesos que se ejecutan).

//////////Para iniciar servidor:

 Este comando permite que la comunicación interna entre "SC sint" y "SC lang" comiencen a funcionar.

CTRL + b

ir al menú "Server", "Boot Server"

s=Server.internal //servidor interno, la ventaja es que corre mejor, hay mejor comunicación.
s.boot
s.quit


s=Server.local //servidor local, corre con la misma máquina de la aplicación, la ventaja es que si se cae el servidor la aplicación sigue corriendo.
s.boot
s.quit

/////////Familiarización con el ambiente:

"hola mundo".postln;

2+3;
10/4;
3.5*8;
2**8;
3+10/2;

1<2

0.0323>0.2

"hola"=="ola"

IMPORTANTE: siempre terminar cada línea de SC con ;

Para ejecutar una línea de comando basta con escribir en el lado izquierdo el código que deseamos y presionar "control enter", en Linux y Windows o "comand enter" en Mac.


////////Variables

a= 5;
b= 3;
c= a+b;

Variables globales

Una diferencia, es que éstas pueden definirse en cualquier parte del código y son accesibles a todas las funciones.

~variable1 = 5;
~variable2 = 10;
~resultado= ~variable1 + ~variable2;
~resu



ltado.postln;

Bloque de código

Basta con abrir un paréntesis al inicio y otro al final.

//Nota inventar juego con mensajes Osc.

(
~nombre = "moco";
~apellido = "asqueroso";
~completo= ~nombre + ~apellido;  //se usa la suma para concatenarlas
~completo.postln;
)

Las variables de texto se conocen como Strings.

/////Arreglos

Listas donde podemos guardar una colección de valores de forma indexada, es decir, cada elemento de la lista tiene un número que identifica su posición.

Se cuentan desde 0.

El primer elemento tiene un índice 0, el segundo 1, el tercero 2, el cuarto 3, etc.

~lista = [20, 3,15];

~lista[0]
~lista[1]
~lista[2]

~lista[5] // no hay valor

Tamaño de una lista

~lista.size

////Agregar valores

~listaNueva = Array.new(10); //inidica cuántos valores queremos agregar.

~listaNueva.add(2)
~listaNueva.add(5)
~listaNueva.add("cosa")
~listaNueva.add(8.2)
~listaNueva.add(9)
~listaNueva.postln;

//Suma de elementos

[1,2,3]+10 //suma número a todos los elementos o transposición en el sentido musical.

//Orden

[20,10,30,9].sort

//Retrógrado

[1,2,3,4].reverse


////////Funciones

Utilizamos funciones para guardar una serie de pasos u operaciones, que los reutilizaremos de forma seguida. Podemos identificar una función por el uso de corchetes. Tenemos tres partes de una función que son muy importantes. La primera, es el nombre. La segunda, son los argumentos de entrada y la tercera, es el resultado de la misma.
}

//definir una función

(

~suma = {arg x,y;
          //vacía

~suma = {arg x,y;
	var resultado; //variable interna
	resultado = x+y;
}
)
(
{SinOsc.ar(MouseButton.kr(80,432),0,MouseX.kr(0.1,0.8),0)!2}.scope;

(
~Ecuipo=
SynthDef.neu(\Ecuipo,{arg freq=440, mul=0.5;
	var sin;
	sin=SinOsc.ar(freq,mul);
	Out.ar(1,sin);
}).play;
)
	Sen(f)*1

//llamar a la función

~suma.value(5,8)


(
~promedio = { arg x=8, y= 9, z=10; //si no hay parámetros se usan por default
	var resultado;
	resultado = (x+y+z)/3;
};
~promedio.value();
)

~promedio.value(5,6,4)

//Convertir frecuencia a número MIDI

(
~freq2midi = {arg freq;
	var resultado;
	resultado = 69+ (12*log2 (freq/440));
	resultado;
}
)

~freq2midi.value(440)
~freq2midi.value(240)
~freq2midi.value(800)

//De MIDI a frecuencia

(
~midi2freq= {arg notaMidi;
	var resultado;
	resultado = (2**((notaMidi-69)/12))*440; //**a la potencia
	resultado;
}
)

~midi2freq.value(40)
~midi2freq.value(69)


/////MÉTODOS


69.midicps; // objeto.método;

440.cpsmidi;

//aplicar métodos a un arreglo

~arr = Array.fill (10,{rrand(20,80)})
~arr = Array.fill (10,{rrand(20,80).midicps}) //pretendemos llenar un array con números aleatorios entre 20 y 80, después convirtiendo las notas midi a freceuncias.

Array.fill(size,función)

////Ugens


/* Ugens --> Unid Generators, son objetos que producen algún tipo de señal como SinOsc, Pulse, Saw, LFTri, cuando se conecta varios de ellos se crean Patches.

                       TIPOS DE UGENS
                                      --> AUDIO RATE .ar


                                     Corre a velocidad de audio = 44100 muestras por segundo.  Se usa para la cadena de audio que se va
                                     a escuchar.

                                    --> CONTROL RATE .kr


                                    Corre a velocidad de control, produce 1 muestra cada 64 muestras hechas por un Ugen .ar. Eso quiere
                                    decir que cada segundo hace 689.0925 muestras de Ugen de Control.

                                    Los usamos como moduladores, es decir le da forma a la señal de audio.*/
{Pulse.ar (700,0.5,0.1) !2}.scope

/*Pulse es una onda cuadrada solo funcional con .ar

{Pulse.ar (frecuencia,ancho de banda,multiplicación) !2}.scope

Ancho de banda= Es el valle de la onda (parte de abajo, periodo apagado, el rango es comprendido como el intervalo abierto (0,1), o por un  número mayor a cero y menor que 1, el default es 0.5 y cuando cambiamos este argumento estamos cambiando el TIMBRE.

--> Pulse es rico en armónicos. */

{Pulse.ar(100,MouseX.kr(0.1,1))!2}.scope

{Pulse.ar(100,0.7,0.3)}.scope // La misma frecuencia pero con el ancho de pulso mayor. La amplitid baja. Nótese que el timbre no varía ya que el ancho de pulso es simétrico con su eje de simetría en 0.5 de tal modo que 0.1=0.9, 0.2=0.8, 0.7=0.3, etc.

{Saw.ar(432,MouseX.kr(0,1),MouseY.kr(-1,1))}.scope //add útil para caso de Modulación de Frecuencia.

{Impulse.kr(30)}.scope //útil para disparar eventos cada cierto tiempo. Parecido a Dust

{SoundIn.ar(0)*SinOsc.ar(MouseX.kr(40,700).poll)}.scope //Cuidado con la retroalimentación, se multiplica por una sinoidal para que solo suene cuando hay señal de entrada.


//RUIDOS


{WhiteNoise.ar(0.19)!2}.scope //señal aleatoria que contiene todas las frecuencias y todas ellas tienen la misma potencia
10
{PinkNoise.ar(0.9)!2}.scope //señal aleatoria que sus contenido de energia por frecuencia disminuye en 3 db por octava.
{BrownNoise.ar(0.8)!2}.scope //señal aleatoria que sus contenido de energia por frecuencia disminuye en 6 db por octava.


//DUST


{Dust.ar(100)!2}.scope//generador de impulsos aleatorios

/*Canales

El sonido análogo o digital puede salir por uno o varios canales. Nosotros estamos acostumbrados a escuchar la música en dos canales que suenan en una bocina cada uno. Esto es conocido como estereofonía y es por eso que al aparato de sonido de nuestro auto o casa le llamamos "el estéreo". Existen aparatos que nos permiten sacar el sonido por más de dos canales. Estos aparatos son conocidos como tarjetas o interfaces de audio. Las hay de 2, 4 u 8 canales por lo menos. Además estas interfaces se pueden conectar entre sí sumando la cantidad de canales. En SuperCollider existen varias clases que nos ayudan a trabajar con los canales de audio por donde queremos que salga nuestro sonido. Aquí veremos 2: Out.ar y Pan2.ar.


Out.ar Out.ar (canal,señal) Saca el sonido por un canal específico. Ese canal específico define un punto de partida u offset a partir del cual se va a distribuir el sonido.

canal: 0 = izq, 1 = der. 3, 4, 5,...multicanal señal: cualquier oscilador que puede estar multiplicado por una envolvente. */

Ejemplos:


{Out.ar(0,Saw.ar(40)*EnvGen.kr(Env.perc(0.01,1),doneAction:2))}.scope  // izquierda
{Out.ar(1,Saw.ar(40)*EnvGen.kr(Env.perc(0.01,1),doneAction:2))}.scope  // derecha

/*Pan2.ar Pan.ar (señal,posición) Distribuye el sonido entre dos canales consecutivos conservando su potencia. Es decir, que
no suena más fuerte cuando esta en los dos canales al mismo tiempo ni más quedito cuando está solo en uno o en otro. Si el Pan2 esta dentro de un Out los canales consecutivos en los que se distribuyen se cuentan a aprtir del offset del Out.

señal: cualquier oscilador o generador de sonido posición: -1 izquierda, 1 derecha y con todo el intervalo continuo extrapolando el sonido entre los dos canales o bocinas.*/

{Pan2.ar(Pulse.ar(100,0.01),MouseX.kr(-1,1))}.scope
{Pan2.ar(Pulse.ar(100,0.01),-0.7)}.scope
{Pan2.ar(Pulse.ar(100,0.01),0)}.scope // En medio.
{Pan2.ar(Pulse.ar(100,0.01),0.3)}.scope
{Pan2.ar(Pulse.ar(100,0.01),1)}.scope
{Out.ar(0,Pan2.ar(Dust.ar(1000),0))}.scope // distribuye la señal entre el canal 0 y 1

{Out.ar(1,Pan2.ar(Dust.ar(1000),0))}.scope // distribuye la señal entre el canal 1 y 2. Si no tenemos una interfase de audio que nos permita expandir los canales solo se va a escuchar al canal 1. Solo tenemos 2 canales en nuestras computadoras que el Collider reconoce como el 0 y el 1.


//MIDIRATIO

.midiratio // convierte intervalos en razones o quebrados
Los intervalos para usar con el mensaje midiratio son expresados en cantidad de semitonos. Está relacionado con el método de Forte para los pitch class sets:

0 = unísono
1 = segunda menor
2 = segunda mayor
3 = tercera menor
4 = tercera mayor
5 = cuarta justa
6 = tritono
7 = quinta justa
8 = sexta menor
9 = sexta mayor
10 = séptima menor
11 = séptima mayor
12 = octava

Los números negativos denotan intervalos descendentes. Entonces para aplicar este mensaje mandamos el mensaje . midiratio al intervalo que deseamos obtener y lo multiplicamos por una frecuencia fundamemntal que nosotros damos. Ejemplo:
440 * 3.midiratio // nos da una tercera menor a partir de La.
440 * -5.midiratio // nos da una carta descendente a partir de La.

[0,1,2,3,4].choose


Diferentes escalas usando el código MIDI.

[60,62,64,65,67,69,71,72].midicps // un array con las notas de la escala mayor
[60,62,63,65,67,68,70,72].midicps // un array con las notas de la escala menor natural
[60,62,64,66,68,70,72].midicps // la escala de tonos enteros
[60,62,63,65,66,68,69.72].midicps // La escala simétrica tono, 1/2tono
[60, 61, 63, 64, 66, 67.72, 71].midicps // La escala simétrica 1/2tono, tono


///////Cargar Archivos

Archivos descomprimidos

.wav o .aiff

~path = thisExecutingPath.dirname +/+ "sonido1.wav"
~buf = Buffer.read(5, ~path );

~buf.plot;

~buf.numFrames;
~buf.bufnum;


======================================================
// Reproducción de buffers
//======================================================

// Correr con Control(Comand) Enter
{PlayBuf.ar(1, ~buf.bufnum, 1, 1,0,0,0)}.play;


// Cambio en el rate (velocidade de reproducción)
{PlayBuf.ar(1, ~buf.bufnum, 0.5, 1,0,0,0)}.play;

{PlayBuf.ar(1, ~buf.bufnum, 2, 1,0,0,0)}.play;

~buf.numFrames;

{PlayBuf.ar(1, ~buf.bufnum, 1, 1,~buf.numFrames/2,0,0)}.play;

// Tomar la velocidad de muestreo del archivo
{PlayB.uf.ar(1, ~buf.bufnum, BufRateScale.kr(~buf.bufnum) , 1, 0, 1)}.play;


 doneAction es un parámetro del sistema que indica si debemos liberar o no la memoria cuando el buffer termina de reproducirse.
//======================================================
// Síntesis
//======================================================

// Visualizador de espectro
FreqScope.new();

// Modular frecuencia de seno con movimiento del Mouse
{SinOsc.ar(MouseX.kr(40,2000))}.play;

// Modular frecuencia de seno con movimiento horizontal del mouse
// Modular amplitud de seno con movimiento vertical del mouse

{SinOsc.ar(MouseX.kr(40,4000),0,MouseY.kr(0,1))}.play;

// Frecuencia Modulada

{SinOsc.ar( SinOsc.ar(1,0,500,1000)  )}.play;

// Poll Imprime los valores de la frecuencia
{SinOsc.ar( SinOsc.ar(1,0,500,1000).poll  )}.play; //está cambiando la frecuencia de 500 a 1000 Hertz

// Intentemos cambiar la frecuencia del modulador a 2
{SinOsc.ar( SinOsc.ar(2,0,500,1000).poll  )}.play;

// Intentemos cambiar la frecuencia del modulador a 10

{SinOsc.ar( SinOsc.ar(10,0,500,1000)  )}.play;

// Intentemos cambiar la frecuencia del modulador a 300
{SinOsc.ar( SinOsc.ar(300,0,500,1000)  )}.play;

// Intentemos cambiar la frecuencia del modulador a 300
{SinOsc.ar( SinOsc.ar(300,0,500,1000)  )}.play;

(
{SinOsc.ar(
	SinOsc.ar(
		MouseX.kr(0,200),
		0,
		MouseY.kr(0,1000),
		1000)
	,0,0.3  )
}.play;
)

//======================================================
// Amplitud Modulada
//======================================================

s.scope;

FreqScope.new;

// AM
// Probemos los siguientes sonidos

{SinOsc.ar( 440,0, SinOsc.ar(1)  )}.play;

// Intentemos cambiar la Amplitud del modulador a 2
{SinOsc.ar( 440,0, SinOsc.ar(2)  )}.play;

// Intentemos cambiar la Amplitud del modulador a 20
{SinOsc.ar( 440,0, SinOsc.ar(20)  )}.play;

// Intentemos cambiar la Amplitud del modulador a 200
{SinOsc.ar( 440,0, SinOsc.ar(200)  )}.play;

// Ahora Cambuemos la frecuencia del modulador con la posición del mouse horizontal
{SinOsc.ar( 440,0, SinOsc.ar(MouseX.kr(0,1000))  )}.play;

//======================================================
// Modulación de Anillo
//======================================================

Señal moduladora mayor o igual a cero

{SinOsc.ar( 440,0, SinOsc.ar(1,0,0.5,0.5)  )}.play;

// Intentemos cambiar la Amplitud del modulador a 2
{SinOsc.ar( 440,0, SinOsc.ar(2,0,0.5,0.5)  )}.play;

// Intentemos cambiar la Amplitud del modulador a 20
{SinOsc.ar( 440,0, SinOsc.ar(20,0,0.5,0.5)  )}.play;

// Intentemos cambiar la Amplitud del modulador a 200
{SinOsc.ar( 440,0, SinOsc.ar(200,0,0.5,0.5)  )}.play;

{SinOsc.ar( 440,0, SinOsc.ar(MouseX.kr(0,1000),0,0.5,0.5)  )}.play;

//======================================================
// Modulación de buffers
//======================================================

// Modular amplitud de un Buffer
{SinOsc.ar(3)*PlayBuf.ar(1, ~buf.bufnum, 1, 1,0,0,0)}.play; //la amplitud empieza a oscilar de acuerdo a los valores del seno.

// Modular rate de un buffer o bien la velocidad de lectura de un buffer
{PlayBuf.ar(1, ~buf.bufnum,SinOsc.ar(0.05).poll, 1,0,1,0)}.play;
// Podemos usar el método .poll para ver el valor actual de una señal moduladora.

// Señal estereo
{ SinOsc.ar([400,800])}.play;

{ [SinOsc.ar(300), Saw.ar(400)] }.play; //elementos de un arreglo más grande

{ [SinOsc.ar(300), Saw.ar(400), LFTri.ar(500)] }.scope;

//======================================================
// Grabación de audio
//======================================================

// Comenzar grabación
Server.default.record;

// Terminar grabación
Server.default.stopRecording


// Sintáxis de un SynthDef

SynthDef(\simbolo, {función}).add

s.boot


// Ejemplo:
// --------------------------------------------------------
(
SynthDef(\sinte1, {|freq = 330, amp = 0.4|
	var sin;

	sin = SinOsc.ar(432,0,0.2);
	Out.ar(0, sin); // Se usa para mandar la señal al bus de salida.

}).add
)

// "Out.ar" es un objeto de suma importancia. Es el objeto que dirige las señales hacia el canal de salida de la tarjeta de audio que va a producir el sonido. Generalmente, utilizamos los dos primeros canales, comenzando a contar desde cero. Cero es el primer canal y uno, el segundo.

//Los argumentos están definidos dentro de un par de barras verticales y nos dan acceso a los valores que denotan para cambiarlos, una vez que el sintetizador se echa a andar.

~snt1 = Synth(\sinte1);
~snt1.set(\gate, 1);
// --------------------------------------------------------

// Envolventes
// --------------------------------------------------------
Env.adsr(1, 0.2, 0.8, 5).plot
EnvGen.kr(Env.adsr(1, 0.2, 1, 5), gate, doneAction:2)

// --------------------------------------------------------
(
SynthDef(\sinte1, {|freq = 330, gate = 1, amp = 0.4|  //es necesario poner gate =1 para activar el SynthDef.
	var sin, env;

	env = EnvGen.kr(Env.adsr(1,0.2,1,5), gate, doneAction:2);
	sin = SinOsc.ar(432,0,0.2);
	Out.ar(0, sin*env);  // recordemos que una multiplicación implica un escalamiento de la señal.

}).add
)

~snt1 = Synth(\sinte1);
~snt1.set(\gate, 0);
// --------------------------------------------------------

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
	sin = SinOsc.ar(432,0,0.2);
	pan = Pan2.ar(sin, MouseX.kr(-1, 1)); //Pan2 crea un tipo de paneo llamado "equal power pan" que mantiene la intensidad sonora percibida en un mismo nivel para cualquier posición de sonido.
	//pan = LinPan2.ar(sin, MouseX.kr(-1, 1)); // baja de intensidad

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

	env = EnvGen.kr(Env.adsr(0.5, 0.2, 1, 5), gate, doneAction:2);

	modulador = SinOsc.ar(freqMod, 0, deltaFreq);
	portadora = SinOsc.ar(freqPorta+modulador, 0, 1);
	pan = Pan2.ar(portadora, MouseX.kr(-1, 1));


	Out.ar(0, pan*amp*env);

}).add
)


~fm = Synth(\fm);
~fm.set(\freqMod, 363);
~fm.set(\freqPorta, 207);
~fm.set(\deltaFreq, 350);
~fm.set(\gate, 0);

//======================================================
// Rutinas y cíclos

~r = Routine({});

(
~r = Routine({
	"Hola".postln;
	1.wait;
	"cómo".postln;
	1.wait;
	"está".postln;
	1.wait;
	"su".postln;
	1.wait;
	"cabeza".postln;
	2.wait;
	"Fin de textos".postln;
});
)

~r.play;

~r.reset; // para reiniciar

~r.stop;

//======================================================
// Rutinas y Synths


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
	Synth(\sin,[\freq,62.midicps]);
	(rrand(0.25,1)).wait;
	Synth(\sin,[\freq,64.midicps]);
	(rrand(0.25,1)).wait;
	Synth(\sin,[\freq,65.midicps]);
	(rrand(0.25,1)).wait;
	Synth(\sin,[\freq,67.midicps]);
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

~lista = [20,30,50,80];

// Cíclo vacío
~lista.do({});

//nos permite recorrer cada uno de los elementos de la lista y realizar alguna operación o función con ellos.

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

// Cíclo que imprime índice y último elemento
(
~lista.do({arg val, indice; //recordemos que los índices empiezan desde 0. Ej en este caso [20-->ind:0; 30 -->ind:1; 50--> ind:2; 80--> ind:3]
	"------".postln;
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
	40.do({arg val; //es necesario poner 40 para optener valores MIDI que podamos escuchar
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
~listaFrecuencias = ~listaMidi.collect({arg val; //collect es parecido a .do pero guarda los resultados en un arreglo
 	val.midicps;
});
)

~listaFrecuencias.postln;

//======================================================
// Streams y Patrones
//======================================================

//Stream es una secuencia de colección de valores como un Array, pero tiene la diferencia de que responden a la función next. Es decir, llevan registro de un valor actual, el cual podemos ir llamando en cada iteración de la función next.

// next, reset

// Patrón Pseq
Pseq([0,4,5],1);

// Stream resultante
Pseq([0,4,5],1).asStream; //Pseq con dos argumentos, un arreglo y el segundo, que son cuántas veces queremos repetir ese arreglo.

// Guardar stream en una variable
~pat = Pseq([0,4,5],1).asStream;

//intenten correr esta línea varias veces
~pat.next;

// Ahora un patrón infinito
~pat = Pseq([0,4,5],inf).asStream;

~pat.next;

// Pedir varios valores al mismo tiempo
~a = ~pat.nextN(10);


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
	\octave, Pseq([Pseq([3], 7),Pseq([4], 7),Pseq([5], 7)], 2),
	\scale, ~scale,
	\degree,Pseq([0,1,2,3,4,5,6], inf),
	\amp, 0.7,
	\dur, 0.25,
	\legato, 1.25,
).play;
)

// Midi Note

\midinote, define una nota en la escala midi (0 al 127).

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
b.play(quant:0);
)


// También hay un pequeño modelo de amplitud.
amp
       Synth amplitude
       (typically ranging from 0 to 1),
       often determined by:

       db
            Amplitude in decibels


//======================================================
// Ejemplos de patrones


// Pbind y pseq
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


// Pbrown
(
Pbind(
	\note, Pbrown(0,12,1,inf).poll, //un paso es medios tonos.
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
	\dur, 1/8
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

t.tempo_(1)


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
	\degree, Pseq([Pseq([0,2,4],3),Pseq([3,5,7],3),Pseq([2,4,6],3)], inf), //se puede anidar
	\dur, Pseq([0.25, 0.25, 0.75, 0.25, 0.5], inf),
	\legato, 0.25,
	\amp, 0.4)
)
);

~pd1.play
~pd1.stop;



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


//Gracias por venir al taller <3 <3



