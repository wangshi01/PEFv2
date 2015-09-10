numSU = 1;
numChannel = 1;
Ptarget = .01;
avgSNR=10;
DopplerFeq = 20;
PacketTime = 2e-3;
a = [274.7229	90.2514	67.6181	50.1222	53.3987	35.3508];
g = [7.9932	3.4998	1.6883	0.6644	0.3756	0.09];
numChannelState = 7;

SNRboundary = [0 1./g.*log(a./Ptarget) inf];

[ProbMatrix,stateProb]=rayleighMarkovModel(numSU,numChannel,Ptarget,avgSNR,DopplerFeq,PacketTime,a,g,numChannelState)

