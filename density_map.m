function d = density_map(x,y,t)
%{
Let "n" be the length of the grid.

--- Inputs ---
x, y: n by n meshgrid of x and y coordinates
   t: time  

--- Outputs ---
d: n by n meshgrid of densities.  All densities must be on [0,inf)
%}



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
% colormap(jet);
% colorbar;
% 
% title('Crime Density Map - Toronto 2024');
% xlabel('Longitude');
% ylabel('Latitude');
% axis equal;

numCrimes = zeros(24);
% figure;
% 
% for hour = 0:23
%     data_hour = data_2024(data_2024.REPORT_HOUR == hour, :);
%     latitude_hour = data_hour.LAT_WGS84;
%     longitude_hour = data_hour.LONG_WGS84;
% 
%     % Create coordinate meshgrid
%     %[X, Y] = meshgrid(linspace(long_edges(1), long_edges(2), 100), ...
%     %                 linspace(lat_edges(1), lat_edges(2), 50));
    %display(x);
    %isplay(y);
    d = zeros(size(x));
    sigma = 0.015; % Adjust as needed
    for i = 1:length(longitude_2024)
        instance = exp(-((x - longitude_2024(i)).^2 + (y - latitude_2024(i)).^2) / (2*sigma^2));
        d = d + instance;
        % numCrimes(hour+1) = numCrimes(hour +1) + 1;
    end
   %display(d);

% end
