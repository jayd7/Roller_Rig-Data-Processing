%% Repeatability/Normality Analysis Script
% Hist fit is plotted with different reps of data. Repeatability is
% analysed.
close all;
clear all;
cd('C:\Users\Jay Dixit\Google Drive\CVeSS\Roller Rig Workstation\Roller Rig Test Data\February\4-25-17');
date = '04-25-17';
figx = figure('name','X-Forces');
figz = figure('name','Z-Forces');
figcorr = figure('name','Correlation-Plot');
lw = 2; % Linewidth for correlation plot
fb = 40;
fs = 2000;
filtorder = 2;
[b,a] = butter(filtorder,(fb/(fs*0.5)),'low');
for i = 1:1:15
    if (i == 3);
        continue;
    end
    filen = ['RR_',date,'_',num2str(i)];
    load(filen);
    filcrrZ = filtfilt(b,a,SumFzN);
    filcrrX = filtfilt(b,a,SumFxN);
    filcrrY = filtfilt(b,a,SumFyN);
    set(0,'CurrentFigure',figx);
    subplotfill(5,3,i);
    histfit(SumFxN);
    set(gca,'XTickLabel',[],'YTickLabel',[]);
    title(sprintf('# %d Mean : %0.1f SE: %0.1f',i, mean(SumFxN),std(SumFxN)),'FontSize',12,'FontWeight','Bold');
    removewhitespace;
    grid on
    set(0,'CurrentFigure',figz);
    subplotfill(5,3,i);
    box on
    histfit(SumFzN);
    set(gca,'XTickLabel',[],'YTickLabel',[]);
    grid on
    title(sprintf('# %d | Mean : %0.1f SE: %0.1f',i,mean(SumFzN),std(SumFzN)),'FontSize',12,'FontWeight','Bold');
    removewhitespace;
    %% Correlation Testing
    set(0,'CurrentFigure',figcorr);
    h = subplotfill(5,3,i);
     [fitres,gof] = plotfit(SumFzN,SumFxN,lw);
    if(gof.rsquare < 0.65)
        set(h,'Color',[1 0.6 0.6]);
    end
    set(gca,'XTickLabel',[],'YTickLabel',[]);
    removewhitespace;
    title(sprintf('# %d | F_z vs F_x | R-sq: %0.1f',i,gof.rsquare),'FontSize',12,'FontWeight','Bold');
    
end