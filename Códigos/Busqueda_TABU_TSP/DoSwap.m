% Autor: Miriam Samantha Arzate Gonzalez (Miembro del Equipo 4)
% 
%%%%%%%% Funcion para hacer movimientos tipo 1.-SWAP (VertexEx) %%%%%%%%%%%
%
% Inspirado en los codigos e implementacion de:  
%       S. Mostapha Kalami Heris (Member of Yarpiz Team)
%           Project Code: YPEA116
%           Project Title: Implementation of Tabu Search for TSP
%           Publisher: Yarpiz (www.yarpiz.com)


function q = DoSwap(p,i1,i2)
    % out : "q" ...... nueva posicion (vecino) después de intercambiar a la
    %                  ciudad i1 con la i2
    % in :  "p" ...... posicion inicial (vector con los indices de las
    %                  ciudades en orden de visita)
    %       "i1" ..... indice de la ciudad 1 a intercambiar de lugar
    %       "i2" ..... indice de la ciudad 2 a intercambiar de lugar
    
    
    q = p;
    q([i1 i2]) = p([i2 i1]); %intercambia las posiciones de i1 e i2
    
end