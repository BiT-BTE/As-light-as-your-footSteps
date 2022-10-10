/*ENVOLVENTES*/


La envolvente es un elemento muy importante que caracteriza el timbre de un sonido. Describe cómo evoluciona su amplitud en el tiempo hasta que se apaga. La estructura clásica de una envolvente considera cuatro segmentos: Ataque, Decaimiento, Sostenido y Liberación, mejor conocidos en inglés como Attack, Decay, Sustain y Release, adsr.


//EnvGen.kr(Ugen de control)

// Env. (me designa qué tipo de envolvente quiero, o método)

SuperCollider implementa dos familias de envolventes, una caracterizada por la duración del sonido y la otra, por el valor de amplitud en el segmento de sostenido. Su principal diferencia es que las primeras se apagan solas, siguiendo un esquema de duraciones especificado y las segundas generan un sonido que se mantiene prendido en el segmento de sostenido, hasta que se especifique que es hora de leer el segmento de liberación, el "release".



PRIMER GRUPO


Env.perc().plot

(
{WhiteNoise.ar(EnvGen.kr(Env.perc(0.001,0.06,0.4,-5).circle(0.95)))}.play;
{SinOsc.ar(90,0,EnvGen.kr(Env.perc(0.001,0.06,0.4,-5).circle(0.5)))}.play
)

Env.linen().plot


{SinOsc.ar(440,0,EnvGen.kr(Env.linen(0.01,0.09,2).circle(1)))}.play


Env.circle().plot

{SinOsc.ar(440,0,EnvGen.kr(Env.circle([0, 1, 0], [0.01, 0.6])))}.play


SEGUNDO GRUPO



Env.new().plot

{SinOsc.ar(440,0,EnvGen.kr(Env.new([0,0.7,0.7,0.9,0.2,0],[1,1,1,1,1]).circle(1)))}.play

Env.new([0,0.7,0.7,0.9,0.2,0],[1,1,1,1,1]).plot



Env.adsr().plot

{SinOsc.ar(440,0,EnvGen.kr(Env.adsr(0.01,0.1,0.5,0.4,0.4).circle(1)))!2}.play


Env.asr().plot

{SinOsc.ar(440,0,EnvGen.kr(Env.asr(0.01,0.5,0.4).circle(2)))!2}.play

Ejercicio


Ponle valores a tus envolventes y observa cómo te quedó el dibujo de esa envolvente.

//Me permite crear ciclos o repeticiones
Env.circle([0, 1, 0, (2..4)], [0.01, 0.6]).plot

Env.new([0,1,0.5,0.5,0],[1,1,3,4],-1,loopNode:2).plot
