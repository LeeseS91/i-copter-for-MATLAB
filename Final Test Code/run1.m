function [hits,distance,trackshape,distractrackshape]=run1()
time = 0;
R = 1000;
delay = 0.015;
hits = 0;

% screen_size = get(0, 'ScreenSize');
% f1 = figure(1);
% set(f1, 'Position', [0 0 screen_size(3) screen_size(4)]);
set(gca,'visible','off');
set(gcf,'color','w');
[buzz buzzfreq] = wavread('beep.wav');
buzzplay = audioplayer(buzz, buzzfreq);

mousePos = 0.5*ones(R,2);
distance = zeros(length(R));
trackshape = zeros(length(R));
distractrackshape = zeros(length(R));

yold = 0:0.01:0.99;
xold = 0.45*ones(1,100);
xupdate = 0.45*ones(1,100);
x = 0.45;
yold2 = 0:0.01:0.99;
xold2 = 0.45*ones(1,100);
xupdate2 = 0.45*ones(1,100);
x2 = 0.45;

%instructions
text(0.1,0.8,'That was a practice run. Now for the real thing...','fontSize',30);
pause(3);
clf('reset');
set(gca,'visible','off');
set(gcf,'color','w');
text(0.1,0.8,'TRACK FOLLOWING TEST','fontSize',30);
pause(3);
clf('reset');
set(gca,'visible','off');
set(gcf,'color','w');
text(0.2,0.5,'GOOD LUCK!','fontSize',50);
pause(3);

%start test
clf('reset')
set(gca,'visible','off');
set(gcf,'color','w');
% axis([0 1.1 0 1]);
text(0.1,0.5,'TEST WILL START IN 5 SECONDS','Color',[1 0 0],'fontSize',30);
pause(1);
clf('reset');
set(gca,'visible','off');
set(gcf,'color','w');
text(0.1,0.5,'TEST WILL START IN 4 SECONDS','Color',[1 0 0],'fontSize',30);
pause(1);
clf('reset');
set(gca,'visible','off');
set(gcf,'color','w');
text(0.1,0.5,'TEST WILL START IN 3 SECONDS','Color',[1 0 0],'fontSize',30);
pause(1);
clf('reset');
set(gca,'visible','off');
set(gcf,'color','w');
text(0.1,0.5,'TEST WILL START IN 2 SECONDS','Color',[1 0 0],'fontSize',30);
pause(1);
clf('reset');
set(gca,'visible','off');
set(gcf,'color','w');
text(0.1,0.5,'TEST WILL START IN 1 SECONDS','Color',[1 0 0],'fontSize',30);
pause(1);
clf('reset');
set(gca,'visible','off');
set(gcf,'color','w');
text(0.1,0.6,'Position cursor at centre of screen','fontSize',30,'Color',[0 0 0]);
text(0.1,0.5,'Stay within blue and red boundaries!','fontSize',30,'Color',[0 0 0]);
pause(2.5);
clf('reset')
set(gca,'visible','off');
set(gcf,'color','w');
axis([0 1.1 0 1]);
line(xold,yold,'LineWidth',2);
line(xold+0.1,yold,'LineWidth',2);
pause(1);

