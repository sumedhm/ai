[x,Fs] = audioread('so.wav'); % word is: so
x = x.';

N = length(x); % signal length
n = 0:N-1;
ts = n*(1/Fs); % time for signal

% define the window
wintype = 'rectwin';
winlen = 201;
winamp = [0.5,1]*(1/winlen);

% find the zero-crossing rate
zc = zerocross(x,wintype,winamp(1),winlen);

% find the zero-crossing rate
E = energy(x,wintype,winamp(2),winlen);
E1 = zeros(0,1);
Z1 = zeros(0,1);
j=0;
for i = 1:10:N-1
     e = sum(E(i:i+10)); % Sliding window = 10
     z = sum(zc(i:i+10));
     E1 = [E1,e];
     Z1 = [Z1,z];
end

P1 = zeros(0,1);
E1_max = max(E1(:));
Z1_max = max(Z1(:));

%Normalization
for i = 1:length(E1)
   E1(i) = E1(i)/E1_max;
   Z1(i) = Z1(i)/Z1_max;
   p = E1(i)*Z1(i);
   P1 = [P1,p];
end

mu_p = mean(P1);
frames = zeros(0,1);

for i = 1:length(P1)
   if(P1(i) > mu_p)
       disp(i);
   else
       %disp([i, ' belongs to non-excitation frame']);
   end
end

% time index for the ST-ZCR and STE after delay compensation
% out = (winlen-1)/2:(N+winlen-1)-(winlen-1)/2;
% t = (out-(winlen-1)/2)*(1/Fs);
% N = length(P1)-1;
% out1 = 1:N;
% t1 = (out1-(winlen-1)/2)*(1/Fs);
% 
% figure;
% plot(ts,x); hold on;
% plot(t,zc(out),'r','Linewidth',2); xlabel('t, seconds');
% title('Short-time Zero Crossing Rate');
% legend('signal','STZCR');
% 
% figure;
% plot(ts,x); hold on;
% plot(t1,Z1(out1),'r','Linewidth',2); xlabel('t, seconds');
% title('Short-time Zero Crossing Rate');
% legend('signal','STZCR');
% 
% figure;
% plot(ts,x); hold on;
% plot(t1,P1(out1),'r','Linewidth',2); xlabel('t, seconds');
% title('Short-time Energy');
% legend('signal','STE');
% 
% figure;
% plot(ts,x); hold on;
% plot(t,E(out),'r','Linewidth',2); xlabel('t, seconds');
% title('Short-time Energy');
% legend('signal','STE');