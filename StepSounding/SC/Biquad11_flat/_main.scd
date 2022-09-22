////////// This is the bela filter flat with 11 Biquads



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
s.options.headphoneLevel = 0; // sets the headphone level to -8 dB
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
										(SOS.ar(
											(SOS.ar(
												(micros
												), 1, -1.998927437, 0.998932002, 1.998487181, -0.998491745, 0.999779754)//Primer biquad
											), 1, -1.995441672, 0.995522059, 1.995441672, -0.995522059, 1) // Segundo Biquad
										), 1, -1.990818967, 0.99113473, 1.990818967, -0.99113473, 1) // Tercer biquad
									), 1, -1.981090327, 0.982347707, 1.978959082, -0.980215109, 0.998924206) // Cuarto Biquad
								), 1, -1.960020356, 0.965004291, 1.960020356, -0.965004291, 1) // Quinto Biquad
							), 1, -1.91164416, 0.931212221, 1.91164416, -0.931212221, 1) // Sexto biquad
						), 1, -1.791712563, 0.866998868, 1.791712563, -0.866998868, 1) // Septimo biquad
					), 1, -1.47390963, 0.750584038, 1.47390963, -0.750584038, 1) // Octavo biquad
				), 1, -0.650250101, 0.55647872, 0.486977719, -0.165659884, 0.748908334) // Noveno biquad
			), 1, 0.82926944, 0.273963712, -0.721255253, -0.108027108, 0.869747778) // Décimo Biquad
		), 1, 1.1031997, 0.180240551, -0.681117136, 0.271317728, 0.617401488) // Onceavo biquad
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
												), 1, -1.998927437, 0.998932002, 1.998487181, -0.998491745, 0.999779754)//Primer biquad
											), 1, -1.995441672, 0.995522059, 1.995441672, -0.995522059, 1) // Segundo Biquad
										), 1, -1.990818967, 0.99113473, 1.990818967, -0.99113473, 1) // Tercer biquad
									), 1, -1.981090327, 0.982347707, 1.978959082, -0.980215109, 0.998924206) // Cuarto Biquad
								), 1, -1.960020356, 0.965004291, 1.960020356, -0.965004291, 1) // Quinto Biquad
							), 1, -1.91164416, 0.931212221, 1.91164416, -0.931212221, 1) // Sexto biquad
						), 1, -1.791712563, 0.866998868, 1.791712563, -0.866998868, 1) // Septimo biquad
					), 1, -1.47390963, 0.750584038, 1.47390963, -0.750584038, 1) // Octavo biquad
				), 1, -0.650250101, 0.55647872, 0.486977719, -0.165659884, 0.748908334) // Noveno biquad
			), 1, 0.82926944, 0.273963712, -0.721255253, -0.108027108, 0.869747778) // Décimo Biquad
		), 1, 1.1031997, 0.180240551, -0.681117136, 0.271317728, 0.617401488) // Onceavo biquad
	)
]}.play;
)
};

ServerQuit.add({ 0.exit }); // quit if the button is pressed