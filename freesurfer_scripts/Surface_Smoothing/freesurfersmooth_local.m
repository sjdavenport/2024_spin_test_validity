surf_dir = '/Users/sdavenport/Documents/Data/Surface/Oasis_data/oasis_data_raw/disc1_freesurfer/OAS1_0001_MR1/surf/';
srf = fs2surf([surf_dir, 'lh.sphere.reg'], [surf_dir, 'rh.sphere.reg']);

data = srf_noise(srf, 5);

smoothnoise = palm_miscread([surf_dir, 'rh.thickness']);
smoothnoise.data = data.rh;
smoothnoise.filename = [surf_dir, 'rh.smoothnoise.curv'];
palm_miscwrite(smoothnoise)
smoothnoise = palm_miscread([surf_dir, 'lh.thickness']);
smoothnoise.filename = [surf_dir, 'lh.smoothnoise.curv'];
smoothnoise.data = data.lh;
palm_miscwrite(smoothnoise)

save('./Testing/orig_data.mat', 'data');