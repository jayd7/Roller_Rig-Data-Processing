close all
clear all
date = '05-04-17';
% cd('C:\Users\Jay Dixit\Google Drive\CVeSS\Roller Rig Workstation\Roller Rig Test Data\February\4-27-17');
 cd('C:\Users\CVeSS\Google Drive\CVeSS\Roller Rig Workstation\Roller Rig Test Data\February\5-4-17');
%% Parameter Definitions
rollerW = 0.08; % Not changed for higher speeds
fs = 2000;
fb = 10;
filtorder = 3;
linspeed = 3;
mu = 1;
repsid = [1,2];
binC = -2000;
binWidth = 5;
fxfull = [];
fyfull = [];
fzfull = [];
XCreepFull = [];
%% Load both files, filter and then merge force data
for i = repsid(1):2:repsid(2)
    filen = ['RR_',date,'_',num2str(i),'.mat'];
    load(filen);
    SumFzN1 = SumFzN;
    SumFxN1 = SumFxN;
    SumFyN1 = SumFyN;
    WheelVAms1 = WheelVAms;
    WheelVCms1 = WheelVCms;
    Time1 = Time;
    % SumFzN = [SumFzN1];
    % SumFxN = [SumFxN1];
    % SumFyN = [SumFyN1];
    % Time = [Time1];
    % fullVAms = [WheelVAms1];
    % fullVCms = [WheelVCms1];
    load(['RR_',date,'_',num2str(i+1),'.mat']);
    SumFzN2 = SumFzN;
    SumFxN2 = SumFxN;
    SumFyN2 = SumFyN;
    WheelVAms2 = WheelVAms;
    WheelVCms2 = WheelVCms;
    Time2 = 250 + Time;
    SumFzN = [SumFzN1;SumFzN2];
    SumFxN = [SumFxN1;SumFxN2];
    SumFyN = [SumFyN1;SumFyN2];
    Time = [Time1;Time2];
    fullVAms = [WheelVAms1;WheelVAms2];
    fullVCms = [WheelVCms1;WheelVCms2];
    % load('RR_03-16-17_9.mat');
    % SumFzN3 = SumFzN;
    % SumFxN3 = SumFxN;
    % SumFyN3 = SumFyN;
    % WheelVAms3 = WheelVAms;
    % WheelVCms3 = WheelVCms;
    % Time3 = 500 + Time;
    % load('RR_03-14-17_4.mat');
    % SumFzN4 = SumFzN;
    % SumFxN4 = SumFxN;
    % SumFyN4 = SumFyN;
    % WheelVAms4 = WheelVAms;
    % WheelVCms4 = WheelVCms;
    % Time4 = 750 + Time;
    % SumFzN = [SumFzN1;SumFzN2;SumFzN3;SumFzN4];
    % SumFxN = [SumFxN1;SumFxN2;SumFxN3;SumFxN4];
    % SumFyN = [SumFyN1;SumFyN2;SumFyN3;SumFyN4];
    % Time = [Time1;Time2;Time3;Time4];
    % fullVAms = [WheelVAms1;WheelVAms2;WheelVAms3;WheelVAms4];
    % fullVCms = [WheelVCms1;WheelVCms2;WheelVCms3;WheelVCms4];
    [b,a] = butter(filtorder,(fb/(fs*0.5)),'low');
    filcrrZ = filter(b,a,SumFzN);
    filcrrX = filter(b,a,SumFxN);
    filcrrY = filter(b,a,SumFyN);
    %% Merging data
    [fx,fy,fz,tb,creepPC]  = breakData(linspeed,Time,filcrrX,filcrrY,filcrrZ,fullVAms,fullVCms);
    sztb = size(tb);
    NCreepX = NaN(size(tb),'double');
    ConstVCreep = NaN(size(tb),'double');
    NCreepX_m = NaN([sztb(1),1],'double');
    NCreepX_lowci = NaN([sztb(1),1],'double');
    NCreepX_upci = NaN([sztb(1),1],'double');
