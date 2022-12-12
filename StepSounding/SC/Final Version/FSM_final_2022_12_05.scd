////////// This is the bela FSM for the integration of the three filters: Low, High and Flat

/*******************
As Light as your foot steps

By: Joaku De Sotavento & Daniel de la Prida

i_mBODY Lab

The following will be the order of the pins:

DigitalIn 0 for the button
AnalogOutP 0 for saying that the Bela is ready and linked with the slider
DigitalIn 2 for red color
DigitalIn 3 for green color
DigitalIn 4 for blue color
AnalogIn 0 for the slider


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
s.options.headphoneLevel = 3; // sets the headphone level to -8 dB
s.options.speakerMuted = 1;

s.options.blockSize = 16;
s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 2;
s.options.belaMaxScopeChannels = 8;

s.waitForBoot {
	// Your code goes here.

	// counter for the switch cas

	~crlButton = 0;

	~buttonMonitor = {
		var d1 = DigitalIn.kr(0); // Digital pin 0 - Butto
		SendReply.kr(Changed.kr(d1), '/buttonMonitor', [77, 99, d1, rrand(0,2)]);
		}.play;

	c = {
		arg red, green, blue;
		var redS = red;
		var greenS = green;
		var blueS = blue;
		DigitalOut.ar(2, redS.not);
		DigitalOut.ar(4, greenS.not);
		DigitalOut.ar(5, greenS.not);
	}.play;

		(
r = Routine({
	inf.do{
	(m.set(\amp, 1); l.set(\amp, 0); k.set(\amp, 0); c.set(\red, 1); c.set(\green, 0); c.set(\blue, 0)).yield;
	(m.set(\amp, 0); l.set (\amp, 1); k.set(\amp, 0); c.set(\red, 0); c.set(\green, 1); c.set(\blue, 0)).yield;
	(m.set(\amp, 0); l.set(\amp, 0); k.set (\amp, 1);c.set(\red, 1); c.set(\green, 0); c.set(\blue, 1)).yield;

	}
})
);


//if( msg[1] ==1, {r.next})

	OSCdef('listenToButtons', {
			arg msg;
			var contador;
			var aumento;
			// Buttons
			// el valor del mensaje comienza don el 3
			~trigger1 = msg[5].asInteger;
		//	~trigger1.postln;
			//contador = contador + aumento;
		//	postln(contador);
			//if(msg[5] == 1,{ k.set(\amp, rrand(0.0, 0.99).postln); m.set(\amp, rrand(0.0, 0.99).postln); l.set(\amp, rrand(0.0, 0.99).postln)});
			//if(msg[3] == 0,{ m.set(\amp, 0)});
			if(msg[5] == 1,{r.next});
			//contador = Stepper(msg[3], 0, 4, 1, 0);
		//	contador.postln;

		}, '/buttonMonitor');

	SynthDef(\ledFade, {
		//var rate = AnalogIn.ar(0).exprange(0.3, 20);
		//var amp = AnalogIn.ar(0); // returns a value from 0-1
		var rate = 0.1; //0.3 a 20
		var amp = 0.9; // returns a value from 0-1
		rate.poll(1); amp.poll(1);
		AnalogOut.ar(0, SinOsc.ar(rate).range(0.0, amp)); // send to Analog Output 0
	}).add;

/*
SynthDef(\FSM, {arg buttonPin, outLed1, outLed2, outLed3, state=0;
	//var volum = AnalogIn.ar(0).exprange(1, 6);
	//var volum = 0.5;
	var micros = SoundIn.ar([0]);
	var micros2 = SoundIn.ar([1]);
	var sig1, sig2;

	// read the value at the pin
	var button = DigitalIn.ar(buttonPin);
	//if([true, false],{"true".postln;}, {"false".postln;})
	//var rate = AnalogIn.ar(0).exprange(0.3, 20);
	//var amp = AnalogIn.kr(0); // returns a value from 0-1
	var amp = 1.0; // returns a value from 0-1
	var rate = 0.1; //0.3 a 20
	var filter;

	//var amp = 1.0; // returns a value from 0-1
	//button.postln;
	rate.poll(1);
	amp.poll(1);
	AnalogOut.ar(0, SinOsc.ar(rate).range(0.0, amp)); // send to Analog Output 0

	filter =
		[
			DigitalOut.ar(outLed1, button.not),
			DigitalOut.ar(outLed2, button.not),
			DigitalOut.ar(outLed3, button.not)
		];


	// toggle an LED on outPin
//	DigitalOut.ar(outLed1, button.not);
//	DigitalOut.ar(outLed2, button.not);
//	DigitalOut.ar(outLed3, button.not);
	//"Boton activado".postln;

	Select.ar(state, filter);

}).add;
*/

// synth that implements the sound filter that highlights the low frequencies
SynthDef.new(\biquadAltoBajo,
{
arg amp, red, green, blue;
var redS = red;
var greenS = green;
var blueS = blue;
var volum = amp;


//var volum = AnalogIn.ar(0).exprange(1, 6);
//var volum = 0.5;
var micros = SoundIn.ar([0]);
var micros2 = SoundIn.ar([1]);
var sig1, sig2;

sig1 = (SOS.ar(
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
	) * volum;
	// this is the stereo part
sig2 = (SOS.ar(
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
	) * volum;
	Out.ar(0, [sig1, sig2]);
}).add;

// synth that implements the sound filter that highlights the High frequencies
SynthDef.new(\biquadBajoAlto,
{
	arg amp;
var volum = amp;
//var volum = AnalogIn.ar(0).exprange(1, 6);
//var volum = 0.5;
var micros = SoundIn.ar([0]);
var micros2 = SoundIn.ar([1]);
var sig1, sig2;

sig1 = (SOS.ar(
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
	) * volum;
	// this is the stereo part
sig2 = (SOS.ar(
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
	) * volum;
	Out.ar(0, [sig1, sig2]);
}).add;


// synth that implements the sound filter that highlights equally all frequencies
SynthDef.new(\biquadFlat,
{
	arg amp;
var volum = amp;
//var volum = AnalogIn.ar(0).exprange(1, 6);
//var volum = 0.5;
var micros = SoundIn.ar([0]);
var micros2 = SoundIn.ar([1]);
var sig1, sig2;

sig1 = (SOS.ar(
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
	) * volum;
	// this is the stereo part
sig2 = (SOS.ar(
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
	) * volum;
	Out.ar(0, [sig1, sig2]);
}).add;


	// Synths are instantiated here
	//a = Synth.new(\buttonControl, [\inPin, 0, \outPin, 2]);
	//b = Synth('buttonControl', ['inPin', 0, 'outPin', 3]);
	//c = Synth('buttonControl', ['inPin', 0, 'outPin', 4]);

//	c = Synth(\FSM, [\buttonPin, 0, \outLed1, 2, \outLed2, 4, \outLed3, 5]);
//	c.set(\state, 1);

	d = Synth.new(\ledFade); // means the bela is alive

	// Synths with the filters are instantiated here, the idea would be to have a single Synth (maybe)
	// that has all the filters inside and depending on the button it plays one of each of the three filters

	k = Synth.new(\biquadAltoBajo);
	l = Synth.new(\biquadBajoAlto);
	m = Synth.new(\biquadFlat);

	s.sync;

};

ServerQuit.add({ 0.exit }); // quit if the button is pressed


