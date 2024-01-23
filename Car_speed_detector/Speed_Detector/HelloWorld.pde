// |———————————————————————————————————————————————————————| 
// |  made by Arduino_uno_guy 11/13/2019                   |
// |   https://create.arduino.cc/projecthub/arduino_uno_guy|
//  |———————————————————————————————————————————————————————|


#include <LiquidCrystal_I2C.h>

#include  <Wire.h>

//initialize the liquid crystal library
//the first parameter is  the I2C address
//the second parameter is how many rows are on your screen
//the  third parameter is how many columns are on your screen
LiquidCrystal_I2C lcd(0x3F,  16, 2);
int timer1;
int timer2;
float Time;
int flag1 = 0;
int flag2 = 0;
float distance = 5.0;
float speed;
int ir_s1 = 8;
int ir_s2 = 9;

void setup() {
  
  lcd.begin(16, 2);

  lcd.init(); // Initialize the LCD
  lcd.backlight();
 
  pinMode(ir_s1, INPUT);
 
  pinMode(ir_s2, INPUT);
 
  Serial.begin(9600);
 
  lcd.clear();
 
 
  
}
void loop() {
  
 if (digitalRead(ir_s1) == LOW && flag1 == 0) {
    timer1 = millis();
    flag1 = 1;
  }

  if (digitalRead(ir_s2) == LOW && flag2 == 0) {
    timer2 = millis();
    flag2 = 1;
  }

  if (flag1 == 1 && flag2 == 1) {
    if (timer1 > timer2) {
      Time = timer1 - timer2;
    } else if (timer2 > timer1) {
      Time = timer2 - timer1;
    }
    Time = Time / 1000;        // convert millisecond to second
    speed = (distance / Time); // v = d / t
    speed = speed * 3600;      // multiply by seconds per hr
    speed = speed / 1000;      // division by meters per Km
  }

  if (speed == 0) {
    lcd.setCursor(0, 1);
    if (flag1 == 0 && flag2 == 0) {
      lcd.print("No car  detected");
    } else {
      lcd.print("Searching...    ");
    }
  } else {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Speed:");
    lcd.print(speed, 1);
    lcd.print("Km/Hr  ");
    lcd.setCursor(0, 1);
    if (speed > 50) {
      lcd.print("  Over Speeding  ");
    } else {
      lcd.print("  Normal Speed   ");
    }
    delay(3000);
    speed = 0;
    flag1 = 0;
    flag2 = 0;
  }
  
}