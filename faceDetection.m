img = imread('Camping.jpg');
img = imresize(img,0.3);
% imshow(img);

% detector = vision.CascadeObjectDetector('ClassificationModel','Mouth');
detector=vision.CascadeObjectDetector('Mouth','MergeThreshold',30);

bbox = detector(img);

IFaces = insertObjectAnnotation(img,'rectangle',bbox,'Mouth');   
figure
imshow(IFaces)
title('Detected faces');