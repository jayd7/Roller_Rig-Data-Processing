function [crr] = detrendTs(inputseries,rot_freq,filtorder)
fs = 2000;
fb = 0.70*rot_freq;
[b,a] = butter(filtorder,(fb/(fs*0.5)),'high');
crr = filtfilt(b,a,inputseries);
end
