/*
Composición algorítmica con supercollider
Cristian Bañuelos y Mauro Herrera

Módulo 1, video 3

RECORDATORIOS IMPORTANTES
Para correr una línea o ejecutar sonido correr
Control Enter en Windows y Linux
Comand Enter en Mac

Para detener el sonido
Control Punto en Windows y Linux
Comand Punto en Mac
*/

// Convierte una nota MIDI a frecuencia
69.midicps

// Convierte una frecuencia a nota MIDI
440.cpsmidi

// Llena un arreglo con 10 elementos aleatorios entre 20 y 80
~arr = Array.fill(10, {rrand(20, 80).midicps})

// UGens
UGen

// audio rate y Control rate

// AUDIO

64 samples por bloque

// CONTROL

1 sample por cada 64 samples de audio

// Ejemplos de Ugens

// SinOsc.ar()
{SinOsc.ar(432, 0 ,0.2)}.play

// Saw.ar()
{Saw.ar(432,MouseX.kr(0,1),MouseY.kr(-1,1))}.scope

// Pulse
{Pulse.ar(210,MouseX.kr(0,1))}.scope

// Impulse
{Impulse.ar(30)}.scope

// Dust
{Dust.ar(30)}.scope

// SoundIn
{SoundIn.ar(0)*SinOsc.ar(MouseX.kr(80,640).poll)}.play



