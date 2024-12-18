#include <Servo.h>

const int triggerPin = 10;
const int echoPin = 11;
long timeElapsed;
int measuredDistance;
Servo servoMotor;

void setup() {
    pinMode(triggerPin, OUTPUT);
    pinMode(echoPin, INPUT);
    Serial.begin(9600);
    servoMotor.attach(12);
}

void loop() {
    for (int angle = 15; angle <= 165; angle++) {
        servoMotor.write(angle);
        delay(30);
        measuredDistance = getDistance();

        Serial.print(angle);
        Serial.print(",");
        Serial.print(measuredDistance);
        Serial.print(".");
    }

    for (int angle = 165; angle > 15; angle--) {
        servoMotor.write(angle);
        delay(30);
        measuredDistance = getDistance();

        Serial.print(angle);
        Serial.print(",");
        Serial.print(measuredDistance);
        Serial.print(".");
    }
}

int getDistance() {
    digitalWrite(triggerPin, LOW);
    delayMicroseconds(2);
    digitalWrite(triggerPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(triggerPin, LOW);

    timeElapsed = pulseIn(echoPin, HIGH);
    return timeElapsed * 0.034 / 2;
}
