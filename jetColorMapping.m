function rgbColors = jetColorMapping(data)
    % Ensure that data is a column vector
    data = data(:);

    % Normalize data to the range [0, 1]
    normalizedData = (data - min(data)) / (max(data) - min(data));

    % Define the number of colors in the jet colormap
    numColors = 256;

    % Create the jet colormap
    jetColormap = jet(numColors);

    % Map normalized data to indices in the jet colormap
    indices = round(normalizedData * (numColors - 1)) + 1;

    % Get the RGB values from the jet colormap based on the indices
    rgbColors = jetColormap(indices, :);
end
