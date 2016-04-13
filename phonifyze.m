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

% Last Modified by GUIDE v2.5 08-Apr-2016 16:30:17

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

%%Data Selection tab %%
    %Creating panels for selecting audio files, and a button to refresh the
    %directories
    handles.corpusSelect = uitable('Parent', handles.dataSelect, 'Position', [0.05 0.55 0.55 0.4], 'units', 'normalized');
    handles.phonemeSelect = uitable('Parent', handles.dataSelect, 'Position', [0.05 0.15 0.55 0.4], 'units', 'normalized');
    handles.directoryRefresh = uicontrol('Parent', handles.dataSelect, 'Style', 'pushbutton', 'String', 'Refresh', 'units', 'normalized','Position', [0.185 0.025 0.25 0.1], 'Callback', {@directoryRefresh_Callback, handles}); 

    %refresh the tables and their dimensions
    [handles.allFilesByRow, handles.allLanguages]=refreshCorpusTable(handles.corpusSelect);
    refreshPhonemeTable(handles.phonemeSelect);
    handles.corpusSelect.Position=[0.05 0.55 0.55 0.4];
    handles.phonemeSelect.Position=[0.1 0.25 0.45 0.2];

%%Analys Selection tab %%

    %selection details
    handles.anaDetails= uicontrol('Parent', handles.anaSelect,'Style','text', ...
        'String','Frequency Domain Analysis', 'units', 'normalized');


    %Time domain list
    handles.timeDomain=uicontrol('Parent', handles.anaSelect,'Style','listbox', 'units', 'normalized');
    handles.tIsWindowed=refreshTimeCheckboxes(handles.timeDomain);
    handles.timeDomain.Position=[0.05 0.525 0.45 0.4];
    handles.timeLabel= uicontrol('Parent', handles.anaSelect,'Style','text', ...
        'String','Time Domain Analysis', 'units', 'normalized');
    handles.timeLabel.Position=[0.05 0.925 0.45 0.04];

    %Frequency Domain list
    handles.freqDomain=uicontrol('Parent', handles.anaSelect,'Style','listbox', 'units', 'normalized');
    handles.fIsWindowed=refreshFreqCheckboxes(handles.freqDomain);
    handles.freqDomain.Position=[0.05 0.05 0.45 0.4];
    handles.freqLabel= uicontrol('Parent', handles.anaSelect,'Style','text', ...
        'String','Frequency Domain Analysis', 'units', 'normalized');
    handles.freqLabel.Position=[0.05 0.45 0.45 0.04];

    handles.timeDomain.Callback={@timeListbox_Callback, handles};
    handles.freqDomain.Callback={@freqListbox_Callback, handles};

    handles.anaDetails.String=updateAnaDetails(handles);

%%Prediction Selection Tab%%
    %button group setup
    handles.predictBtnGroup=uibuttongroup('Parent', handles.predictSelect,...
                      'Title','Prediction Method',...
                      'Position', [0.05 0.55 0.55 0.4], 'units', 'normalized');
    handles.predictBtnGroup.SelectionChangedFcn={@predictBtnGroup_Change, handles};

    %neural net radio button
    handles.predictBtnNeural=uicontrol('Style', 'radiobutton',...
                        'Parent', handles.predictBtnGroup,...
                      'String','Neural Network',...
                      'units', 'normalized');
    handles.predictBtnNeural.Position= [0.05 0.9 0.55 0.08];
    %GMM radio button
    handles.predictBtnGMM=uicontrol('Style', 'radiobutton',...
                        'Parent', handles.predictBtnGroup,...
                      'String','Gaussian Mixture Model',...
                      'units', 'normalized');
    handles.predictBtnGMM.Position= [0.05 0.75 0.55 0.08];
    %SVM radio button
    handles.predictBtnSVM=uicontrol('Style', 'radiobutton',...
                        'Parent', handles.predictBtnGroup,...
                      'String','Support Vector Machines',...
                      'units', 'normalized');
    handles.predictBtnSVM.Position= [0.05 0.6 0.55 0.08];
    %HMM radio button
    handles.predictBtnHMM=uicontrol('Style', 'radiobutton',...
                        'Parent', handles.predictBtnGroup,...
                      'String','Hidden Markov Model',...
                      'units', 'normalized');
    handles.predictBtnHMM.Position= [0.05 0.45 0.55 0.08];
    
    
    %Prepare features button
    handles.prepareFeat = uicontrol('Parent', handles.predictSelect, 'Style', 'pushbutton', 'String', 'Prepare Data', 'units', 'normalized'); 
    handles.prepareFeat.Callback= {@prepareFeatures_Callback, handles};
    handles.prepareFeat.Position= [0.05 0.45 0.55 0.08];



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

refreshCorpusTable(handles.corpusSelect);
refreshPhonemeTable(handles.phonemeSelect);
handles.corpusSelect.Position=[0.05 0.55 0.55 0.4];
handles.phonemeSelect.Position=[0.1 0.25 0.45 0.2];

function timeListbox_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.anaDetails.String=updateAnaDetails(handles);



function freqListbox_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.anaDetails.String=updateAnaDetails(handles);


function predictBtnGroup_Change(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function prepareFeatures_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.prepareFeat.Enable='off';
prepareData(handles);
handles.prepareFeat.Enable='on';