%     hHist = figure;
    for n = 1:1:sztb(1)
        asslen = find(~isnan(fz(n,:)));
        [constVCr,constVfx,constVfz,Kf] = getconstVCreep(fz(n,asslen),fx(n,asslen),binC,binWidth);
        %     for j = 1:1:length(asslen)
        NCreepX(n,asslen) = abs(fx(n,asslen)./(mu*fz(n,asslen)));
        ConstVCreep(n,Kf) = constVCr;
        NCreepX_m(n) = nanmean(NCreepX(n,asslen));
        NCreepX_s(n) = std(NCreepX(n,asslen));
        VCreep_m(n) = mean(constVCr);
        VCreep_s(n) = std(constVCr);
        VCreep_lo(n) = VCreep_m(n) - 2*(std(constVCr));
        VCreep_hi(n) = VCreep_m(n) + 2*(std(constVCr));
        NCreepX_lowci(n) = NCreepX_m(n) - 2*(std(NCreepX(n,asslen)));
        NCreepX_upci(n) = NCreepX_m(n) + 2*(std(NCreepX(n,asslen)));
        % Compare Histograms of both binned and full creepages
        figure;
        subplotfill(1,2,1);
        if(isempty(NCreepX(n,asslen)))
            continue;
        else
        histfit(NCreepX(n,asslen));
        set(gca,'FontSize',11);
        title(sprintf('# %d Full Creepage Lem: %d',n,length(asslen)),'FontSize',12);
        xlabel(sprintf('Mean %0.2f SD: %0.2f',mean(NCreepX(n,asslen)),std(NCreepX(n,asslen))),'FontSize',12); 
        end
        subplotfill(1,2,2);
        if(isempty(constVCr))
            continue;
        else            
        histfit(constVCr);
        set(gca,'FontSize',11);
        title(sprintf('# %d Binned Creepage @ %d N Lem: %d',n,binC,length(constVCr)),'FontSize',12);
        xlabel(sprintf('Mean: %0.2f SD: %0.2f',mean(constVCr),std(constVCr)),'FontSize',12);
        end
        %     end
%         [nb,errfit] = compecdf(NCreepX(n,asslen)','Empirical');
%         NCreepX_m(n) = nb(3);
      
    end
    fxfull = [fxfull;fx];
    fyfull = [fyfull;fy];
    fzfull = [fzfull;fz];
    XCreepFull = [XCreepFull;NCreepX];
end
figure;
plot(creepPC,NCreepX_m,creepPC,NCreepX_lowci,creepPC,NCreepX_upci,creepPC,VCreep_m,creepPC,VCreep_lo,creepPC,VCreep_hi);
% plot(creepPC,VCreep_m,creepPC,NCreepX_m);
title(sprintf('Creep-Creepage Plot %0.1f km/h',linspeed));
grid on
removewhitespace;
legend('binned mean','full mean');
legend('full mean','full low','full high','binned mean','binned low','binned high');
figure('name','Force Binned Curve');
plot(creepPC,VCreep_m,creepPC,VCreep_lo,creepPC,VCreep_hi);
title(sprintf('Force Binned at %0.2f +/- %0.2f',binC,binWidth/2));
grid on;
box on;
removewhitespace;
% plotcorr(fz,fx);
% plothistmat(fz);
% for nt = 1:1:46
% figure;
% %plot(tb(1), fx(1,:),'b');
% p = plot(tb(nt,find(tb)), NCreepX(nt,find(NCreepX)),'-r');
% legend(sprintf('NCreepX, Median: %f',NCreepX_m(nt)));
% end
% figure;
% subplotfill(2,1,1)
% plot(tb(nt,:),fx(nt,:));
% grid on
% title('X');
% subplotfill(2,1,2)
% plot(tb(nt,:),fz(nt,:));
% grid on
% title('Z');
