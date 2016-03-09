function varargout = phonifyze(varargin)
% PHONIFYZE MATLAB code for phonifyze.fig
%      PHONIFYZE, by itself, creates a new PHONIFYZE or raises the existing
%      singleton*.
%
%      H = PHONIFYZE returns the handle to a new PHONIFYZE or the handle to
%      the existing singleton*.
%
%      PHONIFYZE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHONIFYZE.M with the given input arguments.
%
%      PHONIFYZE('Property','Value',...) creates a new PHONIFYZE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before phonifyze_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to phonifyze_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help phonifyze

% Last Modified by GUIDE v2.5 08-Mar-2016 22:12:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @phonifyze_OpeningFcn, ...
                   'gui_OutputFcn',  @phonifyze_OutputFcn, ...
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


% --- Executes just before phonifyze is made visible.
function phonifyze_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to phonifyze (see VARARGIN)

%Creating the tab group
handles.tgroup = uitabgroup('Parent', handles.main,'TabLocation', 'top');
handles.tab1 = uitab('Parent', handles.tgroup, 'Title', 'Corpus Selection');
handles.tab2 = uitab('Parent', handles.tgroup, 'Title', 'Analysis Selection');
handles.tab3 = uitab('Parent', handles.tgroup, 'Title', 'Prediction Selection');
%Creating and placing panels into each tab
handles.dataSelect=uipanel('Parent', handles.tab1, 'Position', [0 0 1 1], 'units', 'normalized', 'BorderType', 'none');
handles.anaSelect=uipanel('Parent', handles.tab2, 'Position', [0 0 1 1], 'units', 'normalized', 'BorderType', 'none');
handles.predictSelect=uipanel('Parent', handles.tab3, 'Position', [0 0 1 1], 'units', 'normalized', 'BorderType', 'none');

%Creating panels for selecting audio files, and a button to refresh the
%directories
%handles.corpusSelect = uitable('Parent', handles.dataSelect, 'Position', [0.05 0.55 0.4 0.4], 'units', 'normalized', 'Title', 'Corpus Selection');
%handles.phonemeSelect = uitable('Parent', handles.dataSelect, 'Position', [0.05 0.15 0.4 0.4], 'units', 'normalized', 'Title', 'Phoneme Selection');
handles.corpusSelect = uitable('Parent', handles.dataSelect, 'Position', [0.05 0.55 0.4 0.4], 'units', 'normalized');
handles.phonemeSelect = uitable('Parent', handles.dataSelect, 'Position', [0.05 0.15 0.4 0.4], 'units', 'normalized');
handles.directoryRefresh = uicontrol('Parent', handles.dataSelect, 'Style', 'pushbutton', 'String', 'Refresh', 'units', 'normalized','Position', [0.125 0.025 0.25 0.1], 'Callback', {@directoryRefresh_Callback, handles}); 

refreshCorpusTable(handles.corpusSelect)

% Choose default command line output for phonifyze
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes phonifyze wait for user response (see UIRESUME)
% uiwait(handles.main);


% --- Outputs from this function are returned to the command line.
function varargout = phonifyze_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function directoryRefresh_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)