s.boot; // boot the server

ServerOptions.inDevices.postln;//  post available audio input devices
s.meter;    // display level meters for monitoring
var input = AudioIn.ar(0); // first input

(
{
	var rho, theta, b1, b2;
	theta = MouseX.kr(0.2pi, pi);
	rho = MouseY.kr(0.6, 0.99);
	b1 = 2.0 * rho * cos(theta);
	b2 = rho.squared.neg;
	z = SOS.ar(AudioIn.ar(1), 1.0, 0.0, 0.0, b1, b2);
}.play;
FreqScope.new(400, 200, 0, server: s);
)

s.quit;