/*
Composición algorítmica con supercollider
Cristian Bañuelos
Mauro Herrera

Módulo 1, video 1

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
// Introducción
//======================================================

//======================================================

// Partes del ambiente de SuperCollider

//======================================================

//======================================================
// Imprimir a la consola
//======================================================

"hola mundo".postln;

2+3;

10/4;

3.5*3;

2**8;

3+10/2;

//======================================================
// Variables
//======================================================

// Variables
a = 5;
b = 3;
c = a+b;

// Variables globales
~variable1 = 5;
~variable2 = 10;
~resultado = ~variable1 + ~variable2;
~resultado.postln;

// Bloque de código
(
~nombre = "Juan";
~apellido = "Pérez";
~completo = ~nombre + ~apellido;
~completo.postln;
)

//======================================================
// Arreglos
//======================================================

~lista = [20,13,15];

~lista[0];
~lista[1];
~lista[2];

// Obtendremos un error
~lista[5];

// Tamaño de una lista
~lista.size;

// Agregar valores
~listaNueva =  Array.new(10);
~listaNueva.add(2);
~listaNueva.add(5);
~listaNueva.add("cosa");
~listaNueva.add(8.3);
~listaNueva.add(9);
~listaNueva.postln;

//Suma de elementos
[1,2,3]+10;

// Orden
[20,10,30,9].sort;

// Retrógrado
[1,2,3,4].reverse;

//======================================================
// Funciones
//======================================================
(
~suma = {arg x,y;
	// Función vacía
}
)
// Definir una función
(
~suma = {arg x,y;
	var resultado;
	resultado = x+y;
}
)
// Llamar a la función
~suma.value(5,8);

(
~promedio = {arg x=8,y=9,z=10;
	var resultado;
	resultado = (x+y+z)/3;
};
~promedio.value();
)

~promedio.value(5,6,4);

//======================================================
// Ejemplos de funciones
//======================================================

// Convertir frecuencia a número MIDI
(
~freq2midi= {arg freq;
	var resultado;
	resultado = 69+ (12*log2(freq/440));
	resultado;
}
)
~freq2midi.value(440);

~freq2midi.value(240);

~freq2midi.value(800);

// Ahora realicemos MIDI a frequencia
(
~midi2freq= {arg notaMidi;
	var resultado;
	resultado = (2**((notaMidi-69)/12))*440;
	resultado;
}
)
~midi2freq.value(40);

~midi2freq.value(69);

~midi2freq.value(85);

// Números aleatorios
rand(100);

rrand(20,40);

//==========================================
