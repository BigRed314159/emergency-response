
%latitude = data.LAT_WGS84;
%longitude = data.LONG_WGS84;

%data.REPORT_YEAR = datetime(data.REPORT_YEAR);
data = readtable('\Users\jakef\MATLAB\Projects\Toronto_Crimes_past3m_clean.csv');

data_2024 = data(data.REPORT_YEAR == 2024, :);

latitude_2024 = data_2024.LAT_WGS84;
longitude_2024 = data_2024.LONG_WGS84;

%World map plot
figure;
geoplot(latitude_2024, longitude_2024, 'r*');
geobasemap('satellite');
title("Crimes in Toronto YTD");


% Create the density map
figure;
H = histogram2(longitude_2024, latitude_2024, 'numBins', [100,100], 'DisplayStyle','tile','ShowEmptyBins','off');
colormap(jet);
colorbar;
title('Crime Density Map - Toronto 2024');
xlabel('Longitude');
ylabel('Latitude');
axis equal;

figure;
for hour = 0:23
    % Filter data to the current hour
    data_hour = data_2024(data_2024.REPORT_HOUR == hour, :);
    
    % Extract latitude and longitude for the current hour
    latitude_hour = data_hour.LAT_WGS84;
    longitude_hour = data_hour.LONG_WGS84;
    
    % Create the density map for the current hour
    %subplot(5, 5, hour + 1);
    subplot(5, 5, hour + 1);

    H = histogram2(longitude_hour, latitude_hour, 'numBins', [100,100], 'DisplayStyle','tile','ShowEmptyBins','off');
    colormap(jet);
    colorbar;
    title('Crime Density Map - Toronto 2024');
    xlabel('Longitude');
    ylabel('Latitude');
    axis equal;
end


% 
% lonRange = linspace(min(longitude_2024), max(longitude_2024), 100);
% [latGrid, lonGrid] = meshgrid(latRange, lonRange);
% 
% function [x, y] grid_location(longitude, latitude)
%     x = 
% 
% [x, y] = meshgrid(1:mapWidth, 1:mapHeight);
% 
% % Evaluate the density over the grid
% [~, density] = ksdensity([latitude_2024, longitude_2024], [latGrid(:), lonGrid(:)]);
% 
% % Reshape the density to match the grid
% density = reshape(density, size(latGrid));
% 
% figure;
% imagesc(lonRange, latRange, density);
% set(gca, 'YDir', 'normal');
% colormap('hot');
% colorbar;
% title('Density of Points');
% xlabel('Longitude');
% ylabel('Latitude');   