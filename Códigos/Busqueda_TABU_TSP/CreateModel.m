% Autor: Miriam Samantha Arzate Gonzalez (Miembro del Equipo 4)
% 
%%%%%%%%%%%%%%%% Funcion para generar el modelo del TSP %%%%%%%%%%%%%%%%%%%
%
% Inspirado en los codigos e implementacion de:  
%       S. Mostapha Kalami Heris (Member of Yarpiz Team)
%           Project Code: YPEA116
%           Project Title: Implementation of Tabu Search for TSP
%           Publisher: Yarpiz (www.yarpiz.com)


function model = CreateModel(archivoTxt) % 'ejemplo.txt'
    
    A = rmmissing(readmatrix(archivoTxt)); %leemos las bases de datos y omitimos NaN

    x = A(:,2); % las entradas de x estan en la segunda columna
    
    y = A(:,3); % las entradas de y estan en la tercera columna
    
    n = numel(x); % cuenta el numero de ciudades
    
    d = zeros(n,n); % inicializamos la matriz de distancias
    
    for i = 1:n-1
        for j = i+1:n
            d(i,j) = sqrt( (x(i)-x(j))^2 + (y(i)-y(j))^2 );
            d(j,i) = d(i,j); % suponemos matriz de distancias simétrica
        end
    end
    
    % Variables para limites de las graficas:
    xmin = min(x) - 100;
    xmax = max(x) + 100;
    
    ymin = min(y) - 100;
    ymax = max(y) + 100;
    
    model.xmin = xmin;
    model.xmax = xmax;
    model.ymin = ymin;
    model.ymax = ymax;
    
    
    %Informacion general del modelo:
    model.n = n;
    model.x = x;
    model.y = y;
    model.d = d;
end