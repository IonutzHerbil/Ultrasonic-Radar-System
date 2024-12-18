# Ultrasonic-Radar-System
Ultrasonic radar system using Arduino and Processing to detect and visualize objects in real-time. Features include angle scanning, distance measurement, and radar-style visualization.

# Working principle
The ultrasonic radar system operates by integrating an ultrasonic sensor, a servo motor, and a microcontroller (Arduino) to detect and measure the distance of objects within its range. The ultrasonic sensor emits high-frequency sound waves, which travel through the air and reflect back upon hitting an object. The time taken for the sound waves to return is measured and used to calculate the distance of the object.

The servo motor rotates the ultrasonic sensor across a defined angular range, enabling it to scan the surroundings and capture distance data at various angles. The Arduino processes this information and communicates the angle and distance measurements to a connected computer via serial communication.

A Processing sketch running on the computer visualizes the data in real-time. The radar-like interface dynamically displays the detected objects, showing their distance and position relative to the sensor. This setup provides an intuitive way to visualize spatial information, making it useful for educational purposes, prototype development, or hobby projects.

![radar](https://github.com/user-attachments/assets/686fe4f5-bcfd-42f4-87b7-eb8496014d46)
