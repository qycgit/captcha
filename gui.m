function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
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
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 30-Dec-2016 19:01:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
[resultTable,testImgs,resultLabels] = testDataPre(false);
setappdata(gcf,'testImgs',testImgs);
setappdata(gcf,'resultLabels',resultLabels);
setappdata(gcf,'current',1);
handles.resultTable.Data = resultTable;
image(testImgs{1,1}, 'Parent', handles.imgAxes);
handles.singleTable.Data = resultLabels(1,:);
set(handles.imgAxes,'xTick',[]);
set(handles.imgAxes,'ytick',[]);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function resultTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resultTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in retrainBtn.
function retrainBtn_Callback(hObject, eventdata, handles)
% hObject    handle to retrainBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[resultTable,testImgs,resultLabels] = testDataPre(true);
setappdata(gcf,'testImgs',testImgs);
setappdata(gcf,'resultLabels',resultLabels);
setappdata(gcf,'current',1);
handles.resultTable.Data = resultTable;
image(testImgs{1,1}, 'Parent', handles.imgAxes);
handles.singleTable.Data = resultLabels(1,:);
set(handles.imgAxes,'xTick',[]);
set(handles.imgAxes,'ytick',[]);
msgbox('ѵ����ɣ�');


% --- Executes on button press in nextBtn.
function nextBtn_Callback(hObject, eventdata, handles)
% hObject    handle to nextBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
testImgs = getappdata(gcf,'testImgs');
resultLabels = getappdata(gcf,'resultLabels');
c = mod(getappdata(gcf,'current')+1,size(testImgs,1))+1;
setappdata(gcf,'current',c);
image(testImgs{c,1}, 'Parent', handles.imgAxes);
handles.singleTable.Data = resultLabels(c,:);
set(handles.imgAxes,'xTick',[]);
set(handles.imgAxes,'ytick',[]);


% --- Executes during object creation, after setting all properties.
function imgAxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imgAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate imgAxes
