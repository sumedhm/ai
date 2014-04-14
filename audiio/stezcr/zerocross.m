function zc = zerocross(x,wintype,winamp,winlen)

error(nargchk(1,4,nargin,'struct'));

% generate x[n] and x[n-1]
x1 = [x(1:end)];
x2 = [0, x(1:end-1)];

% generate the first difference
firstDiff = sgn(x1)-sgn(x2);

% magnitude only
absFirstDiff = abs(firstDiff);

% lowpass filtering with window
zc = winconv(absFirstDiff,wintype,winamp,winlen);