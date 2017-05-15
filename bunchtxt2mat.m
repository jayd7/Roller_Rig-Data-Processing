% Imports all text data from a given date (passed as a string) with the starting and ending indices and saves the data as .mat Written by: Jay Dixit, RTL, CVeSS
function bunchtxt2mat(date,startind,endind)
for i = startind:1:endind
    filen = ['RR_',date,'_',num2str(i)]
    fname = [filen,'.txt'];
   [Time,WheelFx,WheelFy,WheelFz,MotorFx,MotorFy,MotorFz,WheelVC,WheelVA] = importfile1(fname,2000); %import startrow   = 1s, endRow = EoF
    [WheelFxN,WheelFyN,WheelFzN,MotorFxN,MotorFyN,MotorFzN] = ForceConvert2N(WheelFx,WheelFy,WheelFz,MotorFx,MotorFy,MotorFz);
    SumFxN = WheelFxN + MotorFxN;
    SumFyN = WheelFyN + MotorFyN;
    SumFzN = WheelFzN + MotorFzN;
    Time = 0.0005*Time;
    WheelVAms = WheelVA/5242880;
    WheelVCms = WheelVC/5242880;
    %% Finding Means and Standard deviations
%     MeanWFxN = mean(WheelFxN);
%     MeanWFyN = mean(WheelFyN);
%     MeanWFzN = mean(WheelFzN);
%     MeanMFxN = mean(MotorFxN);
%     MeanMFyN = mean(MotorFyN);
%     MeanMFzN = mean(MotorFzN);
%     MeanSFxN = mean(SumFxN);
%     MeanSFyN = mean(SumFyN);
%     MeanSFzN = mean(SumFzN);
%     StdDevWFxN = std(WheelFxN);
%     StdDevWFyN = std(WheelFyN);
%     StdDevWFzN = std(WheelFzN);
%     StdDevMFxN = std(MotorFxN);
%     StdDevMFyN = std(MotorFyN);
%     StdDevMFzN = std(MotorFzN);
%     StdDevSFxN = std(SumFxN);
%     StdDevSFyN = std(SumFyN);
%     StdDevSFzN = std(SumFzN);
    save(filen,'Time','WheelFxN','WheelFyN','WheelFzN','MotorFxN','MotorFyN','MotorFzN','SumFxN','SumFyN','SumFzN','WheelVAms','WheelVCms');
end
end
