/*
This script exemplifies the use of SuperCollider on Bela.
When a project contains a `_main.scd` file, `sclang` is started
and the content of the file is executed.
The examples in SuperCollider/ include more code examples to interface
with Bela-specific UGens.
If you want to interact with SuperCollider running on the board
from within the SuperCollider IDE on your computer, check out
the SuperCollider/7-remote-control examples instead.
*/
s = Server.default;

s.options.numAnalogInChannels = 8;
s.options.numAnalogOutChannels = 8;
s.options.numDigitalChannels = 16;

s.options.blockSize = 16;
s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 2;

s.options.postln;

s.waitForBoot({
	//synths examples

  s.sync;


	~buttonMonitor = {
			 var d1 = DigitalIn.kr(); // Digital pin 1 - Button


	//Analog	(in the future)
	// ~ctrl = {
	// 	var a0 = AnalogIn.ar(0) * 0.5;
	// 	var a1 = AnalogIn.ar(1) * 0.5;
	// 	SendReply.kr(Impulse.kr(10), '/ctrl', [a0, a1]);
	// }.play;

	// ~dur = 0.2;
	// ~amp = 0.8;
	// ~pitch = 300;
	// OSCdef('listen', {arg msg;
	// 	~amp = msg[3].linexp(0.0, 1.0, 0.1, 0.8);
	// 	~dur = msg[4].linexp(0.1, 1.0, 1.0, 0.01);
	// 	~pitch = msg[4].linlin(0.0, 1.0, 80, 800);
	// 	//[~amp, ~dur, ~pitch].postln;
	// }, '/ctrl');



SendReply.kr(Changed.kr(d1+d2+d3), '/buttonMonitor', [ d1, d2, d3]);
		}.play;


//counter list
a = Routine.new({ 1.yield; 2.yield;  3.yield; 4.yield; 5.yield; 6.yield; 7.yield; 8.yield; 9.yield; 10.yield});
b = Routine.new({ 1.yield; 2.yield;  3.yield; 4.yield; 5.yield; 6.yield; 7.yield; 8.yield; 9.yield; 10.yield});
c = Routine.new({ 1.yield; 2.yield;  3.yield; 4.yield; 5.yield; 6.yield; 7.yield; 8.yield; 9.yield; 10.yield});


		~button1 = 0;
		~button2 = 0;
		~button3 = 0;


// Listen to the buttons
		OSCdef('listenToButtons', {
			arg msg;
			// Buttons
			~trigger1 = msg[3].asInteger;
			~trigger1.postln;
			~trigger2 = msg[4].asInteger;
			~trigger3 = msg[5].asInteger;


		//counter

			if(msg[3] == 1,{ ~button1 = a.next;  });  //["Scene: " ++ ~button1].postln;
			if(msg[4] == 1,{ ~button2 = b.next;  });
			if(msg[5] == 1,{ ~button3 = c.next;  }); //msg[5].asInteger;



			//Clocker to check result and restart in 1.5 SuperCollider

			(
			t = Task({

				2.wait;
				if(msg[3] == 1,{
				~resultbutton1 = ~button1;
				["Scene: " ++ ~resultbutton1].postln;
				});
				if(msg[4] == 1,{
				~resultbutton2 = ~button2;
				["Synth: " ++ ~resultbutton2].postln;
				});
				if(msg[5] == 1,{
				~resultbutton3 = ~button3;
				["Parameters: " ++ ~resultbutton3].postln
				});

			    2.yield;
				    a.reset;
				    b.reset;
				    c.reset;
			    });
			t.start;
			);


		~resultbutton1.postln;

		//working
		// q = Synth(\shh);
    	// 	q.set(\t_trig, ~trigger1);

 				if(~resultbutton1 == 1, {
				q = Synth(\shh);
 				q.set(\t_trig, ~trigger1)
			    });

		}, '/buttonMonitor');

});


ServerQuit.add({ 0.exit }); // quit if the button is pressed