while time < R
    set(gca,'visible','off');
    set(gcf,'color','w');
    text(0.2,0.25,['No. of Hits = ' num2str(hits)],'fontSize',30,'Color',[1 0 0]);
    axis([0 1.1 0 1]);
    yguide1 = 0.45; yguide2 = 0.55;
    xguide = 0:2;
    line([xguide(1) xguide(end)],[yguide1 yguide1],'Color','r','LineWidth',2);
    line([xguide(1) xguide(end)],[yguide2 yguide2],'Color','r','LineWidth',2);
    time=time+1;
     
    move=[-0.015 0.015];
    move2=[-0.02 0.02];
    
    if xold(100) > 0.99
        x = x + move(1);
    elseif xold(100) < 0.01
        x = x + move(2);
    else
        if xold(100) > xold(99)
            if randi(100) > 80
                x = x + move(1);
            else
                x = x + move(2);
            end
        else
            if randi(100) > 80
                x = x + move(2);
            else
                x = x + move(1);
            end
        end
        %realised x is only bit that needs to be changed.
    end
    
    %decide distraction line
    
    if time <  R/4 ||(time > R/2 && time < 3*R/4)
        xold2(1:99)=xold(1:99);
        xold2(100)=xold(99);
        x2=x;
    elseif (time > R/4 && time < R/2) || time > 3*R/4
        
        if xold2(100) > 0.96
            x2 = x2 + move2(1);
        elseif yold2(100) < 0.04
            x2 = x2 + move2(2);
        elseif abs(xold2(100)-xold(100))>0.2
            if xold2(100)>xold(100)
                x2 = x2 + move2(1);
            else
                x2 = x2 + move2(2);
            end
        else
            if xold2(100) > xold2(99)
                if randi(100) > 80
                    x2 = x2 + move2(1);
                else
                    x2 = x2 + move2(2);
                end
            else
                if randi(100) > 80
                    x2 = x2 + move2(2);
                else
                    x2 = x2 + move2(1);
                end
            end
            
        end
        
        line(xold2, yold2, 'Color', 'k','LineWidth',2);
        line(xold2+0.1, yold2, 'Color', 'k','LineWidth',2);
        if time>R-50;
            line(xold2(end-(50-(R-time)):end), yold2(end-(50-(R-time)):end), 'Color', [1 1 1],'LineWidth',2);
            line(xold2(end-(50-(R-time)):end)+0.1, yold2(end-(50-(R-time)):end), 'Color', [1 1 1],'LineWidth',2);
        end
    end
    xupdate2(1:99)=xold2(2:100);
    xupdate2(100) = x2;
    xold2=xupdate2;
    
    
    hold on
    plot(xold2(55)+0.05,0.55,'k.','markersize', 30);
    hold off
    
    %realised y is only bit that needs to be changed.
    %plot lines and distraction lines
    
    line(xold,yold,'LineWidth',2);
    line(xold+0.1,yold,'LineWidth',2);
    if time>R-50;
        line(xold(end-(50-(R-time)):end), yold(end-(50-(R-time)):end), 'Color', [1 1 1],'LineWidth',2);
        line(xold(end-(50-(R-time)):end)+0.1, yold(end-(50-(R-time)):end), 'Color', [1 1 1],'LineWidth',2);
    end
    %smash the last 99 entries where the first 99 entries were.
    xupdate(1:99)=xold(2:100);
    
    %create new entry for 100th position
    xupdate(100) = x;
    
    %x array is now moved one space to the left.
    xold=xupdate;
    
    [mousePos1 mousePos2] = mouseTrack2edit(delay);
    
    if mousePos2 == 100 && time >= 50
        mousePos(time,2) = mousePos(time-1,2);
    end
    
    if mousePos1 == 100 && time >= 50
        mousePos(time,1) = mousePos(time-1,1);
    elseif time >= 50
        mousePos(time,:) = [mousePos1 mousePos2];
    else
        mousePos(time,1) = 0.5;
        mousePos(time,2) = 0.5;
    end
    
    if  mousePos(time,1) < xold(round(mousePos(time,2)*100)) && time > 50 ||...
            mousePos(time,1) > (xold(round(mousePos(time,2)*100))+0.1) && time > 50
        hits = hits + 1;
        play(buzzplay);
    end
    
    if mousePos(time,2) < yguide1 || mousePos(time,2) > yguide2
        hits = hits + 1;
        hold on
        text(0.02,0.9,'STAY INSIDE RED LINES!','fontSize',50,'Color',[0 0 1],'BackgroundColor',[1 0 0]);
        pause(1.5);
        mousePos(time,2) = 0.5;
    end
    
    distance(time)=abs(mousePos(time,1)-(xold(round(mousePos(time,2)*100))+0.05));
    trackshape(time)=1-((xold(45)+0.05)+(xold(55)+0.05))/2;
    distractrackshape(time)=1-((xold2(45)+0.05)+(xold2(55)+0.05))/2;
    
    text(0.2,0.25,['No. of Hits = ' num2str(hits)],'fontSize',10,'Color',[1 0 0]);
    clf('reset')
end

set(gca,'visible','off');
set(gcf,'color','w');
text(0.3,0.5,['HITS = ' num2str(hits)],'fontSize',50,'Color',[1 0 0]);
pause(3)
close