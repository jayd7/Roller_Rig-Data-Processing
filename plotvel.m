function plotvel(fname)
load([fname,'.mat']);
fb = 10;
filtorder = 4;
fs = 2000;
[b,a] = butter(filtorder,(fb/(fs*0.5)),'low');
filVAms = filtfilt(b,a,WheelVAms);
filVCms = filtfilt(b,a,WheelVCms);
Time = Time*0.005;
err = WheelVCms - WheelVAms;
figure;
plot(Time,WheelVAms,'b');
hold on
plot(Time,WheelVCms, 'g');
hold on
plot(Time, err, 'k');
hold off
legend('Actual','Command','Error');
title(sprintf('Max Error %f rps Median Err %f rps Mean Err %f rps',max(err),median(err),mean(err)));
end
