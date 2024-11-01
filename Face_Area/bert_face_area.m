[vertices, faces] = srfread2('C:\Users\12SDa\davenpor\Data\Surface\lh.white.srf');
clear g_white
g_white.vertices = vertices;
g_white.faces = faces;
[vertices, faces] = srfread2('C:\Users\12SDa\davenpor\Data\Surface\lh.sphere.reg.srf');
clear g_sphere
g_sphere.vertices = vertices;
g_sphere.faces = faces;

%%
srf_white = loadsrf('fs5', 'white');
srf_sphere = loadsrf('fs5', 'sphere');

g_white = srf_white.lh;
g_sphere = srf_sphere.lh;

%%
    g_white = fs2surf([datadir, data_folder, '/surf/', 'lh.white']);
    g_sphere = fs2surf([datadir, data_folder, '/surf/', 'lh.sphere.reg']);

%%
[face_areas_brain, vertex_areas_brain] = srf_face_area( g_white );
% face_areas_brain = face_areas_brain*(length(face_areas_brain)/sum(face_areas_brain));
% srfplot( g_white, face_areas_brain )
% colorbar
% surfscreen

%%
[face_areas_sphere, vertex_areas_sphere] = srf_face_area( g_sphere );
% face_areas_sphere = face_areas_sphere*(length(face_areas_sphere)/sum(face_areas_sphere));
face_areas_sphere = face_areas_sphere/sum(face_areas_sphere)*sum(face_areas_brain);
vertex_areas_sphere = vertex_areas_sphere/sum(vertex_areas_sphere)*sum(vertex_areas_brain);

% srfplot( g_sphere, face_areas_sphere )
% spherescreen(1)

%%
subplot(1,2,1)
face_area_ratio = face_areas_sphere./face_areas_brain;
srfplot( g_white, face_area_ratio, 0)
caxis([0.5,2])
fullscreen;
% colorbar
colormap('jet')
title('Face Areas')
subplot(1,2,2)
vertex_area_ratio = vertex_areas_sphere./vertex_areas_brain;
srfplot( g_white, vertex_area_ratio )
caxis([0.5,2])
fullscreen;
% colorbar
colormap('jet')
title('Vertex Areas')
%% Area ratio on the brain -saving
for dosqrt = [0,1]
    if dosqrt == 0
        face_area_ratio = face_areas_sphere./face_areas_brain;
    else
        face_area_ratio = sqrt(face_areas_sphere)./sqrt(face_areas_brain);
    end
    srfplot( g_white, face_area_ratio, 0)
    caxis([0.5,2])
    axis image
    fullscreen
    colorbar
    colormap('jet')
    if dosqrt == 0 
        title('Sphere area/Cortex Area')
        saveim('face_nosqrt_srf_face_area', './')
    else
        title('sqrt(Sphere area)/Sqrt(Cortex Area)')
        saveim('face_sqrt_srf_face_area', './')
    end
end
% saveim('bertface_srf_face_area', './')

%% Calculation using srf2area
% addpath(genpath('C:\Users\12SDa\davenpor\davenpor\Other_Toolboxes\areal\'))
[s, vertexarea_white] = srf2area('C:\Users\12SDa\davenpor\Data\Surface\lh.white.srf', 'dpf');
[facearea_sphere, vertexarea_sphere] = srf2area('C:\Users\12SDa\davenpor\Data\Surface\lh.sphere.reg.srf', 'dpf');
facearea_sphere = facearea_sphere/sum(facearea_sphere)*sum(facearea_white);

%%
for dosqrt = [0,1]
    if dosqrt == 0
        dpf_face_area_ratio = facearea_sphere./facearea_white;
    else
        dpf_face_area_ratio = sqrt(facearea_sphere)./sqrt(facearea_white);
    end
    srfplot( g_white, dpf_face_area_ratio, 0)
    caxis([0.5,2])
    fullscreen
    colorbar
    colormap('jet')
    if dosqrt == 0 
        title('Sphere area/Cortex Area')
        saveim('face_nosqrt_dpf', './')
    else
        title('sqrt(Sphere area)/Sqrt(Cortex Area)')
        saveim('face_sqrt_dpf', './')
    end
end

%% Read in Anderson's Bert face area calculation
nvertices = 134814;
sphere_area_data = dpvread('C:\Users\12SDa\davenpor\Data\Surface\lh.sphere.reg.area.dpv', nvertices);
% sphere_area_data = dpvread('C:\Users\12SDa\davenpor\Data\Surface\Newareafiles\lh.sphere.reg.area.dpv', nvertices);
sphere_area = sphere_area_data(:,5);
white_area_data = dpvread('C:\Users\12SDa\davenpor\Data\Surface\lh.white.area.dpv', nvertices);
% white_area_data = dpvread('C:\Users\12SDa\davenpor\Data\Surface\Newareafiles\lh.white.area.dpv', nvertices);
white_area = white_area_data(:,5);
sphere_area = sphere_area/sum(sphere_area)*sum(white_area);

%% Plot the mesh area
% g_white = loadsrf('bert', 'white');
srfplot( g_white, white_area, 0)
saveim('ex_area')
%% Andreson's Bert DPV area ratio on the brain (not sure if this is interesting really)
for dosqrt = [0,1]
    if dosqrt == 0
        dpv_face_area_ratio = sphere_area./white_area;
    else
        dpv_face_area_ratio = sqrt(sphere_area)./sqrt(white_area);
    end
    srfplot( g_white, dpv_face_area_ratio, 0)
    caxis([0.5,2])
    fullscreen
    colorbar
    colormap('jet')
    if dosqrt == 0 
        title('Sphere area/Cortex Area')
        saveim('bertface_nosqrt_dpv', './')
    else
        title('sqrt(Sphere area)/Sqrt(Cortex Area)')
        saveim('bertface_sqrt_dpv', './')
    end
end

%% Comparing 
face_area_ratio = face_areas_sphere./face_areas_brain;
figure
% face_area_ratio = facearea_sphere./facearea_white;
srfplot( g_white, face_area_ratio, 0)
caxis([0.5,2])
surfscreen
colorbar
colormap('jet')