filename = 'C:\Users\12SDa\davenpor\Data\Oasis\oasis_cs_freesurfer_disc1\disc1\OAS1_0001_MR1\surf\lh.white';
surfplot(filename)

%%
surfplot(filename, randn(204140,1))

%%
[vertices, faces] = freesurfer_read_surf(filename);
clear surf
surf.vertices = vertices;
surf.faces = faces;

%%
oasis_left = 'C:\Users\12SDa\davenpor\Data\Oasis\oasis_cs_freesurfer_disc1\disc1\OAS1_0001_MR1\surf\lh.white';
oasis_right = 'C:\Users\12SDa\davenpor\Data\Oasis\oasis_cs_freesurfer_disc1\disc1\OAS1_0001_MR1\surf\rh.white';

srf = fs2surf(oasis_left, oasis_right);
surfplot(srf.lh)

%%
oasis_left = 'C:\Users\12SDa\davenpor\Data\Oasis\oasis_cs_freesurfer_disc1\disc1\OAS1_0001_MR1\surf\lh.sphere';
oasis_right = 'C:\Users\12SDa\davenpor\Data\Oasis\oasis_cs_freesurfer_disc1\disc1\OAS1_0001_MR1\surf\rh.sphere';

srfsphere = fs2surf(oasis_left, oasis_right);
surfplot(srfsphere.lh)

%% Registered data
oasis_left_reg = 'C:\Users\12SDa\davenpor\Data\Oasis\oasis_cs_freesurfer_disc1\disc1\OAS1_0001_MR1\surf\lh.sphere.reg';
oasis_right_reg = 'C:\Users\12SDa\davenpor\Data\Oasis\oasis_cs_freesurfer_disc1\disc1\OAS1_0001_MR1\surf\rh.sphere.reg';

srfsphere_reg = fs2surf(oasis_left_reg, oasis_right_reg);
surfplot(srfsphere_reg.lh)

%%
filename = 'C:\Users\12SDa\davenpor\Data\Oasis\oasis_cs_freesurfer_disc1\disc1\OAS1_0001_MR1\surf\lh.white';
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