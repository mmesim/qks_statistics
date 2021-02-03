# Skewness & Kurtosis of moment release history

*moments.m*

calculate tmax, skewness, and kurtosis of Moment release
input: a [Array, earthquake catalog]
format: YYYY-MM-DD-HR-MIN-SEC.MSEC LAT LON DEPTH MAG 

*parabola_ms_swarms.m*

Function to fit parabola for MS-AS and earthquake swarms
It would be useful if you run first the moments.m
Then you can decide which seqeucnes are swarms and MS-AS

Input:
X : vector for skewness
Y : vector for kurtosis
ms: vector with ms indices
swarms: vector with swarms indices
filename: string to the output diary file

<u>**Cite**</u>

Roland, E., & McGuire, J. J. (2009). Earthquake swarms on transform faults. *Geophysical Journal International*, *178*(3), 1677–1690. <https://doi.org/10.1111/j.1365-246X.2009.04214.x>

Chen, X., & Shearer, P. M. (2011). Comprehensive analysis of earthquake source spectra and swarms in the Salton Trough, California. *Journal of Geophysical Research B: Solid Earth*, *116*(B09), doi:10.1029/2011JB008263.  

Mesimeri, M., Karakostas, V., Papadimitriou, E., & Tsaklidis, G. (2019). Characteristics of earthquake clusters: Application to western Corinth Gulf (Greece). *Tectonophysics*, 228160. https://doi.org/10.1016/j.tecto.2019.228160