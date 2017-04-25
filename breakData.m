function [fx,fy,fz,tb,creepPC] = breakData(linspeed,time, rawx,rawy,rawz,wheelVAms,wheelVCms)
filen = sprintf('lookupdata_%0.1f.mat',linspeed);
load(filen); % general speed data. put three mat files with _ seperated speeds
fb = 10;
filtorder = 3;
fs = 2000;
tolC = 0.00001;
tolA = 0.0003;
[b,a] = butter(filtorder,(fb/(fs*0.5)),'low');
filVAms = filtfilt(b,a,wheelVAms);
k = NaN([length(LookupData),2000000],'double');
fx = NaN([length(LookupData),2000000],'double');
fy = NaN([length(LookupData),2000000],'double');
fz = NaN([length(LookupData),2000000],'double');
tb = NaN([length(LookupData),2000000],'double');
for i = 1:1:length(LookupData)
    x = LookupData(i);
        tmp = find((abs(wheelVCms - x) < tolC));
        %z = find(abs(filVAms - wheelVCms) < tolA);
        %[lia,locb] = ismember(tmp,z);
        for j = 1:1:length(tmp)
            %if(lia(j) == true)
                k(i,tmp(j)) = tmp(j);
                fx(i,tmp(j)) = rawx(tmp(j));
                fy(i,tmp(j)) = rawy(tmp(j));
                fz(i,tmp(j)) = rawz(tmp(j));
             %   tb(i,locb(j)) = time(tmp(j));
            %end
        end
end
creepPC = CreepData*100;
figure;
plot(wheelVCms,'r');
hold on
plot(filVAms,'--b');
plot(-wheelVCms+filVAms,'-k');
legend('VC','VA','err');
% for j = 1:1:length(LookupData)
%     for l = 1:1:250000
%         if (k(j,l) ~= 0)
%             fx(j,l) = rawx(k(j,l));
%             fy(j,l) = rawy(k(j,l));
%             fz(j,l) = rawz(k(j,l));
%             tb(j,l) = time(k(j,l));
%         end
%     end
% end
end
    
    
    