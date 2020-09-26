function dist=tspfun(city)
% Cost function for the traveling salesman problem.
% Uses global variables "x" and "y"
% Haupt and Haupt, 2003

[Ncity,var]=size(city);
tour=[city city(:,1)];
%distance between cities
for ic=1:Ncity
    ic
    for id=1:Ncity
        id
        dcity(ic,id)=sqrt((city(ic,2)-city(id,2))^2+(city(ic,3)-city(id,3))^2); 
    end % id
end % ic
% cost of each chromosome
for ic=1:Ncity
    dist(ic,1)=0;
    for id=1:Ncity
        dist(ic,1)=dist(ic)+dcity(tour(ic,id),tour(ic,id+1));
    end % id
end % ic