%% Plot full 3D surface
load('lookupdata_3.0.mat');
% Populate creepage matrix
CreepagePcFull = ones(size(XCreepFull));
gCreep = []; %NaN([2000000,1],'double');
gCreepage = []; %NaN([2000000,1],'double');
gLoad = []; %NaN([2000000,1],'double');
for i = 1:1:46
    cur = CreepData(i);
    CreepagePcFull(i,:) = cur*CreepagePcFull(i,:);
    CreepagePcFull(i+46,:) = cur*CreepagePcFull(i+46,:);
    CreepagePcFull(i+46*2,:) = cur*CreepagePcFull(i+46*2,:);
    k1 = find(~isnan(XCreepFull(i,:)));
    k2 = find(~isnan(XCreepFull(i+46,:)));
    k3 = find(~isnan(XCreepFull(i+46*2,:)));
    gCreep = [gCreep,XCreepFull(i,k1),XCreepFull(i+46,k2),XCreepFull(i+46*2,k3)];
    gCreepage = [gCreepage,CreepagePcFull(i,k1),CreepagePcFull(i+46,k2),CreepagePcFull(i+46*2,k3)];
    gLoad = [gLoad,fzfull(i,k1),fzfull(i+46,k2),fzfull(i+46*2,k3)];
end
