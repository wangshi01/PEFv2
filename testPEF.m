clear all;clc;

% constants settings
BUSYSTATE = 1;
FREESTATE = 2;
VELOCITYOFLIGHT=3e8;

% globle settings
numSU = 2;
numChannel = 2;
packetTime = 2e-3*ones(numSU,numChannel);
a = [274.7229  90.2514 67.6181 50.1222 53.3987 35.3508];
g = [7.9932    3.4998  1.6883  0.6644  0.3756  0.09];
numChannelState = 7;
carrierFeq = 5e9; % carrier fequency: 5GHz
avgSNR = [10 10; 10 10];

% PU activity settings
busyToBusy=[.5 .5];
freeToFree=[.5 .5];

% SU settings
bufferSize = [10 10];
Ptarget = [0.01 0.01; 0.01 0.01];
vMS = 5/3.6; % speed of the mobile station :5km/h 
dopplerFeq = ((vMS*carrierFeq)/(VELOCITYOFLIGHT))*ones(numSU,numChannel); 
%dopplerFeq=(velocity of MS * carrier fequency/ velocity of light)

% SU sensing parameters
probMissDetection = [0.0661 0.0661; 0.0661 0.0661];
probFalseAlarm = [0.0661 0.0661; 0.0661 0.0661];

% simulation setting structure definition
settings= struct(...
    'numSU',numSU,...
    'numChannel',numChannel,...
    'packetTime',packetTime,...
    'a',a,...
    'g',g,...
    'numChannelState',numChannelState,...
    'carrierFeq',carrierFeq,...
    'avgSNR',avgSNR,...
    'busyToBusy',busyToBusy,...
    'freeToFree',freeToFree,...
    'bufferSize',bufferSize,...
    'Ptarget',Ptarget,...
    'vMS',vMS,...
    'dopplerFeq',dopplerFeq,...
    'probMissDetection',probMissDetection,...
    'probFalseAlarm',probFalseAlarm,...
    'arrivalRate',[2 2]);

% set simulation settings
arrivalRate1 = linspace(2,18,5);
arrivalRate2 = linspace(2,18,5);
for i = 1:5
    for j = 1:5
        iGroup = (i-1)*5+j;
        if iGroup == 1
            continue;
        end
        settings(iGroup) = settings(iGroup-1);
        settings(iGroup).arrivalRate=[arrivalRate1(i) arrivalRate2(j)];
    end
end

% pef on probability of distribution definition 
numSU1       = 11;
numSU2       = 11;
pef=zeros(25,numSU1,numSU2);

for iGroup = 1:1    
    for iSU1 = 1:numSU1
        for iSU2 = 1:numSU2;
            tic;
            ProbS1C1 = (iSU1-1) * (0.1);
            ProbS1C2 = (iSU2-1) * (0.1);
            probDistribution = [ ProbS1C1 ProbS1C2; 1-ProbS1C1 1-ProbS1C2 ];
            pef(iGroup,iSU1,iSU2) = PEFv2( ...
            settings(iGroup).numSU,...                              % number of secondary user(1*1)
            settings(iGroup).numChannel,...                         % number of channel(1*1)
            settings(iGroup).arrivalRate,...                        % arrival rate of SU (1* numSU)
            settings(iGroup).bufferSize,...                         % buffer size of SU (1*numSU)
            settings(iGroup).probMissDetection,...                  % channel sensing miss detection ratio (numSU * numChannel)
            settings(iGroup).probFalseAlarm,...                     % channel sensing false alarm ratio (numSU * numChannel)
            probDistribution,...                                    % channel resourse allocation probabilities (numSU * numChannel)
            settings(iGroup).busyToBusy,...
            settings(iGroup).freeToFree,...                         % PU activity transmission probabilities (1 * numChannel)
            settings(iGroup).Ptarget,...                            % channel condition state parameters (numSU * numChannel)
            settings(iGroup).avgSNR,...            
            settings(iGroup).dopplerFeq,...
            settings(iGroup).packetTime,...
            settings(iGroup).a,...
            settings(iGroup).g,...
            settings(iGroup).numChannelState);
            toc;
        end
    end
end 

