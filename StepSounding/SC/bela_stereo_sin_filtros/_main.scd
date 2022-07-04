/*******************
Hello Bela!
Connect your headphones to the stereo audio output of the Bela and run this program.

(c) 2017: Jonathan Reus, Marije Baalman, Giulio Moro, Andrew McPherson
*/

// The latency with out filter in SC is the 0.259 ms

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

{SoundIn.ar([0,1])*5}.play;

};

ServerQuit.add({ 0.exit }); // quit if the button is pressed