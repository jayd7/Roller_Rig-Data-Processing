clear all
close all
load('RR_05-10-17_53.mat')
z95 = 1.96;
cc = 1.4826; % Consistency Constant for MAD
fb = 10; fs = 2000; filtorder = 2;
    [b,a] = butter(filtorder,(fb/(fs*0.5)),'low');
    filcrrZ = filter(b,a,SumFzN);
    filcrrX = filter(b,a,SumFxN);
    filcrrY = filter(b,a,SumFyN);
    ct = 1;
    inc = 8000;
for i = 1:4000:(length(Time)-inc)
    tr = Time(i:i+inc-1);
    fz = filcrrZ(i:i+inc-1);
    fx = filcrrX(i:i+inc-1);
    crp = fx./fz;
%     pd{ct} = fitdist(crp,'Normal');
    mu(ct) = mean(crp);
    sig(ct) = std(crp);
    ct = ct+1;
%     mu(ct) = median(crp);
%     lo(ct) = median(crp) - z95*cc*mad(crp);
%     hi(ct) = median(crp) + z95*cc*mad(crp);
end
    
    