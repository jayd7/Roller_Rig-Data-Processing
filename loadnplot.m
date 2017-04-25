%% This function loads, converts and plots forces(combined/seperate) v.time
function loadnplot(filename)
filen = [filename,'.txt']
[Time,WheelFx,WheelFy,WheelFz,MotorFx,MotorFy,MotorFz] = ...
    importfile(filen,1000); %import startrow = 1s, endRow = EoF
[WheelFxN,WheelFyN,WheelFzN,MotorFxN,MotorFyN,MotorFzN] = ... 
    ForceConvert2N(WheelFx,WheelFy,WheelFz,MotorFx,MotorFy,MotorFz);
SumFxN = WheelFxN + MotorFxN;
SumFyN = WheelFyN + MotorFyN;
SumFzN = WheelFzN + MotorFzN;
Time = 0.0005*Time;
%% Finding Means and Standard deviations
MeanWFxN = mean(WheelFxN);
MeanWFyN = mean(WheelFyN);
MeanWFzN = mean(WheelFzN);
MeanMFxN = mean(MotorFxN);
MeanMFyN = mean(MotorFyN);
MeanMFzN = mean(MotorFzN);
MeanSFxN = mean(SumFxN);
MeanSFyN = mean(SumFyN);
MeanSFzN = mean(SumFzN);
StdDevWFxN = std(WheelFxN);
StdDevWFyN = std(WheelFyN);
StdDevWFzN = std(WheelFzN);
StdDevMFxN = std(MotorFxN);
StdDevMFyN = std(MotorFyN);
StdDevMFzN = std(MotorFzN);
StdDevSFxN = std(SumFxN);
StdDevSFyN = std(SumFyN);
StdDevSFzN = std(SumFzN);
%% Defining the strings to be displayed in plot annotation
LegendWFx = ['Longitudinal- ', 'Mean: ', num2str(MeanWFxN), ' SD: ', ... 
     num2str(StdDevWFxN)];
LegendWFy = ['Lateral- ', 'Mean: ', num2str(MeanWFyN), ' SD: ', ... 
     num2str(StdDevWFyN)];
LegendWFz = ['Vertical- ', 'Mean: ', num2str(MeanWFzN), ' SD: ', ... 
     num2str(StdDevWFzN)];
LegendMFx = ['Longitudinal- ', 'Mean: ', num2str(MeanMFxN), ' SD: ', ... 
     num2str(StdDevMFxN)];
LegendMFy = ['Lateral- ', 'Mean: ', num2str(MeanMFyN), ' SD: ', ... 
     num2str(StdDevMFyN)];
LegendMFz = ['Vertical- ', 'Mean: ', num2str(MeanMFzN), ' SD: ', ... 
     num2str(StdDevMFzN)];
LegendSFx = ['Longitudinal- ', 'Mean: ', num2str(MeanSFxN), ' SD: ', ... 
     num2str(StdDevSFxN)];
LegendSFy = ['Lateral- ', 'Mean: ', num2str(MeanSFyN), ' SD: ', ... 
     num2str(StdDevSFyN)];
LegendSFz = ['Vertical- ', 'Mean: ', num2str(MeanSFzN), ' SD: ', ... 
     num2str(StdDevSFzN)];

%% Actual Plotting
figure;
ax1 = subplotfill(2,2,1);
plot(Time,WheelFxN, '-b');
hold on
plot(Time, WheelFyN, '-g');
hold on
plot(Time, WheelFzN, '-r');
ylabel(ax1,'Wheel Forces');
legend(LegendWFx,LegendWFy,LegendWFz);
legend(ax1, 'boxoff');
legend(ax1, 'Location', 'NorthEast');
legend(ax1,'show');
removewhitespace;
ax2 = subplotfill(2,2,3);
grid on;
plot(Time,MotorFxN, '-b');
hold on
plot(Time, MotorFyN, '-g');
hold on
plot(Time, MotorFzN, '-r');
ylabel(ax2,'Motor Forces');
legend(LegendMFx,LegendMFy,LegendMFz);
legend(ax2, 'boxoff');
legend(ax2, 'Location', 'NorthEast');
legend(ax2,'show');
removewhitespace;
ax3 = subplotfill(1,2,2);
grid on;
plot(Time,SumFxN, '-b');
hold on
plot(Time, SumFyN, '-g');
hold on
plot(Time, SumFzN, 'r');
ylabel(ax3,'Wheel + Motor Forces');
legend(LegendSFx,LegendSFy,LegendSFz);
legend(ax3, 'boxoff');
legend(ax3, 'Location', 'NorthEast');
legend(ax3,'show');
removewhitespace;
set(findall(gcf,'type','text'),'fontSize',8);
files = [filename,'.mat'];
save(files);
end