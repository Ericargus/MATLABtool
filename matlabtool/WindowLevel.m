function varargout = WindowLevel(varargin)
% WINDOWLEVEL MATLAB code for WindowLevel.fig
%      WINDOWLEVEL, by itself, creates a new WINDOWLEVEL or raises the existing
%      singleton*.
%
%      H = WINDOWLEVEL returns the handle to a new WINDOWLEVEL or the handle to
%      the existing singleton*.
%
%      WINDOWLEVEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WINDOWLEVEL.M with the given input arguments.
%
%      WINDOWLEVEL('Property','Value',...) creates a new WINDOWLEVEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WindowLevel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WindowLevel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WindowLevel

% Last Modified by GUIDE v2.5 03-Mar-2018 20:17:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WindowLevel_OpeningFcn, ...
                   'gui_OutputFcn',  @WindowLevel_OutputFcn, ...
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


% --- Executes just before WindowLevel is made visible.
function WindowLevel_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WindowLevel (see VARARGIN)

% Choose default command line output for WindowLevel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WindowLevel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WindowLevel_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in FIleList.
function FIleList_Callback(~, ~, handles)
% hObject    handle to FIleList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FIleList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FIleList
file_info = get(handles.FIleFolder,'userdata');
num_file = length(file_info);
file_list = [];
for i = 1:num_file
    file = [file_info(i).folder,'/', file_info(i).name];
    file_list = char(file_list, file);
    set(handles.FIleList, 'string', file);
    %FIleList.Items.Add('file_list');
end


% --- Executes during object creation, after setting all properties.
function FIleList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FIleList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SIngleFile.
function SIngleFile_Callback(hObject, eventdata, handles)
% hObject    handle to SIngleFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file_name, file_path] = uigetfile('.dcm', 'FileSect');
file = [file_path, file_name];
axes(handles.Origin);
dicomData = double(dicomread(file));
set(handles.SIngleFile, 'userdata', dicomData);
%title(file_name);
imshow(dicomData, []); title(file_name);



% --- Executes on button press in FIleFolder.
function FIleFolder_Callback(hObject, eventdata, handles)
% hObject    handle to FIleFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder_name = uigetdir();
%global file_info
file_info = dir(folder_name);
num_file = length(file_info);
set(handles.FIleFolder, 'userdata', file_info);






function Kvalue_Callback(hObject, eventdata, handles)
% hObject    handle to Kvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Kvalue as text
%        str2double(get(hObject,'String')) returns contents of Kvalue as a double
k_value = str2double(get(hObject, 'string'));
if isempty(k_value)
    k_value = 0.0;
end
set(handles.Kvalue, 'userdata', k_value)



% --- Executes during object creation, after setting all properties.
function Kvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Kvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Transfrom.
function Transfrom_Callback(~, eventdata, handles)
% hObject    handle to Transfrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
k = get(handles.Kvalue, 'userdata');
if isempty(get(handles.SIngleFile,'userdata'))
else
    dicomData = get(handles.SIngleFile,'userdata');
end
maxPixel = max(max(dicomData));
fakeData = dicomData;
fakeData(fakeData == 0) = inf;
minPixel = min(min(fakeData));
sumPixel = sum(sum(dicomData));
avgPixel = sumPixel/(maxPixel-minPixel);
a = tabulate(dicomData(:));
pixelValue = a(:,1);
pixelValueNum = a(:,2);
pixelNum = length(pixelValue);
j = 0;
l = 0;
left = 0;
right = 0;
for i = 1:pixelNum
    l = l+1;
    if l == pixelNum
        break
    end
    if pixelValueNum(l)<(k*avgPixel) && pixelValueNum(l+1)>=(k*avgPixel)
        left = pixelValue(i);
        con = 1;
        while con
            j = j+1;
            if pixelNum ==j
                break
            end
            if pixelValueNum(pixelNum+1-j)<(k*avgPixel) && ...
                    pixelValueNum(pixelNum-j)>=(k*avgPixel)
                right = pixelValue(pixelNum-j);
                con = 0;
            else
                continue
            end
        end
        break
    else
        continue
    end
end
if (maxPixel-minPixel)<512 || right == 0 || left == 0
    right = maxPixel;
    left = minPixel;
end
windowWindth = right - left;
%windowCenter = (right - left)/2;
toOne = dicomData > right;
toZero = dicomData < left;
img = (dicomData - left)/(windowWindth);
img(toOne) = 1; img(toZero) = 0;
img = img.*255;
axes(handles.AfterTrans);
imshow(img, []),title('AfterTransform');
    
    
