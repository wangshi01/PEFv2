%% functionname: function description
function state = MarkovChainState(numState,initState,transProbMatrix,simLength)
    
    state(1)=initState;
    p = rand(1,simLength);
    prob =zeros(1,numState+1);
    for iSim=2:simLength
        % body
        for i = 1:numState
            prob(i+1) = prob(i) + transProbMatrix(state(iSim-1),i);
            if p(iSim)>prob(i) && p(iSim)<=prob(i+1)
                state(iSim) = i;
                break;
            end
        end
    end     
end