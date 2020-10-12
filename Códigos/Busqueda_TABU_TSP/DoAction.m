% Autor: Miriam Samantha Arzate Gonzalez (Miembro del Equipo 4)
% 
%%%%% Funcion encargada de realizar el movimiendo al vecino indicado %%%%%%
%
% Inspirado en los codigos e implementacion de:  
%       S. Mostapha Kalami Heris (Member of Yarpiz Team)
%           Project Code: YPEA116
%           Project Title: Implementation of Tabu Search for TSP
%           Publisher: Yarpiz (www.yarpiz.com)
    

function q = DoAction(p,a) 
    % out:   "q" .... la nueva posicion a la que llegariamos
    %
    % in:    "p" .... la posicion inicial
    %        "a" .... el movimiento a realizar [tipo, i, j]

    switch a(1) %revisa el tipo de movimiento 
        case 1
            % Swap (VertexEx)
            q = DoSwap(p,a(2),a(3));
            
        case 2
            % Reversion (2-opt move)
            q = DoReversion(p,a(2),a(3));
            
        case 3
            % Insertion (VertexIns)
            q = DoInsertion(p,a(2),a(3));
            
    end

end