function bunchtxt2matvel(date,startind,endind)
for i = startind:1:endind
    filen = ['RR_',date,'_',num2str(i)]
    fname = [filen,'.txt'];
   [Time,WheelFx,WheelFy,WheelFz,MotorFx,MotorFy,MotorFz,WheelVC,WheelVA] = importfile1(fname,10); %import startrow   = 1s, endRow = EoF
    save(filen);
end
end