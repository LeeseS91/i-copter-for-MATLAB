function [wordScore wordFixationScore] = word()

score = 0;
fixation = 0;
fixationcount = 0;
q = 1;

%text positions
q_x = 0.1; q_y = 0.9;
a_x = 0.1;
a_y = [0.7 0.5 0.3];
score_x = 0.45; score_y = 0.5;
OUTPUTold = 0.5;

[wrong wrongrate] = wavread('buzzer.wav');
[right rightrate] = wavread('correct.wav');
playerwrong = audioplayer(wrong, wrongrate);
playerright = audioplayer(right, rightrate);

%questions
question = {'What is the opposite of happy?';...
    'What is the opposite of big?';...
    'What is the opposite of hard?';...
    'Which day follows Tuesday?';...
    'Which day follows Saturday?';...
    'Which day follows Monday?';...
    'How many days in a year?';...
    'How many days in a week?';...
    'How many hours in a day?';...
    'What is the capital of England?';...
    'What is the capital of France?';...
    'How many pennies in a pound?';...
    'What colour is a banana?';...
    'An apple is...?';...
    'Cars are driven on...?';...
    'Blue and red makes...?';...
    'Blue and yellow makes...?';...
    'Red and yellow makes...?';...
    'Brazil is in which continent?';...
    'India is in which continent?'};
sol = {'sad';'small';'soft';'Wednesday';'Sunday';'Tuesday';'365';'7';'24';...
    'London';'Paris';'100';'yellow';'a fruit';'the road';'purple';'green';'orange';'South America';'Asia'};
falsol1 = {'glad';'large';'strong';'Friday';'Monday';'Saturday';'265';'12';'60';...
    'Bristol';'Lyon';'60';'pink';'a vegetable';'the sea';'orange';'purple';'blue';'North America';'Africa'};
falsol2 = {'lazy';'middle';'wet';'Monday';'Thursday';'Wednesday';'347';'9';'30';...
    'Manchester';'Nice';'1000';'orange';'a meat';'the railway';'green';'red';'purple';'Europe';'South America'};
r3 = randperm(length(question));

%set up figure
screen_size = get(0, 'ScreenSize');
f1 = figure(1);
set(f1, 'Position', [0 0 screen_size(3) screen_size(4)]);
set(gca,'visible','off');
set(gcf,'color','w');

%instructions
text(0.1,0.9,'WORD TEST','fontSize',30);
pause(1);
text(0.1,0.7,'You will be asked a sequence of twenty word questions.','fontSize',25);
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
text(0.1,0.9,'PRACTICE QUESTION','fontSize',30);
pause(2);
clf('reset')
set(gca,'visible','off');
set(gcf,'color','w');
text(q_x,q_y,'What colour is Rudolphs nose?','fontSize',25);
pause(0.25);
text(a_x,a_y(1),'red','Color',[0 0 0],'fontSize',25);
text(a_x,a_y(2),'blue','Color',[0 0 0],'fontSize',25);
text(a_x,a_y(3),'black','Color',[0 0 0],'fontSize',25);

[OUTPUT1c OUTPUT2c] = mouseTrack2wordnumber(1.25);

%work out position of mouse click etc
if OUTPUT2c == 100
    OUTPUT2c = OUTPUTold;
end

if OUTPUT2c < a_y(1) + 0.1 && OUTPUT2c > a_y(1) - 0.1
    score = score + 1;
    play(playerright);
else
    score = score - 1;
    play(playerwrong);
end

text(score_x, score_y, ['SCORE = ' int2str(score)], 'Color', [1 0 0], 'fontSize', 50);
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

