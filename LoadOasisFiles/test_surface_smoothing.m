sourceBaseDir = 'C:\Users\12SDa\davenpor\Data\Oasis\oasis_cs_freesurfer_disc1\disc1\';
savedir = 'C:\Users\12SDa\davenpor\Data\Oasis\oasis_data\';
subjectdir = [sourceBaseDir, 'OAS1_0001_MR1\'];

metric = 'dist';
left_hemi = [subjectdir, 'surf\lh.sphere'];
right_hemi = [subjectdir, 'surf\rh.sphere'];
srf_sphere = fs2surf(left_hemi, right_hemi);
data = surf_noise(srf_sphere);

FWHM = 6;
data_smooth_sphere = smooth_surface(srf_sphere, data, FWHM, metric);

left_hemi = [subjectdir, 'surf\lh.white'];
right_hemi = [subjectdir, 'surf\rh.white'];
srf_white = fs2surf(left_hemi, right_hemi);
data_smooth_white = smooth_surface(srf_white, data, FWHM, metric);

isequal(data_smooth_sphere, data_smooth_white)