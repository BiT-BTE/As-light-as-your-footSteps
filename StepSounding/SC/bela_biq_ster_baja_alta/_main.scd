///////////////// bela filter bajo altas


/*******************
Hello Bela!
Connect your headphones to the stereo audio output of the Bela and run this program.

(c) 2017: Jonathan Reus, Marije Baalman, Giulio Moro, Andrew McPherson
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
										), 1,-1.99544167170140,0.995522058971043,1.98870975168977,-0.988789867760976,0.996626350894092)//Primer biquad
									), 1,-1.99081896700769,0.991134730383673,1.97994747451044,-0.980261513561295,0.994539185793679) // Segundo Biquad
								), 1,-1.98109032708820,0.982347706936024,1.95966504599403,-0.960908827412584,0.989185106402662) // Tercer biquad
							), 1,-1.96002035576163,0.965004291126555,1.96002035576163,-0.965004291126555,1) // Cuarto Biquad
						), 1,-1.81715283963911,0.835753663604907,1.91164416040560,-0.931212220800568,1.05199965501265) // Quinto Biquad
					), 1,-1.62802845944649,0.696436891433213,1.79171256294550,-0.866998867856710,1.10054130353143) // Sexto biquad
				), 1,-1.24009649842968,0.472880760352765,1.47390962975530,-0.750584038350420,1.18854430410996) // Septimo biquad
			),1,-0.650250100924374,0.556478719984411,0.575592175975871,-0.377772909258127,0.885185831048128) // Octavo biquad
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
										), 1,-1.99544167170140,0.995522058971043,1.98870975168977,-0.988789867760976,0.996626350894092)//Primer biquad
									), 1,-1.99081896700769,0.991134730383673,1.97994747451044,-0.980261513561295,0.994539185793679) // Segundo Biquad
								), 1,-1.98109032708820,0.982347706936024,1.95966504599403,-0.960908827412584,0.989185106402662) // Tercer biquad
							), 1,-1.96002035576163,0.965004291126555,1.96002035576163,-0.965004291126555,1) // Cuarto Biquad
						), 1,-1.81715283963911,0.835753663604907,1.91164416040560,-0.931212220800568,1.05199965501265) // Quinto Biquad
					), 1,-1.62802845944649,0.696436891433213,1.79171256294550,-0.866998867856710,1.10054130353143) // Sexto biquad
				), 1,-1.24009649842968,0.472880760352765,1.47390962975530,-0.750584038350420,1.18854430410996) // Septimo biquad
			),1,-0.650250100924374,0.556478719984411,0.575592175975871,-0.377772909258127,0.885185831048128) // Octavo biquad
		), 1,0.829269440440680,0.273963711889164,-0.535412475860895,0.177473530464306,0.645643562575238) // Noveno biquad
	)]
}.play;
)
};

ServerQuit.add({ 0.exit }); // quit if the button is pressed