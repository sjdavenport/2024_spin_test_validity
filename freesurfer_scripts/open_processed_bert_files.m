% Opening matlab: 
% /usr/pubsw/packages/matlab/R2023a/bin/glnxa64/MATLAB

addpath('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/matlab/')
addpath('/home/sdavenport/2024_spin_test_validity/freesurfer_scripts/')
bert_origrh_area = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/rh.area');
bert_ic3_area = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/rh.area.ic3_fwhm0.dir/bert.1.mgh');

%%
addpath('C:\Users\12SDa\davenpor\Data\Surface\freesurfer_files\matlab')
areadata = palm_miscread('C:/Users/12Sda/davenpor/Data/Oasis/oasis_cs_freesurfer_disc1/disc1/OAS1_0001_MR1/surf/rh.area');

%%
srf = fs2surf('C:/Users/12Sda/davenpor/Data/Oasis/oasis_cs_freesurfer_disc1/disc1/OAS1_0001_MR1/surf/rh.white');


