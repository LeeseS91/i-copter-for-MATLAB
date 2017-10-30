function P = createcursor(fileName)
motorcycle = importdata(fileName);
n=1;
P=zeros(16,16);
while n<=16
    for m=1:16
        if motorcycle(n,m)==255
            P(n,m)=NaN;
        elseif motorcycle(n,m)==0;
            P(n,m)=1;
        end
    end
    n=n+1;
end
end
        