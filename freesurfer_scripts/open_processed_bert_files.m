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

save('/home/sdavenport/2024_spin_test_validity/freesurfer_scripts/smoothed_data.mat', 'data');

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
a = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/rh.testvar.curv.ic3.dir/bert.1.mgh');
resampled_int3.rh = a.data;
a = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.testvar.curv.ic3.dir/bert.1.mgh');
resampled_int3.lh = a.data;
a = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/rh.testvar.curv.ic5.dir/bert.1.mgh');
resampled_int5.rh = a.data;
a = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.testvar.curv.ic5.dir/bert.1.mgh');
resampled_int5.lh = a.data;
save('/home/sdavenport/2024_spin_test_validity/freesurfer_scripts/resampled_ints.mat', 'resampled_int3', 'resampled_int5');

%%
resampled_ic3.lh = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.smoothnoise.curv.ic3.dir/bert.1.mgh');
resampled_ic3.rh = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/rh.smoothnoise.curv.ic3.dir/bert.1.mgh');
resampled_ic5.lh = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.smoothnoise.curv.ic5.dir/bert.1.mgh');
resampled_ic5.rh = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/rh.smoothnoise.curv.ic5.dir/bert.1.mgh');
save('/home/sdavenport/2024_spin_test_validity/freesurfer_scripts/fs_smooth_runs.mat', 'resampled_ic3', 'resampled_ic5');


%%
a = load('./fs_smooth_runs.mat');
b = load('./smoothed_data.mat');
bertdir = 'C:\Users\12SDa\davenpor\Data\Surface\freesurfer_files\bert\surf\';
bert_srf = fs2surf([bertdir, 'lh.sphere.reg'], [bertdir, 'rh.sphere.reg']);
srf5 = loadsrf('fs5', 'sphere');

clear resampled_data orig_data
resampled_data.lh = a.resampled_ic5.lh.data;
resampled_data.rh = a.resampled_ic5.rh.data;

orig_data.lh = b.data.lh;
orig_data.rh = b.data.rh;

%%
subplot(1,3,1)
srfplot(bert_srf.lh, orig_data.lh)
title('Original smoothed data')
subplot(1,3,2)
srfplot(srf5.lh, resampled_data.lh)
title('Freesurfer resampling')
subplot(1,3,3)
srfplot(srf5.lh, myresampled_data.lh)
title('Actual nearest neighbours')

%%
srfplot(srf5.lh, myresampled_data.lh - resampled_data.lh)

%%
nnindices = resample_srf_nn( bert_srf, srf5 );

%%
myresampled_data = resample_srf(orig_data, bert_srf, srf5);

%%
plot(resampled_data.lh,  myresampled_data.lh, '*' )

%%
histogram(resampled_data.lh -  myresampled_data.lh)

%%
a = load('./fs_smooth_runs.mat');
b = load('./smoothed_data.mat');
c = load('resampled_ints.mat');
orig_data = b.data;
load('nnindices.mat')
bertdir = 'C:\Users\12SDa\davenpor\Data\Surface\freesurfer_files\bert\surf\';
bert_srf = fs2surf([bertdir, 'lh.sphere.reg'], [bertdir, 'rh.sphere.reg']);
srf3 = loadsrf('fs3', 'sphere');
srf5 = loadsrf('fs5', 'sphere');

resampled_data3.lh = a.resampled_ic3.lh.data;
resampled_data3.rh = a.resampled_ic3.rh.data;

myresampled_data3.lh = orig_data.lh(nnindices3.lh);
myresampled_data3.rh = orig_data.rh(nnindices3.rh);

resampled_data5.lh = a.resampled_ic5.lh.data;
resampled_data5.rh = a.resampled_ic5.rh.data;

myresampled_data5.lh = orig_data.lh(nnindices.lh);
myresampled_data5.rh = orig_data.rh(nnindices.rh);

%%
ea = 0.05;
interp = 1;
subplot(1,3,1)
srfplot(bert_srf.lh, orig_data.lh, 0, 0, 1)
title('Original smoothed data', 'color','white')
subplot(1,3,2)
srfplot(srf3.lh, resampled_data3.lh, 0, 0, 1)
title('Freesurfer resampling','color','white')
subplot(1,3,3)
srfplot(srf3.lh, myresampled_data3.lh, 0, 0, 1)
title('Actual nearest neighbours','color','white')
% colormap('spring')
% saveim('Freesurfer resampling vs nearest neighbours - ic3.pdf')

%%
srfwhite = loadsrf('fs3', 'white');
subplot(1,2,1)
% srfplot(bert_srf.lh, orig_data.lh)srfplot(srf3.lh, resampled_data3.lh)
srfplot(srfwhite.lh, resampled_data3.lh)
subplot(1,2,2)
% ax1     = axes ;
srfplot(srfwhite.lh, myresampled_data3.lh, 0, 0, 1)
% ax2     = axes ;
% srfplot(srf3.lh, [], 0, 0.1, 0)
% title('Actual nearest neighbours','color','white')

%%
% ax1     = axes ;
% srfplot(srfwhite.lh, [], 0, 0.1, 1)
% ax2     = axes ;
subplot(1,2,1)
srfplot(srf3.lh, myresampled_data3.lh, 0, 0, 1)
subplot(1,2,2)
srfplot(srfwhite.lh, myresampled_data3.lh, 0, 0, 0)

