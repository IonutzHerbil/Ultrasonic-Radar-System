import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial serialPort;
String angleValue = "";
String distanceValue = "";
String incomingData = "";
String objectStatus;
float pixelDistance;
int angleInt, distanceInt;
int separatorIndex1 = 0;
int separatorIndex2 = 0;

void setup() {
    size(1200, 700);
    smooth();
    serialPort = new Serial(this, "COM6", 9600);
    serialPort.bufferUntil('.');
}

void draw() {
    fill(98, 245, 31);
    noStroke();
    fill(0, 4);
    rect(0, 0, width, height - height * 0.065);

    fill(98, 245, 31);
    drawRadarDisplay();
    drawMotionLine();
    drawDetectedObject();
    drawInfoText();
}

void serialEvent(Serial serialPort) {
    incomingData = serialPort.readStringUntil('.');
    incomingData = incomingData.substring(0, incomingData.length() - 1);

    separatorIndex1 = incomingData.indexOf(",");
    angleValue = incomingData.substring(0, separatorIndex1);
    distanceValue = incomingData.substring(separatorIndex1 + 1, incomingData.length());

    angleInt = int(angleValue);
    distanceInt = int(distanceValue);
}

void drawRadarDisplay() {
    pushMatrix();
    translate(width / 2, height - height * 0.074);
    noFill();
    strokeWeight(2);
    stroke(98, 245, 31);
    arc(0, 0, width - width * 0.0625, width - width * 0.0625, PI, TWO_PI);
    arc(0, 0, width - width * 0.27, width - width * 0.27, PI, TWO_PI);
    arc(0, 0, width - width * 0.479, width - width * 0.479, PI, TWO_PI);
    arc(0, 0, width - width * 0.687, width - width * 0.687, PI, TWO_PI);

    line(-width / 2, 0, width / 2, 0);
    for (int angle = 30; angle <= 150; angle += 30) {
        line(0, 0, (-width / 2) * cos(radians(angle)), (-width / 2) * sin(radians(angle)));
    }
    popMatrix();
}

void drawDetectedObject() {
    pushMatrix();
    translate(width / 2, height - height * 0.074);
    strokeWeight(9);
    stroke(255, 10, 10);
    pixelDistance = distanceInt * ((height - height * 0.1666) * 0.025);
    if (distanceInt < 40) {
        line(pixelDistance * cos(radians(angleInt)), -pixelDistance * sin(radians(angleInt)),
             (width - width * 0.505) * cos(radians(angleInt)),
             -(width - width * 0.505) * sin(radians(angleInt)));
    }
    popMatrix();
}

void drawMotionLine() {
    pushMatrix();
    strokeWeight(9);
    stroke(30, 250, 60);
    translate(width / 2, height - height * 0.074);
    line(0, 0, (height - height * 0.12) * cos(radians(angleInt)), -(height - height * 0.12) * sin(radians(angleInt)));
    popMatrix();
}

void drawInfoText() {
    pushMatrix();
    if (distanceInt > 40) {
        objectStatus = "Out of Range";
    } else {
        objectStatus = "In Range";
    }

    fill(0, 0, 0);
    noStroke();
    rect(0, height - height * 0.0648, width, height);
    fill(98, 245, 31);
    textSize(25);
    text("10cm", width - width * 0.3854, height - height * 0.0833);
    text("20cm", width - width * 0.281, height - height * 0.0833);
    text("30cm", width - width * 0.177, height - height * 0.0833);
    text("40cm", width - width * 0.0729, height - height * 0.0833);

    textSize(40);
    text("SciCraft", width - width * 0.875, height - height * 0.0277);
    text("Angle: " + angleInt + " °", width - width * 0.48, height - height * 0.0277);
    text("Distance: ", width - width * 0.26, height - height * 0.0277);
    if (distanceInt < 40) {
        text("        " + distanceInt + " cm", width - width * 0.225, height - height * 0.0277);
    }

    textSize(25);
    fill(98, 245, 60);
    int[] angleMarkers = {30, 60, 90, 120, 150};
    for (int marker : angleMarkers) {
        pushMatrix();
        translate((width - width * 0.5) + width / 2 * cos(radians(marker)),
                  (height - height * 0.09) - width / 2 * sin(radians(marker)));
        rotate(radians(-marker + 90));
        text(marker + "°", 0, 0);
        popMatrix();
    }
    popMatrix();
}
