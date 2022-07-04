////////// This is the bela filter Alto bajo


/*******************

*/

s = Server.default;

// Set up options for the Bela
s.options.numAnalogInChannels = 2;
s.options.numAnalogOutChannels = 2;
s.options.numDigitalChannels = 0;
s.options.maxLogins = 4;
s.options.bindAddress = "0.0.0.0"; // allow anyone on the network connect to this server


s.options.pgaGainLeft = 10;
s.options.pgaGainRight = 10;
s.options.headphoneLevel = 0; // The headphones are at -5 and that means it is more or less equally to the input signal from pulse
s.options.speakerMuted = 0;

s.options.blockSize = 16;
s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 2;
s.options.belaMaxScopeChannels = 8;

s.waitForBoot {
	// Your code goes here.
(
{
var volum = 0.5;
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
										), 1,-1.98735055990554,0.987430621221091,1.99544167170140,-0.995522058971043,1.00407130576713)//Primer biquad
									), 1,-1.97994747451044,0.980261513561294,1.99081896700769,-0.991134730383673,1.00549079843643) // Segundo Biquad
								), 1,-1.95500251703539,0.956243339189606,1.98109032708820,-0.982347706936024,1.01334413118423) // Tercer biquad
							), 1,-1.96002035576163,0.965004291126555,1.96002035576163,-0.965004291126555,1) // Cuarto Biquad
						), 1,-1.91164416040560,0.931212220800568,1.83352774127574,-0.852296182767236,0.959136527211588) // Quinto Biquad
					), 1,-1.79171256294550,0.866998867856710,1.65535186558470,-0.724908404878517,0.923893653378960) // Sexto biquad
				), 1,-1.47390962975530,0.750584038350421,1.24009649842968,-0.472880760352765,0.841365354696518) // Septimo biquad
			), 1,-0.650250100924374,0.556478719984411,0.532681879146733,-0.275060177975467,0.819195380961095) // Octavo biquad
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
										), 1,-1.98735055990554,0.987430621221091,1.99544167170140,-0.995522058971043,1.00407130576713)//Primer biquad
									), 1,-1.97994747451044,0.980261513561294,1.99081896700769,-0.991134730383673,1.00549079843643) // Segundo Biquad
								), 1,-1.95500251703539,0.956243339189606,1.98109032708820,-0.982347706936024,1.01334413118423) // Tercer biquad
							), 1,-1.96002035576163,0.965004291126555,1.96002035576163,-0.965004291126555,1) // Cuarto Biquad
						), 1,-1.91164416040560,0.931212220800568,1.83352774127574,-0.852296182767236,0.959136527211588) // Quinto Biquad
					), 1,-1.79171256294550,0.866998867856710,1.65535186558470,-0.724908404878517,0.923893653378960) // Sexto biquad
				), 1,-1.47390962975530,0.750584038350421,1.24009649842968,-0.472880760352765,0.841365354696518) // Septimo biquad
			), 1,-0.650250100924374,0.556478719984411,0.532681879146733,-0.275060177975467,0.819195380961095) // Octavo biquad
		), 1,0.829269440440680,0.273963711889164,-0.535412475860895,0.177473530464306,0.645643562575238) // Noveno biquad
	)]
}.play;
)
};

ServerQuit.add({ 0.exit }); // quit if the button is pressed