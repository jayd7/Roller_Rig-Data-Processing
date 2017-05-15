%% plot normfits of all 7 sets at 1% Creepage and draw overlapping plots
close all;
clear all;
x_val = 0:0.001:1;
load('groupedNCreeps.mat');
load('lookupdata_3.0.mat');
load('NcreepX8-9.mat');
cr = 100*CreepData;
z90 = 1.645; z95 = 1.96;
cc = 1.4826; % Consistency Constant for MAD
trunmeanarr = cell(46,1);
fullmeanarr = cell(46,1);
for i = 1:1:46    
    set{1} = NCreepX1(i,find(~isnan(NCreepX1(i,:))))';
    set{2} = NCreepX2(i,find(~isnan(NCreepX2(i,:))))';
    set{3} = NCreepX3(i,find(~isnan(NCreepX3(i,:))))';
    set{4} = NCreepX4(i,find(~isnan(NCreepX4(i,:))))';
    set{5} = NCreepX5(i,find(~isnan(NCreepX5(i,:))))';
    set{6} = NCreepX6(i,find(~isnan(NCreepX6(i,:))))';
    set{7} = NCreepX7(i,find(~isnan(NCreepX7(i,:))))';
    set{8} = NCreepX8(i,find(~isnan(NCreepX8(i,:))))';
    set{9} = NCreepX9(i,find(~isnan(NCreepX9(i,:))))';
    for j = 1:1:9
        fullmeanarr{i} = [fullmeanarr{i};mean(set{j})];
    end
    md = median(fullmeanarr{i});
    lo = md - z95*cc*mad(fullmeanarr{i},1);
    hi = md + z95*cc*mad(fullmeanarr{i},1);
    k_in = find(fullmeanarr{i} > lo & fullmeanarr{i} < hi);
    trunmeanarr{i} = fullmeanarr{i}(k_in);
    me(i) = mean(trunmeanarr{i});
    me_lo(i) = me(i) -z95*std(trunmeanarr{i});
    me_hi(i) = me(i) + z95*std(trunmeanarr{i});
    trunpd = fitdist(trunmeanarr{i},'Normal');
    ytrpd = pdf(trunpd,x_val);
    yptr = pdf(trunpd,trunmeanarr{i});
    figure;
    hold on;
    plot(x_val,ytrpd,'--b','LineWidth',2);
    scatter(trunmeanarr{i},yptr,'filled');
    title(sprintf('Population Mean PDF and Exact Values %0.1f %% Creepage',cr(i)));
    box on
    grid on
    pd1 = fitdist(set{1},'Normal');
    pd2 = fitdist(set{2},'Normal');
    pd3 = fitdist(set{3},'Normal');
    pd4 = fitdist(set{4},'Normal');
    pd5 = fitdist(set{5},'Normal');
    pd6 = fitdist(set{6},'Normal');
    pd7 = fitdist(set{7},'Normal');
    pd8 = fitdist(set{8},'Normal');
    pd9 = fitdist(set{9},'Normal');
    rng('shuffle','twister');
    rnd1 = random(pd1,[1,1000000]);
    rng('shuffle','twister');
    rnd2 = random(pd2,[1,1000000]);
    rng('shuffle','twister');
    rnd3 = random(pd3,[1,1000000]);
    rng('shuffle','twister');
    rnd4 = random(pd4,[1,1000000]);
    rng('shuffle','twister');
    rnd5 = random(pd5,[1,1000000]);
    rng('shuffle','twister');
    rnd6 = random(pd6,[1,1000000]);
    rng('shuffle','twister');
    rnd7 = random(pd7,[1,1000000]);
    rng('shuffle','twister');
    rnd8 = random(pd8,[1,1000000]);
    rng('shuffle','twister');
    rnd9 = random(pd9,[1,1000000]);
    rndmat = [rnd1;rnd2;rnd3;rnd4;rnd5;rnd6;rnd7;rnd8;rnd9];
    rnd_av = mean(rndmat)'; %mean of matrix columns
    pdrnd{i} = fitdist(rnd_av,'Normal');
    ypd1 = pdf(pd1,x_val);
    ypd2 = pdf(pd2,x_val);
    ypd3 = pdf(pd3,x_val);
    ypd4 = pdf(pd4,x_val);
    ypd5 = pdf(pd5,x_val);
    ypd6 = pdf(pd6,x_val);
    ypd7 = pdf(pd7,x_val);
    ypd8 = pdf(pd8,x_val);
    ypd9 = pdf(pd9,x_val);
    ypdrnd(i,:) = pdf(pdrnd{i},x_val);
    yovall = [set{1}',set{2}',set{3}',set{4}',set{5}',set{6}',set{7}',set{8}',set{9}'];
    ovmode = mode(yovall(find(yovall)));
    figure;
    plh = plot(x_val,ypd1,x_val,ypd2,x_val,ypd3,x_val,ypd4,x_val,ypd5,x_val,ypd6,x_val,ypd7,x_val,ypd8,'--',x_val,ypd9,'--',x_val,ypdrnd(i,:),'--');
%     for jx = 1:1:7
%         set(plh(jx),'LineWidth',2);
%     end
%     set(plh(8),'LineStyle','--');
    legend('1','2','3','4','5','6','7','8','9','avg rnd var','Orientation','Horizontal','Location','best');
    title(sprintf('PDF of all 7 Experiments at %0.1f %% Creepage \n Mode: %0.2f',cr(i),ovmode),'FontSize',12,'FontWeight','Demi');
    xlabel('Normalized Creep Value','FontSize',12,'FontWeight','Demi');
    ylabel('Probability Density Function','FontSize',12,'FontWeight','Demi');
    grid on;
    axis tight;
%     Crp = [set1(1:lnc)',set2(1:lnc)',set3(1:lnc)',set4(1:lnc)',set5(1:lnc)',set6(1:lnc)',set7(1:lnc)'];
%     gnam{1:lnc,1} = 'Iter 1';
%     gnam{1:lnc,2} = 'Iter 2';
%     gnam{1:lnc,3} = 'Iter 3';
%     gnam{1:lnc,4} = 'Iter 4';
%     gnam{1:lnc,5} = 'Iter 5';
%     gnam{1:lnc,6} = 'Iter 6';
%     gnam{1:lnc,7} = 'Iter 7';
%     [p,tbl,stats] = anova1(Crp,gnam,'off');
%     if(p <= 0.05)
%         [cmpstat,~,~,nms] = multcompare(stats,'alpha',0.025,'display','off');

    %% Conflation
%     num = (ypd1.*ypd2.*ypd3.*ypd4.*ypd5.*ypd6.*ypd7.*ypd8.*ypd9)';
%     confPD = fitdist(num,'Normal');
%     ft = fittype( 'gauss1' );
%     opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
%     [xData, yData] = prepareCurveData( x_val, num );
%     [fitresult, gof] = fit( xData, yData, ft, opts );
%     apd = fitresult.a1;
%     cpd = fitresult.c1;
%     den = sqrt(2*pi)*apd*cpd;
%     ypdConf = num/den;
%     kConf = find(ypdConf);
%     mConf = fitresult.b1;
%     stdConf = fitresult.c1;
%     figure;
%     p = plot(x_val,ypd1,x_val,ypd2,x_val,ypd3,x_val,ypd4,x_val,ypd5,x_val,ypd6,'--',x_val,ypd7,'--',x_val,ypdConf,'.-',x_val,ypdrnd(i,:),'.-');
% %     for j = 1:length(p)
% %         set(p(j),'LineWidth',2);
% %     end
% %     set(p(8),'LineStyle','--','Color',[0.75 0 0]);
%     legend('1','2','3','4','5','6','7','8','9','Conflated','Avg Rand Var','Orientation','Horizontal','Location','best');
%     title(sprintf('PDF of all 7 Experiments at %0.1f %% Creepage \n Conflated PD Mean: %0.2f SD: %0.2f',cr(i),mConf,stdConf),'FontSize',12,'FontWeight','Demi');
%     xlabel('Normalized Creep Value','FontSize',12,'FontWeight','Demi');
%     ylabel('Probability Density Function','FontSize',12,'FontWeight','Demi');
%     grid on;
%     axis tight;
    
end
crcomp = [];
rndm = [];
rndlo = [];
rndhi = [];
for i= 1:1:46
    l = length(fullmeanarr{i});
    crcomp = [crcomp,cr(i)*ones(1,l)];
    rndm = [rndm,pdrnd{i}.mu];
    rndlo = [rndlo,pdrnd{i}.mu - 2*pdrnd{i}.sigma];
    rndhi = [rndhi,pdrnd{i}.mu + 2*pdrnd{i}.sigma];
end
flmat = cell2mat(fullmeanarr)';
figure;
hold on
h1 = plot(cr,me,cr,me_lo,cr,me_hi);
h2 = plot(cr,rndm,'--',cr,rndlo,'--',cr,rndhi,'--');
% set(h2,'LineStyle','--');
legend('Pop. Means Dist','Low 95','High 95','Avg Rand Var Dist','low 95','high 95');
scatter(crcomp,flmat,'x','Color',[0.6 0.6 0.6]);
