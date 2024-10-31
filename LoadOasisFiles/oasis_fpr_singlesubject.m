function fpr = oasis_fpr_singlesubject(FWHM, nsims, nperm, surface)

if ~exist('surface', 'var')
    surface = 'fs4';
end

oasis_data_dir = '/Users/sdavenport/Documents/Data/Surface/Oasis_data/oasis_data_repo/';
oasis_subject_files = filesindir(oasis_data_dir, '.sphere.reg');
nnindices_files = filesindir(oasis_data_dir, surface);

ico_srf = loadsrf(surface, 'sphere');

if ~exist('nsims', 'var')
    nsims = 1000;
end
if ~exist('nperm', 'var')
    nperm = 1000;
end

fpr = 0;

for I = 1:nsims
    I
    % modul(I,10)
    id = randsample(1:length(oasis_subject_files), 1);
    subject_file = [oasis_data_dir,oasis_subject_files{id}];
    nnind_file = [oasis_data_dir,nnindices_files{id}];
    
    % Load in the subject data
    clear srf

    % Load in the surface info for subject 1
    srf_sphere_data = load(subject_file);
    srf_sphere = srf_sphere_data.srf;
    % fs1_left = '';
    % fs1_right = '';
    % fs1_sphere_left = '';
    % fs1_sphere_right = '';
    % srf = fs2surf(fs1_left, fs1_right);
    % srf_sphere = fs2surf(fs1_sphere_left, fs1_sphere_right);

    % Add data and smooth
    X = srf_noise( srf_sphere, FWHM, 1, 'ones' );
    Y = srf_noise( srf_sphere, FWHM, 1, 'ones' );

    % Resample the data to the fs4 sphere
    a = load(nnind_file);
    X_resampled.lh = X.lh(a.nnindices.lh);
    X_resampled.rh = X.rh(a.nnindices.rh);
    Y_resampled.lh = Y.lh(a.nnindices.lh);
    Y_resampled.rh = Y.rh(a.nnindices.rh);

    % Run the spin test
    [thresh, rho_store] = spintest( X_resampled, Y_resampled, ico_srf, nperm, 0.05, 0 );
    if rho_store(1) > thresh
        fpr = fpr + 1;
    end
end

fpr = fpr/nsims;

end