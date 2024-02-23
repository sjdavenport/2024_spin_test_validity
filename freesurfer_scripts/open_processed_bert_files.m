% Opening matlab: 
% /usr/pubsw/packages/matlab/R2023a/bin/glnxa64/MATLAB

addpath('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/matlab/')
addpath('/home/sdavenport/2024_spin_test_validity/freesurfer_scripts/')
addpath(genpath('/home/sdavenport/StatBrainz/'))

%%
bert_origrh_area = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/rh.area');
bert_ic3_area = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/rh.area.ic3_fwhm0.dir/bert.1.mgh');

f = find(bert_origrh_area.data == bert_ic3_area.data(1));

%%
bert_origrh_thickness = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/rh.thickness');
bert_ic3_thickness = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/rh.thickness.ic3_fwhm0.dir/bert.1.mgh');

f = find(bert_origrh_thickness.data == bert_ic3_thickness.data(1));

%%
bert_origrh_thickness = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/rh.thickness');
bert_ic3_thickness = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/rh.thickness.ic3.dir/bert.1.mgh');

f = find((bert_origrh_thickness.data < (bert_ic3_thickness.data(1) + 10^(-4))).*(bert_origrh_thickness.data > (bert_ic3_thickness.data(1) - 10^(-4))));
mean(bert_ic3_thickness.data(:))
mean(bert_origrh_thickness(:))

%% Write 
testvar = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/rh.thickness');
testvar.data = 1:length(testvar.data);
testvar.filename = '/home/sdavenport/freesurfer_files/bert/surf/rh.testvar.curv';
palm_miscwrite(testvar)
testvar = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/lh.thickness');
testvar.filename = '/home/sdavenport/freesurfer_files/bert/surf/lh.testvar.curv';
testvar.data = 1:length(testvar.data);
palm_miscwrite(testvar)

ltv =  palm_miscread('/home/sdavenport/freesurfer_files/bert/surf/rh.testvar.curv');

%% Write smooth data
bert_surf_dir = '/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/';
srf = fs2surf([bert_surf_dir, 'lh.sphere.reg'], [bert_surf_dir, 'rh.sphere.reg']);

data = srf_noise(srf, 20);

smoothnoise = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/rh.thickness');
smoothnoise.data = data.rh;
smoothnoise.filename = '/home/sdavenport/freesurfer_files/bert/surf/rh.smoothnoise.curv';
palm_miscwrite(smoothnoise)
smoothnoise = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/lh.thickness');
smoothnoise.filename = '/home/sdavenport/freesurfer_files/bert/surf/lh.smoothnoise.curv';
smoothnoise.data = data.lh;
palm_miscwrite(smoothnoise)

ltv =  palm_miscread('/home/sdavenport/freesurfer_files/bert/surf/rh.testvar.curv');
%%
srf = fs2surf('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/rh.sphere.reg');
srfico = fs2surf('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/fsaverage3/surf/rh.sphere');

%%
bert_origrh_thickness = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/rh.thickness');
bert_ic3_thickness = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/rh.thickness.ic3.dir/bert.1.mgh');

f = find((bert_origrh_thickness.data < (bert_ic5_thickness.data(1) + 10^(-4))).*(bert_origrh_thickness.data > (bert_ic5_thickness.data(1) - 10^(-4))));
mean(bert_ic3_thickness.data(:))
mean(bert_origrh_thickness(:))

%%
areadata = palm_miscread('C:/Users/12Sda/davenpor/Data/Oasis/oasis_cs_freesurfer_disc1/disc1/OAS1_0001_MR1/surf/rh.area');

%%
srf = fs2surf('C:/Users/12Sda/davenpor/Data/Oasis/oasis_cs_freesurfer_disc1/disc1/OAS1_0001_MR1/surf/rh.white');

%%
areadata = palm_miscread('C:/Users/12Sda/davenpor/Data/Oasis/oasis_cs_freesurfer_disc1/disc1/OAS1_0001_MR1/mri/brain.mgz');

%% Load in the processed test data
resampled_testvar = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/rh.testvar.curv.ic3.dir/bert.1.mgh')

