function fpr = oasis_fpr_singlesubject(FWHM, nsims, nperm)

oasis_data_dir = '';
oasis_subject_files = filesindir(oasis_data_dir);

if ~exist('nsims', 'var')
    nsims = 1000;
end
if ~exist('nperm', 'var')
    nperm = 1000;
end

fpr = 0;

for I = 1:nsims
    id = randsample(1:length(oasis_subject_files), 1);
    subject_file = [oasis_data_dir, oasis_subject_files(id)];

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
    X = srf_noise( srf_sphere, FWHM, 'ones' );
    Y = srf_noise( srf_sphere, FWHM, 'ones' );

    % Run the spin test
    [thresh, rho_store] = spintest( X, Y, srf_sphere, nperm, 0 );
    if rho_store(1) > thresh
        fpr = fpr + 1;
    end
end

fpr = fpr/nsim;

end