# Face Mask Detection using MATLAB

We have used viola jones algorithm to detect face, nose and mouth. 
First we converted the image to grayscale and added guassian filter to it, then did the face recognition and cropped the face.
Later we detected the nose & mouth part. 

If both mouth and nose were detected we passed the message as "Wear mask".
If either one of them were detected (XOR) "Please wear mask properly"
And if nothing was detected "Thank you for wearing mask."

GUI.m is the main working script.
reduceThresholdValue.m is not used for the project, the code will be usefull if you need to reduce threshold value at some point.
