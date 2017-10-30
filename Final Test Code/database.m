
function [Subject Age Gender Driver Gamer  number numberFixationScore word wordFixationScore Practice...
     bikeNodist bikedist] = database(data,num)
  
Subject=[];
Age=[];
Gender=[];
Driver=[];
Gamer=[];
number=[];
numberFixationScore=[];
word=[];
wordFixationScore=[]
Practice=[];
bikeNodist=[];
bikedist=[];

Subject(num)=data(1);
Age(num)=data(2);
Gender(num)=data(3);
Driver(num)=data(4);
Gamer(num)=data(5);
number(num)=data(6);
numberFixationScore(num)=data(7);
word(num)=data(8);
numberFixationScore(num)=data(9);
Practice(num)=data(10);
bikeNodist(num)=data(11);
bikedist(num)=data(12);

end
