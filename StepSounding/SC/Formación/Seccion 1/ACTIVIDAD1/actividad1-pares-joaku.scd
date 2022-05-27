/*
Actividad 1 evaluada por pares

Por: Joaku de Sotavento

joaquindiazescultor@gmail.com

*/

s.boot;

s.scope;

FreqScope.new;

// UGen 1
(
{LPF.ar(SoundIn.ar(0), MouseX.kr(1e2,2e4,1), 0.2, 0.2) }.scope(1);
)
// UGen 2

(
{LPF.ar(Saw.ar(100), MouseX.kr(1e2,2e4,1), 0.2) }.scope(1);
)

// UGen 3

(
{ Klank.ar(`[[200, 671, 1153, 1723], nil, [50, 30, 100, 200]], Impulse.ar(1, 1, 0.1)) }.play;
)

// UGen 4

(
{ OnePole.ar(WhiteNoise.ar(0.5), MouseX.kr(-0.99, 0.99)) }.scope(1);
)

// UGen 5

(

b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

{
    var trig;
    trig = Impulse.kr(1.0);
    PlayBuf.ar(1,b,BufRateScale.kr(b),trig,0,0);
}.scope(1);

)

// UGen 6

(
{ SinOsc.ar(Integrator.ar(Dust2.ar(8), 0.99999, 200, 800), 0, 0.2) }.scope(1);
)


// UGen 7

(
{
    var n;
    n = 8; // number of 'voices'
    Mix.ar( // mix all stereo pairs down.
        Pan2.ar( // pan the voice to a stereo position
            CombL.ar( // a comb filter used as a string resonator
                Dust.ar( // random impulses as an excitation function
                    // an array to cause expansion of Dust to n channels
                    // 1 means one impulse per second on average
                    1.dup(n),
                    0.3 // amplitude
                ),
                0.01, // max delay time in seconds
                // array of different random lengths for each 'string'
                {0.0004.rand+0.0003}.dup(n),
                4 // decay time in seconds
            ),
            {1.0.rand2}.dup(n) // give each voice a different pan position
        )
    )
}.scope(2, zoom:4);
)

