function [ formants] = formants( full_signal, sr )
%FORMANTS Finds the voiced-vowel formants of a pre-windowed signal
%   Given an [nx1] windowed signal and frequency Fs, find the formants of the voiced
%   signal and output them in a 3x1 array, along with the approximate power
%   of each (normalized to the largest formant)
%   
%   Usage: [ formants sigPower formPower] = formants( signal, Fs )
    wintime = 0.025;
    steptime = 0.010;
    
    winpts = round(wintime*sr);
    steppts = round(steptime*sr);
  
    WINDOW = [hanning(winpts)'];
    % hanning gives much less noisy sidelobes
    NOVERLAP = winpts - steppts;


    signal=enframe(full_signal, WINDOW,steppts);
    [sigRows, ~]=size(signal);
    for i=1:sigRows
        preemph = [1 0.63];
        x1=signal(i, :);
        x1 = filter(1,preemph,x1);
        A = lpc(x1,8);
        if ~all(isfinite(A))
            formants(1:3,i)=zeros(3,1);            
        else
        rts = roots(A);
        rts = rts(imag(rts)>=0);
        angz = atan2(imag(rts),real(rts));
        [frqs,indices] = sort(angz.*(sr/(2*pi)));
        bw = -1/2*(sr/(2*pi))*log(abs(rts(indices)));
        nn = 1;
        for kk = 1:length(frqs)
            if (frqs(kk) > 90 && bw(kk) <400)
                formants(nn, i) = frqs(kk);
                nn = nn+1;
            else
                formants(nn, i) = 0;
            end
        end
        end


%         f= -sr/2:sr/(length(x1)):sr/2-sr/(length(x1));
%         %plot(f, abs(freqX1)/length(freqX1))
%         sigPower(1,i)=bandpower(signal(i, :));
% 
%         pf1=bandpower(x1, sr, [formants(1,i)-150 formants(1,i)+150]);
%         pf2=bandpower(x1, sr, [formants(2,i)-150 formants(2,i)+150]);
%         pf3=bandpower(x1, sr, [formants(3,i)-150 formants(3,i)+150]);
%         formPower(1:3, i)=[pf1 pf2 pf3]./sigPower(1,i);
    end
    
 end

