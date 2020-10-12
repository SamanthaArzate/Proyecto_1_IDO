% Autor: Miriam Samantha Arzate Gonzalez (Miembro del Equipo 4)
% 
%%%%%%%% Funcion para hacer movimientos tipo 2.-REVERSION (2-Opt) %%%%%%%%%
%
% Inspirado en los codigos e implementacion de:  
%       S. Mostapha Kalami Heris (Member of Yarpiz Team)
%           Project Code: YPEA116
%           Project Title: Implementation of Tabu Search for TSP
%           Publisher: Yarpiz (www.yarpiz.com)


function q = DoReversion(p,i1,i2)
    % out:  "q" ..... Nueva posicion (vecino) después de remover 2 arcos 
    %                 del tour no adyacentes y reconectar los 2 subtours,  
    %                 suponiendo i<j, i-1 con j y i con j+1 (los de en 
    %                 medio, i.e. de i a j, quedan en reversa) 
    %
    % in :  "p" ..... Posicion inicial (vector con los indices de las
    %                 ciudades en orden de visita)
    %       "i1" .... Indice de la ciudad 1 limite de la reversion
    %       "i2" .... Indice de la ciudad 2 limite de la reversion

    
    q = p;
    if i1 < i2
        q(i1:i2) = p(i2:-1:i1); 
    else
        q(i1:-1:i2) = p(i2:i1);
    end
end

