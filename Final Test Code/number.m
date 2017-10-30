function [numberScore numberFixationScore] = number()

q = 1;
Q = 20;
score = 0;
fixation = 0;
fixationcount = 0;
[wrong wrongrate] = wavread('buzzer.wav');
[right rightrate] = wavread('correct.wav');
playerwrong = audioplayer(wrong, wrongrate);
playerright = audioplayer(right, rightrate);
OUTPUTold = 0.5;
%text positions
q_x = 0.1; q_y = 0.8;
a_x = [0.1 0.4 0.7];
a_y = 0.5;
score_x = 0.1; score_y = 0.3;

% screen_size = get(0, 'ScreenSize');
% f1 = figure(1);
% set(f1, 'Position', [0 0 screen_size(3) screen_size(4)]);
set(gca,'visible','off');
set(gcf,'color','w');

%instructions
text(0.1,0.9,'NUMBER TEST','fontSize',30);
pause(1);
text(0.1,0.7,'You will be asked a sequence of twenty simple maths questions.','fontSize',25);
pause(2);
text(0.1,0.6,'There will be three options.','fontSize',25);
pause(2);
text(0.1,0.5,'MOVE the curser to the correct answer. You do NOT have to click the mouse.','fontSize',25);
pause(2);
text(0.1,0.4,'You will have 1.25 seconds per question. Be quick!','fontSize',25);
pause(3);

clf('reset')
set(gca,'visible','off');
set(gcf,'color','w');
text(0.1,0.8,'PRACTICE QUESTION','fontSize',30);
pause(2);
clf('reset')
set(gca,'visible','off');
set(gcf,'color','w');
text(q_x,q_y,'What is 3 + 2?','fontSize',25);
pause(0.25);
text(a_x(1),a_y,'5','Color',[0 0 0],'fontSize',25);
text(a_x(2),a_y,'6','Color',[0 0 0],'fontSize',25);
text(a_x(3),a_y,'4','Color',[0 0 0],'fontSize',25);

[OUTPUT1c OUTPUT2c] = mouseTrack2wordnumber(1.25);

%work out position of mouse click etc
if OUTPUT1c == 100
    OUTPUT1c = OUTPUTold;
end

if OUTPUT1c < a_x(1) + 0.1 && OUTPUT1c > a_x(1) - 0.1
    score = score + 1;
    play(playerright);
else
    score = score - 1;
    play(playerwrong);
end

text(score_x, score_y, ['SCORE = ' int2str(score)], 'Color', [1 0 0], 'fontSize',50);
pause(2);
clf('reset');
set(gca,'visible','off');
set(gcf,'color','w');

score = 0;

pause(1);
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

