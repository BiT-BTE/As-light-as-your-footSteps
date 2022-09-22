///////////////// bela filter bajo altas 11 Biquads optimizado 8 de septiembre del 2022

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
												), 1, -1.998927437, 0.998932002, 1.998927437, -0.998932002, 1)//Primer biquad
											), 1, -1.995441672, 0.995522059, 1.985827732, -0.985907732, 0.995182049) // Segundo Biquad
										), 1, -1.989298989, 0.989723576, 1.976717553, -0.977139454, 0.993675442) // Tercer biquad
									), 1, -1.979483428, 0.980948975, 1.960893407, -0.96234519, 0.99060865) // Cuarto Biquad
								), 1, -1.960020356, 0.965004291, 1.960020356, -0.965004291, 1) // Quinto Biquad
							), 1, -1.783052847, 0.804371956, 1.903157901, -0.92591305, 1.067359223) // Sexto biquad
						), 1, -1.580194984, 0.6588482, 1.768479905, -0.856504885, 1.119152967) // Septimo biquad
					), 1, -1.229485715, 0.480896381, 1.446623494, -0.742435453, 1.176608624) // Octavo biquad
				), 1, -0.650250101, 0.55647872, 0.575592176, -0.377772909, 0.885185831) // Noveno biquad
			), 1, 1.021347858, 0.218664066, -0.665047485, 0.206470679, 0.651146894) // Décimo Biquad
		), 1, 1.1031997, 0.180240551, -0.997352408, -0.067001519, 0.904054278) // Onceavo biquad
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
												), 1, -1.998927437, 0.998932002, 1.998927437, -0.998932002, 1)//Primer biquad
											), 1, -1.995441672, 0.995522059, 1.985827732, -0.985907732, 0.995182049) // Segundo Biquad
										), 1, -1.989298989, 0.989723576, 1.976717553, -0.977139454, 0.993675442) // Tercer biquad
									), 1, -1.979483428, 0.980948975, 1.960893407, -0.96234519, 0.99060865) // Cuarto Biquad
								), 1, -1.960020356, 0.965004291, 1.960020356, -0.965004291, 1) // Quinto Biquad
							), 1, -1.783052847, 0.804371956, 1.903157901, -0.92591305, 1.067359223) // Sexto biquad
						), 1, -1.580194984, 0.6588482, 1.768479905, -0.856504885, 1.119152967) // Septimo biquad
					), 1, -1.229485715, 0.480896381, 1.446623494, -0.742435453, 1.176608624) // Octavo biquad
				), 1, -0.650250101, 0.55647872, 0.575592176, -0.377772909, 0.885185831) // Noveno biquad
			), 1, 1.021347858, 0.218664066, -0.665047485, 0.206470679, 0.651146894) // Décimo Biquad
		), 1, 1.1031997, 0.180240551, -0.997352408, -0.067001519, 0.904054278) // Onceavo biquad
	)
]}.play;
)
};

ServerQuit.add({ 0.exit }); // quit if the button is pressed