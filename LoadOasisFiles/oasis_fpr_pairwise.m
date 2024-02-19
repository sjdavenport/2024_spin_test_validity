nsubj_oasis = 432;

nsims = 1000;
nperm = 1000;

FWHM = 4;

for I = 1:nsims
    ids = randsample(1:nsubj_oasis, 2);

    id1 = ids(1);
    id2 = ids(2);

    % Load in the subject data
    clear surf1 surf2

    % Load in the surface info for subject 1
    fs1_left = '';
    fs1_right = '';
    fs1_sphere_left = '';
    fs1_sphere_right = '';
    surf1 = fs2surf(fs1_left, fs1_right);
    sphere1 = fs2surf(fs1_sphere_left, fs1_sphere_right);

    % Add data and smooth
    surf1.lh.data = randn(surf1.lh.nvertices, 1);
    surf1.rh.data = randn(surf1.rh.nvertices, 1);
    surf1 = smooth_surface(surf1, FWHM);
        
    % Load in the surface info for subject 2
    fs2_left = '';
    fs2_right = '';    
    fs2_sphere_left = '';
    fs2_sphere_right = '';
    surf2 = fs2surf(fs2_left, fs2_right);
    sphere2 = fs2surf(fs2_sphere_left, fs2_sphere_right);

    surf2.lh.data = randn(surf2.lh.nvertices, 1);
    surf2.rh.data = randn(surf2.rh.nvertices, 1);
    surf2 = smooth_surface(surf2, FWHM);
    
    % Spin the surface data for subject 1
    [ left_rotations,  right_rotations] = spin_surface( surf1, sphere, nperm )
end
