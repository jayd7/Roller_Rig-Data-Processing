function [] = kimber_test()
%
% The 'kimber' test adapts the Generalized ESD procedure to check for up to
% 'r' upper outliers from an exponential distribution. An approximation to
% the critical values is used instead of the published tables, which can
% reduce accuracy.
%
% Data in 'x' are organized so that columns are the time series and rows
% are the time intervals. All series contain the same number of
% observations.
%
% 'x_date' is a column vector (cell array) containing the dates of the
% corresponding data in 'x'.
%
% 'r'  is the predefined number of outliers to check.
%
% 'alpha' specifies the significan level. By default 'alpha' = 0.05.
%
% [] = kimber_test() returns a message in the Command Window saying if the
% tests passed or there was some problem during execution.
%
% Created by Francisco Augusto Alcaraz Garcia
%            alcaraz_garcia@yahoo.com
%
% References:
%
% 1) A.C. Kimber (1982). Tests for Many Outliers in an Exponential Sample.
% Journal of the Royal Statistical Society, Series C (Applied Statistics),
% 31(3), pp. 263-271.
%
% 2) B. Iglewicz; D.C. Hoaglin (1993). How to Detect and Handle Outliers.
% ASQC Basic References in Quality Control, vol. 16, Wisconsin, US.


% Test sample from Ref. 2).
% INPUTS:
x = [50 1; 134 1; 187 2; 882 3; 1450 12; 1470 25; 2290 46; 2930 56;
    4180 68; 15800 109; 29200 323; 86100 417];
x_date = cellstr(['03/01/2005'; '04/01/2005';
    '05/01/2005'; '06/01/2005'; '07/01/2005';
    '10/01/2005'; '11/01/2005'; '12/01/2005';
    '13/01/2005'; '14/01/2005'; '17/01/2005';
    '18/01/2005']);
r = 3;
alpha = 0.05;

% OUTPUTS:
ss_test = [0.595135236015013,0.392285983066792;0.498523210352893,0.5;
           0.537908964014571,0.337461300309598;];
s_test = [0.450152189125093;0.392032994538044;0.383949844522918;];
outlier_test = {'14/01/2005','Series1';'17/01/2005','Series1';
    '18/01/2005','Series1';'17/01/2005','Series2';'18/01/2005','Series2';};
outlier_num_test = [10,1;11,1;12,1;11,2;12,2;];


[n, c] = size(x);
[xr, ix] = sort(x);
s = zeros(r,1);
ss = zeros(r,c);
outlier = [];
outlier_num = [];

for j = 1:r,
    u = ((alpha/r) / nchoosek(n,j))^(1/(n-j));
    s(j,1) = (1-u)/(1+(j-1)*u);
    
    ss(j,:) = xr(n+1-j,:)./sum(xr(1:n+1-j,:));
end

for i = 1:c,
    [i1,j1] = find(ss(:,i) > s);
    if ~isempty(i1),
        outlier = [outlier; x_date(ix(end-max(i1)+1:end)) repmat(cellstr(strcat('Series', num2str(i))),max(i1),1)];
        outlier_num = [outlier_num; ix(end-max(i1)+1:end,i) repmat(i,max(i1),1)];
    end
end

if isequal(round(ss_test.*10^5)./10^5, round(ss.*10^5)./10^5) && ...
        isequal(round(s_test.*10^5)./10^5, round(s.*10^5)./10^5) && ...
        isequal(outlier_test, outlier) && isequal(outlier_num_test, outlier_num),
    disp('All tests have passed.');
else
    disp('There is some error in the cash output. Please do not use the function.');
end

