# Interevent Times distribution

Here we calculate the interevent distribution for a catalog or a cluster and fit four statistical distributions (Weibull, Lognormal, Gamma, Exponential )

How to: 

(i) Specify the input catalog line 6 [.mat format] and run distr_pdf 

Output variables: aic, bic, -logL

Output objects: ex, gm, lgn, wbl (estimated parameters)

(ii) Specify the input catalog line 6 [.mat format] and run distr_cdf 

*Note: you should run distr_pdf first*

<u>Output variables</u>

K-S test: cv_ks (critical value) - ks [distance] - ks_pval [p-value]

<u>**Cite**</u>

Corral, A. (2006). Dependence of earthquake recurrence times and independence of magnitudes on seismicity history. *Tectonophysics*, *424*(3–4), 177–193. https://doi.org/10.1016/j.tecto.2006.03.035

Mesimeri, M., Karakostas, V., Papadimitriou, E., & Tsaklidis, G. (2019). Characteristics of earthquake clusters: Application to western Corinth Gulf (Greece). *Tectonophysics*, 228160. https://doi.org/10.1016/j.tecto.2019.228160