while q <= Q
    r = randperm(3);
    a_x1 = a_x(r(1));
    a_x2 = a_x(r(2));
    a_x3 = a_x(r(3));
    OUTPUTold = OUTPUT1c;
    
    questionperm=randperm(Q);
    % vary it between multiplication and addition
    if rem(questionperm(q),3)==0
        %create random numbers to put in sum & create possible solutions
        n1 = randi(10); n2 = randi(10);
        n1s = int2str(n1);
        n2s = int2str(n2);
        
        sol = int2str(n1 * n2);
        falsol1 = int2str(n1 * n2 + randi(3));
        falsol2 = int2str(n1 * n2 - randi(3));
        
        %create colours and fonts for distraction
        col = [1 0 0; 0 0 0; 0 0 0];
        font = [40; 25; 25];
        r2 = randperm(3);
        
        %display text and allow user input
        text(q_x,q_y,['What is ' n1s ' x ' n2s '?'],'fontSize',25);
        pause(0.15);
        text(a_x1,a_y,[' ' sol],'Color',col(r2(1),:),'fontSize',font(r2(1)));
        text(a_x2,a_y,[' ' falsol1],'Color',col(r2(2),:),'fontSize',font(r2(2)));
        text(a_x3,a_y,[' ' falsol2],'Color',col(r2(3),:),'fontSize',font(r2(3)));
        
    else
        %create random numbers to put in sum & create possible solutions
        n1 = randi(10); n2 = randi(10);
        n1s = int2str(n1);
        n2s = int2str(n2);
        
        sol = int2str(n1 + n2);
        falsol1 = int2str(n1 + n2 + randi(3));
        falsol2 = int2str(n1 + n2 - randi(3));
        
        %create colours and fonts for distraction
        col = [1 0 0; 0 0 0; 0 0 0];
        font = [50; 25; 25];
        r2 = randperm(3);
        
        %display text and allow user input
        text(q_x,q_y,['What is ' n1s ' + ' n2s '?'],'fontSize',25);
        pause(0.25);
        text(a_x1,a_y,[' ' sol],'Color',col(r2(1),:),'fontSize',font(r2(1)));
        text(a_x2,a_y,[' ' falsol1],'Color',col(r2(2),:),'fontSize',font(r2(2)));
        text(a_x3,a_y,[' ' falsol2],'Color',col(r2(3),:),'fontSize',font(r2(3)));
    end
    
    [OUTPUT1a OUTPUT2a] = mouseTrack2wordnumber(0.25);
    [OUTPUT1b OUTPUT2b] = mouseTrack2wordnumber(0.5);
    [OUTPUT1c OUTPUT2c] = mouseTrack2wordnumber(0.5);
    
    %if starting mouse position is on the correct answer already and they
    %stray towards distraction add count
    if abs(OUTPUTold - a_x1) < 0.15 && col(r2(2),1) == 1
            distance_init= OUTPUTold - a_x2;
            distance_a = OUTPUT1a - a_x2;
            distance_b = OUTPUT1b - a_x2;
            distance_c = OUTPUT1c - a_x2;
        if distance_a < distance_init || distance_b < distance_init || distance_c < distance_init
            fixation = fixation + 1;
        end
        fixationcount = fixationcount + 1;
    elseif abs(OUTPUTold - a_x1) < 0.15 && col(r2(3),1) == 1
            distance_init= OUTPUTold - a_x3;
            distance_a = OUTPUT1a - a_x3;
            distance_b = OUTPUT1b - a_x3;
            distance_c = OUTPUT1c - a_x3;
        if distance_a < distance_init || distance_b < distance_init || distance_c < distance_init
            fixation = fixation + 1;
        end
        fixationcount = fixationcount + 1;    
    %if the answer is in the middle and starting point is not on
    %the distraction already and tend towards distraction add count
    elseif col(r2(2),1) == 1 && ((r2(1) == 2 && abs(OUTPUTold - a_x2) > 0.15) ||...
            (abs(OUTPUTold - a_x(2)) < 0.15))
        distance_a = OUTPUT1a - a_x2;
        distance_b = OUTPUT1b - a_x2;
        distance_c = OUTPUT1c - a_x2;
        if distance_a < 0.24 || distance_b < 0.24 || distance_c < 0.24
            fixation = fixation + 1;
        end
        fixationcount = fixationcount + 1;
    elseif col(r2(3),1) == 1 && ((r2(1) == 2 && abs(OUTPUTold - a_x3) > 0.15) ||...
            (abs(OUTPUTold - a_x(2)) < 0.15))
        distance_a = OUTPUT1a - a_x3;
        distance_b = OUTPUT1b - a_x3;
        distance_c = OUTPUT1c - a_x3;
        if distance_a < 0.24 || distance_b < 0.24 || distance_c < 0.24
            fixation = fixation + 1;
        end
        fixationcount = fixationcount + 1;        
    %if start on distraction and stay on distraction add counts
    elseif col(r2(2),1) == 1 && abs(OUTPUTold - a_x2) < 0.15 
        if abs(OUTPUT1b - a_x2) < 0.15 || abs(OUTPUT1c - a_x2) < 0.15
            fixation = fixation + 1;
        end    
        fixationcount = fixationcount + 1;
    elseif col(r2(3),1) == 1 && abs(OUTPUTold - a_x3) < 0.15
        if abs(OUTPUT1b - a_x3) < 0.15 || abs(OUTPUT1c - a_x3) < 0.15
        fixation = fixation + 1;
        end
        fixationcount = fixationcount + 1;
    end
    
    %work out position of mouse click etc
    if OUTPUT1a == 100
        OUTPUT1a = OUTPUTold;
    end
    
    if OUTPUT1b == 100
        OUTPUT1b = OUTPUT1a;
    end
    
    if OUTPUT1c == 100
        OUTPUT1c = OUTPUT1b;
    end
    
    if OUTPUT1c < a_x1 + 0.1 && OUTPUT1c > a_x1 - 0.1
        score = score + 1;
        play(playerright);
    else
        score = score - 1;
        play(playerwrong);
    end
    
    text(score_x, score_y, ['SCORE = ' int2str(score)], 'Color', [1 0 0], 'fontSize', 50);
    pause(1);
    clf('reset');
    set(gca,'visible','off');
    set(gcf,'color','w');
    
    q = q + 1;
end

numberFixationScore = fixation / fixationcount;

text(0.1, 0.5, ['FINAL SCORE = ' int2str(score)], 'Color', [1 0 0], 'fontSize', 50);

numberScore = score;
end