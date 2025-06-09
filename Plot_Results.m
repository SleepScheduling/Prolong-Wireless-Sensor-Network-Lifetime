function[] = Plot_Results()
% clc;
clear all;
% close all;


Convergence_Graph();
Parameters();


end

function[] = Parameters()

load Res;
%load Results;
% load FinRes_1;
% load Results2;
load Fitness.mat;


X = 100:50:300;

%% Ratio_of_active_node
figure,
bar(X, RES.Ratio_of_active_node')
newColors = [0.6350, 0.0780, 0.1840; 0.3010, 0.7450, 0.9330; 0.75, 0.75, 0; 1, 0, 0; 0.75, 0, 0.75];
colororder(newColors)
set(gca, 'FontSize', 14);
xlabel('No of Nodes', 'FontSize', 14);
ylabel('Ratio of active node', 'FontSize', 14);
h = legend('SFO','WOA','GSO','BBFGO','IGS-BBFGOA');
set(h, 'fontsize', 12, 'Location', 'NorthEastOutside')
print('-dtiff', '-r300', ['.\Results\', 'No of Nodes vs Ratio of active node'])

%% Degree_of_neighbour
figure,
bar(X, RES.Degree_of_neighbour')
newColors = [0.6350, 0.0780, 0.1840; 0.3010, 0.7450, 0.9330; 0.75, 0.75, 0; 1, 0, 0; 0.75, 0, 0.75];
colororder(newColors)
set(gca, 'FontSize', 14);
xlabel('No of Nodes', 'FontSize', 14);
ylabel('Degree of neighbour', 'FontSize', 14);
h = legend('SFO','WOA','GSO','BBFGO','IGS-BBFGOA');
set(h, 'fontsize', 12, 'Location', 'NorthEastOutside')
print('-dtiff', '-r300', ['.\Results\', 'No of Nodes vs Degree of neighbour'])


%% Redundant_Degree_Of_The_Area
figure,
bar(X, RES.Redundant_Degree_Of_The_Area')
newColors = [0.6350, 0.0780, 0.1840; 0.3010, 0.7450, 0.9330; 0.75, 0.75, 0; 1, 0, 0; 0.75, 0, 0.75];
colororder(newColors)
set(gca, 'FontSize', 14);
xlabel('No of Nodes', 'FontSize', 14);
ylabel('Redundant Degree Of The Area', 'FontSize', 14);
h = legend('SFO','WOA','GSO','BBFGO','IGS-BBFGOA');
set(h, 'fontsize', 12, 'Location', 'NorthEastOutside')
print('-dtiff', '-r300', ['.\Results\', 'No of Nodes vs Redundant Degree Of The Area'])


%% Energy_consumption_ratio
figure,
bar(X, RES.RE')
newColors = [0.6350, 0.0780, 0.1840; 0.3010, 0.7450, 0.9330; 0.75, 0.75, 0; 1, 0, 0; 0.75, 0, 0.75];
colororder(newColors)
set(gca, 'FontSize', 14);
xlabel('No of Nodes', 'FontSize', 14);
ylabel('Energy consumption ratio', 'FontSize', 14);
h = legend('SFO','WOA','GSO','BBFGO','IGS-BBFGOA');
set(h, 'fontsize', 12, 'Location', 'NorthEastOutside')
print('-dtiff', '-r300', ['.\Results\', 'No of Nodes vs Energy consumption ratio'])

%% Packet_delivery_ratio
figure,
bar(X, RES.PDR')
newColors = [0.6350, 0.0780, 0.1840; 0.3010, 0.7450, 0.9330; 0.75, 0.75, 0; 1, 0, 0; 0.75, 0, 0.75];
colororder(newColors)
set(gca, 'FontSize', 14);
xlabel('No of Nodes', 'FontSize', 14);
ylabel('Packet delivery ratio', 'FontSize', 14);
h = legend('SFO','WOA','GSO','BBFGO','IGS-BBFGOA');
set(h, 'fontsize', 12, 'Location', 'NorthEastOutside')
print('-dtiff', '-r300', ['.\Results\', 'No of Nodes vs Packet delivery ratio'])




end



function [] = Convergence_Graph()

load Fitness

No_of_Nodes = [100, 150, 200, 250, 300];
for n = 1 : 5
    for j = 1 : 5 % For all algorithms
        Value = Fit{1, n};
        val(j,:) = statistical_Analysis(Value(j, :));
    end
    disp('Statistical Analysis :')
    fprintf('Number of Nodes : %d\n ', No_of_Nodes(n));
    ln = {'BEST','WORST','MEAN','MEDIAN','STANDARD DEVIATION'};
    T = table(val(1, :)', val(2, :)', val(3, :)',val(4, :)', val(5, :)','Rownames',ln);
    T.Properties.VariableNames = {'SFO','WOA','GSO','BBFGO','IGS-BBFGOA'};
    disp(T)
    Value = Fit{1, n};
    figure,
    plot(Value(1, :),'Color',[0.3010 0.7450 0.9330], 'LineWidth', 2)
    hold on;
    plot(Value(2, :), 'Color',[1 0 0], 'LineWidth', 2)
    plot(Value(3, :),'Color',[0.4660 0.6740 0.1880],'LineWidth', 2)
    plot(Value(4, :),'Color',[0.9290 0.6940 0.1250],'LineWidth', 2)
    plot(Value(5, :),'k','LineWidth', 2)
    set(gca,'fontsize',20);
    xlabel('No. of Iterations','fontsize',16);
    ylabel('Cost Function','fontsize',16);
    h = legend('SFO','WOA','GSO','BBFGO','IGS-BBFGOA');
    set(h,'fontsize',12,'Location','Best')
    print('-dtiff','-r300',['.\Results\', 'Convergence-',num2str(n)])
end
end

function[a] = statistical_Analysis(val)
a(1) = min(val);
a(2) = max(val);
a(3) = mean(val);
a(4) = median(val);
a(5) = std(val);
end
