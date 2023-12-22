% Define the radius
r1 = 1;
r2 = 1.15;

% Number of points
numpoints = 500;

% Generate evenly spaced angles
theta = linspace(0, 2*pi, numpoints);

% Calculate the coordinates of the points on the circle
x1 = r1 * cos(theta);
y1 = r1 * sin(theta);

x2 = r2 * cos(theta);
y2 = r2 * sin(theta);

%% Generate random data
data = rand(1, numpoints);
FWHM = 100;
[smoothed_data, ss] = tor_conv(data, FWHM, 1);
rgbColors = jetColorMapping(smoothed_data);

%%
% Plot the circle


figure;
ax = axes;

% plot(x1, y1, 'o');
% hold on
% plot(x2, y2, 'o')
axis equal;
title('Circle with 100 evenly spaced points');
xlabel('X-axis');
ylabel('Y-axis');
grid on;

for I = 1:numpoints -1 
    xvals = [x1(I), x1(I+1), x2(I+1), x2(I)];
    yvals = [y1(I), y1(I+1), y2(I+1), y2(I)];
    fill(ax, xvals, yvals, rgbColors(I,:), 'edgealpha', 0.01)
%     ax.fill_between
%     patch(ax, 'XData', xvals, 'tYData', yvals, 'CData', rand(1, 1));
    hold on
end

xvals = [x1(end), x1(1), x2(1), x2(end)];
yvals = [y1(end), y1(1), y2(1), y2(end)];
fill(ax, xvals, yvals, rgbColors(end,:), 'edgealpha', 0.01)
axis off
% Set colormap (e.g., jet)
colormap(ax, jet);
saveim