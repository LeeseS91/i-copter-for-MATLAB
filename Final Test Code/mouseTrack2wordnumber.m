function [OUTPUT1 OUTPUT2] = mouseTrack2wordnumber(timeoutval, axesHandle)

if ~exist('axesHandle', 'var')
    axesHandle = gca;
end

if ~exist('timeoutval', 'var'), 
    timeoutval = inf;
end

if ~(ishandle(axesHandle) && strcmp(get(axesHandle,'type'),'axes'))
    error('Axis handle is not valid');
end

if ~(isscalar(timeoutval) && (timeoutval > 0))
    error('Timeout should be a positive scalar');
end

figHandle = get(axesHandle, 'parent');

OUTPUT1 = 100; OUTPUT2 = 100;

% get existing figure properties
oldProperties = get(figHandle,{'WindowButtonMotionFcn','units','pointer'});

% replace with new properties to register mouse input
set(figHandle,{'WindowButtonMotionFcn','units','Pointer'},...
    {@buttonMotionCallback,'pixels','crosshair'});

figLocation = get(figHandle, 'Position');  

% key step: wait until timeout or until UIRESUME is called
if isinf(timeoutval)
    customWait(figHandle);
else
   customWait(figHandle, timeoutval);
end

% restore pre-existing figure properties
set(figHandle, {'WindowButtonMotionFcn','units','Pointer'}, ...
     oldProperties);
 
function buttonMotionCallback(obj, eventdata) %#ok<INUSD>
      pt = mapCurrentPosition();
      OUTPUT1 = pt(1,1);
      OUTPUT2 = pt(1,2);
end

% The following adjustment is based on GINPUT
function pt = mapCurrentPosition()
    scrn_pt = get(0, 'PointerLocation');              
    set(figHandle,'CurrentPoint',...
        [scrn_pt(1) - figLocation(1) + 1, scrn_pt(2) - figLocation(2) + 1]);
    pt = get(axesHandle,'CurrentPoint');       
end

end