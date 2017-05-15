function [WheelFxN,WheelFyN,WheelFzN,MotorFxN,MotorFyN,MotorFzN] = ForceConvert2N(WheelFx,WheelFy,WheelFz,MotorFx,MotorFy,MotorFz)
    WheelFxN = (3000/32767)*WheelFx; % Limits updated 5-6-17 -> 1500 N/channel
    WheelFyN = (3000/32767)*WheelFy; 
    WheelFzN = (6000/32767)*WheelFz; 
    MotorFxN = (3000/32767)*MotorFx;
    MotorFyN = (3000/32767)*MotorFy;
    MotorFzN = (6000/32767)*MotorFz;
end