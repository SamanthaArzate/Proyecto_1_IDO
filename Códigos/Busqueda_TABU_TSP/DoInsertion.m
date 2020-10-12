% Autor: Miriam Samantha Arzate Gonzalez (Miembro del Equipo 4)
% 
%%%%%% Funcion para hacer movimientos tipo 3.-INSERTION (VertexIns) %%%%%%%
%
% Inspirado en los codigos e implementacion de:  
%       S. Mostapha Kalami Heris (Member of Yarpiz Team)
%           Project Code: YPEA116
%           Project Title: Implementation of Tabu Search for TSP
%           Publisher: Yarpiz (www.yarpiz.com)

function q = DoInsertion(p,i1,i2)
    % out : "q" ...... Posicion final despues de escoger un nodo al 
    %                  azar (i) e insertarlo entre otras 2 ciudades 
    %                  (despues de j)
    %
    % in :  "p" ...... Posicion inicial (vector con los indices de las
    %                  ciudades en orden de visita)
    %       "i1" ..... Ciudad a extraer 
    %       "i2" ..... Ciudad anterior a la insercion 
    
    if i1 < i2
        q = p([1:i1-1 i1+1:i2 i1 i2+1:end]);
    else
        q = p([1:i2 i1 i2+1:i1-1 i1+1:end]);
    end
end