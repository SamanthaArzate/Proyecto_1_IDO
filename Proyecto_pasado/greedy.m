function p = greedy(s,D)
%Vecino mas cercano empezando en el nodo s.

n = size(D,1);
p = zeros(1,n);
p(1) = s;

for k = 2:n
    D(s,:) = inf;
    [junk,s] = min(D(:,s)); %#ok
    p(k) = s;
end
end