close all
clear all
%% Parameter Definitions
rollerW = 0.08; % Not changed for higher speeds
fs = 2000;
fb = 50;
filtorder = 3;
linspeed = 2;
%% Load both files, filter and then merge force data
load('RR_03-07-17_3.mat');
SumFzN1 = SumFzN;
SumFxN1 = SumFxN;
SumFyN1 = SumFyN;
WheelVAms1 = WheelVAms;
WheelVCms1 = WheelVCms;
Time1 = Time;
%crrZ1 = detrendTs(SumFzN1,rollerW,3);
% crrX = detrendTs(SumFxN,rollerW,3);
% crrY = detrendTs(SumFyN,rollerW,3);
%crrZwDC1 = addDC(SumFzN,crrZ1);
% crrXwDC = addDC(SumFxN,crrX);
% crrYwDC = addDC(SumFyN,crrY);
[b,a] = butter(filtorder,(fb/(fs*0.5)),'low');
%filcrrZ1 = filtfilt(b,a,crrZwDC1);
% filcrrX1 = filtfilt(b,a,SumFxN);
% filcrrY1 = filtfilt(b,a,SumFyN);
filVAms1 = filtfilt(b,a,WheelVAms1);
filVCms1 = filtfilt(b,a,WheelVCms1);
load('RR_03-07-17_4.mat');
SumFzN2 = SumFzN;
SumFxN2 = SumFxN;
SumFyN2 = SumFyN;
WheelVAms2 = WheelVAms;
WheelVCms2 = WheelVCms;
Time2 = 250 + Time;
SumFzN = [SumFzN1;SumFzN2];
SumFxN = [SumFxN1;SumFxN2];
SumFyN = [SumFyN1;SumFyN2];
crrZ = detrendTs(SumFzN,rollerW,3);
% crrX = detrendTs(SumFxN,rollerW,3);
% crrY = detrendTs(SumFyN,rollerW,3);
crrZwDC = addDC(SumFzN,crrZ);
% crrXwDC = addDC(SumFxN,crrX);
% crrYwDC = addDC(SumFyN,crrY);
[b,a] = butter(filtorder,(fb/(fs*0.5)),'low');
filcrrZ = filtfilt(b,a,crrZwDC);
filcrrX = filtfilt(b,a,SumFxN);
filcrrY = filtfilt(b,a,SumFyN);
Time = [Time1;Time2];
% filcrrZ = [filcrrZ1;filcrrZ2];
% filcrrX = [filcrrX1;filcrrX2];
% filcrrY = [filcrrY1;filcrrY2];
fullVAms = [WheelVAms1;WheelVAms2];
fullVCms = [WheelVCms1;WheelVCms2];
%% Merging data
[fx,fy,fz,tb,creepPC]  = breakData(linspeed,Time,filcrrX,filcrrY,filcrrZ,fullVAms,fullVCms);
sztb = size(tb);
NCreepX = zeros(size(tb));
NCreepX_m = zeros([sztb(1),1]);
for n = 1:1:sztb(1)
    asslen = find(fz(n,:));
    for j = 1:1:length(asslen)
        NCreepX(n,asslen(j)) = abs(fx(n,asslen(j))/fz(n,asslen(j)));
    end
    NCreepX_m(n) = median(NCreepX(n,asslen));
end
figure;
    plot(creepPC,NCreepX_m);
    title(sprintf('Creep-Creepage Plot %0.1f km/h',linspeed));
    grid on
    removewhitespace;
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
