% addpath('~/tools/toolbox.git/share/');
clf

% Simulation parameters
nR = 1000; % number of realization (each is a pair of maps)
nV = 60; % number of vertices
longdist = false; % add some crazy off-diagonal dependencies

% Simulate intrinsic smoothing, non-stationary
FWHM = [1:1:floor(nV/2) ceil(nV/2):-1:1] + 2;
%FWHM = (1:nV) + 2;
S = topsmooth(nV,FWHM);
% S = eye(nV);

% Add some off-diagonal (long distance) dependencies too
if longdist
    S0 = zeros(nV);
    d = floor(nV/6);
    S0(4*d+1:5*d,1*d+1:2*d) = 1;
    S0(1*d+1:2*d,4*d+1:5*d) = 1;
    S0 = S0./sum(S0,2); S0(isnan(S0)) = 0;
    S = S./sum(S,2) + S0;
    for s = 1:size(S,1)
        fs = fftn(S(s,:));
        pfs = fs.*conj(fs);
        acf = real(ifftn(pfs));
        scl = 1/sqrt(acf(1));
        S(s,:) = S(s,:)*scl;
    end
end

% Random data, smoothed identically
Y = randn(nV,nR); Y = S*Y;
X = randn(nV,nR); X = S*X;

% For each realization (pair of maps), regress one on another
% and compute the residuals
res = zeros(size(Y));
for r = 1:nR
    b = X(:,r)\Y(:,r);
    res(:,r) = Y(:,r) - X(:,r)*b;
end

% Inspect the covariances of the maps and residuals
covY   = cov(Y')';
covX   = cov(X')';
covres = cov(res')';
subplot(2,3,1), imagesc(covY);   xticks([]); yticks([]); title('cov(Y)');   colorbar
subplot(2,3,2), imagesc(covX);   xticks([]); yticks([]); title('cov(X)');   colorbar
subplot(2,3,3), imagesc(covres); xticks([]); yticks([]); title('cov(res)'); colorbar

% Create a circular permutation matrix (we could work
% with indices, but it's helpful to think in terms of matrices)
steps = randi(nV-1);
Pidx = (1:nV); Pidx = circshift(Pidx,steps);
P = eye(nV); P = P(Pidx,:);

% Permute one of the sides
PY = Y;
PX = P*X;

% For each realization (pair of maps), regress one on another
% and compute the residuals, now for the permuted data
Pres = zeros(size(PY));
for r = 1:nR
    Pb = PX(:,r)\PY(:,r);
    Pres(:,r) = PY(:,r) - PX(:,r)*Pb;
end

% Inspect the covariances of the maps and residuals
covPY   = cov(PY')';
covPX   = cov(PX')';
covPres = cov(Pres')';
subplot(2,3,4), imagesc(covPY);   xticks([]); yticks([]); title('cov(Y)');    colorbar
subplot(2,3,5), imagesc(covPX);   xticks([]); yticks([]); title('cov(X*)');   colorbar
subplot(2,3,6), imagesc(covPres); xticks([]); yticks([]); title('cov(res*)'); colorbar

fprintf('Mean variance of the residuals (unpermuted): %g\n', mean(var(res)));
fprintf('Mean variance of the residuals (permuted): %g\n',   mean(var(Pres)));
fprintf('Variance of permuted > permuted in %d out of %d realizations\n', sum(var(Pres)>var(res)), nR);