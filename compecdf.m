%% Plot ECDF and norm fit CDF
function [ normbounds,err ] = compecdf(data,distname)
if(strcmp(distname,'Empirical'))
    err = [];
    [fe,xe,flo,fup] = ecdf(data);
    k_fe(1) = find((fe >= 0.0240 & fe <= 0.0259),1,'first');
    k_fe(2) = find((fe >= 0.9740 & fe <= 0.9759),1,'first');
    k_fe(3) = find((fe >= 0.498 & fe <= 0.502),1,'first');
    normbounds = xe(k_fe);
    return
elseif(strcmp(distname,'Normal'))
    ff = cdf(pdfit,xe);
    k_fe(1) = find((fe >= 0.0240 & fe <= 0.0259),1,'first');
    k_fe(2) = find((fe >= 0.9740 & fe <= 0.9759),1,'first');
    k_fe(3) = find((fe >= 0.498 & fe <= 0.502),1,'first');
    pdfit = fitdist(data,distname);
    k_ff(1) = find((ff >= 0.0240 & ff <= 0.0259),1,'first');
    k_ff(2) = find((ff >= 0.9740 & ff <= 0.9759),1,'first');
    k_ff(3) = find((ff >= 0.498 & ff <= 0.502),1,'first');
    disp(sprintf('Empirical 50 bound: %0.2f, 95 Bounds %0.2f to %0.2f \n',xe(k_fe(3)),xe(k_fe(1)),xe(k_fe(2))));
    disp(sprintf('NormFit 50 bound: %0.2f, 95 Bounds %0.2f to %0.2f \n',xe(k_ff(3)),xe(k_ff(1)),xe(k_ff(2))));
    err = xe(k_fe) - xe(k_ff);
    normbounds = xe(k_ff);
    disp(sprintf('Errors b/w Empirical and Normfit estimates: 50ile %0.2f, CI ( %0.2f , %0.2f )',err(3),err(1),err(2)));
end
figure('visible','off');
hold on
plot(xe,fe,'b');
plot(xe,flo,'--y');
plot(xe,fup,'--y');
% plot(xe,ff,'r');
legend('Empirical','Bounds','CDF');
title(['Comparing empirical with ',distname]);
end