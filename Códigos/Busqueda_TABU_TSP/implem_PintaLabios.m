% Autor: Miriam Samantha Arzate Gonzalez (Miembro del Equipo 4)
%
%%%%%%%%%%%% Implementacion de la heurística Tabu para el P2 %%%%%%%%%%%%%


clc;
clear;
close all;

%% Definicion del problema

A = [0 2 2 3 4 5 4 3 5 6;
    2 0 1 3 3 4 6 4 3 5;
    2 1 0 4 5 3 2 4 1 7;
    3 3 4 0 2 4 5 3 5 2;
    4 3 5 2 0 2 4 1 2 2;
    5 4 3 4 2 0 3 2 1 3;
    4 6 2 5 4 3 0 3 2 1;
    3 4 4 3 1 2 3 0 5 3;
    5 3 1 5 2 1 2 5 0 4;
    6 5 7 2 2 3 1 3 4 0];


model.n = 10;

model.d = A;        

CostFunction = @(tour) Costito(tour, model);     % Funcion de costo dado 
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

sol.Position = randperm(model.n);       % genera un tour inicial, aleatorio
% y exhaustivo

sol.Cost = CostFunction(sol.Position);  % calcula costo de ese tour inicial


% Inicializa la mejor solucion encontrada hasta el momento
BestSol = sol;


% Inicializa un arreglo de tamaño MaxIt con los mejores costos encontrados
BestCost = zeros(MaxIt,1);


% Inicializa contador/indice de movimientos tabu
TC = zeros(nAction,1);


%% Busqueda tabu (Ciclo principal)
tic
for it = 1:MaxIt
    
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
    if sol.Cost <= BestSol.Cost
        BestSol = sol;
    end
    
    % Guarda el mejor costo hasta ahora (iteracion it) en vector BestCost
    BestCost(it) = BestSol.Cost + 619; %el 619 es el costo fijo
    
    % Muestra el progreso de la busqueda
    disp(['Iteracion ' num2str(it) ': Mejor Costo = ' num2str(BestCost(it))]);
    
    % Revisa si se llegó al minimo global trivial (cero)
    if BestCost(it) == 0
        break; % termina la busqueda
    end
    
end
toc

BestCost = BestCost(1:it); % es hasta "it" por si sale con costo cero


%% Results
disp('La mejor ruta es: ')
disp(BestSol.Position)

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteracion');
ylabel('Mejor Costo');
grid on;












%% funcion de costo

function costo = Costito(tour, model)     % Funcion de costo dado 
    costo = 0;
    for i = 1:9
        costo = model.d(tour(i),tour(i+1)) + costo;
    end
end  

