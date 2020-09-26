function dcity=distancias(city)
% Cost function for the traveling salesman problem.
% Uses global variables "x" and "y"
% Haupt and Haupt, 2003

[Ncity,var]=size(city);
%distance between cities
for ic=1:Ncity
    for id=1:Ncity
        dcity(ic,id)=sqrt((city(ic,2)-city(id,2))^2+(city(ic,3)-city(id,3))^2); 
    end % id
end