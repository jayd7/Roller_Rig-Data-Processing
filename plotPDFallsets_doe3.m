%% plot normfits of all 7 sets at 1% Creepage and draw overlapping plots
close all;
clear all;
date = '05-10-17';
cd('C:\Users\CVeSS\Google Drive\CVeSS\Roller Rig Workstation\Roller Rig Test Data\February\5-10-17');
x_val = 0:0.001:1;
load('lookupdata_3.0.mat');

cr = 100*CreepData;
z90 = 1.645; z95 = 1.96;
cc = 1.4826; % Consistency Constant for MAD
trunmeanarr = cell(46,1);
fullmeanarr = cell(46,1);
fb = 10; fs = 2000; filtorder = 2;
[b,a] = butter(filtorder,(fb/(fs*0.5)),'low');
creepPC = [ones(1,15),2.9*ones(1,10),0.5*ones(1,10),ones(1,5),0.5,1,0.5,1,0.5,1,.5,1,0.5,1];
% strcell = cell(1,50);
for i = 1:1:50   
    fname = ['RR_',date,'_',num2str(i)];
    load(fname);
    filcrrZ = filter(b,a,SumFzN);
    filcrrX = filter(b,a,SumFxN);
    filcrrY = filter(b,a,SumFyN);
    NCreepX = filcrrX./filcrrZ;
    set{i} = NCreepX;
    pd{i} = fitdist(set{i},'Normal');
    ypd(i,:) = pdf(pd{i},x_val);
    meanarr(i) = mean(set{i});
end
%     rng('shuffle','twister');
%     rnd1 = random(pd1,[1,1000000]);
%     rng('shuffle','twister');
%     rnd2 = random(pd2,[1,1000000]);
%     rng('shuffle','twister');
%     rnd3 = random(pd3,[1,1000000]);
%     rng('shuffle','twister');
%     rnd4 = random(pd4,[1,1000000]);
%     rng('shuffle','twister');
%     rnd5 = random(pd5,[1,1000000]);
%     rng('shuffle','twister');
%     rnd6 = random(pd6,[1,1000000]);
%     rng('shuffle','twister');
%     rnd7 = random(pd7,[1,1000000]);
%     rng('shuffle','twister');
%     rnd8 = random(pd8,[1,1000000]);
%     rng('shuffle','twister');
%     rnd9 = random(pd9,[1,1000000]);
%     rndmat = [rnd1;rnd2;rnd3;rnd4;rnd5;rnd6;rnd7;rnd8;rnd9];
%     rnd_av = mean(rndmat)'; %mean of matrix columns
%     pdrnd{i} = fitdist(rnd_av,'Normal');
%     ypdrnd(i,:) = pdf(pdrnd{i},x_val);
%     yovall = [set{1}',set{2}',set{3}',set{4}',set{5}',set{6}',set{7}',set{8}',set{9}'];
%     ovmode = mode(yovall(find(yovall)));
    figure;
    k1 = find(creepPC == 1);
    for i = 1:length(k1)
        strcell{i} = num2str(k1(i));
    end
    plh = plot(x_val,ypd(k1,:));
    legend(strcell,'Orientation','Vertical','Location','best');
    title(sprintf('PDF of all 5 Experiments at 1 %% Creepage'),'FontSize',12,'FontWeight','Demi');
    xlabel('Normalized Creep Value','FontSize',12,'FontWeight','Demi');
    ylabel('Probability Density Function','FontSize',12,'FontWeight','Demi');
    grid on;
    axis tight;    
    figure;
    k2 = find(creepPC == 2.9);
        for i = 1:length(k2)
        strcell{i} = num2str(k2(i));
    end
    plh = plot(x_val,ypd(k2,:));
    legend(strcell,'Orientation','Vertical','Location','best');
    title(sprintf('PDF of all 5 Experiments at 2.9 %% Creepage'),'FontSize',12,'FontWeight','Demi');
    xlabel('Normalized Creep Value','FontSize',12,'FontWeight','Demi');
    ylabel('Probability Density Function','FontSize',12,'FontWeight','Demi');
    grid on;
    axis tight;
    figure;
    k3 = find(creepPC == 0.5);
        for i = 1:length(k3)
        strcell{i} = num2str(k3(i));
    end
    plh = plot(x_val,ypd(k3,:));
    legend(strcell,'Orientation','Vertical','Location','best');
    title(sprintf('PDF of all 5 Experiments at 0.5 %% Creepage'),'FontSize',12,'FontWeight','Demi');
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