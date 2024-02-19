function oasis_fpr_singlesubject(FWHM, nsims, nperm)

nsubj_oasis = 432;

if ~exist('nsims', 'var')
    nsims = 1000;
end
if ~exist('nperm', 'var')
    nperm = 1000;
end

for I = 1:nsims
    subject_id = randsample(1:nsubj_oasis, 1);

    % Load in the subject data
    clear srf

    % Load in the surface info for subject 1
    fs1_left = '';
    fs1_right = '';
    fs1_sphere_left = '';
    fs1_sphere_right = '';
    srf = fs2surf(fs1_left, fs1_right);
    srf_sphere = fs2surf(fs1_sphere_left, fs1_sphere_right);

    % Add data and smooth
    surface_data.lh = randn(srf.lh.nvertices, 1);
    surface_data.rh = randn(srf.rh.nvertices, 1);
    srf = smooth_surface(srf, surface_data, FWHM);

    % Spin the surface data for subject 1
    [ left_rotations,  right_rotations] = spin_surface( srf, srf_sphere, nperm );

    % Do spin test bit here!
    
end


end