/*Erik Garcia Aparcio - Caverna */
(
s.boot;
)
/*Creanos el sonido principal al cual aplicaremos las UGens que elijamos*/
{SinOsc.ar(440,0,1)}.play

//============  Tour of UGens     ===================//
//===================================================//
/*     Las UGens Funcionan por si solas con frecuencias determinadas
pero aplicando la frecciencia 440 de arriba sera auditivamente mas notable el cambio o funcion que estos realizan */

//Frecuencia Baja
{ LFPar.ar(XLine.kr(100,15000,6),0,0.1) }.scope(1, zoom: 4);

{ LFPar.ar(LFPar.kr(0.2, 0, 400,800),0,0.1) }.scope(1, zoom: 4);

{ LFSaw.ar(LFSaw.kr(LFSaw.kr(0.2,0,8,10),0, 400,800),0,0.1) }.scope(1, zoom: 4);

//Pulsos
{ LFPulse.ar(100,0,MouseY.kr(0,1),0.1) }.scope(1, zoom: 4);

{ VarSaw.ar(100,0,MouseY.kr(0,1),0.1) }.scope(1, zoom: 4);


//Resonancia paso bajo, altoy de banda
{ RLPF.ar(WhiteNoise.ar, MouseX.kr(1e2,2e4,1), 0.2, 0.2) }.scope(1);

//Distorcion
{ SinOsc.ar(300, 0, MouseX.kr(0.1,80,1)).distort * 0.2 }.scope(1);

//Comment Este suena muy lindo
// Pulso de Banda oscilatorio
{ RLPF.ar(Pulse.ar([100,250],0.5,0.1), XLine.kr(8000,400,5), 0.05) }.scope(1);

/*En este ejemplo para anidar este UGen se crean variables para manipular el arreglo*/

////////Comment Suena genial este!!!

( //para anidar funciones es necesario el uso de () parentesis
{
    var p, a, b;
    p = Impulse.ar(8);
    a = SinOsc.ar(1200, 0, Decay2.ar(p, 0.005, 0.1));
    b = SinOsc.ar(600,  0, Decay2.ar(PulseDivider.ar(p, MouseX.kr(1,8).round(9)), 0.005, 0.5));

    [a, b] * 0.1
}.scope(2, zoom:4);
{ RLPF.ar(Pulse.ar([100,250],0.5,0.1), XLine.kr(8000,400,5), 0.05) }.scope(1);
)
//ó//
{ VarSaw.ar(VarSaw.kr(0.2, 0, 0.2, 400,800),0,0.2,0.1) }.scope(1, zoom: 4);//Donde dentro de UGens Varsaw se usa otro VarSaw dentro de el
{ VarSaw.ar(XLine.kr(100,15000,6),0,0.2,0.1) }.scope(1, zoom: 4);



{ VarSaw.ar(VarSaw.kr(VarSaw.kr(0.2,0,0.2,8,10),0,0.2, 400,800),0,0.2,0.1) }.scope(1, zoom: 4);
{ VarSaw.ar(VarSaw.kr(0.2, 0, 0.2, 400,800),0,0.2,0.1) }.scope(1, zoom: 4);
{ VarSaw.ar(XLine.kr(100,15000,6),0,0.2,0.1) }.scope(1, zoom: 4);

//=======================================================//