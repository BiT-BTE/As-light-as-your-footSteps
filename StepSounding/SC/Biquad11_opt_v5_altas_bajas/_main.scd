////////// This is the bela filter Alto bajo 11 Biquads optimizado V5 del 8 de septiembre del 2022


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
											), 1, -1.984875904, 0.984948431, 1.995661918, -0.99573484, 1.0054341) // Segundo Biquad
										), 1, -1.971888625, 0.972280965, 1.989680296, -0.990076177, 1.009022655) // Tercer biquad
									), 1, -1.949568497, 0.951120867, 1.978674803, -0.980250349, 1.014929614) // Cuarto Biquad
								), 1, -1.960020356, 0.965004291, 1.960020356, -0.965004291, 1) // Quinto Biquad
							), 1, -1.903157901, 0.92591305, 1.802223427, -0.82377175, 0.94696474) // Sexto biquad
						), 1, -1.757278503, 0.851607252, 1.580035648, -0.664850198, 0.899137869) // Septimo biquad
					), 1, -1.381407822, 0.723713928, 1.17956059, -0.471849938, 0.853882952) // Octavo biquad
				), 1, -0.430916105, 0.514496749, 0.354807354, -0.247005109, 0.823379192) // Noveno biquad
			), 1, 1.021347858, 0.218664066, -0.642096428, 0.233855695, 0.628675552) // Décimo Biquad
		), 1, 1.1031997, 0.180240551, -0.889866733, 0.047990311, 0.806623436) // Onceavo biquad
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
											), 1, -1.984875904, 0.984948431, 1.995661918, -0.99573484, 1.0054341) // Segundo Biquad
										), 1, -1.971888625, 0.972280965, 1.989680296, -0.990076177, 1.009022655) // Tercer biquad
									), 1, -1.949568497, 0.951120867, 1.978674803, -0.980250349, 1.014929614) // Cuarto Biquad
								), 1, -1.960020356, 0.965004291, 1.960020356, -0.965004291, 1) // Quinto Biquad
							), 1, -1.903157901, 0.92591305, 1.802223427, -0.82377175, 0.94696474) // Sexto biquad
						), 1, -1.757278503, 0.851607252, 1.580035648, -0.664850198, 0.899137869) // Septimo biquad
					), 1, -1.381407822, 0.723713928, 1.17956059, -0.471849938, 0.853882952) // Octavo biquad
				), 1, -0.430916105, 0.514496749, 0.354807354, -0.247005109, 0.823379192) // Noveno biquad
			), 1, 1.021347858, 0.218664066, -0.642096428, 0.233855695, 0.628675552) // Décimo Biquad
		), 1, 1.1031997, 0.180240551, -0.889866733, 0.047990311, 0.806623436) // Onceavo biquad
	)]
}.play;
)
};

ServerQuit.add({ 0.exit }); // quit if the button is pressed