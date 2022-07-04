///////////////// bela filter bajo altas 11 Biquads

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
												), 1.0, -1.998927437, 0.998932002, 1.998927437, -0.998932002, 1.0)//Primer biquad
											), 1.0, -1.995441672, 0.995522059, 1.98735056, -0.987430621, 0.995945203) // Segundo Biquad
										), 1.0, -1.990818967, 0.99113473, 1.977566031, -0.977879692, 0.993342973) // Tercer biquad
									), 1.0, -1.981090327, 0.982347707, 1.955002517, -0.956243339, 0.98683159) // Cuarto Biquad
								), 1.0, -1.960020356, 0.965004291, 1.960020356, -0.965004291, 1.0) // Quinto Biquad
							), 1.0, -1.808353206, 0.826863954, 1.91164416, -0.931212221, 1.057118794) // Sexto biquad
						), 1.0, -1.613517096, 0.681315772, 1.791712563, -0.866998868, 1.110439157) // Septimo biquad
					), 1.0, -1.221027842, 0.450232638, 1.47390963, -0.750584038, 1.207105669) // Octavo biquad
				), 1.0, -0.650250101, 0.55647872, 0.575592176, -0.377772909, 0.885185831) // Noveno biquad
			), 1.0, 0.82926944, 0.273963712, -0.553645929, 0.14946242, 0.667630932) // Décimo Biquad
		), 1.0, 1.1031997, 0.180240551, -0.997352408, -0.067001519, 0.904054278) // Onceavo biquad
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
												(micros
												), 1.0, -1.998927437, 0.998932002, 1.998927437, -0.998932002, 1.0)//Primer biquad
											), 1.0, -1.995441672, 0.995522059, 1.98735056, -0.987430621, 0.995945203) // Segundo Biquad
										), 1.0, -1.990818967, 0.99113473, 1.977566031, -0.977879692, 0.993342973) // Tercer biquad
									), 1.0, -1.981090327, 0.982347707, 1.955002517, -0.956243339, 0.98683159) // Cuarto Biquad
								), 1.0, -1.960020356, 0.965004291, 1.960020356, -0.965004291, 1.0) // Quinto Biquad
							), 1.0, -1.808353206, 0.826863954, 1.91164416, -0.931212221, 1.057118794) // Sexto biquad
						), 1.0, -1.613517096, 0.681315772, 1.791712563, -0.866998868, 1.110439157) // Septimo biquad
					), 1.0, -1.221027842, 0.450232638, 1.47390963, -0.750584038, 1.207105669) // Octavo biquad
				), 1.0, -0.650250101, 0.55647872, 0.575592176, -0.377772909, 0.885185831) // Noveno biquad
			), 1.0, 0.82926944, 0.273963712, -0.553645929, 0.14946242, 0.667630932) // Décimo Biquad
		), 1.0, 1.1031997, 0.180240551, -0.997352408, -0.067001519, 0.904054278) // Onceavo biquad
	)]
}.play;
)
};

ServerQuit.add({ 0.exit }); // quit if the button is pressed