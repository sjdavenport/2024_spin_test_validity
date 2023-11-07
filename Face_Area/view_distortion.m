addpath('C:\Users\12SDa\davenpor\davenpor\Other_Toolboxes/Andersons_toolbox/bin/');
addpath('C:\Users\12SDa\davenpor\davenpor\Other_Toolboxes\PALM\');
addpath('C:\Users\12SDa\davenpor\davenpor\Other_Toolboxes\areal\share\');

%%
% H = {'lh','rh'};
H = {'lh', 'rh'};
fileloc = 'C:\Users\12SDa\davenpor\Data\Surface\';
ratio = cell(1,2);
ratio_sqrt = cell(1,2);
for h = 1:numel(H)

    % Compute the area per vertex
    srf2area([fileloc, H{h}, '.white.srf'],...
        [fileloc, '\Newareafiles\',H{h}, '.white.area.dpv'],'dpv');
    srf2area([fileloc,H{h}, '.sphere.reg.srf'],...
        [fileloc, '\Newareafiles\',H{h}, '.sphere.reg.area.dpv'],'dpv');

    % Load the area files
    [area_wht,crd_wht,idx_wht] = dpxread([fileloc, 'Newareafiles\', H{h}, '.white.area.dpv']);
    [area_sph,crd_sph,idx_sph] = dpxread([fileloc, 'Newareafiles\', H{h}, '.sphere.reg.area.dpv']);

    % Rescale area of sphere
    area_sph = area_sph/sum(area_sph)*sum(area_wht);

    % Compute the ratio
    ratio{h} = area_sph./area_wht;
    ratio_sqrt{h} = sqrt(ratio);

%     Save
%     dpxwrite(fullfile('~','subjects','bert','ascii',sprintf('%s.sphere.reg.area.ratio.dpv',H{h})),ratio);
%     dpxwrite(fullfile('~','subjects','bert','ascii',sprintf('%s.sphere.reg.area.ratio_sqrt.dpv',H{h})),ratio_sqrt);

end

% Display maps
%%
data = { ...
[fileloc, '\lh.sphere.reg.area.dpv'], ...
[fileloc, '\rh.sphere.reg.area.dpv'] };
surfs = { ...
[fileloc, '\lh.sphere.reg'], ...
[fileloc, '\rh.sphere.reg'] };
palm_viewsurf(data,surfs,'layout','cardinal','datarange',[.5 2],'mapname','jet','title','Area distortion','background',[0.4 0.4 0.4]);