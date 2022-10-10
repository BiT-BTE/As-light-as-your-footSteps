

{SinOsc.ar(440,0,SinOsc.ar(110,0,1,1))}.scope








(
var w, carrfreqslider, modfreqslider, modindexslider, synth;

w=Window("amplitud modulada", Rect(100, 400, 400, 300));
w.view.decorator = FlowLayout(w.view.bounds);

synth= {arg carrfreq=440, modfreq=1, i=0;

SinOsc.ar(carrfreq ,0,SinOsc.ar(modfreq,0,i,1))
}.scope;

carrfreqslider= EZSlider(w, 300@50, "carrfreq", ControlSpec(20, 5000, 'exponential', 10, 440), {|ez|  synth.set(\carrfreq, ez.value)});
w.view.decorator.nextLine;

modfreqslider= EZSlider(w, 300@50, "modfreq", ControlSpec(1, 5000, 'exponential', 1, 1), {|ez|  synth.set(\modfreq, ez.value)});
w.view.decorator.nextLine;
modindexslider= EZSlider(w, 300@50, "modAmp", ControlSpec(0.0, 1, 'linear', 0.01, 0.0), {|ez|  synth.set(\i, ez.value)});

w.front;

)

FreqScope.new(400, 200, 0, server: s);

