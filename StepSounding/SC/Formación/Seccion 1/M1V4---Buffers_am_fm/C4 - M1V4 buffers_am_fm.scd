/*
Composición algorítmica con supercollider
Cristian Bañuelos
Mauro Herrera

Módulo 1, video 4

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
// Cargar archivos
//======================================================

~path = thisProcess.nowExecutingPath.dirname +/+"sonido1.wav";

~buf = Buffer.read(s, ~path );

~buf.plot;

~buf.numFrames;

~buf.bufnum;

//======================================================
// Reproducción de buffers
//======================================================

// Correr con Control(Comand) Enter
{PlayBuf.ar(1, ~buf.bufnum, 1, 1,0,0,0)}.play;

// Detener el sonido con
// Control Punto en Windows y Linux
// Command Punto en Mac

// Cambio en el rate (velocidade de reproducción)
{PlayBuf.ar(1, ~buf.bufnum, 0.5, 1,0,0,0)}.play;

{PlayBuf.ar(1, ~buf.bufnum, 2, 1,0,0,0)}.play;

~buf.numFrames;

{PlayBuf.ar(1, ~buf.bufnum, 1, 1,~buf.numFrames/2,0,0)}.play;

// Tomar la velocidad de muestreo del archivo
{PlayBuf.ar(1, ~buf.bufnum, BufRateScale.kr(~buf.bufnum) , 1, 0, 1)}.play;

//======================================================
// Síntesis
//======================================================

// Visualizador de espectro
FreqScope.new();

// Modular frecuencia de seno con movimiento del Mouse
{SinOsc.ar(MouseX.kr(40,4000))}.play;

// Modular frecuencia de seno con movimiento horizontal del mouse
// Modular amplitud de seno con movimiento vertical del mouse

{SinOsc.ar(MouseX.kr(40,4000),0,MouseY.kr(0,1))}.play;

// Frecuencia Modulada

{SinOsc.ar( SinOsc.ar(1,0,500,1000)  )}.play;

// Poll Imprime los valores de la frecuencia
{SinOsc.ar( SinOsc.ar(1,0,500,1000).poll  )}.play;

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
{SinOsc.ar(3)*PlayBuf.ar(1, ~buf.bufnum, 1, 1,0,0,0)}.play;

// Modular rate de un buffer
{PlayBuf.ar(1, ~buf.bufnum,SinOsc.ar(0.05).poll, 1,0,1,0)}.play;
// Podemos usar el método .poll para ver el valor actual de una señal moduladora.

// Señal estereo
{ SinOsc.ar([400,800])}.play;

{ [SinOsc.ar(300), Saw.ar(400)] }.play;

{ [SinOsc.ar(300), Saw.ar(400), LFTri.ar(500)] }.play;

//======================================================
// Grabación de audio
//======================================================

// Comenzar grabación
Server.default.record;

// Terminar grabación
Server.default.stopRecording

