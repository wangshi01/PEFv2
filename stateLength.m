% calculate the duration of channel state in the term of packets

% g0= 10;
% PacketTime=2e-3;
% numSU =1;
% numChannel=1;
% avgSNR=10;
% a = [274.7229	90.2514	67.6181	50.1222	53.3987	35.3508];
% g = [7.9932	3.4998	1.6883	0.6644	0.3756	0.09];
% Ptarget=0.01;
% SNRboundary = [0 1./g.*log(a./Ptarget) inf];
% vMS = 5/3.6; % speed of the mobile station :5km/h 
% carrierFeq = 5e9; % carrier fequency: 5GHz
% VELOCITYOFLIGHT=3e8;
% DopplerFeq = ((vMS*carrierFeq)/(VELOCITYOFLIGHT))*ones(numSU,numChannel);
% numChannelState = 7;

%  [ ProbMatrix,...%( numSU * numChannel * numState * numState)
%     stateProb... %( 1 * numState)
%     ] = rayleighMarkovModel(numSU,numChannel,Ptarget,avgSNR,DopplerFeq,PacketTime,a,g,numChannelState); % (numSU * numChannel)


state = MarkovChainState(3,1,1/3*ones(3,3),200000);