/* Lista de U gens
Actividad 1 . Sanmartin R. JP
*/


//Inicio de Ugens

/*Klang es un banco de ociladores sinusoidales de freq. fija
Sólo es de tipo .ar y recibe como argumentros tres arreglos
   El primero recibe 3 frecuencias del oscilador
   El segundo array recibe 3 amplitudes
   Y el tercero recibe 3 fases   */

// Ugen 1

{ Klang.ar(`[ [800, 1000, 1200], [0.3, 0.3, 0.3], [pi, pi, pi]], 1, 0) * 0.4}.play//aguas, esta algo agudo

play({ Klang.ar(`[ Array.rand(12, 600.0, 1000.0), nil, nil ], 1, 0) * 0.05 }); //es el mismo pero esta mejor


//Ugen 2
// Filtro de paso bajo aplicado a un oscilador de dientes de sierra. El cutoff se modula con MouseX

{ LPF.ar(Saw.ar(100), MouseX.kr(1e2,2e4,1), 0.2) }.scope(1);

//Ugen 3
//Panea una señal de audio (en este caso un Brown Noise), y usa un oscilador .kr como paramotro de paneo.

{ Pan2.ar(BrownNoise.ar, SinOsc.kr(0.2), 0.3) }.scope(2);

//Ugen 4
/* Es un ejemplo de que se puede hacer con el playbuf
Esta genial porque controla la velocidad a la que se reproduce la muestra, y la posicion de inicio del loop
*/

(
{

    var trig;
    trig = Impulse.kr(MouseY.kr(0.5,200,1));
    PlayBuf.ar(1,1,BufRateScale.kr(1),trig,MouseX.kr(0,BufFrames.kr(b)),1)
}.scope(1);

)


//Ugen 5
/* Este me gusto mucho. Es un tipo particular de triger
Podemos hacerlo funcionar con cualquier tipo de señal. Emite un pulso de sonido cada que recibe un numero dado de "sub-triggers" dados por el ususario y la señal.

Los triggers son "sumados" o "contados" cada vez que nuestra señal (oscilante) hace la transicion de negativa a positiva

Nosotros elegimos depués de cuantos triggers queremos que se emita el pulso*/

(
{
    var p, a, b;
    p = Impulse.ar(8);
    a = SinOsc.ar(1200, 0, Decay2.ar(p, 0.005, 0.1));
    b = SinOsc.ar(600,  0, Decay2.ar(PulseDivider.ar(p, MouseX.kr(1,8).round(1)), 0.005, 0.5));

    [a, b] * 0.4
}.scope(2, zoom:4);
)
