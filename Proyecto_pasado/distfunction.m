function distancia = distfunction(POB,A)

[NPOB,Ncity]=size(POB);
dist = zeros(NPOB, 1);
%
for i=1:NPOB
    for j=1:Ncity-1
        dist(i) = dist(i) + A(POB(i,j), POB(i,j+1));
    end % j
end % i

distancia = dist;