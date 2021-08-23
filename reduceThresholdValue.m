% If nose not detected for the given threshold value we want to reduce
% threshold value until it detects it

NoseFound = 0; % initial state, as if nose not found

while NoseFound == 0
    % declaring nose detector
    nosedetector=vision.CascadeObjectDetector('Nose');
    % set innitial threshold value you want
    nosedetector.MergeThreshold = 40;
    % box for mouth detection
    nosebox = nosedetector(faceCropedImg);

     if(sum(sum(nosebox))~=0) % if nose is found
          % while threshold value is greater than (number) reduce the
          % threshold
          while nosedetector.MergeThreshold > 10
              %reduce by 1
              nosedetector.MergeThreshold = nosedetector.MergeThreshold - 1;
              %if any one object found break the loop and show the detected
              %image
              if(sum(sum(nosebox))~=0)
                  nose = insertObjectAnnotation(faceCropedImg, 'rectangle', nosebox, 'Nose'); % Annotation
                  NoseFound = 1; % breaks the condition
                  axes(handles.axes3);
                  imshow(nose); 
                  break;
              elseif nosedetector.MergeThreshold == 20
                  nose = insertObjectAnnotation(faceCropedImg, 'rectangle', nosebox, 'Nose');
                  NoseFound = 0;
                  axes(handles.axes3);
                  imshow(nose); 
                  break;
              end
          
          end
          break;
     else  % if nose detected at the given threshold value
          nose = insertObjectAnnotation(faceCropedImg, 'rectangle', nosebox, 'Nose'); % Annotation
          % nose = imcrop(faceCropedImg, bb_m); % Crop segmented nose
          NoseFound = 1;
          axes(handles.axes3);
          imshow(nose); 
      end
end