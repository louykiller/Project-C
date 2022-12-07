# Objective of the project
Mesure the speed of sound by making use of 2 microphones plugged into an Arduino board sending the values read via Wi-Fi to the computer where a program in Processing, will display and visualize the data in a graphic.

# Requirements
- The communication between the Arduino and the computer should be made via Wi-Fi (If not possible use cable connection)
- The 2 Microphones need to be connected with cables to the Arduino
- The transmission of data (the time of reading and sending the data) needs to be fast enough to display it properly 
- Needs to be a simple implementation. KISS (Keep It Simple Student!)

# Development plan
There are 4 main steps to reach the objective:
In Arduino:
1st - Read the values captured by the 2 microphones (plugged by wires in the Arduino) and treat the data (encoding, compressing, etc)
2nd - Send UDP packages containing these values with the Wi-Fi antena (we need to figure out the optimal size of the packets to send)
In Processing:
3rd - These packets need to be recieved in Processing (and decode, decompress, etc) to be used in the program
4th - Finally this data recieved will be displayed in a x and y graphic where the x value is the value captured by the 1st microphone and the y value is the value of the 2nd microphone
