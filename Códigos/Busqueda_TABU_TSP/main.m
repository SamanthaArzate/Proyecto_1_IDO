% Autor: Miriam Samantha Arzate Gonzalez (Miembro del Equipo 4)
% 
%%%%%%%%%%%% Implementacion de la heurística Tabu para el TSP %%%%%%%%%%%%%
%
% Inspirado en los codigos e implementacion de:  
%       S. Mostapha Kalami Heris (Member of Yarpiz Team)
%           Project Code: YPEA116
%           Project Title: Implementation of Tabu Search for TSP
%           Publisher: Yarpiz (www.yarpiz.com)


clc;
clear;
close all;

%% Definicion del problema
archivoTxt = "zi929.txt"; 

model = CreateModel(archivoTxt);      % Crea el modelo del TSP deseado

CostFunction = @(tour) TourLength(tour, model);     % Funcion de costo dado 
                                                    % el tour propuesto y 
                                                    % ya sin tener que 
                                                    % mencionar el modelo

ActionList = CreatePermActionList(model.n);     % Genera una lista de 
                                                % movimientos permitidos 
                                                % (vecindad) 
                                                % model.n es el tamaño del 
                                                % modelo, i.e. #ciudades

nAction = numel(ActionList);  % Número de vecinos


%% Busqueda Tabu (Parametros)

MaxIt = 50;                 % Numero maximo de iteraciones

TL = round(0.5 * nAction);     % Tabu length (tamaño maximo de la lista con 
                               % movimientos considerados tabu) (static 
                               % tabu ternure) (como la eligio Mostapha) 
                               
                            % Dicha lista representa nuestra Short Term 
                            % Memory Structure (preve que la busqueda no 
                            % vuelva a visitar soluciones que se han 
                            % visitado previamente)


%% Inicializacion

% Crea una estructura / individuo vacio
empty_individual.Position = [];
empty_individual.Cost = [];


% Genera una solución inicial
sol = empty_individual;        % inicializa con la estructura vacia por si 
                               % la vecindad es vacía
                               
% sol.Position = randperm(model.n);       % genera un tour inicial, aleatorio
                                        % y exhaustivo


%Solución inicial NN
[row,col] = find( model.d == min(model.d(model.d>0)));
sol.Position(1) = row(1);
sol.Position(2) = col(1);

for i = 3:model.n
    destinos = find(~ismember(1:model.n,sol.Position(1:i-1)));
    [row,col] = find( model.d == min(model.d(sol.Position(i-1),destinos)));
    r = find(row == sol.Position(i-1));
    sol.Position(i) = col(r(1));
end                                        
                                        
sol.Cost = CostFunction(sol.Position);  % calcula costo de ese tour inicial


% Inicializa la mejor solucion encontrada hasta el momento
BestSol = sol;


% Inicializa un arreglo de tamaño MaxIt con los mejores costos encontrados
BestCost = zeros(MaxIt,1);


% Inicializa contador/indice de movimientos tabu
TC = zeros(nAction,1);


%% Busqueda tabu (Ciclo principal)
tic
for it = 151:200%MaxIt 
    
    bestnewsol.Cost = inf;  % inicializa mejor costo de ruta en infinito 
                            % (cualquier cambio lo mejora)
    
    % Busqueda local dentro de la vecindad establecida
    for i = 1:nAction
        if TC(i) == 0  % compara que ese vecino no sea tabu 
            newsol.Position = DoAction(sol.Position, ActionList{i});
            newsol.Cost = CostFunction(newsol.Position);
            newsol.ActionIndex = i;

            if newsol.Cost <= bestnewsol.Cost % Revisa si mejora el costo
                bestnewsol = newsol;
            end
        end
    end
    
    % Actualiza la solucion actual
    sol = bestnewsol;
    
    % Actualiza lista Tabu
    for i = 1:nAction
        if i == bestnewsol.ActionIndex
            TC(i) = TL;       % Añade el movimiento a la lista tabu
                              % No podremos volver a realizar ese 
                              % movimiento en TL pasos.
                              % (Buscamos prevenir visitar soluciones del 
                              % pasado reciente)                              
        else
            TC(i) = max(TC(i)-1,0);   % Reduce Tabu Counter
        end
    end
    
    % Verifica si la sol. de esta vecindad supera a la mejor encontrada
    % si el progreso es > 1% actualiza la posicion, si no, random
    if sol.Cost <= BestSol.Cost
%         if (BestSol.Cost - sol.Cost)/BestSol.Cost > 0.01
            BestSol = sol;
%         else
%             BestSol.Cost = sol.Cost;
%             BestSol.Position = randperm(model.n);
%         end
    end
    
    % Guarda el mejor costo hasta ahora (iteracion it) en vector BestCost
    BestCost(it) = BestSol.Cost;
    
    % Muestra el progreso de la busqueda
    disp(['Iteracion ' num2str(it) ': Mejor Costo = ' num2str(BestCost(it))]);
    
    % Genera la grafica de la mejor solucion hasta el momento
    %figure(1);
    %PlotSolution(BestSol, model); 
    %pause(0.01);
    
    % Revisa si se llegó al minimo global trivial (cero)
    if BestCost(it) == 0
        break; % termina la busqueda
    end
    
end
toc

%BestCost = BestCost(1:it); % es hasta "it" por si sale con costo cero 


%% Results

%figure;
%plot(BestCost,'LineWidth',2);
%xlabel('Iteracion');
%ylabel('Mejor Costo');
%grid on;


