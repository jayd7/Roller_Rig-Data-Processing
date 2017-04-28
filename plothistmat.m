function plothistmat(datamat)
load('lookupdata_3.0.mat');
sz = size(datamat);
rowC = sz(1);
fsz = 10;
lw = 2;
f{1} = figure;
f{2} = figure;
% f{3} = figure;
% f{4} = figure;
prev = 1;
for i = 1:1:rowC
    y = datamat(i,find(~isnan(datamat(i,:))));
    if(mod(i,24) == 0)
        ctfig = 24;
    else
        ctfig = mod(i,24);
    end
    set(0,'CurrentFigure',f{prev});
    h = subplotfill(4,6,ctfig);
    plothist(y);
    removewhitespace;
    prev = (i - mod(i,24))/24 + 1;
end