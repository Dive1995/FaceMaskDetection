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

% mouthdetect = vision.CascadeObjectDetector('Mouth');

% mouthdetect.MergeThreshold = 1; % Threshold value, starts at 1 or any value you want

% FaceFound = 0;
% whos FaceFound;
% while FaceFound == 0
%       bb_m = step(mouthdetect, faceCropedImg); % Detects mouth in image.
%       whos bb_m;
%       if(bb_m == emptyArray) % Check if a mouth is found, if not increase the Threshold by 1
%           mouthdetect.MergeThreshold = mouthdetect.MergeThreshold + 1;
%       else  
%           mouth = insertObjectAnnotation(faceCropedImg, 'rectangle', bb_m, 'Mouth'); % Annotation
%           % mouth = imcrop(face, bb_m); % Crop segmented mouth
%           FaceFound = 1;
%           figure;
%           imshow(mouth);
%       end
%  end


%% resizing the croped image ## because it is small

 faceCropedImg = imresize(faceCropedImg,1.5);
 
 %%  displaying the mouth detection if detected

 mouthdetector=vision.CascadeObjectDetector('Mouth','MergeThreshold',200);
 
 mouthbox = mouthdetector(faceCropedImg);
 whos mouthbox;
 
 mouth = insertObjectAnnotation(faceCropedImg,'rectangle',mouthbox,'Mouth');   
 mouthHasBeenDetected = true;
 axes(handles.axes4);
 imshow(mouth); 
 
% figure
% imshow(mouth)
% title('Detected Mouth');

%% check if there is no mouth detection 
 
Bdouble = double.empty(0,4);
box = double(mouthbox);

if size(box) == size(Bdouble)
%     set global variable mouthHasBeenDetected to true

mouthHasBeenDetected = false;
%     figure
%     imshow(img);
%     title("inside if")
end

%% checking for nose detection
  nosedetector=vision.CascadeObjectDetector('Nose','MergeThreshold',50);
  
  nosebox = nosedetector(faceCropedImg);
  whos nosebox;
 
 nose = insertObjectAnnotation(faceCropedImg,'rectangle',nosebox,'Nose');   
 noseHasBeenDetected = true;
    axes(handles.axes3);
   imshow(nose); 
% figure
% imshow(nose)
% title('Detected Nose');

%% check if there is no nose detection 
 
% Bdouble = double.empty(0,4);
% box = double(mouthbox);

if size(box) == size(Bdouble)
%     set global variable mouthHasBeenDetected to true
noseHasBeenDetected = false;
%     figure
%     imshow(img);
%     title("inside if")
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


detector = vision.CascadeObjectDetector;
% detector=vision.CascadeObjectDetector('MergeThreshold',30);

bbox = detector(img);

faceDetectedImg = insertObjectAnnotation(img,'rectangle',bbox,'Face');   

% crop and segment the face from the image using for loop

 for i = 1 : size(bbox, 1) 
   faceCropedImg = imcrop(img, bbox(i, :));
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
