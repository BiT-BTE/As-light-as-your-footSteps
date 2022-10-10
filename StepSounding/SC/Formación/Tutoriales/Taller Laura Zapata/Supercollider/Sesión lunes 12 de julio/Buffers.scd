//BUFFERS

///////Cargar Archivos

Archivos descomprimidos

.wav o .aiff

b = Buffer.loadDialog; // cargar el archivo.

b.postln;
b.numFrames;
b.bufnum;

======================================================
// Reproducción de buffers
//======================================================

// Correr con Control(Comand) Enter
{PlayBuf.ar(1, b.bufnum, 1, 1,0,0,0)}.play;


// Cambio en el rate (velocidade de reproducción)
{PlayBuf.ar(1, b.bufnum, 0.5, 1,0,0,0)}.play;

{PlayBuf.ar(1, b.bufnum, 2, 1,0,0,0)}.play;

b.numFrames;

{PlayBuf.ar(1, b.bufnum, 1, 1, b.numFrames/2,0,0)}.play;

// Tomar la velocidad de muestreo del archivo

{PlayBuf.ar(1, b.bufnum, BufRateScale.kr(b.bufnum) , 1, 0, 1)}.play;


 doneAction es un parámetro del sistema que indica si debemos liberar o no la memoria cuando el buffer termina de reproducirse.

//======================================================
// Modulación de buffers
//======================================================

// Modular amplitud de un Buffer
{SinOsc.ar(3)*PlayBuf.ar(1, b.bufnum, 1, 1,0,0,0)}.play; //la amplitud empieza a oscilar de acuerdo a los valores del seno.

// Modular rate de un buffer o bien la velocidad de lectura de un buffer

{PlayBuf.ar(1, b.bufnum,SinOsc.ar(0.05).poll, 1,0,1,0)}.play;

// Podemos usar el método .poll para ver el valor actual de una señal moduladora.