while q <= length(question)
    r = randperm(3);
    a_y1 = a_y(r(1));
    a_y2 = a_y(r(2));
    a_y3 = a_y(r(3));
    OUTPUTold = OUTPUT2c;
    
    %create random numbers to put in sum & create possible solutions
    n1 = randi(10); n2 = randi(10);
    n1s = int2str(n1);
    n2s = int2str(n2);
    
    %create colours and fonts for distraction
    col = [1 0 0; 0 0 0; 0 0 0];
    font = [50; 25; 25];
    r2 = randperm(3);
    
    %display text and allow user input
    text(q_x,q_y,[' ' question{r3(q)}],'fontSize',25);
    pause(0.25);
    text(a_x,a_y1,[' ' sol{r3(q)}],'Color',col(r2(1),:),'fontSize',font(r2(1)));
    text(a_x,a_y2,[' ' falsol1{r3(q)}],'Color',col(r2(2),:),'fontSize',font(r2(2)));
    text(a_x,a_y3,[' ' falsol2{r3(q)}],'Color',col(r2(3),:),'fontSize',font(r2(3)));
    
    [OUTPUT1a OUTPUT2a] = mouseTrack2wordnumber(0.25);
    [OUTPUT1b OUTPUT2b] = mouseTrack2wordnumber(0.5);
    [OUTPUT1c OUTPUT2c] = mouseTrack2wordnumber(0.5);
    
     %if starting mouse position is on the correct answer already and they
    %stray towards distraction add count
    if abs(OUTPUTold - a_y1) < 0.1 && col(r2(2),1) == 1
            distance_init= OUTPUTold - a_y2;
            distance_a = OUTPUT2a - a_y2;
            distance_b = OUTPUT2b - a_y2;
            distance_c = OUTPUT2c - a_y2;
        if distance_a < distance_init || distance_b < distance_init || distance_c < distance_init
            fixation = fixation + 1;
        end
        fixationcount = fixationcount + 1;
    elseif abs(OUTPUTold - a_y1) < 0.1 && col(r2(3),1) == 1
            distance_init= OUTPUTold - a_y3;
            distance_a = OUTPUT1a - a_y3;
            distance_b = OUTPUT1b - a_y3;
            distance_c = OUTPUT1c - a_y3;
        if distance_a < distance_init || distance_b < distance_init || distance_c < distance_init
            fixation = fixation + 1;
        end
        fixationcount = fixationcount + 1;    
    %if the answer is in the middle and starting point is not on
    %the distraction already and tend towards distraction add count
    elseif col(r2(2),1) == 1 && ((r2(1) == 2 && abs(OUTPUTold - a_y2) > 0.1) ||...
            (abs(OUTPUTold - a_y(2)) < 0.1))
        distance_a = OUTPUT1a - a_y2;
        distance_b = OUTPUT1b - a_y2;
        distance_c = OUTPUT1c - a_y2;
        if distance_a < 0.16 || distance_b < 0.16 || distance_c < 0.16
            fixation = fixation + 1;
        end
        fixationcount = fixationcount + 1;
    elseif col(r2(3),1) == 1 && ((r2(1) == 2 && abs(OUTPUTold - a_y3) > 0.1) ||...
            (abs(OUTPUTold - a_y(2)) < 0.1))
        distance_a = OUTPUT1a - a_y3;
        distance_b = OUTPUT1b - a_y3;
        distance_c = OUTPUT1c - a_y3;
        if distance_a < 0.16 || distance_b < 0.16 || distance_c < 0.16
            fixation = fixation + 1;
        end
        fixationcount = fixationcount + 1;        
    %if start on distraction and stay on distraction add count
    elseif col(r2(2),1) == 1 && abs(OUTPUTold - a_y2) < 0.1
        if abs(OUTPUT1b - a_y2) < 0.1 || abs(OUTPUT1c - a_y2) < 0.1
            fixation = fixation + 1;
        end    
        fixationcount = fixationcount + 1;
    elseif col(r2(3),1) == 1 && abs(OUTPUTold - a_y3) < 0.1
        if abs(OUTPUT1b - a_y3) < 0.15 || abs(OUTPUT1c - a_y3) < 0.1
        fixation = fixation + 1;
        end
        fixationcount = fixationcount + 1;
    end
    
    %work out position of mouse click etc
    if OUTPUT2a == 100
        OUTPUT2a = OUTPUTold;
    end
    
    if OUTPUT2b == 100
        OUTPUT2b = OUTPUT2a;
    end
    
    if OUTPUT2c == 100
        OUTPUT2c = OUTPUT2b;
    end
    
    
    if OUTPUT2c < a_y1 + 0.1 && OUTPUT2c > a_y1 - 0.1
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

wordFixationScore = fixation / fixationcount;

text(0.1, 0.5, ['FINAL SCORE = ' int2str(score)], 'Color', [1 0 0], 'fontSize', 50);

wordScore = score;

end
