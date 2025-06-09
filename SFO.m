function [fmin,state,best,time]=SFO(Plants, Fun, LB, UB, n_iter)
% n = number of plants
% p = pollination rate
% m = mortality rate
% d = problem dimension
% LB = lower bounds
% UB = upper bounds
% n_iter = max number os gerations
p = 0.5;
m = 0.7;
[n, d] = size(Plants);
for i=1:n
    Fitness(i)=feval(Fun, Plants(i,:));
end
[fmin,I]=min(Fitness);
best=Plants(I,:);
S=Plants;
tic;
for t=1:n_iter
 
    for i=1:n
        % pollination
        for j=1:(round(p*n))
            S(j,:) = (Plants(j,:)-Plants(j+1,:))*rand(1) + Plants(j+1,:);
        end
        
        % steps
        for j=(round(p*n)+1):(round(n*(1-m)))
            S(j,:)=Plants(j,:)+rand*((best-Plants(j,:))/(norm((best-Plants(j,:)))));
        end
        
        % mortality of m% plants
        for j = ((round(n*(1-m)))+1):n
            S(j,:)= (UB(j,:)-LB(j,:))*rand+LB(j,:);
        end
        
        for j = ((round(n*(1-m)))+1):n
            for k=1:length(LB)
                S(j,k)= (UB(k)-LB(k))*rand+LB(k);
            end
        end
        S(i,:)=bound_check(S(i,:),LB,UB);
        
        Fnew = feval(Fun, S(i,:));
        if (Fnew <= Fitness(i))
            Plants(i,:) = S(i,:);
            Fitness(i) = Fnew;
        end
        if  Fnew <= fmin
            best = S(i,:);
            fmin = Fnew;
        end
    end
    state(t,:) = [n_iter best fmin];
    population{t} = S;
end
time = toc;
end

function s = bound_check(s,LB,UB)
ns_tmp=s;
I=ns_tmp<LB;
ns_tmp(I)=LB(I);
J=ns_tmp>UB;
ns_tmp(J)=UB(J);
s=ns_tmp;
end
