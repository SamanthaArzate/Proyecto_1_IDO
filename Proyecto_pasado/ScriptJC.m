% X = rand(100,2);
% tic
% [p,L] = tspsearch(X,100);
% % tspplot(p,X) %Ver grafica
% %L %imprime distancia
% toc
format long

fileID = fopen('zi929.txt','r');
formatSpec = '%f';
X = fscanf(fileID,formatSpec);

X

% tic
%   [p,L] = tspsearch(X,10);
%   L
% toc