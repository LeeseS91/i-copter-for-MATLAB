function [nohitswithdist nohitsnodist] = findhits(dist,trackshape, distract)

hitloc=zeros(length(dist));
x=1:length(dist);
x2=(length(dist)/4):length(dist)/2;
x3=(3*length(dist)/4):length(dist);

for i=1:length(dist)
    if dist(i)>0.05
        hitloc(i)=trackshape(i);
    end
end

hitsindex=find(hitloc~=0);
hitloc=hitloc(hitsindex);

hitcount=zeros(length(hitsindex));
for i=1:length(hitsindex)
    if hitsindex(i)>length(dist)/4 && hitsindex(i)<length(dist)/2
        hitcount(i)=1;
    elseif hitsindex(i)>(3*length(dist))/4 && hitsindex(i)<length(dist)
        hitcount(i)=1;
    else
        hitcount(i)=0;
    end
end

nohitswithdist=sum(hitcount);
nohitsnodist=length(hitsindex)-sum(hitcount);


figure(1);
plot(x(hitsindex), hitloc,'rx', x, trackshape,'b-',x2, distract((length(dist)/4):length(dist)/2),'k-',...
    x3, distract((3*length(dist)/4):length(dist)), 'k-')
title('Comparing hit locations to addition of distraction')
xlabel('time')
ylabel('track position')
legend('a hit','correct track','distraction track')
figure(2);
plot(x, dist*10, 'r-')
xlabel('time')
ylabel('distance from centre of track')