clear all
close all
startexp = 1;
endexp = 8;
sizeexp = endexp - startexp + 1;
qstart = 1;
qend = 8;
% pstart = 5;
% pend = 8;
rollerW = 0.04; % in RPS
midMark = zeros(sizeexp,1);
lowMark = zeros(sizeexp,1);
highMark = zeros(sizeexp,1);
indexarr = zeros(sizeexp,1);
%splinearr = 0:0.001:sizeexp*0.1;
for i = 1:1:endexp
    filen = ['RR_03-01-17_',num2str(i)]
    fname = [filen,'.mat'];
    load(fname);
    %matnplot(filen);
    crrZ = detrendTs(SumFzN,rollerW,3);
    crrX = detrendTs(SumFxN,rollerW,3);
    crrY = detrendTs(SumFyN,rollerW,3);
    crrZwDC = addDC(SumFzN,crrZ);
    crrXwDC = addDC(SumFxN,crrX);
    crrYwDC = addDC(SumFyN,crrY);
    %Low PAss Filtering
    fb = 10;
    fs = 2000;
    filtorder = 3;
    [b,a] = butter(filtorder,(fb/(fs*0.5)),'low');
    filcrrZ = filtfilt(b,a,crrZwDC);
    filcrrX = filtfilt(b,a,crrXwDC);
    filcrrY = filtfilt(b,a,crrYwDC);
%     figure;
%     subplotfill(2,1,1);
%     plot(Time,SumFzN,'-b');
%     hold on
%     plot(Time,crrZwDC,'-r');
%     subplotfill(2,1,2);
%     plot(Time,SumFxN,'-b');
%     hold on
%     plot(Time,crrXwDC,'-r');
%     figure;
%     subplotfill(2,1,1);
%     plot(Time,filcrrZ,'-b');
%     subplotfill(2,1,2);
%     plot(Time,filcrrX,'-b');
    NCreepX(i,:) = abs(filcrrX./filcrrZ);
    NCreepX_m = median(NCreepX(i,:));
    NCreepX_s = std(NCreepX);
    midMark(i) = NCreepX_m;
%     if( i == 1 || i == 47 || i == 93) % special case.
%         indexarr(i) = 0;
%     elseif(i <= 32 || (i > 47 && i <= 78) || (i > 93 && i < 125))
%         indexarr(i) = indexarr(i-1) + 0.1;
%     elseif (i == 33 || i == 79 || i == 125)
%         indexarr(i) = 3.4;
%     elseif ((i > 33 && i <= 46) || (i > 79 && i <= 92) || (i > 125 && i <= 138))
%         indexarr(i) = indexarr(i-1) + 0.2;
%     end
%     figure;
%     subplotfill(pend-pstart+1,1,
%     plot(Time,NCreepX,'-b');
%     b = NCreepX_s;
%     a = std(filcrrX)/std(filcrrZ);
%     title(sprintf('Normalised Creep Behaviour \n Mean : %f Std: %f',NCreepX_m,NCreepX_s));
end
figure;
subplotfill(4,1,1);
plot(Time,NCreepX(qstart,:));
title(sprintf('Sample %d Median: %f',qstart,midMark(qstart)));
grid on;
axis tight;
subplotfill(4,1,2);
plot(Time,NCreepX(qstart+1,:));
title(sprintf('Sample %d MEdian: %f',qstart+1,midMark(qstart+1)));
grid on;
axis tight;
subplotfill(4,1,3);
plot(Time,NCreepX(qstart+2,:));
title(sprintf('Sample %d Median: %f ',qstart+2,midMark(qstart+2)));
grid on;
axis tight;
subplotfill(4,1,4);
plot(Time,NCreepX(qstart+3,:));
title(sprintf('Sample %d Median: %f ',qstart+3,midMark(qstart+3)));
grid on;
axis tight;
figure;
subplotfill(4,1,1);
plot(Time,NCreepX(qstart+4,:));
title(sprintf('Sample %d MEdian: %f',qstart+4,midMark(qstart+4)));
grid on;
axis tight;
subplotfill(4,1,2);
plot(Time,NCreepX(qstart+5,:));
title(sprintf('Sample %d MEdian: %f',qstart+5,midMark(qstart+5)));
grid on;
axis tight;
subplotfill(4,1,3);
plot(Time,NCreepX(qstart+6,:));
title(sprintf('Sample %d MEdian: %f',qstart+6,midMark(qstart+6)));
grid on;
axis tight;
subplotfill(4,1,4);
plot(Time,NCreepX(qstart+7,:));
title(sprintf('Sample %d MEdian: %f',qstart+7,midMark(qstart+7)));
grid on;
axis tight;

figure;
plot([1:1:4],midMark(1:4),'-*r');
hold on
plot([5:1:qend], midMark(5:qend), '-ob');
xlabel('Experiments');
ylabel('Median value of normalised creep for the experiment');
title(sprintf('Median Normalised Creep Dependence on Loading and Velocity'));
legend('15% Increments','100N increments');
grid on;
