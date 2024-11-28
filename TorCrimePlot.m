

data = readtable('Toronto_Crimes_past3m_clean.csv');

data_2024 = data(data.REPORT_YEAR == 2024, :);

latitude_2024 = data_2024.LAT_WGS84;
longitude_2024 = data_2024.LONG_WGS84;

lat_max = max(latitude_2024);
lat_min = min(latitude_2024);
long_max = max(longitude_2024);
long_min = min(longitude_2024);
lat_edges = [lat_min, lat_max];
long_edges = [long_min,long_max];

% figure;
% geoplot(latitude_2024, longitude_2024, 'r*');
% geobasemap('satellite');
% title("Crimes in Toronto YTD");


% figure;
% H = histogram2(longitude_2024, latitude_2024, 'numBins', [100,100], 'DisplayStyle','tile','ShowEmptyBins','off');

%add the bar on the side
colormap(jet);
colorbar;

title('Crime Density Map - Toronto 2024');
xlabel('Longitude');
ylabel('Latitude');
axis equal;

numCrimes = zeros(24);
figure;
for hour = 0:23
    data_hour = data_2024(data_2024.REPORT_HOUR == hour, :);
    latitude_hour = data_hour.LAT_WGS84;
    longitude_hour = data_hour.LONG_WGS84;
    
    % Create coordinate meshgrid
    [X, Y] = meshgrid(linspace(long_edges(1), long_edges(2), 100), ...
                     linspace(lat_edges(1), lat_edges(2), 100));
    
    Z = zeros(size(X));
    sigma = 0.015; % Adjust as needed
    for i = 1:length(longitude_hour)
        instance = exp(-((X - longitude_hour(i)).^2 + (Y - latitude_hour(i)).^2) / (2*sigma^2));
        Z = Z + instance;
        numCrimes(hour+1) = numCrimes(hour +1) + 1;
    end
    display(Z);
    % Clear and create the plot
    clf;
    
    surf(X, Y, Z, 'EdgeColor', 'none');
    view(2); % 2D view
    
    colormap(jet);
    colorbar;
    xlabel('Longitude');
    ylabel('Latitude');
    title(sprintf('Crime Density Map - Toronto 2024\nHour: %02d:00', hour));
    clim([0 60]); % for colour bar continuity
    axis equal; % Make plot square
    
    pause(0.1); % second delay between frames
end


bar(numCrimes, 20);