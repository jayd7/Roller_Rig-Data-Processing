clear all
close all
date = '3-24-17';
cd(['C:\Users\Jay Dixit\Google Drive\CVeSS\Roller Rig Workstation\Roller Rig Test Data\February\',date]);
load('lookupdata_3.0.mat');
datalen = 9002;
reps = 1;
repsid = [2];
startexp = 1;
endexp = 72;
sizeexp = endexp - startexp + 1;
mu = 1;
fb = 10;
fs = 2000;
nfft = 2^12;
wndo = nfft;
ovlp = nfft/2;
filtorder = 2;
[b,a] = butter(filtorder,(fb/(fs*0.5)),'low');
pstart = 10;
pend = 20;
rollerW = 0.08; % in RPS
midMark = NaN(sizeexp,1);
lowMark = NaN(sizeexp,1);
highMark = NaN(sizeexp,1);
indexarr = NaN(sizeexp,1);
NCreepX = NaN([46,datalen],'double');
%splinearr = 0:0.001:sizeexp*0.1;
for j = startexp:1:endexp
    filen = ['RR_0',date,'_',num2str(j)]
    fname = [filen,'.mat'];
    load(fname);
    %matnplot(filen);
%     crrZ = detrendTs(SumFzN,rollerW,3);
%     crrX = detrendTs(SumFxN,rollerW,3);
%     crrY = detrendTs(SumFyN,rollerW,3);
%     crrZwDC = addDC(SumFzN,crrZ);
%     crrXwDC = addDC(SumFxN,crrX);
%     crrYwDC = addDC(SumFyN,crrY);
%     Low PAss Filtering
    filcrrZ = filtfilt(b,a,SumFzN);
    filcrrX = filtfilt(b,a,SumFxN);
    filcrrY = filtfilt(b,a,SumFyN);
%     figure;
%     subplotfill(2,1,1);
%     plot(Time,SumFzN,'-b');
%     hold on
%     plot(Time,crrZwDC,'-r');
%     legend('raw','wDC');
%     subplotfill(2,1,2);
%     plot(Time,SumFxN,'-b');
%     hold on
%     plot(Time,crrXwDC,'-r');
%     legend('raw','wDC');
%     figure;
%     subplotfill(2,1,1);
%     plot(Time,filcrrZ,'-b');
%     title('Z');
%     subplotfill(2,1,2);
%     plot(Time,filcrrX,'-b');
%     title('X');
    i = j-startexp + 1;
    NCreepX(i,:) = [abs(filcrrX./(mu*filcrrZ))'];
    fx(i,:) = filcrrX;
    fy(i,:) = filcrrY;
    fz(i,:) = filcrrZ;
    %,NaN([1,20000-length(SumFxN)],'double')];
    NCreepX_m = nanmedian(NCreepX(i,:));
    NCreepX_s = nanstd(NCreepX(i,:));
    midMark(i) = NCreepX_m;
    lowMark(i) = NCreepX_s;
    highMark(i) = NCreepX_m + 2*NCreepX_s;
%     if( i == 1 || i == 22 || i == 42) % special case.
%         indexarr(i) = 0;
%     % elseif((i > 1 && i <= 21) || (i > 22 && i <= 42) || (i > 43 && i < 125))
%     else
%         indexarr(i) = indexarr(i-1) + 0.1;
% %     elseif (i == 3 || i == 79 || i == 125)
% %         indexarr(i) = 3.4;
% %     elseif ((i > 33 && i <= 46) || (i > 79 && i <= 92) || (i > 125 && i <= 138))
% %         indexarr(i) = indexarr(i-1) + 0.2;
%     end
    x = WheelVCms(1);
    velind = find(abs(LookupData - x) < 0.0001);
    indexarr(i) = CreepData(velind)*100;
%     figure;
%     plot(Time,NCreepX(i,:),'-b');
%     b = NCreepX_s;
%     title(sprintf('Normalised Creep Behaviour \n Median : %f Std: %f',NCreepX_m,NCreepX_s));
end
% pinterestX = indexarr(pstart:pend);
% pinterestY = midMark(pstart:pend);
figure;
plot(indexarr,midMark,'-b');
% hold on
% plot(indexarr,lowMark,'-.r');
% hold on
% plot(indexarr,highMark,'-.g');
% legend('Mean','95% Confidence low','95% Confidence High');
grid on;
xlabel('% Creepage');
ylabel('Normalised Creep');
%createFit(indexarr,midMark);
%boxplot(NCreepX')
%% --------------------------------- FITDIST-CI CODE--------------------------
pts = 36;
for i = 1:1:36
    nanind = find(isnan(NCreepX(i,:)) == true);
    NCreepX(i,nanind) = [];
end
fullCreep = NaN([pts,datalen*reps],'double');
%filCreep = NaN([pts,datalen*reps],'double');
% paramarr = NaN([36,3],'double');
%[d,pd] = allfitdist(fullCreep(1,:));
X = NaN(36,3);
icdfY = [0.025 0.5 0.975];
icdfX = NaN(36,3);
icdfXn = NaN(36,3);
%% Plot code for generating correlation data.
width = 3;     % Width in inches
height = 3;    % Height in inches
alw = 1;    % AxesLineWidth
fsz = 11;      % Fontsize
lw = 2;      % LineWidth
msz = 8;       % MarkerSize
figcor{1} = figure('units','normalized','Position',[0 0 0.8 0.8]);
figcor{2} = figure('units','normalized','Position',[0 0 0.8 0.8]);
figcor{3} = figure('units','normalized','Position',[0 0 0.8 0.8]);
figcor{4} = figure('units','normalized','Position',[0 0 0.8 0.8]);
figcoh{1} = figure('units','normalized','Position',[0 0 0.8 0.8]);
figcoh{2} = figure('units','normalized','Position',[0 0 0.8 0.8]);
figcoh{3} = figure('units','normalized','Position',[0 0 0.8 0.8]);
figcoh{4} = figure('units','normalized','Position',[0 0 0.8 0.8]);
%set(figcor,'PaperPositionMode','auto');
prev = 1;
for i = 1:1:36
    i
    if(reps == 1)
        if(repsid(1) == 1)
            fullCreep(i,:) = [NCreepX(i,:)];
            fullX(i,:) = [fx(i,:)];
            fullZ(i,:) = [fz(i,:)];
            fullY(i,:) = [fy(i,:)];
        elseif(repsid(1) == 2)
            fullCreep(i,:) = [NCreepX(i+36,:)];
            fullX(i,:) = [fx(i+36,:)];
            fullZ(i,:) = [fz(i+36,:)];
            fullY(i,:) = [fy(i+36,:)];
        elseif(repsid(1) == 3)
            fullCreep(i,:) = [NCreepX(i+72,:)];
            fullX(i,:) = [fx(i+72,:)];
            fullZ(i,:) = [fz(i+72,:)];
            fullY(i,:) = [fy(i+72,:)];
        end
    elseif(reps == 2)
        if(isequal(repsid,[1,2]))
            fullCreep(i,:) = [NCreepX(i,:),NCreepX(i+36,:)];
            fullX(i,:) = [fx(i,:),fx(i+36,:)];
            fullZ(i,:) = [fz(i,:),fz(i+36,:)];
            fullY(i,:) = [fy(i,:),fy(i+36,:)];
            fullind(i,:) = [indexarr(i,:);indexarr(i+36,:)];
            fullmid(i,:) = [midMark(i,:);midMark(i+36,:)];
        elseif(isequal(repsid,[2,3]))
            fullCreep(i,:) = [NCreepX(i+36,:),NCreepX(i+72,:)];
            fullX(i,:) = [fx(i+36,:),fx(i+72,:)];
            fullZ(i,:) = [fz(i+36,:),fz(i+72,:)];
            fullY(i,:) = [fy(i+36,:),fy(i+72,:)];
            fullind(i,:) = [indexarr(i+36,:);indexarr(i+72,:)];
            fullmid(i,:) = [midMark(i+36,:);midMark(i+72,:)];
        elseif(isequal(repsid,[1,3]))
            fullCreep(i,:) = [NCreepX(i,:),NCreepX(i+72,:)];
            fullX(i,:) = [fx(i,:),fx(i+72,:)];
            fullZ(i,:) = [fz(i,:),fz(i+72,:)];
            fullY(i,:) = [fy(i,:),fy(i+72,:)];
        else
            disp('Error, repsid invalid');
        end
    elseif(reps == 3)
        fullCreep(i,:) = [NCreepX(i,:),NCreepX(i+36,:),NCreepX(i+72,:)];
        fullX(i,:) = [fx(i,:),fx(i+36,:),fx(i+72,:)];
        fullY(i,:) = [fy(i,:),fy(i+36,:),fy(i+72,:)];
        fullZ(i,:) = [fz(i,:),fz(i+36,:),fz(i+72,:)];
    end
    y = fullX(i,:); x = fullZ(i,:);
    [Cxy,F] = mscohere(x,y,wndo,ovlp,nfft,fs);
    k02 = find(F < 1.2);
    yn = Cxy(k02) > 0.9;
    if(mod(i,9) == 0)
        ctfig = 9;
    else
        ctfig = mod(i,9);
    end
    set(0,'CurrentFigure',figcor{prev});
    h = subplotfill(3,3,ctfig);
    set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
    [fitres,gof] = plotfit(y,x,lw);
    if(gof.rsquare < 0.7)
        set(h,'Color',[1 0.6 0.6]);
    end
    %fit(i) = fitres;
    gofc(i) = gof;
    title(sprintf('Creepage: %0.3f',CreepData(i)),'Fontname','Tahoma','FontSize',10,'FontWeight','Bold','Color',[0 0.7 0]);
    removewhitespace;
    set(0,'CurrentFigure',figcoh{prev});
    h2 = subplotfill(3,3,ctfig);
    set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
    hold on;
    scatter(F,Cxy,'b','fill');
    rfl = plot([0,10],[0.9,0.9]);
    set(rfl,'LineWidth',2,'Color',[1 0 0],'LineStyle','--');
    vfl = plot([1.2 1.2],ylim,'-.k');
    set(vfl,'LineWidth',2);
    axis([0 5 ylim]);
    %set(gca,'xscale','log');
    hold off;
    if(not(isequal(yn,ones(size(k02)))))
        set(h2,'Color',[1 0.6 0.6]);
    end
    %grid on;
    box on;
   %set(gca,'XTickLabel',[],'YTickLabel',[]); 
    title(sprintf('Creepage: %0.3f',CreepData(i)),'Fontname','Tahoma','FontSize',10,'FontWeight','Bold','Color',[0 0.7 0]);
    removewhitespace;
    prev = (i - mod(i,9))/9 + 1;
end
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits', 'inches');
% papersize = get(gcf, 'PaperSize');
% left = (papersize(1)- width)/2;
% bottom = (papersize(2)- height)/2;
% myfiguresize = [left, bottom, width, height];
% set(gcf,'PaperPosition', myfiguresize);
%print('improvedExample','-dpng','-r300');
% %     nanind = find(isnan(fullCreep(i,:)) == true);
% %     fullCreep(nanind) = [];
%     filCreep(i,:) = filtfilt(b,a,fullCreep(i,:));
%     [d,pd] = allfitdist(filCreep(i,:));
%     paramarr(i,:) = d;
%     Dist = paramarr(i,1).DistName;
%     if(strcmp(Dist,'extreme value'))
%         A = paramarr(i,1).Params(1);
%         B = paramarr(i,1).Params(2);
%         icdfX(i,:) = icdf('ev',icdfY,A,B);        
%     elseif(strcmp(Dist,'generalized pareto'))
%         A = paramarr(i,1).Params;
%         icdfX(i,:) = icdf('gp',icdfY,A(1),A(2),A(3));
%     elseif(strcmp(Dist,'tlocationscale'))
%         A = paramarr(i,1).Params;
%         icdfX(i,:) = icdf('tlocationscale',icdfY,A(1),A(2),A(3));
%     elseif(strcmp(Dist,'generalized extreme value'))
%         A = paramarr(i,1).Params;
%         icdfX(i,:) = icdf('gev',icdfY,A(1),A(2),A(3));
%     elseif(strcmp(Dist,'weibull'))
%         A = paramarr(i,1).Params;
%         icdfX(i,:) = icdf('weibull',icdfY,A(1),A(2));
%     else
%         A = paramarr(i,1).Params;
%         icdfX(i,:) = icdf(Dist,icdfY,A(1),A(2));
%     end
%     [muhat,sigmahat] = normfit(fullCreep(i,:));
%     icdfXn(i,:) = icdf('normal',icdfY,muhat,sigmahat);
% end
% %figure;
% %boxplot(fullCreep');
% %title('UnLPFiltered Creep Boxplot');
% %removewhitespace;
% % figure;
% % boxplot(filCreep');
% % title('LPFiltered Creep Box plot');
% % removewhitespace;
% figure;
% hold on;
% plot(CreepData(3:36),icdfX(3:36,2),'-*','Color',[0.8 0 0.8]);
% plot(CreepData(3:36),icdfX(3:36,1),'-*','Color',[0.8 0 0]);
% plot(CreepData(3:36),icdfX(3:36,3),'-*', 'Color', [0 0.8 0]);
% hold off;
% set(gca,'FontSize',14);
% legend('50%ile','Lower 95% Confidence Bound','Upper 95% Confidence Bound');
% title(sprintf('Creep-Creepage Curve for 12 km/h Simulated Speed '));
% xlabel('Creepage');
% ylabel('L/V Ratio');
% removewhitespace;
% figure;
% hold on;
% plot(CreepData(3:36),icdfXn(3:36,2),'-*','Color',[1 0 1]);
% plot(CreepData(3:36),icdfXn(3:36,1),'-*','Color',[1 0 0]);
% plot(CreepData(3:36),icdfXn(3:36,3),'-*','Color', [0 1 0]);
% hold off;
% set(gca,'FontSize',14);
% title(sprintf('Norm fit Data for 3-24'));
% legend('50%ile','Lower 95% Confidence Bound','Upper 95% Confidence Bound');
% xlabel('% Creepage');
% ylabel('L/V Ratio');
% removewhitespace;
% 
