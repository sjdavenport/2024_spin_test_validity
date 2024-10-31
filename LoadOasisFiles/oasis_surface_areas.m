global dataloc
datadir = [dataloc, 'Surface/Oasis_data/oasis_data_raw/disc1_freesurfer/'];
ico_srf = loadsrf( 'fs6', 'sphere' );

fileids = filesindir(datadir, '_MR1');

%%
% for subid = 1:length(fileids)
for subid = 1:1
    subid
    subdata = load([datadir, fileids{subid}]);
    white_srf = fs2surf([datadir, fileids{subid}, '/surf/', 'lh.white']);
    white_sphere = fs2surf([datadir, fileids{subid}, '/surf/', 'lh.sphere']);

    [face_areas_brain_left, vertex_areas_brain_left] = srf_face_area( white_srf );
    [face_areas_sphere_left, vertex_areas_sphere_left] = srf_face_area( white_sphere );
    face_areas_sphere_left = face_areas_sphere_left/sum(face_areas_sphere_left)*sum(face_areas_brain_left);
    vertex_areas_sphere_left = vertex_areas_sphere_left/sum(vertex_areas_sphere_left)*sum(vertex_areas_brain_left);

    vertex_area_ratio_left = vertex_areas_sphere_left./vertex_areas_brain_left;

    save([datadir, 'nnindices_subject_', num2str(subid)], 'nnindices')
    subid = extract_numbers(fileids{subid});
    nnindices = resample_srf_nn( subdata.srf, ico_srf );
    
end

%%
global dataloc
repodatadir = [dataloc, 'Surface/Oasis_data/oasis_data_repo/'];
ico_srf = loadsrf( 'fs6', 'sphere' );

fileids = filesindir(repodatadir, 'nnindices');

%%
% for subid = 1:length(fileids)
clear resampled_vertex_area
resampled_vertex_area.lh = zeros(ico_srf.lh.nvertices, 1);
resampled_vertex_area.rh = zeros(ico_srf.rh.nvertices, 1);

for I = 1:length(fileids)
    I
    subid = extract_numbers(fileids{I});
    substr = num2str(subid);
    if subid < 10
        substr = ['0', substr];
    end
    substr
    data_folder = ['OAS1_00', substr, '_MR1'];
    % subdata = load([datadir, data_folder]);
    g_white_left = fs2surf([datadir, data_folder, '/surf/', 'lh.white']);
    g_sphere_left = fs2surf([datadir, data_folder, '/surf/', 'lh.sphere.reg']);
    g_white_right = fs2surf([datadir, data_folder, '/surf/', 'rh.white']);
    g_sphere_right = fs2surf([datadir, data_folder, '/surf/', 'rh.sphere.reg']);

    [face_areas_brain_left, vertex_areas_brain_left] = srf_face_area( g_white_left );
    [face_areas_sphere_left, vertex_areas_sphere_left] = srf_face_area( g_sphere_left );
    face_areas_sphere_left = face_areas_sphere_left/sum(face_areas_sphere_left)*sum(face_areas_brain_left);
    vertex_areas_sphere_left = vertex_areas_sphere_left/sum(vertex_areas_sphere_left)*sum(vertex_areas_brain_left);
    vertex_area_ratio_left = vertex_areas_sphere_left./vertex_areas_brain_left;

    [face_areas_brain_right, vertex_areas_brain_right] = srf_face_area( g_white_right );
    [face_areas_sphere_right, vertex_areas_sphere_right] = srf_face_area( g_sphere_right );
    face_areas_sphere_right = face_areas_sphere_right/sum(face_areas_sphere_right)*sum(face_areas_brain_right);
    vertex_areas_sphere_right = vertex_areas_sphere_right/sum(vertex_areas_sphere_right)*sum(vertex_areas_brain_right);
    vertex_area_ratio_right = vertex_areas_sphere_right./vertex_areas_brain_right;

    nni = load([repodatadir, fileids{I}]);
    resampled_vertex_area.lh = resampled_vertex_area.lh + vertex_area_ratio_left(nni.nnindices.lh);
    resampled_vertex_area.rh = resampled_vertex_area.rh + vertex_area_ratio_right(nni.nnindices.rh);
    %
    % save([datadir, 'nnindices_subject_', num2str(subid)], 'nnindices')
    % subid = extract_numbers(fileids{subid});
    % nnindices = resample_srf_nn( subdata.srf, ico_srf );
end

resampled_vertex_area.lh = resampled_vertex_area.lh/length(fileids);
resampled_vertex_area.rh = resampled_vertex_area.rh/length(fileids);

%%
global where_mat
savedir = [where_mat, 'Papers/2024_spin_test_validity/LoadOasisFiles/'];
save([savedir, 'resampled_vertex_area'], 'resampled_vertex_area')

%%
global where_mat
savedir = [where_mat, 'Papers/2024_spin_test_validity/LoadOasisFiles/'];
load([savedir, 'resampled_vertex_area'])

srf = loadsrf('fs6', 'white');
srfplot(srf.lh, resampled_vertex_area.lh, 1); 
caxis([0.5,2]); 
colormap('jet')
% saveim(['test.jpeg'], figsavedir)

