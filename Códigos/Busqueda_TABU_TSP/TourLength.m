% Autor: Miriam Samantha Arzate Gonzalez (Miembro del Equipo 4)
% 
%%%%%%% Funcion para calcular la longitud/costo del tour propuesto %%%%%%%%
%
% Inspirado en los codigos e implementacion de:  
%       S. Mostapha Kalami Heris (Member of Yarpiz Team)
%           Project Code: YPEA116
%           Project Title: Implementation of Tabu Search for TSP
%           Publisher: Yarpiz (www.yarpiz.com)

function L = TourLength(tour,model) % tour es un vector con el orden de visita a las ciudades

    n = numel(tour);        % cuenta el número de ciudades en el tour
    
    tour = [tour tour(1)];  % cierra el ciclo (empieza y termina en la primera ciudad)
    
    L = 0;                  % incializa la distancia en cero
    
    for k = 1:n
        
        i = tour(k);    % partida
        j = tour(k+1);  % llegada
        
        L = L + model.d(i,j); % va sumando las distancias recorridas en el tour
        
    end

end