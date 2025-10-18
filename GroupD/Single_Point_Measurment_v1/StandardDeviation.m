% % --------------------------------
% % Testdaten
% % --------------------------------
% 
% % Parameter
% max_samples = 500;  % Maximale sample-Anzahl
% data_mean = 10; % Mittelwert für Zufallsdaten
% data_std = 2; % Standardabweichung für Zufallsdaten-Generierung
% 
% % Initialisieren von Arrays
% num_samples = 1:max_samples;
% std_percentage_of_mean = zeros(1, max_samples);
% 
% % Zufallsdaten aufbereiten und Standardabweichung berechnen
% for i = 1:max_samples
%     data = data_mean + data_std * randn(1, i);
%     std_percentage_of_mean(i) = (std(data) / mean(data)) * 100;
% end
% 
% % Ergebnisse plotten
% figure;
% plot(num_samples, std_percentage_of_mean, 'LineWidth', 2);
% xlabel('Anzahl der Stichproben');
% ylabel('Standardabweichung (% des Mittelwerts)');
% title('Standardabweichung in Prozent des Mittelwerts vs. Anzahl der Stichproben');
% grid on;


% --------------------------------
% Anpassen an Datenreihe
% --------------------------------
%file_path = 'test.txt';
% Funktion zum Plotten der Standardabweichung in Prozent des Mittelwerts in Abhängigkeit von der Anzahl der Stichproben

% Datensatz laden
%data = load(file_path);

% Anpassen nach Struktur des Datensatzes
data=data_full_x;
%data=data_full_y;

% Anzahl der Stichproben berechnen
%num_samples = size(data, 1);
num_samples = 10000;

% Arrays initialisieren
std_percentage_of_mean = zeros(1, num_samples);
mean_val = zeros(1, num_samples);


% Standardabweichung in Prozent des Mittelwerts berechnen

for i = 1:num_samples
    std_percentage_of_mean(i) = (std(data(1:i)) / mean(data(1:i))) * 100;
    mean_val(i)=mean(data(1:i));
end


mean(data(1:10000))


% Ergebnisse plotten
figure;
%plot(1:num_samples, std_percentage_of_mean, 'LineWidth', 2);
plot(1:num_samples, mean_val, 'LineWidth', 2);
xlabel('Anzahl der Stichproben');
ylabel('Standardabweichung (% des Mittelwerts)');
title('Standardabweichung in Prozent des Mittelwerts vs. Anzahl der Stichproben');
grid on;



