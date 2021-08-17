clear
clc

 img = imread('notproperly2.jpeg');
% img = imread('Dive.png');
% img = imresize(img,0.3);
% imshow(img);

% detector = vision.CascadeObjectDetector('ClassificationModel','Mouth');
% % mouthdetector=vision.CascadeObjectDetector('Mouth');
% % mouthdetector.MergeThreshold = 60;
% ,'MergeThreshold',100


% % mouthbox = mouthdetector(img);
% % whos mouthbox;

% % IFaces = insertObjectAnnotation(img,'rectangle',mouthbox,'Mouth');   
% mouth = imcrop(img, bbox);
% figure
% imshow(IFaces)
% imshow(mouth);
% title('Detected faces');


% % Bdouble = double.empty(0,4);
% % box = double(mouthbox);





% taking mouthnot found as in initial state
MouthFound = 0;

while MouthFound == 0
    % declaring mouth detector
    mouthdetector=vision.CascadeObjectDetector('Mouth');
    
    % set innitial threshold value
    mouthdetector.MergeThreshold = 200;
    % box for mouth detection
    mouthbox = mouthdetector(img);
    
%     whos mouthbox;

    %declaring empty matrix as double type
    emptyDouble = double.empty(0,4);
    % to check if any detection found #here we only need the size only
    notEmptyDouble = ones(1,4);

     if size(mouthbox) == size(emptyDouble) % Check if a mouth is found
         % a is declared for testing purposes
          a=mouthdetector.MergeThreshold
          
          %while threshold value is greater than 5 decrease threshold value by 1 
          while mouthdetector.MergeThreshold > 5
              %b is declared for testing purpose
              b=mouthdetector.MergeThreshold
              
              %reduce by 1
              mouthdetector.MergeThreshold = mouthdetector.MergeThreshold - 1;
              %find for detection
              mouthbox = mouthdetector(img);
%               whos mouthbox;
              %if any one object found break the loop and show the detected
              %image
              if size(mouthbox) == size(notEmptyDouble)
                  mouth = insertObjectAnnotation(img, 'rectangle', mouthbox, 'Mouth'); % Annotation
                  MouthFound = 1;
                  figure;
                  imshow(mouth);
                  title('finally mouth found')
                  break;
              end
          end
          break;
     else  
          mouth = insertObjectAnnotation(img, 'rectangle', mouthbox, 'Mouth'); % Annotation
          % mouth = imcrop(face, bb_m); % Crop segmented mouth
          MouthFound = 1;
          figure;
          imshow(mouth);
          title('mouth found')
      end
 end










% Aint = int16.empty(0,4);
% Bdouble = double.empty(0,4);
% a = double(bbox);
% 
% if size(a) == size(Bdouble)
%     figure
%     imshow(img);
%     whos img;
%     title("inside if")
% end    
% 
% whos Bdouble;