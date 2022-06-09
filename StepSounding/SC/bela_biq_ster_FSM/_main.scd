////////// This is the bela FSM Biquad

/*******************

This patch implements three filters based on Biquad cascade of nine elements

The boton in this skectch changes from one filter to another, p'assing by the flat config, to the hp-lp and finally to the lp-hp

*/

s = Server.default;

// Set up options for the Bela
s.options.numAnalogInChannels = 2;
s.options.numAnalogOutChannels = 2;
s.options.numDigitalChannels = 0;
s.options.maxLogins = 4;
s.options.bindAddress = "0.0.0.0"; // allow anyone on the network connect to this server

s.options.blockSize = 16;
s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 2;
s.options.belaMaxScopeChannels = 8;

s.waitForBoot {
	// Your code goes here.
	(
		{
// this was de variable for the volume, not in use for now
var volum = 0.5;
// those are the variables for the 2 mic channels
var micros = SoundIn.ar([0]);
var micros2 = SoundIn.ar([1]);

	[(SOS.ar(
		(SOS.ar(
			(SOS.ar(
				(SOS.ar(
					(SOS.ar(
						(SOS.ar(
							(SOS.ar(
								(SOS.ar(
									(SOS.ar(
										(micros
										), 1,-1.99544167170140,0.995522058971043,1.99544167170140,-0.995522058971043,1)//Primer biquad
									), 1,-1.99081896700769,0.991134730383673,1.99081896700769,-0.991134730383673,1) // Segundo Biquad
								), 1,-1.98109032708820,0.982347706936024,1.97895908164869,-0.980215108814587,0.998924205822230) // Tercer biquad
							), 1,-1.96002035576163,0.965004291126555,1.96002035576163,-0.965004291126555,1) // Cuarto Biquad
						), 1,-1.91164416040560,0.931212220800568,1.91164416040560,-0.931212220800568,1) // Quinto Biquad
					), 1,-1.79171256294550,0.866998867856710,1.79171256294550,-0.866998867856710,1) // Sexto biquad
				), 1,-1.47390962975530,0.750584038350420,1.47390962975530,-0.750584038350420,1) // Septimo biquad
			), 1,-0.650250100924374,0.556478719984411,0.486977719470636,-0.165659884381527,0.748908333544837) // Octavo biquad
		), 1,0.829269440440680,0.273963711889164,-0.535412475860895,0.177473530464306,0.645643562575238) // Noveno biquad
	),
	// this is the stereo part
	(SOS.ar(
		(SOS.ar(
			(SOS.ar(
				(SOS.ar(
					(SOS.ar(
						(SOS.ar(
							(SOS.ar(
								(SOS.ar(
									(SOS.ar(
										(micros2
										), 1,-1.99544167170140,0.995522058971043,1.99544167170140,-0.995522058971043,1)//Primer biquad
									), 1,-1.99081896700769,0.991134730383673,1.99081896700769,-0.991134730383673,1) // Segundo Biquad
								), 1,-1.98109032708820,0.982347706936024,1.97895908164869,-0.980215108814587,0.998924205822230) // Tercer biquad
							), 1,-1.96002035576163,0.965004291126555,1.96002035576163,-0.965004291126555,1) // Cuarto Biquad
						), 1,-1.91164416040560,0.931212220800568,1.91164416040560,-0.931212220800568,1) // Quinto Biquad
					), 1,-1.79171256294550,0.866998867856710,1.79171256294550,-0.866998867856710,1) // Sexto biquad
				), 1,-1.47390962975530,0.750584038350420,1.47390962975530,-0.750584038350420,1) // Septimo biquad
			), 1,-0.650250100924374,0.556478719984411,0.486977719470636,-0.165659884381527,0.748908333544837) // Octavo biquad
		), 1,0.829269440440680,0.273963711889164,-0.535412475860895,0.177473530464306,0.645643562575238) // Noveno biquad
	)]
}.play;
);
};

ServerQuit.add({ 0.exit }); // quit if the button is pressed