// Trying tone with tactors in Arduino 5 volts
int dur = 200;


void setup() {
}

void loop() {
      // play the note corresponding to this sensor:
      tone(9, 1);
      delay(dur);
      noTone(9);
      delay(dur);

}
