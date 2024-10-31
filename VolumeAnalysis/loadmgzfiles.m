T1mri = palm_miscread('/Users/sdavenport/Documents/Data/Surface/Oasis_data/oasis_data_raw/disc1_freesurfer/OAS1_0001_MR1/mri/T1.mgz');

%%
cd /Applications/freesurfer/7.4.1/matlab/

%%
T1im = MRIread('/Users/sdavenport/Documents/Data/Surface/Oasis_data/oasis_data_raw/disc1_freesurfer/OAS1_0001_MR1/mri/brainmask.mgz');

data = T1im.vol;

imagesc(data(:,:,100))