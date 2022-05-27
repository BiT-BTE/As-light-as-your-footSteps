/*
  WiFiAccessPoint.ino creates a WiFi access point and provides a web server on it.

  Steps:
  1. Connect to the access point "yourAp"
  2. Point your web browser to http://192.168.4.1/H to turn the LED on or http://192.168.4.1/L to turn it off
     OR
     Run raw TCP "GET /H" and "GET /L" on PuTTY terminal with 192.168.4.1 as IP address and 80 as port

  Created for arduino-esp32 on 04 July, 2018
  by Elochukwu Ifediora (fedy0)
*/

#include <WiFi.h>
#include <WiFiClient.h>
#include <WiFiAP.h>

#define motors 2 // Set the GPIO pin where you connected your test LED or comment this line out if your dev board has a built-in LED

// Set these to your desired credentials.
const char *ssid = "DRAGONesp";
const char *password = "1234567890";

WiFiServer server(80);

/////////////////////// This part is for the PWM function

// use first channel of 16 channels (started from zero)
#define LEDC_CHANNEL_0     0

// use 13 bit precission for LEDC timer
#define LEDC_TIMER_13_BIT  13

// use 5000 Hz as a LEDC base frequency
#define LEDC_BASE_FREQ     5000

// fade LED PIN (replace with LED_BUILTIN constant for built-in LED)
#define LED_PIN            3

int brightness = 0;    // how bright the LED is
int fadeAmount = 5;    // how many points to fade the LED by
int fadePaulatino = 60;

// Arduino like analogWrite
// value has to be between 0 and valueMax
void ledcAnalogWrite(uint8_t channel, uint32_t value, uint32_t valueMax = 255) {
  // calculate duty, 8191 from 2 ^ 13 - 1
  uint32_t duty = (8191 / valueMax) * min(value, valueMax);

  // write duty to LEDC
  ledcWrite(channel, duty);
}
/////////////////////// Para controlar la onda triangular

boolean vibrationTrOn = false;

///////////////////// delay sin delay

int period = 60;
unsigned long time_now = 0;


void setup()
{
  //pinMode(motors, OUTPUT);

  Serial.begin(115200);
  Serial.println();
  Serial.println("Configuring access point...");

  // You can remove the password parameter if you want the AP to be open.
  WiFi.softAP(ssid, password);
  IPAddress myIP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(myIP);
  server.begin();

  Serial.println("Server started");

  /////////////////////////// Yhis part is also for the PWM
  // Setup timer and attach timer to a led pin
  ledcSetup(LEDC_CHANNEL_0, LEDC_BASE_FREQ, LEDC_TIMER_13_BIT);
  ledcAttachPin(motors, LEDC_CHANNEL_0);




}

