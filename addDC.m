function tswdc = addDC(rawts,detrendedts)
%% UPdate 3-4-17 Changed dccomp to median instead of mean
dccomp = median(rawts(1:500));
tswdc = dccomp + detrendedts;
%tswdc = detrendedts;
end