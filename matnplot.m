function matnplot(filename)
filen = [filename,'.mat'];
load(filen);
%% Signal Conditioning
fs = 2000;    %SyqNet update rate
rollerW = .08;
bufZ = 5;
bufT = 2;
%  crrZ = detrendTs(SumFzN,rollerW,3);
%  crrX = detrendTs(SumFxN,rollerW,3);
%  crrY = detrendTs(SumFyN,rollerW,3);
%  crrZwDC = addDC(SumFzN,crrZ);
%  crrXwDC = addDC(SumFxN,crrX);
%  crrYwDC = addDC(SumFyN,crrY);
 fb = 10;
 filtorder = 2;
 [b,a] = butter(filtorder,(fb/(fs*0.5)),'low');
 filcrrX = filtfilt(b,a,SumFxN);
 filcrrY = filtfilt(b,a,SumFyN);
 filcrrZ = filtfilt(b,a,SumFzN);
%  arrcmpX = SumFxN;
%  arrcmpZ = SumFzN;
%  arrcmpX = SumFxN;
%  arrcmpZ = SumFzN;
%  pdRawX = fitdist(SumFxN,'Normal');
%  pdRawZ = fitdist(SumFzN,'Normal');
%  pdFilX = fitdist(arrcmpX,'Normal');
%  pdFilZ = fitdist(arrcmpZ,'Normal');
%  NCreepX = abs(filcrrX./filcrrZ);
%  NCreepX_m = median(NCreepX);
%  NCreepX_s = std(NCreepX);
%  midMark = NCreepX_m;
%  lowMark = NCreepX_m - 2*NCreepX_s;
%  highMark = NCreepX_m + 2*NCreepX_s;
%  figure;
%  stem(Time,NCreepX);
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
 
% LegendSFx = ['Mean: ', num2str(MeanSFxN), ' SD: ', ... 
%      num2str(StdDevSFxN)];
% LegendSFy = ['Mean: ', num2str(MeanSFyN), ' SD: ', ... 
%      num2str(StdDevSFyN)];
%  LegendSFz = ['Mean: ', num2str(MeanSFzN), ' SD: ', ... 
%      num2str(StdDevSFzN)];
%  
%  figure;
%  plot(Time,SumFxN);
%  ylim([-3000,3000]);
%  title('\Sigma (F_x^{motordyno} + F_x^{wheeldyno})');
%  legend(LegendSFx,'Location','Best');
%  xlabel('Time (sec)');
%  ylabel('Force (N)');
%  grid on;
%  box on;
 
%   figure;
%  plot(Time,SumFyN);
%  ylim([-3000,3000]);
%  title('\Sigma (F_y^{motordyno} + F_y^{wheeldyno})');
%  legend(LegendSFy,'Location','Best');
%  xlabel('Time (sec)');
%  ylabel('Force (N)');
%  grid on;
%  box on;
%  
%    figure;
%  plot(Time,SumFzN);
%  ylim([-6000,6000]);
%  title('\Sigma (F_z^{motordyno} + F_z^{wheeldyno})');
%  legend(LegendSFz,'Location','Best');
%  xlabel('Time (sec)');
%  ylabel('Force (N)');
%  grid on;
%  box on;
 
