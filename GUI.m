function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 16-Aug-2021 14:33:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
% get image
[filename, pathname]=uigetfile({'*.bmp;*.jpg;*.jpeg;*.tif;*.png;','IMAGE FILES (*.bmp,*.jpg,*.jpeg,*.tif,*.png)'},'Choose an image');
img=imread(filename);

% show image in the GUI axes
axes(handles.axes1);
imshow(img);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img;
global faceCropedImg;
global emptyArray;
global mouthHasBeenDetected;
global noseHasBeenDetected;

%% resizing the croped image ## because it is small

 faceCropedImg = imresize(faceCropedImg,1.5);
 
%% testing part
% taking mouthnot found as in initial state
MouthFound = 0;

while MouthFound == 0
    % declaring mouth detector
    mouthdetector=vision.CascadeObjectDetector('Mouth');
    
    % set innitial threshold value
    mouthdetector.MergeThreshold = 200;
    % box for mouth detection
    mouthbox = mouthdetector(faceCropedImg);
    
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
              c=mouthdetector.MergeThreshold
              
              %reduce by 1
              mouthdetector.MergeThreshold = mouthdetector.MergeThreshold - 1;
              %find for detection
              mouthbox = mouthdetector(faceCropedImg);
%               whos mouthbox;
              %if any one object found break the loop and show the detected
              %image
              if size(mouthbox) == size(notEmptyDouble)
                  mouth = insertObjectAnnotation(faceCropedImg, 'rectangle', mouthbox, 'Mouth'); % Annotation
                  MouthFound = 1;
%                   figure;
%                   imshow(mouth);
%                   title('finally mouth found')
                  axes(handles.axes4);
                  imshow(mouth); 
                  break;
              elseif mouthdetector.MergeThreshold == 6
                  mouth = insertObjectAnnotation(faceCropedImg, 'rectangle', mouthbox, 'Mouth');
                  MouthFound = 0;
                  axes(handles.axes4);
                  imshow(mouth); 
                  break;
              end
          end
          break;
     else  
          mouth = insertObjectAnnotation(faceCropedImg, 'rectangle', mouthbox, 'Mouth'); % Annotation
          % mouth = imcrop(face, bb_m); % Crop segmented mouth
          MouthFound = 1;
          axes(handles.axes4);
          imshow(mouth); 
%           figure;
%           imshow(mouth);
%           title('mouth found')
      end
 end

 

%% 
 %%  displaying the mouth detection if detected

%  mouthdetector=vision.CascadeObjectDetector('Mouth','MergeThreshold',200);
%  
%  mouthbox = mouthdetector(faceCropedImg);
%  whos mouthbox;
%  
%  mouth = insertObjectAnnotation(faceCropedImg,'rectangle',mouthbox,'Mouth');   
%  mouthHasBeenDetected = true;
%  axes(handles.axes4);
%  imshow(mouth); 
 

%% check if there is no mouth detection 
 
% Bdouble = double.empty(0,4);
% box = double(mouthbox);
% 
% if size(box) == size(Bdouble)
% %     set global variable mouthHasBeenDetected to false
% 
% mouthHasBeenDetected = false;
% axes(handles.axes4);
% imshow('nodetection.jpeg');
% end


% % mouthdetect = vision.CascadeObjectDetector('Mouth');

% mouthdetect.MergeThreshold = 1; % Threshold value, starts at 1 or any value you want


%% testing for nose
% taking mouthnot found as in initial state
NoseFound = 0;

while NoseFound == 0
    % declaring mouth detector
    nosedetector=vision.CascadeObjectDetector('Nose');
    
    % set innitial threshold value
    nosedetector.MergeThreshold = 200;
    % box for mouth detection
    mouthbox = nosedetector(faceCropedImg);
    
%     whos mouthbox;

    %declaring empty matrix as double type
    emptyDouble = double.empty(0,4);
    % to check if any detection found #here we only need the size only
    notEmptyDouble = ones(1,4);

     if size(mouthbox) == size(emptyDouble) % Check if a mouth is found
         % a is declared for testing purposes
          a=nosedetector.MergeThreshold
          
          %while threshold value is greater than 5 decrease threshold value by 1 
          while nosedetector.MergeThreshold > 5
              %b is declared for testing purpose
              b=nosedetector.MergeThreshold
              
              %reduce by 1
              nosedetector.MergeThreshold = nosedetector.MergeThreshold - 1;
              %find for detection
              nosebox = nosedetector(faceCropedImg);
%               whos mouthbox;
              %if any one object found break the loop and show the detected
              %image
              if size(nosebox) == size(notEmptyDouble)
                  nose = insertObjectAnnotation(faceCropedImg, 'rectangle', nosebox, 'Nose'); % Annotation
                  NoseFound = 1;
                  axes(handles.axes3);
                  imshow(nose); 
%                   figure;
%                   imshow(nose);
%                   title('finally nose found')
                  break;
              elseif nosedetector.MergeThreshold == 6
                  nose = insertObjectAnnotation(faceCropedImg, 'rectangle', mouthbox, 'Nose');
                  NoseFound = 0;
                  axes(handles.axes3);
                  imshow(nose); 
                  break;
              end
          
          end
          break;
     else  
          nose = insertObjectAnnotation(faceCropedImg, 'rectangle', nosebox, 'Nose'); % Annotation
          % mouth = imcrop(face, bb_m); % Crop segmented mouth
          NoseFound = 1;
          axes(handles.axes3);
          imshow(nose); 
%           figure;
%           imshow(mouth);
%           title('nose found')
      end
 end

%% checking for nose detection
%   nosedetector=vision.CascadeObjectDetector('Nose','MergeThreshold',20);
%   
%   nosebox = nosedetector(faceCropedImg);
%   whos nosebox;
%  
%  nose = insertObjectAnnotation(faceCropedImg,'rectangle',nosebox,'Nose');   
%  noseHasBeenDetected = true;
%     axes(handles.axes3);
%    imshow(nose); 


%% check if there is no nose detection 
 
% % Bdouble = double.empty(0,4);
% % box = double(mouthbox);
% 
% if size(box) == size(Bdouble)
% %     set global variable mouthHasBeenDetected to true
% noseHasBeenDetected = false;
% axes(handles.axes3);
%  imshow('nodetection.jpeg');
% 
% end

%% display result as message
if NoseFound && MouthFound==1
    f = msgbox('Please wear mask');
elseif xor(NoseFound,MouthFound)==1
    f = msgbox('Please wear mask properly');
else
    f = msgbox('Thank you for wearing mask!!!');
end




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% declaring global values
global img;
global faceDetectedImg;
global faceCropedImg;

facedetector=vision.CascadeObjectDetector('FrontalFaceLBP');
% facedetector = vision.CascadeObjectDetector;
% facedetector=vision.CascadeObjectDetector('MergeThreshold',30);

facebox = facedetector(img);

faceDetectedImg = insertObjectAnnotation(img,'rectangle',facebox,'Face');   

% crop and segment the face from the image using for loop

 for i = 1 : size(facebox, 1) 
   faceCropedImg = imcrop(img, facebox(i, :));
   axes(handles.axes2);
   imshow(faceCropedImg); 
 end

%  crop face without using for loop ## does not work for now

% faceCropedImg = imcrop(img, bbox);
% axes(handles.axes2);
% imshow(faceCropedImg);





% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% clear all values
clear global img;
clear global faceCropedImg;
clear global faceDetectedImg;
close all;
