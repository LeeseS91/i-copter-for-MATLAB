screen_size = get(0, 'ScreenSize');
f1 = figure(1);
set(f1, 'Position', [0 0 screen_size(3) screen_size(4)]);
set(gca,'visible','off');
set(gcf,'color','w');

load('records.mat');
load('trackshapes.mat');
num = size(records,1) + 1;
time = clock;

% ask initial questions
Subject=inputdlg('What type of subject do you study? [1= Arts, 2= Science, 3= Social Sciences 4= Maths/Engineering] ', 'i');
while ~ismember(Subject,{'1','2','3','4'})
    Subject = inputdlg('What type of subject do you study? [1= Arts, 2= Science, 3= Social Sciences 4= Maths/Engineering] ', 'i');
end
Age=inputdlg('What is your age bracket? [1= <18, 2= 18-26, 3= >26] ' , 'i');
while ~ismember(Age,{'1','2','3'})
    Age = inputdlg('What is your age bracket? [1= <18, 2= 18-26, 3= >26] ' , 'i');
end
Gender=inputdlg('Gender? [1= Male, 2= Female] ', 'i');
while ~ismember(Gender,{'1','2'})
    Gender = inputdlg('Gender? [1= Male, 2= Female] ', 'i');
end
Driver=inputdlg('Do you drive? [1= Yes, 2= No] ', 'i');
while ~ismember(Driver,{'1','2'})
    Driver = inputdlg('Do you drive? [1= Yes, 2= No] ', 'i');
end
Gamer=inputdlg('How often do you play computer games? [1= Not at all, 2= Occasionally, 3= Regularly] ', 'i');
while ~ismember(Gamer,{'1','2','3'})
    Gamer = inputdlg('How often do you play computer games? [1= Not at all, 2= Occasionally, 3= Regularly] ', 'i');
end

% run number game
[numscore numberfixationscore]=number();
pause(3);
clf('reset')
set(f1, 'Position', [0 0 screen_size(3) screen_size(4)]);
set(gca,'visible','off');
set(gcf,'color','w');

% run word game
[wdscore wordfixationscore] =word();
pause(3);
clf('reset')
set(f1, 'Position', [0 0 screen_size(3) screen_size(4)]);
set(gca,'visible','off');
set(gcf,'color','w');

% run practice bike game
hitspract=run1practice();
pause(3);
clf('reset')
set(f1, 'Position', [0 0 screen_size(3) screen_size(4)]);
set(gca,'visible','off');
set(gcf,'color','w');

% run bike game
[hits,distance,trackshape,distractrackshape]=run1();
pause(3);
clf('reset')
set(gca,'visible','off');
set(gcf,'color','w');

[nohitswithdist nohitsnodist] = findhits(distance,trackshape,distractrackshape);

datarray=[str2double(Subject) str2double(Age) str2double(Gender)...
    str2double(Driver) str2double(Gamer) numscore numberfixationscore wdscore wordfixationscore...
    hitspract nohitsnodist(1) nohitswithdist(1)];

[Subject Age Gender Driver Gamer number numberFixationScore word wordFixationScore Practice...
     bikeNodist bikedist] = database(datarray,num);
 
 records(num,:) = datarray;
 trackshapes(num,:) = [distance,trackshape,distractrackshape];
 
 save(sprintf('records%d.mat',num),'records');
 save(sprintf('trackshapes%d.mat',num),'trackshapes');
 save('records.mat','records');
 save('trackshapes.mat','trackshapes');
 
 clear