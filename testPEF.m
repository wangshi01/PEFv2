% test PEF

% test github
%v2
clear all;clc;

numSU = 2;
numChannel = 2;

bufferSize = [10 10];
Ptarget = [0.01 0.01; 0.01 0.01];
avgSNR = [10 10; 10 10];

vMS = 5/3.6; % speed of the mobile station :5km/h 
carrierFeq = 5e9; % carrier fequency: 5GHz
VELOCITYOFLIGHT=3e8;
dopplerFeq = ((vMS*carrierFeq)/(VELOCITYOFLIGHT))*ones(numSU,numChannel); 
%dopplerFeq=(velocity of MS * carrier fequency/ velocity of light)
packetTime = 2e-3*ones(numSU,numChannel);
% sensing parameters
probMissDetection = [0.0661 0.0661; 0.0661 0.0661];
probFalseAlarm = [0.0661 0.0661; 0.0661 0.0661];
% PU channel occupancy parameters
busyToBusy=[.5 .5];
freeToFree=[.5 .5];

a = [274.7229  90.2514 67.6181 50.1222 53.3987 35.3508];
g = [7.9932    3.4998  1.6883  0.6644  0.3756  0.09];
numChannelState = 7;
    
BUSYSTATE = 1;
FREESTATE = 2;
ProbS1C1  = 0.1;
ProbS1C2  = 0.5;


arrivalRate1=linspace(2,20,10);
arrivalRate2=linspace(2,20,10);
numRate1 = 10;
numRate2 = 10;
numSU1 = 11;
numSU2 = 11;
pef=zeros(numRate1,numRate2,numSU1,numSU2);
for iRate1=1:numRate1
    for iRate2=1:numRate2
        arrivalRate=[arrivalRate1(iRate1) arrivalRate2(iRate2)]
        for iSU1 = 1:numSU1
            for iSU2 = 1:numSU2;
                tic;
                ProbS1C1 = (iSU1-1) * (0.1);
                ProbS1C2 = (iSU2-1) * (0.1);
                probDistribution = [ ProbS1C1 ProbS1C2; 1-ProbS1C1 1-ProbS1C2 ];
                pef(iRate1,iRate2,iSU1,iSU2) = PEFv2( ...
                numSU,...                               % number of secondary user(1*1)
                numChannel,...                          % number of channel(1*1)
                arrivalRate,...                         % arrival rate of SU (1* numSU)
                bufferSize,...                          % buffer size of SU (1*numSU)
                probMissDetection,...                   % channel sensing miss detection ratio (numSU * numChannel)
                probFalseAlarm,...                      % channel sensing false alarm ratio (numSU * numChannel)
                probDistribution,...                    % channel resourse allocation probabilities (numSU * numChannel)
                busyToBusy,freeToFree,...               % PU activity transmission probabilities (1 * numChannel)
                Ptarget,avgSNR,dopplerFeq,packetTime,... % channel condition state parameters (numSU * numChannel)
                a,g,numChannelState);
                toc;
            end
        end
    end
end
