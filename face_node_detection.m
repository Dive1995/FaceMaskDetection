function varargout = Demo3(varargin)
% DEMO3 MATLAB code for Demo3.fig
%      DEMO3, by itself, creates a new DEMO3 or raises the existing
%      singleton*.
%
%      H = DEMO3 returns the handle to a new DEMO3 or the handle to
%      the existing singleton*.
%
%      DEMO3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO3.M with the given input arguments.
%
%      DEMO3('Property','Value',...) creates a new DEMO3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Demo3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Demo3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Demo3

% Last Modified by GUIDE v2.5 07-Sep-2020 11:09:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Demo3_OpeningFcn, ...
                   'gui_OutputFcn',  @Demo3_OutputFcn, ...
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


% --- Executes just before Demo3 is made visible.
function Demo3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Demo3 (see VARARGIN)

% Choose default command line output for Demo3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Demo3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Demo3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Start_Webcam.
function Start_Webcam_Callback(hObject, eventdata, handles)
% hObject    handle to Start_Webcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global c;
global loopFlag;
loopFlag = true;
c=webcam;
 while true
     if(loopFlag ==false)
         break;
     else
    e=c.snapshot;
     axes(handles.axes1);
 imshow(e);
 drawnow;
     end
 end


% --- Executes on button press in Face_Detection.
function Face_Detection_Callback(hObject, eventdata, handles)
% hObject    handle to Face_Detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FDetect=vision.CascadeObjectDetector;
global loopFlag;
global c ;
while true
     if(loopFlag ==false)
         break;
     else
    e=c.snapshot;
    BB=step(FDetect,e);
    imshow(e);
    hold on;
    for i=1:size(BB,1)
rectangle('Position',BB(i,:),'Linewidth',5,'LineStyle','-','EdgeColor','r');
end
hold off;
    drawnow;
     end
end


% --- Executes on button press in Eye_Detection.
function Eye_Detection_Callback(hObject, eventdata, handles)
% hObject    handle to Eye_Detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FDetect=vision.CascadeObjectDetector('EyePairBig','MergeThreshold',50);
global loopFlag;
global c ;
while true
     if(loopFlag ==false)
         break;
     else
    e=c.snapshot;
    BB=step(FDetect,e);
    imshow(e);
    hold on;
    for i=1:size(BB,1)
rectangle('Position',BB(i,:),'Linewidth',5,'LineStyle','-','EdgeColor','r');
end
hold off;
    drawnow;
     end
end



% --- Executes on button press in Nose_Detection.
function Nose_Detection_Callback(hObject, eventdata, handles)
% hObject    handle to Nose_Detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global loopFlag;
global c ;
FDetect=vision.CascadeObjectDetector('Nose','MergeThreshold',30);
while true
     if(loopFlag ==false)
         break;
     else
    e=c.snapshot;
    BB=step(FDetect,e);
    imshow(e);
    hold on;
    for i=1:size(BB,1)
rectangle('Position',BB(i,:),'Linewidth',5,'LineStyle','-','EdgeColor','r');
end
hold off;
    drawnow;
     end
end

% --- Executes on button press in Close_Webcam.
function Close_Webcam_Callback(hObject, eventdata, handles)
% hObject    handle to Close_Webcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global loopFlag;
loopFlag=false;
clear global c;
axes(handles.axes1);
imshow('Thank.JPG');