%%
srfplot(srfwhite.lh, myresampled_data3.lh, 0, 0, 0)


%%
subplot(1,3,1)
srfplot(bert_srf.lh, orig_data.lh)
title('Original smoothed data', 'color','white')
subplot(1,3,2)
srfplot(srf5.lh, resampled_data5.lh)
title('Freesurfer resampling','color','white')
subplot(1,3,3)
srfplot(srf5.lh, myresampled_data5.lh)
title('Actual nearest neighbours','color','white')
saveim('Freesurfer resampling vs nearest neighbours - ic5.pdf')

%%
subplot(1,2,1)
srfplot(bert_srf.lh, orig_data.lh)
title('Original data','color','white')
subplot(1,2,2)
srfplot(srf3.lh, orig_data.lh(round(c.resampled_int3.lh)))
title('Int resampling','color','white')
saveim('Original data versus rounded resampled integer values - ic3.pdf')

subplot(1,2,1)
srfplot(bert_srf.lh, orig_data.lh)
title('Original data','color','white')
subplot(1,2,2)
srfplot(srf5.lh, orig_data.lh(round(c.resampled_int5.lh)))
title('Int resampling','color','white')
saveim('Original data versus rounded resampled integer values - ic5.pdf')

%%
plot(resampled_data3.lh,  myresampled_data3.lh, '*' )
xlabel('FS resampling')
ylabel('Nearest neighbour resampling')
saveim('FSvsnn_vals_ic3')

plot(resampled_data5.lh,  myresampled_data5.lh, '*' )
xlabel('FS resampling')
ylabel('Nearest neighbour resampling')
saveim('FSvsnn_vals_ic5')

%%
nnindices3 = resample_srf_nn( bert_srf, srf3 );
myresampled_data3.lh = orig_data.lh(nnindices3.lh);
myresampled_data3.rh = orig_data.rh(nnindices3.rh);

%%
save('./nnindices', 'nnindices', "nnindices3")

%% Read smoothed thickness
bert_orig_thickness = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/lh.thickness');

bert_ic6_fwhm_0_thickness = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.thickness.ic6_fwhm0.dir/bert.1.mgh');
bert_ic6_fwhm_30_thickness = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.thickness.ic6_fwhm30.dir/bert.1.mgh');

bert_ic6_fwhm_40_thickness = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.thickness.ic6_fwhm40.dir/bert.1.mgh');

save('/home/sdavenport/2024_spin_test_validity/freesurfer_scripts/bert_thickness_vars', 'bert_orig_thickness', 'bert_ic6_fwhm_0_thickness', 'bert_ic6_fwhm_40_thickness')

%%
bert_ic5_fwhm_5_thickness = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.thickness.ic5_fwhm5.dir/bert.1.mgh');
bert_ic5_fwhm_10_thickness = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.thickness.ic5_fwhm10.dir/bert.1.mgh');

%% Write unsmooth data
bert_surf_dir = '/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/';
srf = fs2surf([bert_surf_dir, 'lh.sphere.reg'], [bert_surf_dir, 'rh.sphere.reg']);

data = srf_noise(srf, 0);

unsmoothnoise = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/rh.thickness');
unsmoothnoise.data = data.rh;
unsmoothnoise.filename = '/home/sdavenport/freesurfer_files/bert/surf/rh.unsmoothnoise.curv';
palm_miscwrite(unsmoothnoise)
unsmoothnoise = palm_miscread('/usr/pubsw/packages/freesurfer/RH4-x86_64-R530/subjects/bert/surf/lh.thickness');
unsmoothnoise.filename = '/home/sdavenport/freesurfer_files/bert/surf/lh.unsmoothnoise.curv';
unsmoothnoise.data = data.lh;
palm_miscwrite(unsmoothnoise)

save('/home/sdavenport/2024_spin_test_validity/freesurfer_scripts/unsmoothed_data.mat', 'data');

%% Save the smoothed unsmoothed data
clear data
a = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.unsmoothnoise.curv.ic6_fwhm10.dir/bert.1.mgh');
data.fwhm10 = a.data;
a = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.unsmoothnoise.curv.ic6_fwhm5.dir/bert.1.mgh');
data.fwhm15 = a.data;
a = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.unsmoothnoise.curv.ic6_fwhm15.dir/bert.1.mgh');
data.fwhm5 = a.data;

save('/home/sdavenport/2024_spin_test_validity/freesurfer_scripts/resampled_ints.mat', 'resampled_int3', 'resampled_int5');

%%
clear data
a = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.unsmoothnoise.curv.ic6_fwhm10.mgz');
data.fwhm10 = a.data;
a = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.unsmoothnoise.curv.ic6_fwhm15.mgz');
data.fwhm15 = a.data;
a = palm_miscread('/home/sdavenport/freesurfer_runs/mris_preproc/lh.unsmoothnoise.curv.ic6_fwhm5.mgz');
data.fwhm5 = a.data;

save('/home/sdavenport/2024_spin_test_validity/freesurfer_scripts/resampled_ints.mat', 'smoothed_data');
