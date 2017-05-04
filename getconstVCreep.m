function [constVCreep, constVfx,constVfz,Kf] = getconstVCreep(fz,fx,binC,binWidth)
Kf = find(((fz <= binC + binWidth/2) & (fz >= binC - binWidth/2)));
constVfx = fx(Kf);
constVfz = fz(Kf);
constVCreep = constVfx./constVfz;
end
