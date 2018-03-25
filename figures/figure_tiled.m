function figHandle=figure_tiled(figNumber,figSize)
% constructs a new figure window spread 
% as 6 tiles across the screen
%  [ ]  [ ]  [ ]
%  [ ]  [ ]  [ ]
%
%INPUTS
%figNumber : the argument passed to the standard figure function
%figSize: frame size compared to 1/6 of the screen, as [width;height]

%Author: Chris Rapson

if nargin<2 || length(figSize(:))~=2
    figSize=[1;1];
end

screenSize=get(0,'ScreenSize');%consider using MonitorPositions
taskbar_height = 0.04 * screenSize(4);
height=(screenSize(4) - taskbar_height)/2*figSize(2); %no padding required when using OuterPosition
width=screenSize(3)/3*figSize(1);  %no padding required when using OuterPosition

figurePositions=[1,                taskbar_height + height,  width,height;  %1
                screenSize(3)/3    taskbar_height + height,  width,height;  %2
                screenSize(3)*2/3  taskbar_height + height,  width,height;  %3
                1,                 taskbar_height,                width,height;  %4
                screenSize(3)/3,   taskbar_height,                width,height;  %5
                screenSize(3)*2/3, taskbar_height,                width,height]; %6

if nargin==0 || isempty(figNumber)
    figHandle=figure;
else
    figHandle=figure(figNumber);
end

if isnumeric(figHandle)
    set(gcf,'OuterPosition',figurePositions(mod(figHandle-1,6)+1,:))
else
    set(gcf,'OuterPosition',figurePositions(mod(get(gcf,'Number')-1,6)+1,:))
end