void loop()
{
  WiFiClient client = server.available(); // listen for incoming clients

  if (client)
  { // if you get a client,
    Serial.println("New Client."); // print a message out the serial port
    String currentLine = "";       // make a String to hold incoming data from the client
    while (client.connected())
    { // loop while the client's connected
      if (client.available())
      { // if there's bytes to read from the client,
        char c = client.read(); // read a byte, then
        Serial.write(c);        // print it out the serial monitor
        if (c == '\n')
        { // if the byte is a newline character

          // if the current line is blank, you got two newline characters in a row.
          // that's the end of the client HTTP request, so send a response:
          if (currentLine.length() == 0)
          {
            // HTTP headers always start with a response code (e.g. HTTP/1.1 200 OK)
            // and a content-type so the client knows what's coming, then a blank line:
            client.println("HTTP/1.1 200 OK");
            client.println("Content-type:text/html");
            client.println();

            // the content of the HTTP response follows the header:
            client.print("Click <a href=\"/H\">ON</a> to turn ON the Vibrators.<br>");
            client.print("Click <a href=\"/L\">OFF</a> to turn OFF the Vibrators.<br>");
            client.print("Click <a href=\"/MM\">+</a> to this increase the Vibrations.<br>");
            client.print("Click <a href=\"/MN\">-</a> to this decrease the Vibrations.<br>");
            client.print("Click <a href=\"/T\">Triangel</a> to turn a Triangular Vibration.<br>");
            client.print("Click <a href=\"/S\">Sin</a> to turn Sin Vibration.<br>");
            client.print("Click <a href=\"/ST\">Saw Tooth</a> to turn a Saw Tooth Vibration.<br>");

            client.print("<p>Spect poison from standing water</p>");

            // The HTTP response ends with another blank line:
            client.println();
            // break out of the while loop:
            break;
          }
          else
          { // if you got a newline, then clear currentLine:
            currentLine = "";
          }
        }
        else if (c != '\r')
        { // if you got anything else but a carriage return character,
          currentLine += c; // add it to the end of the currentLine
        }

        // Check to see if the client request was "GET /H" or "GET /L":
        if (currentLine.endsWith("GET /H"))
        {
          //digitalWrite(motors, HIGH); // GET /H turns the LED on
          brightness = 255;
          ledcAnalogWrite(LEDC_CHANNEL_0, brightness);
        }
        if (currentLine.endsWith("GET /L"))
        {
          //digitalWrite(motors, LOW); // GET /L turns the LED off
          brightness = 0;
          ledcAnalogWrite(LEDC_CHANNEL_0, brightness);
          vibrationTrOn = false;
        }
        if (currentLine.endsWith("GET /MM")) {
          vPaulatina(fadePaulatino);
        }
        if (currentLine.endsWith("GET /MN")) {
          vPaulatina(-fadePaulatino);
        }
        if (currentLine.endsWith("GET /T")) {
          brightness = 0;
          vibrationTrOn = true;
        }
        if (currentLine.endsWith("GET /S"))
        {
          digitalWrite(motors, LOW); // GET /L turns the LED off
        }
        if (currentLine.endsWith("GET /ST"))
        {
          digitalWrite(motors, HIGH); // GET /L turns the LED off
        }
      }
    }
    // close the connection:
    client.stop();
    Serial.println("Client Disconnected.");
  }

  tVibration(vibrationTrOn);
}

void vPaulatina(int nivelV) {
  // change the brightness for next time through the loop:
  brightness += nivelV;

  // reverse the direction of the fading at the ends of the fade:
  if (brightness <= 0) {
    brightness = 0;
  }
  if (brightness >= 255) {
    brightness = 255;
  }

  // set the brightness on LEDC channel 0
  ledcAnalogWrite(LEDC_CHANNEL_0, brightness);
}


void tVibration(boolean _vibrationTrOn) {
  // set the brightness on LEDC channel 0
  if (_vibrationTrOn) {

    if (millis() >= time_now + period) {
      time_now += period;
      //Serial.println("Hello");

      ledcAnalogWrite(LEDC_CHANNEL_0, brightness);

      // change the brightness for next time through the loop:
      brightness = brightness + fadeAmount;

      // reverse the direction of the fading at the ends of the fade:
      if (brightness <= 0 || brightness >= 255) {
        fadeAmount = -fadeAmount;
      }
      // wait for 30 milliseconds to see the dimming effect
      //delay(120);
    }
  }
}

/*

  if (client) {
    Serial.println("new client");
    // an http request ends with a blank line
    boolean currentLineIsBlank = true;
    while (client.connected()) {
      if (client.available()) {
        char c = client.read();
        Serial.write(c);
        // if you've gotten to the end of the line (received a newline
        // character) and the line is blank, the http request has ended,
        // so you can send a reply
        if (c == '\n' && currentLineIsBlank) {
          // send a standard http response header
          client.println("HTTP/1.1 200 OK");
          client.println("Content-Type: text/html");
          client.println("Connection: close");  // the connection will be closed after completion of the response
          client.println("Refresh: 5");  // refresh the page automatically every 5 sec
          client.println();
          client.println("<!DOCTYPE HTML>");
          client.println("<html>");
          // output the value of each analog input pin
          for (int analogChannel = 0; analogChannel < 6; analogChannel++) {
            int sensorReading = analogRead(analogChannel);
            client.print("analog input ");
            client.print(analogChannel);
            client.print(" is ");
            client.print(sensorReading);
            client.println("<br />");
          }
          client.println("</html>");
          break;
        }
        if (c == '\n') {
          // you're starting a new line
          currentLineIsBlank = true;
        } else if (c != '\r') {
          // you've gotten a character on the current line
          currentLineIsBlank = false;
        }
      }
    }
    // give the web browser time to receive the data
    delay(1);
    // close the connection:
    client.stop();
    Serial.println("client disconnected");
  }

*/
