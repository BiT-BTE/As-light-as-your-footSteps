////////// This is the bela filter Low Frequencies filter with 11 Biquads

/*******************
As Light as your foot steps

By: Joaku De Sotavento & Daniel de la Prida

i_mBODY Lab

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
s.options.headphoneLevel = 0; // sets the headphone level to -8 dB
s.options.speakerMuted = 1;

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
										(SOS.ar(
											(SOS.ar(
												(micros
												), 1.0, -1.998927437, 0.998932002, 1.998927437, -0.998932002, 1)//Primer biquad
											), 1.0, -1.985827732, 0.985907732, 1.995441672, -0.995522059, 1.004841276) // Segundo Biquad
										), 1.0, -1.977566031, 0.977879692, 1.990818967, -0.99113473, 1.00670164) // Tercer biquad
									), 1.0, -1.955002517, 0.956243339, 1.981090327, -0.982347707, 1.013344131) // Cuarto Biquad
								), 1.0, -1.960020356, 0.965004291, 1.960020356, -0.965004291, 1) // Quinto Biquad
							), 1.0, -1.91164416, 0.931212221, 1.833527741, -0.852296183, 0.959136527) // Sexto biquad
						), 1.0, -1.791712563, 0.866998868, 1.655351866, -0.724908405, 0.923893653) // Septimo biquad
					), 1.0, -1.47390963, 0.750584038, 1.240096498, -0.47288076, 0.841365355) // Octavo biquad
				), 1.0, -0.650250101, 0.55647872, 0.532681879, -0.275060178, 0.819195381) // Noveno biquad
			), 1.0, 0.82926944, 0.273963712, -0.535412476, 0.17747353, 0.645643563) // Décimo Biquad
		), 1.0, 1.118500234, 0.167965541, -0.844930596, 0.117702624, 0.755413875) // Onceavo biquad
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
										(SOS.ar(
											(SOS.ar(
												(micros2
												), 1.0, -1.998927437, 0.998932002, 1.998927437, -0.998932002, 1)//Primer biquad
											), 1.0, -1.985827732, 0.985907732, 1.995441672, -0.995522059, 1.004841276) // Segundo Biquad
										), 1.0, -1.977566031, 0.977879692, 1.990818967, -0.99113473, 1.00670164) // Tercer biquad
									), 1.0, -1.955002517, 0.956243339, 1.981090327, -0.982347707, 1.013344131) // Cuarto Biquad
								), 1.0, -1.960020356, 0.965004291, 1.960020356, -0.965004291, 1) // Quinto Biquad
							), 1.0, -1.91164416, 0.931212221, 1.833527741, -0.852296183, 0.959136527) // Sexto biquad
						), 1.0, -1.791712563, 0.866998868, 1.655351866, -0.724908405, 0.923893653) // Septimo biquad
					), 1.0, -1.47390963, 0.750584038, 1.240096498, -0.47288076, 0.841365355) // Octavo biquad
				), 1.0, -0.650250101, 0.55647872, 0.532681879, -0.275060178, 0.819195381) // Noveno biquad
			), 1.0, 0.82926944, 0.273963712, -0.535412476, 0.17747353, 0.645643563) // Décimo Biquad
		), 1.0, 1.118500234, 0.167965541, -0.844930596, 0.117702624, 0.755413875) // Onceavo biquad
	)]
}.play;
)
};

ServerQuit.add({ 0.exit }); // quit if the button is pressed