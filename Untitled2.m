close all
clear all
% cd('C:\Users\Jay Dixit\Google Drive\CVeSS\Roller Rig Workstation\Roller Rig Test Data\February\3-20-17');

%% Parameter Definitions
rollerW = 0.08; % Not changed for higher speeds
fs = 2000;
fb = 50;
filtorder = 3;
linspeed = 1;
mu = 1;
%% Load both files, filter and then merge force data
load('RR_03-16-17_1.mat');
SumFzN1 = SumFzN;
SumFxN1 = SumFxN;
SumFyN1 = SumFyN;
WheelVAms1 = WheelVAms;
WheelVCms1 = WheelVCms;
Time1 = Time;
load('RR_03-16-17_2.mat');
SumFzN2 = SumFzN;
SumFxN2 = SumFxN;
SumFyN2 = SumFyN;
WheelVAms2 = WheelVAms;
WheelVCms2 = WheelVCms;
Time2 = 250 + Time;
% SumFzN = [SumFzN1;SumFzN2];
% SumFxN = [SumFxN1;SumFxN2];
% SumFyN = [SumFyN1;SumFyN2];
% Time = [Time1;Time2];
% fullVAms = [WheelVAms1;WheelVAms2];
% fullVCms = [WheelVCms1;WheelVCms2];
load('RR_03-16-17_3.mat');
SumFzN3 = SumFzN;
SumFxN3 = SumFxN;
SumFyN3 = SumFyN;
WheelVAms3 = WheelVAms;
WheelVCms3 = WheelVCms;
Time3 = 500 + Time;
% % load('RR_03-14-17_4.mat');
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
SumFzN = [SumFzN1;SumFzN2;SumFzN3];
SumFxN = [SumFxN1;SumFxN2;SumFxN3];
SumFyN = [SumFyN1;SumFyN2;SumFyN3];
Time = [Time1;Time2;Time3];
fullVAms = [WheelVAms1;WheelVAms2;WheelVAms3];
fullVCms = [WheelVCms1;WheelVCms2;WheelVCms3];
crrZ = detrendTs(SumFzN,rollerW,3);
crrZwDC = addDC(SumFzN,crrZ);
crrX = detrendTs(SumFxN,rollerW,3);
crrXwDC = addDC(SumFxN,crrX);
[b,a] = butter(filtorder,(fb/(fs*0.5)),'low');
filcrrZ = filtfilt(b,a,crrZwDC);
filcrrX = filtfilt(b,a,SumFxN);
filcrrY = filtfilt(b,a,SumFyN);
%% Merging data
[fx,fy,fz,tb,creepPC]  = breakData(linspeed,Time,filcrrX,filcrrY,filcrrZ,fullVAms,fullVCms);
sztb = size(tb);
NCreepX = NaN(size(tb),'double');
NCreepX_m = NaN([sztb(1),1],'double');
for n = 1:1:sztb(1)
    asslen = find(~isnan(fz(n,:)));
    for j = 1:1:length(asslen)
        NCreepX(n,asslen(j)) = (fx(n,asslen(j))/(mu*fz(n,asslen(j)))); % abs removed
    end
    NCreepX_m(n) = nanmedian(NCreepX(n,asslen));
end
creepint = NCreepX_m(1:find(creepPC == 0.3));
creepageint = creepPC(1:find(creepPC == 0.3));
figure;
    plot(creepPC,NCreepX_m);
    title(sprintf('Creep-Creepage Plot %0.1f km/h',linspeed));
    grid on
    removewhitespace;
figure;
boxplot(NCreepX(1,:));
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
