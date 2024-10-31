%%
native_image = 'C:/Users/12SDa/davenpor/davenpor/Toolboxes/BrainStat/BrainImages/Gifti_files/tpl-fsaverage_den-10k_hemi-L_white.surf.gii';
spherepathloc = 'C:/Users/12SDa/davenpor/davenpor/Toolboxes/BrainStat/BrainImages/Gifti_files/tpl-fsaverage_den-10k_hemi-L_sphere.surf.gii';

% native_image = 'C:\Users\12SDa\davenpor\Data\Oasis\oasis_cs_freesurfer_disc1\disc1\OAS1_0002_MR1\surf\lh.white';
% spherepathloc = 'C:\Users\12SDa\davenpor\Data\Oasis\oasis_cs_freesurfer_disc1\disc1\OAS1_0002_MR1\surf\lh.sphere';

%%
face_areas_brain = surf_face_area( native_image );
% face_areas_brain = face_areas_brain*(length(face_areas_brain)/sum(face_areas_brain));
surfplot( native_image, face_areas_brain )
colorbar
surfscreen

%%
face_areas_sphere = surf_face_area( spherepathloc );
% face_areas_sphere = face_areas_sphere*(length(face_areas_sphere)/sum(face_areas_sphere));
face_areas_sphere = face_areas_sphere/sum(face_areas_sphere)*sum(face_areas_brain);
surfplot( spherepathloc, face_areas_sphere )
spherescreen(1)

%% Area ratio on the brain
face_area_ratio = face_areas_sphere./face_areas_brain;
surfplot( native_image, face_area_ratio < 0.7)
surfscreen
colorbar
% colormap('jet')


%% Ratio diff on the brain
face_area_diff_g0 = face_areas_sphere - face_areas_brain > 0;
surfplot( native_image, face_area_diff_g0, 0)
surfscreen

%% Area ratio on the brain
face_area_ratio = face_areas_sphere./face_areas_brain;
face_area_ratio = sqrt(face_areas_sphere)./sqrt(face_areas_brain);
surfplot( native_image, face_area_ratio, 0)
caxis([0.5,2])
surfscreen
colorbar
colormap('jet')
% title('Sphere area/Cortex Area')
title('sqrt(Sphere area)/sqrt(Cortex Area)')
saveim('facearearatio_front_sqrt', './')
%% Area ratio on the brain
face_area_ratio = face_areas_sphere./face_areas_brain;
for do_sphere = [0,1]
for turn = [0,1]
    if do_sphere
        surfplot( spherepathloc, face_area_ratio, turn)
        spherename = '_sphere';
        spherescreen(1)
    else
        surfplot( native_image, face_area_ratio, turn)
        spherename = '';
        surfscreen
        colorbar
    end
    colormap('jet')
    title('Sphere area/Cortex Area')
    caxis([0.5,2])
    if turn == 0
        saveim(['facearearatio_front',spherename] , './')
    else
        saveim(['facearearatio_back',spherename], './')
    end
end
end

%% Area diff on the brain
face_area_diff = face_areas_sphere - face_areas_brain;
for turn = [0,1]
    surfplot( native_image, face_area_diff, turn)
    surfscreen
    colorbar
    title('Sphere area - Cortex Area')
    colormap('jet')
    saveim('faceareadiff')
    if turn == 0
        saveim('faceareadiff_front',  './')
    else
        saveim('faceareadiff_back',  './')
    end
end

%% Area diff on the brain
face_area_diff_g0 = face_areas_sphere - face_areas_brain > 0;
surfplot( native_image, face_area_diff_g0, 0)
surfscreen

%% Increase vs decrease
face_area_over1 = face_areas_sphere./face_areas_brain > 2;
surfplot( native_image, face_area_ratio, 0, 0.05, 1, [-75,50])
surfscreen
colorbar
colormap('jet')
% spherescreen(1)


%% Area ratio on the brain
face_area_ratio = face_areas_sphere./face_areas_brain;
surfplot( spherepathloc, face_area_ratio, 0, 0.05, 1, [-9,7])
colorbar
surfscreen

% spherescreen
%%
path4gifti = 'C:/Users/12SDa/neuromaps-data/atlases/fsaverage/tpl-fsaverage_den-10k_hemi-L_desc-nomedialwall_dparc.label.gii';
g = gifti(path4gifti);
nomedwall_left = g.cdata; 
subplot(1,2,1)
surfplot( native_image, nomedwall_left, 1 )
subplot(1,2,2)
surfplot( spherepathloc, nomedwall_left, 1 )
