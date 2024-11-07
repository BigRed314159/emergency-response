function d = density_map(x,y,t)
%{
Let "n" be the length of the grid.

--- Inputs ---
x, y: n by n meshgrid of x and y coordinates
   t: time  

--- Outputs ---
d: n by n meshgrid of densities.  All densities must be on [0,inf)
%}

% Define the size of the rectangular map
mapWidth = 500;  % Width of the map
mapHeight = 300; % Height of the map
numHotspots = 5; % Number of hotspots

% Create an empty map for density values
densityMap = zeros(mapHeight, mapWidth);

% Create grid of coordinates
[x, y] = meshgrid(1:mapWidth, 1:mapHeight);

% Set the random seed to ensure reproducibility (choose any number)
rng(12345);  % Fixed seed for reproducibility

% Define initial manually specified hotspot locations (X, Y) as a matrix
hotspotLocations = [
    100, 100;  % Hotspot 1 location
    200, 150;  % Hotspot 2 location
    350, 250;  % Hotspot 3 location
    400, 50;   % Hotspot 4 location
    50, 200;   % Hotspot 5 location
];

% Define initial intensity values for each hotspot (could be any positive value)
hotspotIntensities = [1, 3, 2, 4, 0.5]; % Control the intensity of each hotspot

% Time settings
numFrames = 100;       % Number of time steps (frames) to update
<<<<<<< HEAD
intervalDuration = 500; % Duration of each interval in seconds (choose 20 seconds)
=======
intervalDuration = 20; % Duration of each interval in seconds (choose 20 seconds)
>>>>>>> 85cfae0a75a8f436656ed91a672ab6713b4ebfa2

% Calculate pause time per frame based on the total interval duration
updateInterval = intervalDuration / numFrames; % Duration of each frame update in seconds

% Simulation loop: update hotspots and intensity over time
figure;

for t = 1:numFrames
    % Clear previous density map
    densityMap = zeros(mapHeight, mapWidth);

    % Randomly update the locations and intensities of the hotspots
    for i = 1:numHotspots
        % Update hotspot locations (move them randomly within the map bounds)
        hotspotLocations(i, 1) = mod(hotspotLocations(i, 1) + randi([-10, 10]), mapWidth);  % X position
        hotspotLocations(i, 2) = mod(hotspotLocations(i, 2) + randi([-10, 10]), mapHeight); % Y position

        % Randomize the intensity (amplitude) for each hotspot over time
        intensity = abs(sin(t / 10) * 5);  % Example: intensity oscillates based on time

        % Randomize the spread (sigma) for each hotspot
        sigma = randi([min(mapWidth, mapHeight) / 20, min(mapWidth, mapHeight) / 5]);

        % Calculate the Gaussian peak for the current hotspot location with updated intensity
        hotspot = intensity * exp(-((x - hotspotLocations(i, 1)).^2 + (y - hotspotLocations(i, 2)).^2) / (2 * sigma^2));

        % Add the hotspot to the density map
        densityMap = densityMap + hotspot;
    end

    % Display the updated density map
    imagesc(densityMap);
    axis equal;  % Ensure the aspect ratio is the same on both axes
    title(['Rectangular Density Map - Time: ' num2str(t)]);
    colormap(jet); % Use a colormap for density representation
    colorbar;

    % Turn on grid lines
    grid on;
    set(gca, 'XTick', 0:50:mapWidth, 'YTick', 0:50:mapHeight); % Customize grid lines
    set(gca, 'YDir', 'normal'); % Reverse the y-axis so that 0 is at the bottom

    % Pause to update the plot at each time step (slower animation)
    pause(updateInterval); % Control the time interval for each frame
end
end
