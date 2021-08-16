clear
clc

 img = imread('Camping.jpg');
% img = imread('Dive.png');
img = imresize(img,0.3);
% imshow(img);

% detector = vision.CascadeObjectDetector('ClassificationModel','Mouth');
detector=vision.CascadeObjectDetector('Mouth','MergeThreshold',100);


bbox = detector(img);
whos bbox;

IFaces = insertObjectAnnotation(img,'rectangle',bbox,'Mouth');   
% mouth = imcrop(img, bbox);
figure
% imshow(IFaces)
% imshow(mouth);
title('Detected faces');

% Aint = int16.empty(0,4);
Bdouble = double.empty(0,4);
a = double(bbox);

if size(a) == size(Bdouble)
    figure
    imshow(img);
    whos img;
    title("inside if")
end    

whos Bdouble;