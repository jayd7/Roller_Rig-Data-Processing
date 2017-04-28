function plotcorr(fz_mat,fx_mat)
load('lookupdata_3.0.mat');
sz = size(fz_mat);
rowC = sz(1);
fsz = 10;
lw = 2;
f{1} = figure;
f{2} = figure;
% f{3} = figure;
% f{4} = figure;
prev = 1;
for i = 1:1:rowC
    y = fx_mat(i,find(~isnan(fx_mat(i,:))));
    x = fz_mat(i,find(~isnan(fx_mat(i,:))));
    if(mod(i,24) == 0)
        ctfig = 24;
    else
        ctfig = mod(i,24);
    end
    set(0,'CurrentFigure',f{prev});
    h = subplotfill(4,6,ctfig);
    [fitres,gof] = plotfit(y,x,lw);
    if(gof.rsquare < 0.7)
        set(h,'Color',[1 0.6 0.6]);
    end
    %fit(i) = fitres;
    gofc(i) = gof;
    title(sprintf('Cr: %0.3f R^2: %0.1f',CreepData(i),gof.rsquare),'Fontname','Tahoma','FontSize',10,'FontWeight','Bold','Color',[0 0.7 0]);
    removewhitespace;
    prev = (i - mod(i,24))/24 + 1;
end