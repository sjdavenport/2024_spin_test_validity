function [facearea, vertexarea] = srf2area(varargin)
% Compute the area per face or per vertex for an ASCII surface file and
% save as a DPV or DPF (aka curvature) file.
%
% Usage:
% srf2area(srffile,areafile,meas)
%
% - srffile  = Input surface file, in ASCII format
% - areafile = Output file, as a DPV or DPF ASCII format. For 'dpv', the
%              format is the conventional FreeSurfer's curvature file.
%              For 'dpf' it contains face indices instead of vertex indices,
%              and vertex indices instead of vertex coordinates.
% - meas     = It can be either 'dpv' for area per vertex or
%              'dpf' for area per face. The area per vertex is simply
%              the sum of the 'dpf' for all faces that meet at the vertex
%              divided by 3. Use 'dpf' for studies of area
%              between subjects. Default is 'dpf'.
%
% _____________________________________
% Anderson M. Winkler
% Yale University / Institute of Living
% Jan/2011
% http://brainder.org

% Defaults
d.fsrf = [];
d.fdpx = [];
d.meas = 'dpf';

% Accept user arguments
fields = fieldnames(d);
nargin = numel(varargin);
for a = 1:nargin
    d.(fields{a}) = varargin{a};
end

% Read the surface file
[vtx,fac] = srfread(d.fsrf);
nV = size(vtx,1);
nF = size(fac,1);

% Compute area per face (DPF)
facvtx = [vtx(fac(:,1),:) vtx(fac(:,2),:) vtx(fac(:,3),:)];
facvtx0(:,1:6) = facvtx(:,1:6) - [facvtx(:,7:9) facvtx(:,7:9)];  % Place 3rd vtx at origin
cp = cross(facvtx0(:,1:3),facvtx0(:,4:6),2);                     % Cross product
facearea = sqrt(sum(cp.^2,2))./2;                                     % Half of the norm
fprintf('Total area (facewise): %g\n',sum(facearea));

% Compute area per vertex (DPV)
vertexarea = zeros(nV,1);

% For speed, divide the dpf by 3.
dpf3 = facearea/3;

% Redistribute!
for f = 1:nF
    vertexarea(fac(f,:)) = vertexarea(fac(f,:)) + dpf3(f);
end
fprintf('Total area (vertexwise): %g\n',sum(vertexarea));

end
