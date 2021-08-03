# Heart-Rate-and-Breathing-Rate-Strap

The device that was built was the Heart Rate and Breathing Rate Strap where it is a device
worn around the chest area in order to get the readings of the heart rate and breathing rate.
In order to achieve that I used a heart monitor sensor that gets attached on the chest strap that
has a clasp and velcro to hold in place on the body. In addition to it the chest strap will also
obtain a reader for the breathing rate which is a force sensor resistor. The result of the device
was that the user is able to see the data that gets displayed as a graph on the user interface for
the following modes called stress, fitness, and meditation. The modes visually indicate on the
graph how the rate fluctuates based on the mode they are in and color codes the readings as
well.

I. INTRODUCTION

Monitoring the heart and breathing rate can help users identify how their moods correlate with
the rate of their heart. The device aims to keep users inform how their heart rate correlates
based on their mood and to also help users to reach a certain mode on the device. The device
contains three modes that can be reached by the user if the user monitors the interface in order
to change their rate for a different mode. There are similar devices that monitor the heart and
breathing rate such as the wristband fitbit, clothing based monitors, and arm bands. The
purpose of these devices is to continuously monitor the heart rate and ECG for periods of time.
This is in the hopes to help users stay informed to either reach a health decision if they notice
their rate is acting differently or to reach a certain goal to improve cardiovascular health.
The heart rate is measured by the AD8232 heart monitor board that obtains embedded
electronics to collect ECG signals. The ECG evaluates the heart with electrodes that get placed
in specific positions on the body. Once they are placed it collects electrical activity of the heart
and then outputs the value. This is going to help indicate at what rate the heart is beating.
Therefore, the heart rate and breathing strap is developed in order to indicate those readings
and also display the readings for the users to be able to see what mode they are in based on
their mood.

II. METHODS

a. Hardware
The hardware was developed by the use of protoboards that had male and female headers
soldered and then clipped down. This is going to make the connection to the peripheral board
without being permanent on the board. The ECG board then gets five headers that get solder
with the exception of SDN. These headers get solder on D9, then we wire wrap the headers.
The wires get threaded through the holes based on their color indication and then solder (clip off
excessive wire). The FSR then gets a resistor wire wrapped and goes to GND on the board. The
other pin gets wire wrapped and connects to 3v3. The FSR gets a piece of tape behind so it
can stay in position on the 3d printed holder.

b. Software
For software we used arduino ide with the serial output to processing 3, in processing 3 we
used the libraries controlP5 and Serial. The controlP5 allows functionality for GUI buttons,
textfields, text labels. The serial library is going to let input from arduino serial print, processing
tokens.

CONCLUSION
The device aims to keep users informed how their heart rate correlates based on their mood
and to also help users to reach a certain mode on the device. However, it did have its
limitations due to the hardware being finicky; it did not allow for consistent readings. The device
also couldt store data information for later analysis. Device also doesn't present changes
between modes; it just indicates whether a mode has been achieved. For future improvements
having better signal range and storage bit into the device could help for better readings and data
storage. The software to allow suggested achieved modes instead of a yes or no context
achievement. A reliable hardware allows for clearer analog signals. Also separate which rate to
read in so users can pick if they want heart or breathing rate measured.
