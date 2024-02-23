% Opening matlab: 
% /usr/pubsw/packages/matlab/R2023a/bin/glnxa64/MATLAB

addpath('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/matlab/')
addpath('/home/sdavenport/2024_spin_test_validity/freesurfer_scripts/')
bert_origrh_area = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/rh.area');
bert_ic3_area = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/rh.area.ic3_fwhm0.dir/bert.1.mgh');

f = find(bert_origrh_area.data == bert_ic3_area.data(1));

%%
bert_origrh_thickness = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/rh.thickness');
bert_ic3_thickness = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/rh.thickness.ic3_fwhm0.dir/bert.1.mgh');

f = find(bert_origrh_thickness.data == bert_ic3_thickness.data(1));

%%
addpath('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/matlab/')
addpath('/home/sdavenport/2024_spin_test_validity/freesurfer_scripts/')
bert_origrh_thickness = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/rh.thickness');
bert_ic3_thickness = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/rh.thickness.ic3.dir/bert.1.mgh');

f = find((bert_origrh_thickness.data < (bert_ic3_thickness.data(1) + 10^(-4))).*(bert_origrh_thickness.data > (bert_ic3_thickness.data(1) - 10^(-4))));
mean(bert_ic3_thickness.data(:))
mean(bert_origrh_thickness(:))

%%
addpath('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/matlab/')
addpath('/home/sdavenport/2024_spin_test_validity/freesurfer_scripts/')
testvar = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/rh.thickness');
testvar.data = 1:length(testvar.data);
testvar.filename = '/home/sdavenport/freesurfer_files/bert/surf/rh.testvar.curv';
palm_miscwrite(testvar)
testvar.filename = '/home/sdavenport/freesurfer_files/bert/surf/lh.testvar.curv';
palm_miscwrite(testvar)

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
addpath(genpath('/home/sdavenport/StatBrainz/'))
addpath('C:\Users\12SDa\davenpor\Data\Surface\freesurfer_files\matlab')
areadata = palm_miscread('C:/Users/12Sda/davenpor/Data/Oasis/oasis_cs_freesurfer_disc1/disc1/OAS1_0001_MR1/surf/rh.area');

%%
srf = fs2surf('C:/Users/12Sda/davenpor/Data/Oasis/oasis_cs_freesurfer_disc1/disc1/OAS1_0001_MR1/surf/rh.white');

%%
areadata = palm_miscread('C:/Users/12Sda/davenpor/Data/Oasis/oasis_cs_freesurfer_disc1/disc1/OAS1_0001_MR1/mri/brain.mgz');



