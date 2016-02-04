function  [y,code] = tonegen(digits, scale, yint)
%TONEGEN      generate "mystery" signal containing tones
%-------
%   Usage:     [Y, C] = tonegen(D, S, Xint)
%
%        D : vector of digits for a 5-element code 
%            if length(D)<5, the function will pick random digits
%        S : scale factor that multiplies the interference signal
%     Xint : interference signal
%        Y : output signal
%        C : output code actually used

%---------------------------------------------------------------
% copyright 1994, by C.S. Burrus, J.H. McClellan, A.V. Oppenheim,
% T.W. Parks, R.W. Schafer, & H.W. Schussler.  For use with the book
% "Computer-Based Exercises for Signal Processing Using MATLAB"
% (Prentice-Hall, 1994).
%---------------------------------------------------------------

if ( nargin < 3)
   load intfere.mat
   if ~exist('yint')
       error(' problem loading interference')
   end
end
if ( nargin < 2 )
  scale = 1.0;    %--- add 100% interference
end
if ( nargin < 1)
   digits = [];
end
fsamp = 10000;
tones = (250 + 500*[0:9]')/fsamp;
if length(digits) < 5
    digits = mod(fix(clock),10);  digits = digits(2:6);
end
code = mod(fix(digits(1:5)),10);    %--- just 5 digits, must be intergers
%----- rand('uniform')    %--- version 4
LL = 50*rand(7,1)-25;    %---- variation in lengths
LL = fix(LL) + [55;175*ones(5,1);95];
Ltot = sum(LL);
if Ltot > length(yint)
   LL = fix(LL*Ltot/length(yint));
end
ttt = [0.5*rand(1);tones(code+1);0.5*rand(1)];   %--- create the tones
f1 = [];
for j = 1:7;
   f1 = [ f1; ttt(j)*ones(LL(j),1) ];
end
N = length(f1);   Nm1 = N-1;   nn = [0:Nm1]';
%--------------------
tau = 0.8;
[ttt,fli] = filter(1-tau,[1 -tau],f1(1)*ones(99,1));   %--- set init conds.
f1 = filter(1-tau,[1 -tau],f1,0.9*fli);
%---- rand('normal')    %--- version 4
y = cos(2*pi*f1.*nn);
y = y +scale*yint(1:N);