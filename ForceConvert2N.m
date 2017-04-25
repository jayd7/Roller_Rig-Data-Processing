function [WheelFxN,WheelFyN,WheelFzN,MotorFxN,MotorFyN,MotorFzN] = ForceConvert2N(WheelFx,WheelFy,WheelFz,MotorFx,MotorFy,MotorFz)
    WheelFxN = (16000/32767)*WheelFx; %16kN is the max value for X forces
    WheelFyN = (16000/32767)*WheelFy; %16kN is the max value for Y forces
    WheelFzN = (32000/32767)*WheelFz; %16kN is the max value for Y forces
    MotorFxN = (16000/32767)*MotorFx;
    MotorFyN = (16000/32767)*MotorFy;
    MotorFzN = (32000/32767)*MotorFz;
end