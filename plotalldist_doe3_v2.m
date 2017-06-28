%% plot normfits of all 7 sets at 1% Creepage and draw overlapping plots
%  close all;
clear all;
date = '6-28-17';
cd('C:\Users\CVeSS\Google Drive\CVeSS\Roller Rig Workstation\Roller Rig Test Data\February\6-28-17');
% cd('C:\Users\Jay Dixit\Google Drive\CVeSS\Roller Rig Workstation\Roller Rig Test Data\February\5-16-17');
mu = 1; % traction forces are normalized by wheel load
startexp = 1;
endexp = 7;
x_val = 0:0.001:1;
load('lookupdata_3.0.mat');
% load('ypd_5-15.mat'); %ypd5-15 removed outlier
% load('mean5-10.mat');
% load('lateralcrpge.mat');
% meanarr5_10 = meanarr;
% meanarr = [];
% cr5_10 = 0.01*creepPC;
% cr = 100*creepage;
z90 = 1.645; z95 = 1.96;
cc = 1.4826; % Consistency Constant for MAD
trunmeanarr = cell(46,1);
fullmeanarr = cell(46,1);
fb = 5; fs = 2000; filtorder = 2;
[b,a] = butter(filtorder,(fb/(fs*0.5)),'low');
% creepPC = [ones(1,15),2.9*ones(1,10),0.5*ones(1,10),ones(1,5),0.5,1,0.5,1,0.5,1,.5,1,0.5,1];
% strcell = cell(1,50);
for i = startexp:1:endexp   
    fname = ['RR_',date,'_',num2str(i)];
    load(fname);
    VCms = WheelVCms(2000);
    kVC = find(LookupData < (VCms + 0.0005) & (LookupData > (VCms - 0.0005)));
    if(~isempty(kVC))
        
        cr(i-startexp+1) = CreepData(kVC);
        filcrrZ = filtfilt(b,a,SumFzN);
        filcrrX = filtfilt(b,a,SumFxN);
        filcrrY = filtfilt(b,a,SumFyN);
        k_fc = find(filcrrZ <= (mean(filcrrZ) + 15) & filcrrZ >= (mean(filcrrZ) - 15));
        [rx,px,rlx,rux] = corrcoef(filcrrX,filcrrZ);
        corrx(i) = rx(1,2);
        corrxp(i) = px(1,2);
        corrx_lo(i) = rlx(1,2);
        corrx_hi(i) = rux(1,2);
        [ry,py,rly,ruy] = corrcoef(filcrrY,filcrrZ);
        corry(i) = ry(1,2);
        corryp(i) = py(1,2);
        corry_lo(i) = rly(1,2);
        corry_hi(i) = ruy(1,2);
        NCreepFC{i-startexp+1} = filcrrX(k_fc)./filcrrZ(k_fc);
        NCreepX = filcrrX./(mu*filcrrZ);
        NCreepY = filcrrY./(mu*filcrrZ);
        setX{i} = NCreepX;
        setY{i} = NCreepY;
%         pdX{i} = fitdist(setX{i},'Normal');
%         pdY{i} = fitdist(setY{i},'Normal');
%         ypdX(i,:) = pdf(pdX{i},x_val);
%         ypdY(i,:) = pdf(pdY{i},x_val);
k_fc_outrem = find(NCreepFC{i-startexp+1} >= median(NCreepFC{i-startexp+1}) - z95*cc*mad(NCreepFC{i-startexp+1},1) & NCreepFC{i-startexp+1} <= median(NCreepFC{i-startexp+1}) + z95*cc*mad(NCreepFC{i-startexp+1},1));
        meanarrXFC(i-startexp+1) = mean(NCreepFC{i-startexp+1}(k_fc_outrem));
        meanarrX(i-startexp+1) = mean(setX{i});
        meanarrY(i-startexp+1) = mean(setY{i});
        meanarrZ(i-startexp+1) = mean(filcrrZ);
    else
        fprintf('Excluded point is: %d \n',i);
        continue;
    end
end
% catarr = [meanarrX,meanarr5_15];
% catcrr = [cr,cr5_15];
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
    fm5_15 = [];
    fm5_16 = [];
    fcr5_15 = [];
    fcr5_16 = [];
%     tmparr = meanarr5_15(1:end);
%     tmpcr = cr5_15(45:end);
for j = 1:1:46
    strcell1 = {};
    strcell2 = {};
    tmX = [];
    crpge(j) = CreepData(j);
    figure;
    k1 = find(cr == crpge(j));
