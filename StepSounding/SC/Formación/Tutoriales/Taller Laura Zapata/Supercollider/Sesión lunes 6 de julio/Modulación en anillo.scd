//Modulación en anillo


La modulación en anillo es bastante parecida a la AM pero con una sutil diferencia: el modulador es bipolar, es decir, su onda viaja de positivo a negativo, en nuestra fórmula sencillamente le quitamos el + 1, y en SuperCollider igualmente le eliminamos el 1 a nuestro argumento add.

Es una multiplicación directa de dos señales.

portador * modulador

Es posible que con esta obtengamos muchos más componentes del espectro de las señales multiplicadas.

Su sintaxis en SuperCollider es de la siguiente forma.

{SinOsc.ar(200,0,0.5)*SinOsc.ar(800,0,0.5)}.scope




(
var w, carrfreqslider, modfreqslider, modindexslider, synth;

w=Window("amplitud modulada", Rect(100, 400, 400, 300));
w.view.decorator = FlowLayout(w.view.bounds);

synth= {arg carrfreq=440, modfreq=1, i=0;

	SinOsc.ar(carrfreq ,0,1)!2*SinOsc.ar(modfreq,0,i)!2
}.scope;

carrfreqslider= EZSlider(w, 300@50, "carrfreq", ControlSpec(20, 5000, 'exponential', 10, 440), {|ez|  synth.set(\carrfreq, ez.value)});
w.view.decorator.nextLine;

modfreqslider= EZSlider(w, 300@50, "modfreq", ControlSpec(1, 5000, 'exponential', 1, 1), {|ez|  synth.set(\modfreq, ez.value)});
w.view.decorator.nextLine;
modindexslider= EZSlider(w, 300@50, "modAmp", ControlSpec(0.0, 1, 'linear', 0.01, 0.0), {|ez|  synth.set(\i, ez.value)});

w.front;

)

FreqScope.new(400, 200, 0, server: s);
