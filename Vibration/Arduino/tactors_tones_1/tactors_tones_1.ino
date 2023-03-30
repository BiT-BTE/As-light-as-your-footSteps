// Trying tones with tactors on ESP32 3,7 volts

// Change this depending on where you put your piezo buzzer
const int TONE_OUTPUT_PIN = 27;

// The ESP32 has 16 channels which can generate 16 independent waveforms
// We'll just choose PWM channel 0 here
const int TONE_PWM_CHANNEL = 0; 

void setup() {
  // ledcAttachPin(uint8_t pin, uint8_t channel);
  ledcAttachPin(TONE_OUTPUT_PIN, TONE_PWM_CHANNEL);
}

void loop() {
  // Plays the middle C scale
  ledcWriteTone(TONE_PWM_CHANNEL, 2);
  delay(6000);
  ledcWriteTone(TONE_PWM_CHANNEL, 0);
  delay(500);
}