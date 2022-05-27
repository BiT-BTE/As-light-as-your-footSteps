/*
  Blink

  Turns an LED on for one second, then off for one second, repeatedly.

  Most Arduinos have an on-board LED you can control. On the UNO, MEGA and ZERO
  it is attached to digital pin 13, on MKR1000 on pin 6. LED_BUILTIN is set to
  the correct LED pin independent of which board is used.
  If you want to know what pin the on-board LED is connected to on your Arduino
  model, check the Technical Specs of your board at:
  https://www.arduino.cc/en/Main/Products

  modified 8 May 2014
  by Scott Fitzgerald
  modified 2 Sep 2016
  by Arturo Guadalupi
  modified 8 Sep 2016
  by Colby Newman

  This example code is in the public domain.

  https://www.arduino.cc/en/Tutorial/BuiltInExamples/Blink
*/

const int pot = 0;

const int drive1 = 11;
const int drive2 = 10;
const int drive3 = 9;
const int drive4 = 6;
const int drive5 = 5;

const int stopVib = 0;

const int periodOn = 250;
const int periodOff = 25;

const int longDelay = 50000;



// the setup function runs once when you press reset or power the board
void setup()
{
  Serial.begin(9600);
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(drive1, OUTPUT);
  pinMode(drive2, OUTPUT);
  pinMode(drive3, OUTPUT);
  pinMode(drive4, OUTPUT);
  pinMode(drive5, OUTPUT);
}

// the loop function runs over and over again forever
void loop()
{
  int intensity = map(analogRead(pot), 0, 1023, 0, 255);

  analogWrite(drive1, intensity); // turn the LED on (HIGH is the voltage level)
  delay(periodOn);

  analogWrite(drive1, intensity / 2); // turn the LED on (HIGH is the voltage level)
  analogWrite(drive2, intensity);
  delay(periodOn);

  analogWrite(drive1, stopVib); // turn the LED on (HIGH is the voltage level)
  analogWrite(drive2, intensity / 2);
  analogWrite(drive3, intensity);
  delay(periodOn);

  analogWrite(drive2, stopVib); // turn the LED on (HIGH is the voltage level)
  analogWrite(drive3, intensity / 2);
  analogWrite(drive4, intensity);
  delay(periodOn);

  analogWrite(drive3, stopVib); // turn the LED on (HIGH is the voltage level)
  analogWrite(drive4, intensity / 2);
  analogWrite(drive5, intensity);
  delay(periodOn);

  analogWrite(drive4, stopVib); // turn the LED on (HIGH is the voltage level)
  analogWrite(drive5, intensity);
  delay(periodOn*2);

  analogWrite(drive5, stopVib);
  delay(longDelay);

}
