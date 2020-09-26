function [p,L] = tspsearch(X,m)

[n,dim] = size(X);
if dim == 2 || dim == 3
    % X es una matriz de coordenada y calculamos la distancia euclidian
    D = distmat(X);
elseif n == dim && min(X(:)) >= 0 && isequal(X,X')
    D = X;
else
    mess = 'Error de dimension';
    error('tspsearch:first',mess)
end

% % Check second argument
% if nargin < 2 || isempty(m)
%     m = 1;
% elseif ~isscalar(m) || m < 1 || m > n || fix(m) < m
%     mess = 'M must be an integer in the range 1 to %d.';
%     error('tspsearch:second',mess,n)
% end

% Starting points for nearest neighbour tours
s = randperm(n);

Lmin = inf;
for k = 1:m
    % Vecino mas cercano
	p = greedy(s(k),D);
    % Usar 2opt
	[p,L] = exchange2(p,D);
    % Si encuentra mejor tour lo actualiza
	if L < Lmin
        Lmin = L;
        pmin = p;
	end
end

p = double(pmin);
L = Lmin;

end