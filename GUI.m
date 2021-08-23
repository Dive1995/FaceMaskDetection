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
 
 global img;
 [filename, pathname] = uigetfile({'*.bmp;*.jpg;*.jpeg;*.tif;*.png;','IMAGE FILES (*.bmp,*.jpg,*.jpeg,*.tif,*.png)'},'Choose an image');
    if isequal(filename,0) || isequal(pathname,0)
       disp('User pressed cancel')
    else
       filename=strcat(pathname,filename);
       img=imread(filename);
%         img=imrotate(img, 270);
       axes(handles.axes1);
        imshow(img);
        title("Test image");
    end



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img;
global faceCropedImg;
global mouthHasBeenDetected;
global noseHasBeenDetected;

%% resizing the croped image 

%  faceCropedImg = imresize(faceCropedImg,[128 128]);
faceCropedImg = imresize(faceCropedImg,[300 NaN]);

 

 %% Mouth testing 

 mouthdetector=vision.CascadeObjectDetector('Mouth','MergeThreshold',150);
 mouthbox = mouthdetector(faceCropedImg);
%  whos mouthbox;

if(sum(sum(mouthbox))~=0)
     mouth = insertObjectAnnotation(faceCropedImg,'rectangle',mouthbox,'Mouth');   
     mouthHasBeenDetected = true;
     axes(handles.axes4);
     imshow(mouth); 
     title("Mouth detetced");
 else
    mouthHasBeenDetected = false;
    axes(handles.axes4);
    imshow(faceCropedImg);
    title("Mouth not detected");
 end



%% testing for nose 

% checking for nose detection
  nosedetector=vision.CascadeObjectDetector('Nose','MergeThreshold',8);
  
  nosebox = nosedetector(faceCropedImg);
 
 if(sum(sum(nosebox))~=0)
    nose = insertObjectAnnotation(faceCropedImg,'rectangle',nosebox,'Nose');   
    noseHasBeenDetected = true;
    axes(handles.axes3);
    imshow(nose); 
    title("Nose detected");
 else
    noseHasBeenDetected = false;
    axes(handles.axes3);
    imshow(faceCropedImg);
    title("Nose not detected");
 end



%% display result as message
if noseHasBeenDetected && mouthHasBeenDetected
    f = msgbox('Please wear mask');
elseif xor(noseHasBeenDetected,mouthHasBeenDetected)
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



img = rgb2gray(img);
img=imgaussfilt(img,2);
% img=imgaussfilt(img);
% img = medfilt3(img);

% facedetector=vision.CascadeObjectDetector('FrontalFaceLBP');
facedetector = vision.CascadeObjectDetector;
facebox = facedetector(img);

faceDetectedImg = insertObjectAnnotation(img,'rectangle',facebox,'Face');   

% crop and segment the face from the image using for loop
if(sum(sum(facebox))~=0)
   for i = 1 : size(facebox, 1) 
       faceCropedImg = imcrop(img, facebox(i, :));
       axes(handles.axes2);
       imshow(faceCropedImg); 
       title("Face detected");
   end
else
    title("Face not detected");
end




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
