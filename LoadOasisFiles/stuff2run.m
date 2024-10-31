% data alone
% medial wall with the scaling factor. Use a factor of sqrt(

% Can either use the correlation or the test-statistic. Anderson says it is
% better to 

% Essentially the correlation has a CLT.

% First try the naive version without the correction factor.

%%
FWHM = 10;
oasis_data_dir = '/Users/sdavenport/Documents/Data/Surface/Oasis_data/oasis_data_repo/';
oasis_subject_files = filesindir(oasis_data_dir, '.sphere.reg');
nnindices_files = filesindir(oasis_data_dir, 'fs4');

ico_srf = loadsrf('fs4', 'sphere');

subject_file = [oasis_data_dir,oasis_subject_files{1}];
nnind_file = [oasis_data_dir,nnindices_files{1}];

% Load in the surface info for subject 1
srf_sphere_data = load(subject_file);
srf_sphere = srf_sphere_data.srf;

X = srf_noise( srf_sphere, FWHM, 1, 'ones' );

a = load(nnind_file);
X_resampled.lh = X.lh(a.nnindices.lh);
X_resampled.rh = X.rh(a.nnindices.rh);

subplot(1,2,1)
srfplot(srf_sphere.lh, X.lh)
subplot(1,2,2)
srfplot(ico_srf.lh, X_resampled.lh)

%%
subplot(1,2,1)
srfplot(srf_sphere.lh, X.lh)
subplot(1,2,2)
srfplot(srf_sphere.lh, [])