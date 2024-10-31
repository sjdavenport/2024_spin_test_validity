function [vertexCoords, faces] = read_surf_custom(surfFile)
    % Read a FreeSurfer surface file into MATLAB
    % Input:
    %   - surfFile: The full path to the surface file (e.g., lh.pial)
    % Output:
    %   - vertexCoords: Nx3 matrix containing the 3D coordinates of vertices
    %   - faces: Mx3 matrix defining the vertex connectivity (triangles)

    % Open the surface file for reading
    fid = fopen(surfFile, 'r', 'b'); % 'b' for big-endian data

    if fid == -1
        error('Unable to open the surface file: %s', surfFile);
    end

    try
        % Read the number of vertices and faces
        numVertices = fread(fid, 1, 'int32');
        numFaces = fread(fid, 1, 'int32');

        % Read vertex coordinates
        vertexCoords = fread(fid, [3, numVertices], 'float32');
        vertexCoords = vertexCoords';

        % Read faces
        faces = fread(fid, [3, numFaces], 'int32');
        faces = faces' + 1;  % FreeSurfer indices are 0-based, MATLAB is 1-based

        % Close the file
        fclose(fid);
    catch
        fclose(fid); % Ensure the file is closed in case of an error
        rethrow(lasterror); % Re-throw the last error to provide details
    end
end
