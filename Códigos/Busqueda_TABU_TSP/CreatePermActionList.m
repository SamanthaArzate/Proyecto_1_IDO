% Autor: Miriam Samantha Arzate Gonzalez (Miembro del Equipo 4)
% 
%%%%%%%% Funcion para generar la lista de movimientos permitidos %%%%%%%%%%
%%%%%%%%  Vecindades (mov) por VertexEx, VertexIns y 2-opt move  %%%%%%%%%%

%
% Inspirado en los codigos e implementacion de S. Mostapha Kalami Heris 
%                                              (Member of Yarpiz Team)
% Inspirado en los codigos e implementacion de:  
%       S. Mostapha Kalami Heris (Member of Yarpiz Team)
%           Project Code: YPEA116
%           Project Title: Implementation of Tabu Search for TSP
%           Publisher: Yarpiz (www.yarpiz.com)



function ActionList = CreatePermActionList(n) 
    % in :    "n" ............. el número de ciudades en el tour
    %
    % out :   "ActionList" .... lista de movimientos permitidos (vecindad)
    %                                       [tipo, i, j]
    %                           tipos:  1.- VertexEx   (SWAP)
    %                                   2.- 2-opt move (REVERSION) 
    %                                   3.- VertexIns  (INSERTION)
    

    nSwap = n*(n-1)/2; 
    nReversion = n*(n-1)/2; 
    nInsertion = n^2; 
    nAction = nSwap + nReversion + nInsertion; % maximo tamaño posible
    
    ActionList = cell(nAction,1); % cell es como un obj list de R pero en 2 dimensiones
    
    c = 0; %contador de elementos en la lista
    
    % Add SWAP ( Vertex Exchange (VertexEx) : vecinos por intercambio de 
    % 2 nodos i<->j )
    for i = 1:n-1
        for j = i+1:n
            c = c+1;
            ActionList{c} = [1 i j]; % 1 = SWAP
        end
    end

    
    % Add REVERSION (2-opt move : remueve 2 arcos del tour no adyacentes y 
    % reconecta los 2 subtours  suponiendo i<j, i-1 con j y i con j+1 (los 
    % de en medio, i.e. de i a j, quedan en reversa) 
    for i = 1:n-1
        for j = i+1:n
            if abs(i-j) > 2
                c = c+1;
                ActionList{c} = [2 i j]; % 2 = REVERSION
            end
        end
    end
    
    
    % Add INSERTION ( Vertex Insertion (VertexIns) : se escoge un nodo al 
    % azar (i) y se inserta entre otras 2 ciudades (después de j)
    for i = 1:n
        for j = 1:n
            if abs(i-j) > 1
                c = c+1;
                ActionList{c} = [3 i j]; % 3 = INSERTION 
            end
        end
    end
    
    ActionList = ActionList(1:c); %elimina celdas vacías de la lista

end