%     k2 = find(cr5_15(1:end) == crpge);
%     strcell = num2str(k1);
    for tmp = 1:length(k1)
        strcell1{tmp} = num2str(k1(tmp));
    end
%     plh = plot(x_val,ypdX(k1,:)); %,x_val,ypd5_15(k2,:),'--');
%     legend(strcell1,'Orientation','Vertical','Location','best');
%     title(sprintf('PDF of all 5 Experiments at %0.4f %% Creepage',crpge(j)),'FontSize',12,'FontWeight','Demi');
%     xlabel('Normalized Creep Value','FontSize',12,'FontWeight','Demi');
%     ylabel('Probability Density Function','FontSize',12,'FontWeight','Demi');
%     grid on;
%     axis tight;
%     figure;
%     plot(x_val,ypdY(k1,:));
%     legend(strcell1,'Orientation','Vertical','Location','best');
%     title(sprintf('PDF of all 5 Experiments at %0.4f %% Creepage',crpge(j)),'FontSize',12,'FontWeight','Demi');
%     xlabel('Normalized Lateral Creep Value','FontSize',12,'FontWeight','Demi');
%     ylabel('Probability Density Function','FontSize',12,'FontWeight','Demi');
%     grid on;
%     axis tight;
%     k2 = find(cr5_15 == crpge(j));
    tmX = [meanarrX(k1)];    
    madtm = mad(tmX,1);
    medtm = median(tmX);
    ktm = find( tmX > medtm - z90*cc*madtm & tmX < medtm + z90*cc*madtm);
    commeanX(j) = mean(tmX(ktm)); %Removing Outliers
% commeanX(j) = mean(tmX); % Not removing outliers
    comlociX(j) = mean(tmX(ktm)) - z90*std(tmX(ktm));
    comhiciX(j) = mean(tmX(ktm)) + z90*std(tmX(ktm));
    tmY = [meanarrY(k1)];    
    madtmY = mad(tmY,1);
    medtmY = median(tmY);
    ktmY = find( tmY > medtmY - z90*cc*madtmY & tmY < medtmY + z90*cc*madtmY);
    commeanY(j) = mean(tmY(ktmY));
    comlociY(j) = mean(tmY(ktmY)) - z90*std(tmY(ktmY));
    comhiciY(j) = mean(tmY(ktmY)) + z90*std(tmY(ktmY));
%     madtm2 = mad(tm2);
%     medtm2 = median(tm2);

%     ktm2 = find( tm2 > medtm2 - z90*cc*madtm2 & tm2 < medtm2 + z90*cc*madtm2);
%     fm5_15 = [fm5_15,tm1(ktm1)];
%     fm5_16 = [fm5_16,tm2(ktm2)];
%     fcr5_15 = [fcr5_15,crpge*ones(size(ktm1))];
%     fcr5_16 = [fcr5_16,crpge*ones(size(ktm2))];
    
end
% figure;
% hold on;
% createFit1(crpge,commeanX);
% createFit1(crpge,comlociX);
% createFit1(crpge,comhiciX);
% hold off;
% title('Curve Fit X Direction');
% figure;
% hold on;
% createFit1(crpge,commeanY);
% createFit1(crpge,comlociY);
% createFit1(crpge,comhiciY);
% hold off;
% title('Curve Fit Y Direction');
% fm = [fm5_15,fm5_16];
% fcr = [fcr5_15,fcr5_16];
%     figure;
%     k2 = find(cr == 2.9);
%         for i = 1:length(k2)
%         strcell{i} = num2str(k2(i));
%     end
%     plh = plot(x_val,ypd(k2,:));
%     legend(strcell,'Orientation','Vertical','Location','best');
%     title(sprintf('PDF of all 5 Experiments at 2.9 %% Creepage'),'FontSize',12,'FontWeight','Demi');
%     xlabel('Normalized Creep Value','FontSize',12,'FontWeight','Demi');
%     ylabel('Probability Density Function','FontSize',12,'FontWeight','Demi');
%     grid on;
%     axis tight;
%     figure;
%     k3 = find(creepPC == 0.5);
%         for i = 1:length(k3)
%         strcell{i} = num2str(k3(i));
%     end
%     plh = plot(x_val,ypd(k3,:));
%     legend(strcell,'Orientation','Vertical','Location','best');
%     title(sprintf('PDF of all 5 Experiments at 0.5 %% Creepage'),'FontSize',12,'FontWeight','Demi');
%     xlabel('Normalized Creep Value','FontSize',12,'FontWeight','Demi');
%     ylabel('Probability Density Function','FontSize',12,'FontWeight','Demi');
%     grid on;
%     axis tight;
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