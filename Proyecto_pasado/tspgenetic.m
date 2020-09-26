function [Hdist, MinDist] = tspgenetic(A, Pob, pobsize, maxit, dfunc)
%tspgenetic es una función que nos ayuda a resolver el problema del tsp asociado
%con una metaheurística de algorítmo genetico
%Inputs: A: La matriz de costos entre ciudad y ciudad
%Pob: número de ciudades a visitar
%pobsize: El tamaño de la población en cada momento
%maxit: El número máximo de iteraciones


ff = dfunc; 
N = Pob; % # Columnas en la matriz de población
mut = .05; % tasa de mutación
select = 0.5; % Porcentaje de población seleccionada
keep = floor(select*pobsize); % #Número de cromosomas que sobreviven
M = ceil((pobsize-keep)/2); %Numero de cruces evolutivos
probas = 1;

for i = 2:keep
    probas=[probas i*ones(1,i)]; 
end 

Nprobas= length (probas);
probas = keep-probas+1; % La probabilidad de ser progenitor

% % Población Inicial
count = 0; % Contador para iteración

for k = 1:pobsize
    POB(k,:) = randperm(Pob);
end

Dist=feval(ff,POB,A); % Calcular la distancia de todos los cromosomas
[Dist,ind]=sort(Dist); % Obtienes el índice de la distancia más corta
POB = POB(ind,:); % Ordenas los pobladores del más apto al menos
Hdist(:,1)=min(Dist); %Creamos el historico de la distancia minima
MinDist(1,:) = POB(1,:); %Nos quedamos con el poblador de la distancia mínima
%Hacemos las iteraciones (MAIN LOOP)
while count<maxit
    count=count+1;
    
    % Elegir progenitores y curce genetico
    pick1=ceil(Nprobas*rand(1,M)); % mate #1
    pick2=ceil(Nprobas*rand(1,M)); % mate #2
    
    % ma y pa contienen los índices de los progenitores
    ma=probas(pick1);
    pa=probas(pick2);
    
    % Se hace el cruce
    for ic=1:M
        par1=POB(ma(ic),:);
        par2=POB(pa(ic),:);
        indx=2*(ic-1)+1; 
        xp=ceil(rand*Pob); 
        aux=par1;
        x0=xp;
        while par1(xp)~=aux(x0)
            par1(xp)=par2(xp);
            par2(xp)=aux(xp);
            xs=find(aux==par1(xp));
            xp=xs;
        end
        POB(keep+indx,:)=par1;
        POB(keep+indx+1,:)=par2;
    end
    
    % Mutamos la población
    nmut=ceil(pobsize*Pob*mut);
        for ic = 1:nmut
            row1=ceil(rand*(pobsize-1))+1;
            col1=ceil(rand*Pob);
            col2=ceil(rand*Pob);
            aux=POB(row1,col1);
            POB(row1,col1)=POB(row1,col2);
            POB(row1,col2)=aux;
            im(ic)=row1;
        end
    Dist=feval(ff,POB,A);
    [Dist,ind]=sort(Dist);
    POB=POB(ind,:);
    Hdist(:,count)=min(Dist); %Creamos el historico de la distancia minima
    MinDist(count,:) = POB(1,:); %Nos quedamos con el poblador de la distancia mínima
end
