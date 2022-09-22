///////////////// bela filter bajo altas 11 Biquads optimizado V2 8 de septiembre del 2022

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
											), 1, -1.995661918, 0.99573484, 1.983054895, -0.983127356, 0.993682786) // Segundo Biquad
										), 1, -1.989680296, 0.990076177, 1.97486516, -0.975258093, 0.992554012) // Tercer biquad
									), 1, -1.978674803, 0.980250349, 1.954763829, -0.956320336, 0.987915663) // Cuarto Biquad
								), 1, -1.960020356, 0.965004291, 1.960020356, -0.965004291, 1) // Quinto Biquad
							), 1, -1.762022899, 0.783090564, 1.903157901, -0.92591305, 1.080098279) // Sexto biquad
						), 1, -1.548375654, 0.631490731, 1.757278503, -0.851607252, 1.13491742) // Septimo biquad
					), 1, -1.197246465, 0.493918287, 1.381407822, -0.723713928, 1.153820757) // Octavo biquad
				), 1, -0.540454674, 0.535200776, 0.475782111, -0.35149366, 0.880336749) // Noveno biquad
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
											), 1, -1.995661918, 0.99573484, 1.983054895, -0.983127356, 0.993682786) // Segundo Biquad
										), 1, -1.989680296, 0.990076177, 1.97486516, -0.975258093, 0.992554012) // Tercer biquad
									), 1, -1.978674803, 0.980250349, 1.954763829, -0.956320336, 0.987915663) // Cuarto Biquad
								), 1, -1.960020356, 0.965004291, 1.960020356, -0.965004291, 1) // Quinto Biquad
							), 1, -1.762022899, 0.783090564, 1.903157901, -0.92591305, 1.080098279) // Sexto biquad
						), 1, -1.548375654, 0.631490731, 1.757278503, -0.851607252, 1.13491742) // Septimo biquad
					), 1, -1.197246465, 0.493918287, 1.381407822, -0.723713928, 1.153820757) // Octavo biquad
				), 1, -0.540454674, 0.535200776, 0.475782111, -0.35149366, 0.880336749) // Noveno biquad
			), 1, 1.021347858, 0.218664066, -0.665047485, 0.206470679, 0.651146894) // Décimo Biquad
		), 1, 1.1031997, 0.180240551, -0.997352408, -0.067001519, 0.904054278) // Onceavo biquad
	)
]}.play;
)
};

ServerQuit.add({ 0.exit }); // quit if the button is pressed