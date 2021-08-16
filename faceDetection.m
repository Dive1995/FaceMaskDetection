img = imread('Camping.jpg');
img = imresize(img,0.3);
imshow(img);

detector = vision.CascadeObjectDetector;

bbox = detector(img);

IFaces = insertObjectAnnotation(img,'rectangle',bbox,'Face');   
figure
imshow(IFaces)
title('Detected faces');