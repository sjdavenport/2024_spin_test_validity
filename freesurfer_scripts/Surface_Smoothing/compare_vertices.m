bert_srf = fs2surf('C:\Users\12SDa\davenpor\Data\Surface\freesurfer_files\bert\surf\rh.sphere.reg');
bert_srfrh = bert_srf.rh;
srfico = fs2surf('C:\Users\12SDa\davenpor\Data\Surface\freesurfer_files\fsaverage3\surf\rh.sphere.reg');

%%
mean(sqrt(sum(bert_srfrh.vertices.^2,2)))
sqrt(sum(srfico.vertices.^2,2))

%% 67527
nearest_vertex_insrf = dsearchn(bert_srfrh.vertices,srfico.vertices(1:10,:));

%%
nearest_vertex_insrf(1)
srfico.vertices(1,:)
bert_srfrh.vertices(nearest_vertex_insrf(1), :)
bert_srfrh.vertices(67527, :)

nearest_vertex_insrf(2)
srfico.vertices(2,:)
bert_srfrh.vertices(nearest_vertex_insrf(2), :)
bert_srfrh.vertices(75648, :)

nearest_vertex_insrf(3)
srfico.vertices(3,:)
bert_srfrh.vertices(nearest_vertex_insrf(3), :)
bert_srfrh.vertices(118908, :)

%%
out = dsearchn(srf.vertices,srfico.vertices(4,:))
bert_srfrh.vertices(104273,:)
bert_srfrh.vertices(104379,:)

%%
out = dsearchn(srf.vertices,srfico.vertices(4,:))
srf.vertices(104273,:)
srf.vertices(104379,:)

%%
addpath('C:\Users\12SDa\global\TomsMiniProject\Latex\MyPapers\2024_spin_test_validity\freesurfer_scripts')
addpath('C:\Users\12SDa\davenpor\Data\Surface\freesurfer_files\matlab')
area_file = palm_miscread('C:\Users\12SDa\davenpor\Data\Surface\freesurfer_files\bert\surf\rh.thickness')

%%
myresampled_data = resample_srf(orig_data, bert_srfrh, srf5);
