k = .1;

sine = 2*sin(0:k:10*pi)';

N = size(sine,1);

nRlz = 1000;

% sf = ceil(pi/2/k);
% P = eye(N);
% P = vertcat(P(sf+1:end,:),P(1:sf,:));
% Yp = P*Y;

subplot(3,1,1); plot(X);
subplot(3,1,2); plot(Y);
subplot(3,1,3); plot(Yp);

%%
pval = zeros(1,nRlz);

for rlz = 1:nRlz
    modul(rlz,100)
    X = sine*(2*(rand>.5)-1);
    Y = sine*(2*(rand>.5)-1);
    X = X + randn(size(X));
    Y = Y + randn(size(Y));

    for p = 1:N
        Pvec = [p:N 1:p-1];
        Yp = Y(Pvec);
        rp = corr(X,Yp);

        if p == 1
            r1  = corr(X,Y);
            cnt = 1;
        else
            cnt = cnt + (rp >= r1);
        end
    end

    pval(rlz) = cnt/N;
end


%%
X = sine*(5*(rand>.5)-1);
Y = sine*(5*(rand>.5)-1);
X = X + randn(size(X));
Y = Y + randn(size(Y));
corr(X,Y)