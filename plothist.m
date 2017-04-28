function plothist(data)
sz = size(data);
rowC = sz(1);
% f{1} = figure;
% f{2} = figure;
% f{3} = figure;
% f{4} = figure;
prev = 1;
for i = 1:1:rowC
    y = data(find(~isnan(data(i,:))));
    [d,pd] = allfitdist(y);
    histfit(y,round(sqrt(length(y))),d(1).DistName);
    title(d(1).DistName,'Fontname','Tahoma','FontSize',10,'FontWeight','Bold','Color',[0 0.7 0]);
    removewhitespace;
end