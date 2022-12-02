s.boot;


(
SynthDef("helpSelect",{ arg out=0,id=0;

    var a,cycle;
    a = [
    SOS.ar(SinOsc.ar(), 1, -1.998927437, 0.998932002, 1.998927437, -0.998932002, 1),
    SOS.ar(Saw.ar(), 1, -1.998927437, 0.998932002, 1.998927437, -0.998932002, 1),
    SOS.ar(Pulse.ar(), 1, -1.998927437, 0.998932002, 1.998927437, -0.998932002, 1)
        ];
    cycle = a.size  * 0.5;
    Out.ar(out,
        Select.ar(id,a) * 0.2
    )
}).add;
)



x = Synth(\helpSelect, [\id,0]);

x.set(\id, 1);

x.set(\id, 0);

x.set(\id, 2);

x.free;

(
~f1 = {|sig| SOS.ar(sig, 1, -1.998927437, 0.998932002, 1.998927437, -0.998932002, 1);};
~f2 = {|sig| SOS.ar(sig, 1, -0.430916105, 0.514496749, 0.354807354, -0.247005109, 0.823379192);};
~f3 = {|sig| SOS.ar(sig, 1, -1.971888625, 0.972280965, 1.989680296, -0.990076177, 1.009022655);};

SynthDef("helpSelect2",{ arg out=0,id=0;

    var a;
    a = [
    ~f1.value(Saw.ar()),
    ~f2.value(Saw.ar()),
    ~f3.value(Saw.ar())
        ];
    Out.ar(out,
        Select.ar(id,a) * 0.2
    )
}).add;
)



y = Synth(\helpSelect2, [\id,0]);

y.set(\id, 1);

y.set(\id, 0);

y.set(\id, 2);

y.free;