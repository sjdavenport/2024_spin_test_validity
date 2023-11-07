filename = 'C:\Users\12SDa\davenpor\Data\Oasis\oasis_cs_freesurfer_disc1\disc1\OAS1_0001_MR1\surf\lh.white';
surfplot(filename)

%%
[coords, faces] = read_fs_geometry(filename);
clear surf
surf.coords = coords;
surf.faces = faces;

%%
fid = fopen(filename, 'rb');
magic = fread3(fid);
fread(fid, 1, 'int32', 'ieee-be')