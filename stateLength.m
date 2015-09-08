% calculate the duration of channel state in the term of packets

g0= 10;
a = [274.7229	90.2514	67.6181	50.1222	53.3987	35.3508];
g = [7.9932	3.4998	1.6883	0.6644	0.3756	0.09];
Ptarget=0.01;
SNRboundary = [0 1./g.*log(a./Ptarget)];
vMS = 5/3.6; % speed of the mobile station :5km/h 
carrierFeq = 5e9; % carrier fequency: 5GHz
VELOCITYOFLIGHT=3e8;
fm = ((vMS*carrierFeq)/(VELOCITYOFLIGHT));
Tp=2e-3;

for i=1:length(SNRboundary)-1
	l(i)=(exp(-SNRboundary(i)/g0)-exp(-SNRboundary(i+1)/g0))/...
	(sqrt(1*pi*SNRboundary(i)/g0)*exp(-SNRboundary(i)/g0)+sqrt(1*pi*SNRboundary(i+1)/g0)*exp(-SNRboundary(i+1)/g0))*(1/(fm*Tp));
end
