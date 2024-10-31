mask = MRIread('/Users/sdavenport/Documents/Data/Surface/Oasis_data/oasis_data_raw/disc1_freesurfer/OAS1_0001_MR1/mri/brainmask.mgz');

imagesc(mask.vol(:,:,50))

voldata = mask.vol;

% Define an affine transformation matrix (4x4) for orientation
% You can use the identity matrix if no specific transformation is needed
% M = eye(4);
M = mask.vox2ras;

% Specify the filename for saving
filename = 'test.mgh';

% Save the volume using save_mgh2
save_mgh2(voldata', filename, M);

%%
system('gzip test.mgh')
system('mv test.mgh.gz test.mgz')

%%


%%
testim = MRIread('./test.mgh');
imagesc(testim.vol(:,:,50))
%%
testim = MRIread('./test.mgz');
imagesc(testim.vol(:,:,50))