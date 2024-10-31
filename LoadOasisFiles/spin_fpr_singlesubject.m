function fpr = spin_fpr_singlesubject(FWHM, nsims, nperm, domask)

if ~exist('nsims', 'var')
    nsims = 1000;
end
if ~exist('nperm', 'var')
    nperm = 1000;
end

fpr = 0;

if domask
    annotfile = '/Users/sdavenport/Documents/Code/MATLAB/MyPackages/StatBrainz/BrainImages/Surface/fsaverage4/lh.aparc.annot';
    lhmask = fsannot2mask( annotfile, 'medial_wall' );
    annotfile = '/Users/sdavenport/Documents/Code/MATLAB/MyPackages/StatBrainz/BrainImages/Surface/fsaverage4/rh.aparc.annot';
    rhmask = fsannot2mask( annotfile, 'medial_wall' );
end

for I = 1:nsims
    I
    srf_sphere = loadsrf('fs4');
    % fs1_left = '';
    % fs1_right = '';
    % fs1_sphere_left = '';
    % fs1_sphere_right = '';
    % srf = fs2surf(fs1_left, fs1_right);
    % srf_sphere = fs2surf(fs1_sphere_left, fs1_sphere_right);

    % Add data and smooth
    X = srf_noise( srf_sphere, FWHM, 1, 'ones' );
    Y = srf_noise( srf_sphere, FWHM, 1, 'ones' );

    if domask
        X.lh(lhmask) = NaN;
        Y.lh(lhmask) = NaN;

        X.rh(rhmask) = NaN;
        Y.rh(rhmask) = NaN;
    end

    % Run the spin test
    [thresh, rho_store] = spintest( X, Y, srf_sphere, nperm, 0.05, 0 );
    if rho_store(1) > thresh
        fpr = fpr + 1;
    end
end

fpr = fpr/nsims;

end