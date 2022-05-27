/*
Actividad por pares 1.
UGens en SuperCollider.


Esta primera actividad de nuestro curso tiene como propósito ejercitar la sintaxis de SuperCollider y asegurarnos de que puedes hacer sonar UGens en el servidor.
Esto será útil para familiarizarnos con los objetos y herramientas que servirán de base a los siguientes módulos.

A continuación se enumeran los pasos a seguir para lograr los objetivos de esta actividad:
*/


// 1) Asegúrate de inicializar servidor con el comando Boot Server, que se encuentra en el menú Server, o ejecutando la siguiente línea de código: s.boot;

// aquí inicilizo el frecuenciometro y el scope
s.boot;
FreqScope.new;
s.scope;


// 2) En el panel de ayuda de SuperCollider busca “Tour of UGens” y navega en la hoja de ayuda para ver la gran cantidad de Unidades Generadoras que implementa SuperCollider. En la misma hoja de ayuda puedes ejecutar los códigos de ejemplo que se presentan.

// 3) De los generadores en el Tour de UGens selecciona al menos 5, e impleméntalos. Para esto, abre un par de corchetes { } y coloca adentro el código del UGen que elegiste. Afuera de los corchetes { } agrega .play

// Ejemplo
{SinOsc.ar(400)}.play;

//=========================================
// INICIA TUS UGENS AQUÍ

// 1 UGen
{LPF.ar(SoundIn.ar(0), MouseX.kr(1e2,2e4,1), 0.2, 0.2) }.play;

// 2 UGen
{LPF.ar(Saw.ar(100), MouseX.kr(1e2,2e4,1), 0.2) }.play;

// 3 UGen
{ Klank.ar(`[[200, 671, 1153, 1723], nil, [50, 30, 100, 200]], Impulse.ar(1, 1, 0.1)) }.play;

// 4 UGen
{ OnePole.ar(SoundIn.ar(0)*10, MouseX.kr(-0.99, 0.99)) }.play;

// 5 UGen
(

b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

{
    var trig;
    trig = Impulse.kr(1.0);
    PlayBuf.ar(1,b,BufRateScale.kr(b),trig,0,0);
}.scope(1);

)


// TERMINA TUS UGENS AQUÍ
//=========================================

// 4) En mínimo uno de tus UGens debe de haber otro UGen anidado, de manera que uno de sus argumentos sea controlado por otro UGen.

// Ejemplo
{SinOsc.ar(mul:SinOsc.ar(1))}.play

//=========================================
// INICIA TU UGEN ANIDADO AQUÍ

{ OnePole.ar(OneZero.ar(SoundIn.ar(0)*10, MouseX.kr(-0.49, 0.49)), MouseX.kr(-0.99, 0.99)) }.play;

{         }.play;

{         }.play;

{         }.play;

{         }.play;


// TERMINA TU UGEN ANIDADO AQUÍ
//=========================================


// 5) Escribe un breve comentario de línea (recuerda que es con notación // ) en cada uno de los UGens que elegiste, describiendo lo que hace.




// 6) Además de los comentarios de línea, utiliza al menos un comentario de bloque.


//=========================================
// INICIA TUS COMENTARIOS AQUÍ
/*
En esta tarea puse a prueba las habilidades fundamentales que hemos comprendido para manipular minimamente SC.

*/
// TERMINA TUS COMENTARIOS AQUÍ
//=========================================



/*
Una vez realizada la actividad, deberás subir a la plataforma tu script terminado, cuidando que el archivo que subas tenga la terminación .scd, que corresponde a los archivos de SuperCollider.
Antes de subir el script, te recomendamos verificar que sea el archivo correcto y que abra sin problemas cuando das doble click sobre él. En caso de que tu computadora no reconozca automáticamente el tipo de archivo, deberás ir al menú de preferencias (dando click derecho sobre el archivo) e indicarle al sistema que esos archivos se ejecutan con SuperCollider.
Para obtener calificación, deberás revisar al menos tres tareas de otros compañeros.
*/