%% Actual Plotting
h(1) = figure;
ax1 = subplotfill(2,2,1);
plot(Time,WheelFyN, '-g');
hold on
plot(Time, WheelFxN, '-b');
hold on
plot(Time, WheelFzN, '-r');
ylabel(ax1,'Wheel Forces');
legend(LegendWFy,LegendWFx,LegendWFz);
legend(ax1, 'boxoff');
legend(ax1, 'Location', 'NorthEast');
legend(ax1,'show');
removewhitespace;
ax2 = subplotfill(2,2,3);
plot(Time,MotorFyN, '-g');
hold on
plot(Time, MotorFxN, '-b');
hold on
plot(Time, MotorFzN, '-r');
ylabel(ax2,'Motor Forces');
legend(LegendMFy,LegendMFx,LegendMFz);
legend(ax2, 'boxoff');
legend(ax2, 'Location', 'NorthEast');
legend(ax2,'show');
removewhitespace;
ax3 = subplotfill(1,2,2);
hold on
plot(Time,SumFyN, 'g');
plot(Time,SumFxN, 'b');
plot(Time,SumFzN, 'r');
plot(Time,filcrrX,'y','LineWidth',2);
plot(Time,filcrrZ,'Color',[0 0.6 0],'LineWidth',2);
hold off;
ylabel(ax3,'Wheel + Motor Forces Corrected n Filtered');
title(filen);
legend(LegendSFy,LegendSFx,LegendSFz,'Filtered X','Filtered Z');
legend(ax3, 'boxoff');
legend(ax3, 'Location', 'NorthEast');
legend(ax3,'show');
removewhitespace;
set(findall(gcf,'type','text'),'fontSize',8);
% figure;
% subplotfill(1,2,1);
% histfit(arrcmpX);
% title(sprintf('Mean: %0.1f SE: %0.1f [ RawNLL: %1.2d | FilNLL: %1.2d ]',mean(arrcmpX),std(arrcmpX),pdRawX.NLogL,pdFilX.NLogL));
% removewhitespace;
% subplotfill(1,2,2);
% histfit(arrcmpZ,round(max((arrcmpZ)-min(arrcmpZ))/50));
% title(sprintf('Mean: %0.1f SE: %0.1f [ RawNLL: %1.2d | FilNLL: %1.2d ]',mean(arrcmpZ),std(arrcmpZ),pdRawZ.NLogL,pdFilZ.NLogL));
% removewhitespace;
% Kf = find(((arrcmpZ <= -2500 + bufZ) & (arrcmpZ >= -2500 - bufZ))); %  & ((Time <=  10 + bufT) & (Time >= 10 - bufT)));
% % Kf = find(arrcmpZ);
% pdX = fitdist(arrcmpX(Kf),'Normal');
% pdZ = fitdist(arrcmpZ(Kf),'Normal'); 
% figure;
% subplotfill(1,2,1);
% histfit(arrcmpX(Kf));
% title(sprintf('Fx,Fz = 1500 +/- %d NLL: %1.2d', bufZ, pdX.NLogL));
% xlabel(sprintf('Mean is: %0.1f SE: %0.1f Len: %d',mean(arrcmpX(Kf)),std(arrcmpZ(Kf)),length(Kf)));
% subplotfill(1,2,2);
% histfit(arrcmpZ(Kf));
% title(sprintf('Fz when 1500 +/- %d',bufZ));
% ylabel(filen);
% xlabel(sprintf('Mean is: %0.1f SE is: %0.1f Len: %d',mean(arrcmpZ(Kf)),std(arrcmpZ(Kf)),length(Kf)));
%  % nsample = length(crrZ);
% % windowsize = round(nsample*1);
% % ovlp = round(windowsize*0);
% % [PvvZ,frZ] = pwelch(crrZ,windowsize,ovlp,[],fs,'power');
% % [PvvX,frX] = pwelch(crrX,windowsize,ovlp,[],fs,'power');
% % %% ---------- plot detrended Z FFT ----------
% % h(2) = figure;
% % subplotfill(2,1,1);
% % plot(Time,crrZ);
% % title('Z corrected');
% % grid on;
% % subplotfill(2,1,2);
% %plot(Time,SumFxN);
% semilogx(frZ,20*log10(PvvZ));
% title(['wsize ',num2str(windowsize),' ovlp ', num2str(ovlp)]);
% grid on
% ax=gca;
% ax.FontSize = 11;
% ax.XLabel.String = 'Frequency (Hz)';
% ax.YLabel.String = 'Magnitude (dB)';
% %% ---------- plot detrended X FFT ----------
% h(3) = figure;
% subplotfill(2,1,1);
% plot(Time,crrX);
% title('X corrected');
% grid on;
% subplotfill(2,1,2);
% %plot(Time,SumFxN);
% semilogx(frX,20*log10(PvvX));
% title(['wsize ',num2str(windowsize),' ovlp ', num2str(ovlp)]);
% grid on
% ax=gca;
% ax.FontSize = 11;
% ax.XLabel.String = 'Frequency (Hz)';
% ax.YLabel.String = 'Magnitude (dB)';
% %% ------------- Filter Design and  Time Series Filtering------------
% fb = 0.3;
% filtorder = 4;
% [b,a] = butter(filtorder,(fb/(fs*0.5)),'low');
% filcrrZ = filtfilt(b,a,crrZ);
% filcrrX = filtfilt(b,a,crrX);
% [PvvfZ,frfZ] = pwelch(filcrrZ,windowsize,ovlp,[],fs,'power');
% [PvvfX,frfX] = pwelch(filcrrX,windowsize,ovlp,[],fs,'power');
% %% Raw Data Correlation between Z forces and X Forces
% [corr,count] = xcorr(SumFzN,SumFxN);
% lag = count/fs;
% max_ind = max(corr); 
% %% --------- FFT plot for filtered signal Z-------------
% 
% h(4) = figure;
% subplotfill(2,1,1);
% plot(Time,filcrrZ);
% grid on
% subplotfill(2,1,2);
% semilogx(frfZ,20*log10(PvvfZ));
% title(sprintf('Filtered Z Signal Fb = %d , Order = %d and pwelch',fb,filtorder));
% grid on;
% ax=gca;
% ax.FontSize = 11;
% ax.XLabel.String = 'Frequency (Hz)';
% ax.YLabel.String = 'Magnitude (dB)';
% %% --------- FFT plot for filtered signal X-------------
% h(5) = figure;
% subplotfill(2,1,1);
% plot(Time,filcrrX);
% grid on
% subplotfill(2,1,2);
% semilogx(frfX,20*log10(PvvfX));
% title(sprintf('Filtered X Signal Fb = %d , Order = %d and pwelch',fb,filtorder));
% grid on;
% ax=gca;
% ax.FontSize = 24;
% ax.XLabel.String = 'Frequency (Hz)';
% ax.YLabel.String = 'Magnitude (dB)';
% 
% %% Detrend plotting
% h(6) = figure;
% subplotfill(2,1,1)
% plot(Time,avgSFZN,'-b');
% hold on
% plot(Time, trendZ, '--r');
% title('Original Data Z and Trend Polynomial');
% grid on
% subplotfill(2,1,2)
% plot(Time,crrZ)
% title('Detrended Data');
% grid on
% h(7) = figure;
% subplotfill(2,1,1)
% plot(Time,avgSFXN,'-b');
% hold on
% plot(Time, trendX, '--r');
% title('Original Data X and Trend Polynomial');
% grid on
% subplotfill(2,1,2)
% plot(Time,crrX)
% title('Detrended Data');
% grid on
% save(filename);
% savefig(h,filename);
end