
//Complemetos de la sesión del Lunes, primeras consideraciones

/*CONTROLES*/



Necesitamos saber algunas cosas antes de comenzar.



==> Para prender el servidor:

Command + b (MacOSX)
Control + b (Windows)
Control + b (Linux-gedit)





==> Para correr lineas de código:


Command + Enter (MacOSX)
Control + Enter (Windows)
Control + Enter (Linux-gedit)




==> Para detener el sonido:

Command + punto (MacOSX)
Control + punto (Windows)
Control +punto (Linux-gedit) o Esc





==> Para recurrir a las ayudas de forma inmediata



Seleccionamos el objeto o nos paramos en él +

Command+D  (MacOSX)
Control + D (Windows)
Control + D (Linux-gedit)



==============================================================================================================================================================================================================

/*SINTAXIS*/

//Las llaves { agrupan funciones }
//Los paréntesis (agrupan expresiones)
//Los corchetes [agrupan arreglos o arrays]

==============================================================================================================================================================================================================

/*MÉTODO .play     .scope*/


Las formas más rápida para hacer sonar nuestros primeros osciladores son:


.play  ==> Sin embargo más adelante veremos por qué a veces no resulta ser lo más útil con lo que respecta a un arreglo o composición más elaborada.

.scope ==> Este nos muestra cómo se está comportando la onda a través de un osciloscopio.



==============================================================================================================================================================================================================


/*ARQUITECTURA*/


2. La arquitectura de SuperCollider está definida bajo la metáfora de clasificación taxonómica.


de esta manera:


====> objetos (números y  símbolos. Son elemetos que no importa que tan simples o complejos sean).


======> Clases (La clase describe una familia con elementos similares. Son conjutos de datos y métodos que resumen características comunes para poder clasificar objetos, poderlos declarar y describir cómo se construyen otros objetos "más estructurados". Por ejemplo si hacemos galletas podríamos hacerlas con el mismo molde, pero con diferentes sabor, textura, olor, color etc. Es decir la clase es un tipo de molde.


=======>OBJETO (Es la instancia de la construcción física del objeto.  Es decir recobra materialidad y ocupa un espacio en la memoria de la computadora). Como el oscilador que vimos el lunes pasado (SinOsc.ar)


Tenemos dos principales OBJETOS para poder interacturar y hacer sonido como mejor nos convenga. Estos se llaman Ugens (Unidades generadoras)



	==============================================================================================================================================================================================================



/*UGENS*/



Son objetos que producen algún tipo de señal a lo largo del tiempo, por ejemplo cualquiera de los osciladores que por defecto tiene SuperCollider como SinOsc, Saw, Pulse, LFTri. Si conectamos varios de ellos crearíamos patches.

Tenemos dos principales Ugens.


	    TIPOS DE UGENS
                                      ==> AUDIO RATE .ar


                                     Corre a velocidad de audio = 44100 muestras por segundo.  Se usa para la cadena de audio que se va
                                     a escuchar.

                                    ==> CONTROL RATE .kr


                                    Corre a velocidad de control, produce 1 muestra cada 64 muestras hechas por un Ugen .ar. Eso quiere
                                    decir que cada segundo hace 689.0925 muestras de Ugen de Control.
	                                ==> Estos los usamos como moduladores, es decir le da forma a la señal de audio.



==============================================================================================================================================================================================================




/*OSCILADORES*/


Tipos de osciladores:

==> SinOsc

es un oscilador de onda senoidal. Funciona con .ar y con .kr.

Sus argumentos son : frecuencia, fase, multiplicación y adición. Su sintaxis es como sigue:

SinOsc.ar (frecuencia, fase, mul, add).

Ejemplos:

{SinOsc.ar(440,0,0.5)!2}.play
{SinOsc.ar(440,0,0.5)!2}.scope



==> Pulse

es un oscilador de onda cuadrada. Funciona solo con .ar.

Sus argumentos son frecuencia, ancho de banda, mul y add. Su sintaxis es como sigue:

Pulse.ar (frecuencia, ancho de banda, mul, add)

Ejemplos:

{Pulse.ar (700,0.5,0.1) !2}.play
{Pulse.ar (700,0.5,0.1) !2}.scope


Su argumeto Ancho de banda= Es el valle de la onda (parte de abajo, periodo apagado, el rango es comprendido como el intervalo abierto (0,1), o por un  número mayor a cero y menor que 1, el default es 0.5 y cuando cambiamos este argumento estamos cambiando el TIMBRE.

--> Pulse es rico en armónicos.

{Pulse.ar(100,MouseX.kr(0.1,1))!2}.scope




==> LFTri

Es un oscilador de onda triangular. Funciona con .ar y .kr.

Sus argumentos son frecuencia, mul y add. Su sintaxis es como sigue:

LFTri.ar (frecuencia, fase, mul, add)

Ejemplos:

{LFTri.ar(150,0,0.5)!2}.play
{LFTri.ar(150,0,0.5)!2}.scope



==>Saw

Es un oscilador de onda de sierra. Funciona solo con .ar.

Sus argumentos son frecuencia, mul y add. Su sintaxis es como sigue:

Saw.ar(frecuencia, mul, add)

Ejemplos:

{Saw.ar(150,0.6,0.5)!2}.play
{Saw.ar(150,0.3,0.5)!2}.scope



Ejercicio:



Realiza tus primeros osciladores.


{SinOsc.ar(440,0,0.5)-SinOsc.ar(80,0,0.5,0.5)}.scope


SynthDef(\sine, {Out.ar(0,SinOsc.ar(Rand(440,880),0,0.1))}).add;

Synth(\sine);



