global dataloc
datadir = [dataloc, 'Surface/Oasis_data/oasis_data_repo/'];
ico_srf = loadsrf( 'fs6', 'sphere' );

fileids = filesindir(datadir, '.reg');

%%
for subid = 2:length(fileids)
    subid
    subdata = load([datadir, fileids{subid}]);
    subid = extract_numbers(fileids{subid});
    nnindices = resample_srf_nn( subdata.srf, ico_srf );
    save([datadir, 'nnindices_subject_', num2str(subid)], 'nnindices')
end

%% Illustrate the resampling
load([datadir, 'nnindices_subject_', num2str(1)])
subdata = load([datadir, fileids{1}]);

data = srf_noise(subdata.srf, 40);
data.lh = data.lh*100;
data.rh = data.rh*100;

resampled_data.lh = data.lh(nnindices.lh);

subplot(1,2,1)
srfplot(subdata.srf.lh, data.lh)
subplot(1,2,2)
srfplot(ico_srf.lh, resampled_data.lh)

%% Testing the resampling
nnindices = dsearchn(subdata.srf.lh.vertices,ico_srf.lh.vertices);

%%
data = srf_noise(subdata.srf, 10);
data.lh = data.lh*100;
data.rh = data.rh*100;

%%
subplot(1,2,1)
srfplot(subdata.srf.lh, data.lh)
subplot(1,2,2)
srfplot(ico_srf.lh, data.lh(nnindices))

%%
min(data.lh(nnindices))
min(data.lh)

%%
for I = 1:1000
    subdata.srf.lh.vertices(nnindices(I),:)
    ico_srf.lh.vertices(I,:)
    pause
end
