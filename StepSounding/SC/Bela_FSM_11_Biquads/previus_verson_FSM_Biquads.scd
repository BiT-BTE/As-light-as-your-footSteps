////////// This is the bela FSM for the integration of the three filters: Low, High and Flat

/*******************
As Light as your foot steps

By: Joaku De Sotavento & Daniel de la Prida

i_mBODY Lab

The following will be the order of the pins:

DP 6 for the button
DP 7 for saying that the Bela is ready
DP 8 for red
DP 8 for green
DP 9 for blue


*/
s = Server.default;

// Set up options for the Bela
s.options.numAnalogInChannels = 2;
s.options.numAnalogOutChannels = 2;
s.options.numDigitalChannels = 16;
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

	~contador = 0;

	SynthDef('buttonControl', {arg inPin, outPin, contador;
		// read the value at the pin
		var button = DigitalIn.ar(inPin);
		//if([true, false],{"true".postln;}, {"false".postln;})

		// toggle an LED on outPin
		DigitalOut.ar(outPin, button.not);
		//"Boton activado".postln;

		~contador += contador;

	}).add;

	SynthDef('ledFade', {
		//var rate = AnalogIn.ar(0).exprange(0.3, 20);
		//var amp = AnalogIn.ar(1); // returns a value from 0-1
		var rate = 0.1; //0.3 a 20
		var amp = 1.0; // returns a value from 0-1
		rate.poll(1); amp.poll(1);
		AnalogOut.ar(0, SinOsc.ar(rate).range(0.0, amp)); // send to Analog Output 0
	}).add;

	SynthDef('record', {arg buf;
		var in = SoundIn.ar(0);
		var button = DigitalIn.ar(6);
		button.poll(0.5);
		RecordBuf.ar(in, buf, run: button, trigger: button);
	}).add;



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
												), 1.0, -1.998927437, 0.998932002, 1.998487181, -0.998491745, 0.999779754)//Primer biquad
											), 1.0, -1.995441672, 0.995522059, 1.995441672, -0.995522059, 1) // Segundo Biquad
										), 1.0, -1.990818967, 0.99113473, 1.990818967, -0.99113473, 1) // Tercer biquad
									), 1.0, -1.981090327, 0.982347707, 1.978959082, -0.980215109, 0.998924206) // Cuarto Biquad
								), 1.0, -1.960020356, 0.965004291, 1.960020356, -0.965004291, 1) // Quinto Biquad
							), 1.0, -1.91164416, 0.931212221, 1.91164416, -0.931212221, 1) // Sexto biquad
						), 1.0, -1.791712563, 0.866998868, 1.791712563, -0.866998868, 1) // Septimo biquad
					), 1.0, -1.47390963, 0.750584038, 1.47390963, -0.750584038, 1) // Octavo biquad
				), 1.0, -0.650250101, 0.55647872, 0.486977719, -0.165659884, 0.748908334) // Noveno biquad
			), 1.0, 0.82926944, 0.273963712, -0.721255253, -0.108027108, 0.869747778) // Décimo Biquad
		), 1.0, 1.118500234, 0.167965541, -0.686630006 , 0.283004006, 0.613884544) // Onceavo biquad
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
												), 1.0, -1.998927437, 0.998932002, 1.998487181, -0.998491745, 0.999779754)//Primer biquad
											), 1.0, -1.995441672, 0.995522059, 1.995441672, -0.995522059, 1) // Segundo Biquad
										), 1.0, -1.990818967, 0.99113473, 1.990818967, -0.99113473, 1) // Tercer biquad
									), 1.0, -1.981090327, 0.982347707, 1.978959082, -0.980215109, 0.998924206) // Cuarto Biquad
								), 1.0, -1.960020356, 0.965004291, 1.960020356, -0.965004291, 1) // Quinto Biquad
							), 1.0, -1.91164416, 0.931212221, 1.91164416, -0.931212221, 1) // Sexto biquad
						), 1.0, -1.791712563, 0.866998868, 1.791712563, -0.866998868, 1) // Septimo biquad
					), 1.0, -1.47390963, 0.750584038, 1.47390963, -0.750584038, 1) // Octavo biquad
				), 1.0, -0.650250101, 0.55647872, 0.486977719, -0.165659884, 0.748908334) // Noveno biquad
			), 1.0, 0.82926944, 0.273963712, -0.721255253, -0.108027108, 0.869747778) // Décimo Biquad
		), 1.0, 1.118500234, 0.167965541, -0.686630006 , 0.283004006, 0.613884544) // Onceavo biquad
	)]



}.play;


	a = Synth('buttonControl', ['inPin', 6, 'outPin', 0, 1]);
	//b = Synth('buttonControl', ['inPin', 6, 'outPin', 1, 1]);
	//c = Synth('buttonControl', ['inPin', 6, 'outPin', 2, 1]);

	d = Synth('ledFade'); // means the bela is alive

	(
		var x, z;
		z = [0, 1, 1.1, 1.3, 1.5, 2];
		switch (z[3].postln,
			1,   { \no },
			1.1, { \wrong },
			1.3, { \wrong },
			1.5, { \wrong },
			2,   { \wrong },
			0,   { \true }
		).postln;
	)

	r = Synth('record', ['buf', b]);

	s.sync;

};

ServerQuit.add({ 0.exit }); // quit if the button is pressed


