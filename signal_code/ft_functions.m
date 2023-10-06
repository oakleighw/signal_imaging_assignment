classdef ft_functions
   methods
       %computes fft, single-sided spectrum P1 based on two-sides spectrum
       %P2 for plotting fast fourier transform
      function [f,P1] = fastf(obj,x,fs)
         Fs = fs;            % Sampling frequency                    
         T = 1/Fs;             % Sampling period       
         L = length(x);      % Length of signal
         t = (0:L-1)*T;        % Time vector

         n = length(t);
         Y = fft(x, n);

         P2 = abs(Y/L);
         P1 = P2(1:floor(L/2+1));
         P1(2:end-1) = 2*P1(2:end-1);

         f = Fs*(0:(L/2))/L;
      end
   end
end