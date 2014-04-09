for i =1:100
    m= aviread('G:\Cricket Matches\Aus vs. SL (final)\Clip 1 Cinepak.avi',i);
    str = strcat(floor(int2str(i/10000)),int2str(floor(mod(i,10000)/1000)),int2str(floor(mod(i,1000)/100)),int2str(floor(mod(i,100)/10)),int2str(floor(mod(i,10))));
    str= strcat('G:\Cricket Matches\Aus vs. SL (final)\frames\',str,'.ppm');
    imwrite(m.cdata,str,'ppm');
end
 
    