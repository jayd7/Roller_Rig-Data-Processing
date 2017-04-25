function plotPSD(inseries1,inseries2,inseries3)
nsample = length(inseries1);
% nfft = nextpow2(nsample/2);
nfft = 2^12;
windowsize = nfft;
ovlp = nfft/2;
fs = 2000;
[Pvv1,fr1] = pwelch(inseries1,windowsize,ovlp,nfft,fs);
frfy1 = 10*log10(Pvv1*fs/2);
[Pvv2,fr2] = pwelch(inseries2,windowsize,ovlp,nfft,fs);
frfy2 = 10*log10(Pvv2*fs/2);
[Pvv3,fr3] = pwelch(inseries3,windowsize,ovlp,nfft,fs);
frfy3 = 10*log10(Pvv3*fs/2);
figure;
p(1) = semilogx(fr1,frfy1,'Color',[0 0.5 0.5], 'LineWidth',1);
hold on
p(2) = semilogx(fr2,frfy2,'Color',[0.5 0 0.5], 'LineWidth',1);
p(3) = semilogx(fr3,frfy3,'Color',[0.5 0.5 0], 'LineWidth',1);
hold off
grid on
legend('in1','in2','in3');
xlabel('Frequency');
ylabel('Scaled Power in db');
title('FFT');
removewhitespace;
end