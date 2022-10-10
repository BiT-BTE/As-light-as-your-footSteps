// FRECUENCIA MODULADA



{SinOsc.ar(440+SinOsc.ar(200,0,1),0,1)}.scope




En lugar de conectar el modulador a la amplitud de la portadora, vamos a conectar el modulador a la frecuencia de la portadora. Habrá tres parámetros, la frecuencia portadora P, la frecuencia de modulación M y la profundidad de modulación o la desviación de frecuencia D o delta (que llamaremos índice de modulación).

Al cambiar la frecuencia y profundidad de la modulación, se redistribuye la energía en las bandas laterales; las fórmulas reales para este uso utilizan las funciones de Bessel y están fuera del alcance de este video.

Frecuencia del portadora =  carrfreq



Frecuencia moduladora = modfreq

(Si la frecuencia de onda moduladora incrementa, las bandas laterales se aumentan. y se complejiza el espectro)



Amplitud  o multiplicación de la modulara =  df

(El término delta f llamado desviación del pico de la frecuencia determina la amplitud de la salida del oscilador modulador. que controla el swing de la frecuencia del oscilador portador. El bamboleo,  el balanceo. Esto es el índice de modulación)



(
var w, carrfreqslider, modfreqslider, modindexslider, synth;

w=Window("frecuencia modulada", Rect(100, 400, 400, 300));
w.view.decorator = FlowLayout(w.view.bounds);

synth= {arg carrfreq=440, modfreq=1, df=0;

	SinOsc.ar(carrfreq + ( modfreq*SinOsc.ar(modfreq,0,df)),0,0.25)!2

}.scope;

carrfreqslider= EZSlider(w, 300@50, "carrfreq", ControlSpec(20, 5000, 'exponential', 10, 440), {|ez|  synth.set(\carrfreq, ez.value)});
w.view.decorator.nextLine;

modfreqslider= EZSlider(w, 300@50, "modfreq", ControlSpec(1, 5000, 'exponential', 1, 1), {|ez|  synth.set(\modfreq, ez.value)});
w.view.decorator.nextLine;
modindexslider= EZSlider(w, 300@50, "df", ControlSpec(0.0, 30, 'linear', 0.01, 0.0), {|ez|  synth.set(\df, ez.value)});

w.front;

)

FreqScope.new(400, 200, 0, server: s);