%%
global where_mat
savedir = [where_mat, 'Papers/2024_spin_test_validity/LoadOasisFiles/'];
load([savedir, 'resampled_vertex_area'])
figsavedir = [where_mat, 'Papers/2024_spin_test_validity/Figures/Surface_area/'];
sets = {'right', 'left', 'top', 'front', 'back'};
for I = 1:length(sets)
    srfplot(srf, resampled_vertex_area, sets{I});
    caxis([0.5,2]);
    colormap('jet')
    % system()
    % saveim(['vertex_area_', sets{I}, '.jpeg'], figsavedir)
end


%%
srfplot(srf, resampled_vertex_area, sets{I});
rectangle('Position',[xlim(1) ylim(1) diff(xlim) diff(ylim)], 'LineWidth', 2, 'EdgeColor', 'k')

% set(gcf, 'WindowStyle', 'modal');

%%
for hemis= {'lh', 'rh'}
    h = hemis{1};
    for doback = [0,1]
        srfplot(srf.(h), resampled_vertex_area.(h), doback);
        axis image
        pause(5)
        system(['screencapture ./vertex_area_', h, '.png'])
    end
end
% For a specific area can do: screencapture -Rx,y,width,height screenshot.png
% Need to get this to work for e.g. surfscreen, fullscreen etc!!

%%
global where_mat
savedir = [where_mat, 'Papers/2024_spin_test_validity/LoadOasisFiles/'];
load([savedir, 'resampled_vertex_area'])

figsavedir = [where_mat, 'Papers/2024_spin_test_validity/Figures/Surface_area/'];

for srftype = {'white','sphere'}
    srf = loadsrf('fs6', srftype{1});
    I = 0;
    close all
    t = tiledlayout(2,2,'TileSpacing','Compact');
    for doback = [0,1]
        for hemis= {'lh', 'rh'}
            h = hemis{1};
            I = I + 1;
            k(I) = nexttile;
            srfplot(srf.(h), resampled_vertex_area.(h), doback);
            % caxis([0.5,2]);
            % colormap('jet')
        end
    end
    surfscreen
    % Set colormap and color limits for all subplots
    set(k, 'Colormap', jet, 'CLim', [0.5,2])
    cbh = colorbar;
    % To position the colorbar as a global colorbar representing
    % all tiles,
    cbh.Layout.Tile = 'south';
    cbh.Color = 'white';
    cbh.FontSize = 25;
    pause
    % saveim(['vertex_area_',srftype{1}, '.png'], figsavedir, [100,100], 2);
end

% ylabelHandle = ylabel(cbh, 'Color Intensity', 'Color', 'w', 'FontSize', 20);
% 
% % Adjust the position of the label
% labelPosition = ylabelHandle.Position;
% ylabelHandle.Position = labelPosition + [0, 0.1, 0];
% cbh.Position = cbh.Position + [0.05, 0, 0, 0];

%%
srfplot(srf, resampled_vertex_area, 'top');
caxis([0.5,2]);
colormap('jet')
%%
srfplot(srf.lh, resampled_vertex_area.lh, 0);
pause(1)
system(['screencapture ./vertex_area_lh_front.png'])

%%
srfplot(srf.lh, resampled_vertex_area.lh, 1);
pause(1)
system(['screencapture ./vertex_area_lh_back.png'])
%%
srfplot(srf.rh, resampled_vertex_area.rh, 0);
pause(1)
system(['screencapture ./vertex_area_rh_front.png'])
%%
srfplot(srf.rh, resampled_vertex_area.rh, 1);
pause(1)
system(['screencapture ./vertex_area_rh_back.png'])

%%
combined_im = zeros([1715*2, 2*2475, 3]);
I = 0; J = 0;
for hemis= {'lh', 'rh'}
    I = I + 1;
    h = hemis{1};
    for sides = {'front', 'back'}
        J = J + 1;
        a = imread(['./vertex_area_', h, '_', sides{1}, '.png']);
        atrun = a(250:end,300:end-250,:);
        combined_im()
    end
end

%%
a = imread('test.png');
atrun = a(250:end,300:end-250,:);
imagesc(atrun)
% imwrite(atrun, 'test2.png')
% fullscreen


%%
centre_im = zeros([1546, 1987, 3]);
centre_im(:,:,1) = 1;
padded_im = addborder( centre_im, padding );
imagesc(padded_im)
Sig = 1-peakgen(1, 100, 0, [200,200]);
a = Sig(1:100,1:100);
% [~, ~, ~, four_index_locations] = numOfConComps(Sig, 0.5);
for I = 1:3
    % a = zeros(100,100);
    % a(four_index_locations{1}) = 1;
    padded_im(1:100,1:100, I) = a*255;
end
padded_im = uint8(padded_im);
imagesc(padded_im)
fullscreen

%%
dim = [200,200];
Sig = 1-peakgen(1, 100, 0, dim);
a = Sig(1:100, 1:100);
imagesc(a)
% a = zeros(size(Sig));
% [~, ~, ~, four_index_locations] = numOfConComps(Sig, 0.5);
% a(four_index_locations{1}) = 1;
% imagesc(a)

%%
imagesc(Sig)