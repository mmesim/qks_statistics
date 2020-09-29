function [ pValue ] = pval_kstest( n,ks,alpha )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(ks)
s = n*ks(i)^2;

    % For d values that are in the far tail of the distribution (i.e.
    % p-values > .999), the following lines will speed up the computation
    % significantly, and provide accuracy up to 7 digits.
    if (s > 7.24) ||((s > 3.76) && (n > 99))
        pValue(i) = 2*exp(-(2.000071+.331/sqrt(n)+1.409/n)*s);
    else
        % Express d as d = (k-h)/n, where k is a +ve integer and 0 < h < 1.
        k = ceil(ks(i)*n);
        h = k - ks(i)*n;
        m = 2*k-1;

        % Create the H matrix, which describes the CDF, as described in Marsaglia,
        % et al. 
        if m > 1
            c = 1./gamma((1:m)' + 1);

            r = zeros(1,m);
            r(1) = 1; 
            r(2) = 1;

            T = toeplitz(c,r);

            T(:,1) = T(:,1) - (h.^(1:m)')./gamma((1:m)' + 1);

            T(m,:) = fliplr(T(:,1)');
            T(m,1) = (1 - 2*h^m + max(0,2*h-1)^m)/gamma(m+1);
         else
             T = (1 - 2*h^m + max(0,2*h-1)^m)/gamma(m+1);
         end

        % Scaling before raising the matrix to a power
        if ~isscalar(T)
            lmax = max(eig(T));
            T = (T./lmax)^n;
        else
            lmax = 1;
        end

        % Pr(Dn < d) = n!/n * tkk ,  where tkk is the kth element of Tn = T^n.
        % p-value = Pr(Dn > d) = 1-Pr(Dn < d)
        pValue(i) = (1 - exp(gammaln(n+1) + n*log(lmax) - n*log(n)) * T(k,k));
    end
   H(i) = (pValue(i) < alpha); 
end
   

end

