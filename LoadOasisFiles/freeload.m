global dataloc
filename = [dataloc, 'Surface/Oasis_data/oasis_data_raw/disc1_freesurfer/OAS1_0001_MR1/surf/lh.white'];
srf = fs2surf(filename);
srfplot(srf)

%%
srfplot(srf, randn(102072,1), 0)

%%
oasis_left = [dataloc, 'Surface/Oasis_data/oasis_data_raw/disc1_freesurfer/OAS1_0001_MR1/surf/lh.white'];
oasis_right = [dataloc, 'Surface/Oasis_data/oasis_data_raw/disc1_freesurfer/OAS1_0001_MR1/surf/rh.white'];

srf = fs2surf(oasis_left, oasis_right);
srfplot(srf.lh)

%% Sphere
oasis_left = [dataloc, 'Surface/Oasis_data/oasis_data_raw/disc1_freesurfer/OAS1_0001_MR1/surf/lh.sphere'];
oasis_right = [dataloc, 'Surface/Oasis_data/oasis_data_raw/disc1_freesurfer/OAS1_0001_MR1/surf/rh.sphere'];

srfsphere = fs2surf(oasis_left, oasis_right);
srfplot(srfsphere.lh)

%% Registered data
oasis_left_reg = [dataloc, 'Surface/Oasis_data/oasis_data_raw/disc1_freesurfer/OAS1_0001_MR1/surf/lh.sphere.reg'];
oasis_right_reg = [dataloc, 'Surface/Oasis_data/oasis_data_raw/disc1_freesurfer/OAS1_0001_MR1/surf/rh.sphere.reg'];

srfsphere_reg = fs2surf(oasis_left_reg, oasis_right_reg);
srfplot(srfsphere_reg.lh)

%%
filename = [dataloc, 'Surface/Oasis_data/oasis_data_raw/disc1_freesurfer/OAS1_0001_MR1/surf/lh.white'];
tic
[vertices, faces] = read_fs_geometry(filename);
clear surf
surf.coords = vertices;
surf.faces = faces;
toc

%%
fid = fopen(filename, 'rb');
magic = fread3(fid);
fread(fid, 1, 'int32', 'ieee-be')