% This script generates the heatmap data, i.e. the data that is used to
% generate Fig. 6 and Fig. S1. It records equilibrium data for the full
% model, for a range of theta and r values.

clearvars
close all
clc

% SPECIFY PARAMETER VALUES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tag=10; % L_max: tag availability.
mu=0.0005; % trait mutation rate.
tagSkewIni = 0.9; % Specifies the initial frequency of one tag. The remaining 1-tagSkewIni is randomly distributed amongst the remaining tags.
helpini = 0.1; % Initial frequency of the helping allele.
alpha = 1; % Partner search potential.
b=0.3; % benefit of helping
c=0.1; % cost of helping
csearch= 0.0001; % cost of abandoning social partner for a new encounter.
T=100000; % number of generations in each trial.
thetaR=[0:0.01:0.5]; % array of population viscosity values
rR=[0:0.025:0.5]; % array of recombination values

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We define the following empty arrays, which we will populate with
% results.
resmark = zeros(length(rR),length(thetaR));
resalt  = zeros(length(rR),length(thetaR));
rescycle  = zeros(length(rR),length(thetaR));
fluc = zeros(length(rR),length(thetaR));
poly  = zeros(length(rR),length(thetaR));
avgtagfreq  = zeros(length(rR),length(thetaR));
stddev = zeros(length(rR),length(thetaR));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following lines are for initiating the population genotype
% frequencies. They ensure that one tag has the frequency given by
% tagSkewIni, and that the remaining 1-tagSkewIni is randomly distributed
% amongst the remaining 1-L_max tags. Furthermore, they ensure that helper
% frequency is initially given by helpini.

maj = (1/tag) * (1 - tagSkewIni) + tagSkewIni ;
popIni = zeros(2,4,tag);
popIni(1,1,:) = rand(1,tag);
popIni(1,1,:) = popIni(1,1,:) ./ ( sum(sum(popIni(1,1,:)))-popIni(1,1,1) ) .* (1-maj)  ;
popIni(1,1,1) = maj ;
popIni(1,1,:) = popIni(1,1,:) .* (1-helpini);
popIni(2,1,:) = (popIni(1,1,:) ./ (1-helpini) ) .* helpini;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for cur_r = 1:length(rR) % This loops over recombination values
    
    r = rR(cur_r);
    
for cur_theta = 1:length(thetaR) % This loops over population viscosity values
    
    theta = thetaR(cur_theta);
    
    pop = zeros(2,4,tag,T+1);
    pop(:,:,:,1) = popIni;
    pop(2,2,:,:) = 1;  % helper

    
for t=1:T % This loops over generations


% The following lines generate the population freqeuncy of each genotype 
% after selection has occured. Note that the competition term 'A' does not
% explicitly feature in the below manipulations. However, we account for
% the effects of A indirectly, by dividing each genotype frequency through
% by the sum of all genotype frequencies. This division also serves to
% prevent the proliferation of rounding errors.
pop(:,3,:,t) = pop(:,1,:,t) .* (1 + (-csearch .* (1-theta) .* alpha .* (1-sum(pop(:,1,:,t)))  + ...  
                  b .*  (theta .* pop(:,2,:,t) + (1-theta) .* (sum(pop(:,1,:,t) .* pop(:,2,:,t)) ))  - ...    
                  c .*  pop(:,2,:,t) .* (theta + (1-theta) .* sum(pop(:,1,:,t)) )) ...
                  ./ (1-alpha .*(1-sum(pop(:,1,:,t))).*(1-theta))) ;

pop(:,3,:,t) = pop(:,3,:,t) ./ sum(sum(pop(:,3,:,t))) ;

% The following lines generate the population freqeuncy of each genotype 
% after recombination has occured. 
pop(:,4,:,t) = pop(:,3,:,t) .* (pop(:,3,:,t) + (sum(pop(:,3,:,t))-pop(:,3,:,t)) + (sum(pop(:,3,:,t),3) - pop(:,3,:,t)) + ...  % individual with both tag and trait mating with individual with one or both of tag and trait 
    (1-r) .* (1-sum(pop(:,3,:,t))-sum(pop(:,3,:,t),3) + pop(:,3,:,t))) + ... % individual with tag and trait mating but not recombining with individual lacking both tag and trait
    r .* (sum(pop(:,3,:,t))-pop(:,3,:,t)) .* (sum(pop(:,3,:,t),3) - pop(:,3,:,t)); % individual with one of tag and trait mating and recombining with individual with the other of the tag / trait

% This  line is just to stop the proliferation of rounding errors.
pop(:,4,:,t) = pop(:,4,:,t) ./ sum(sum(pop(:,4,:,t))) ;

% The following lines generate the population freqeuncy of each genotype 
% after mutation has occured.
pop(1,1,:,t+1) = pop(2,4,:,t) .* (mu) + pop(1,4,:,t) .* (1-mu);  
pop(2,1,:,t+1) = pop(1,4,:,t) .* (mu) + pop(2,4,:,t) .* (1-mu);  

% This  line is just to stop the proliferation of rounding errors.
pop(:,1,:,t+1) = pop(:,1,:,t+1) ./ sum(sum(pop(:,1,:,t+1))) ;

end

% This matrix records the equilibrium helper frequency for each specific 
% combination of r and theta.
resalt(cur_r,cur_theta) = mean(sum(sum ( pop(:,1,:,round(T/2) : T) .* pop(:,2,:,round(T/2) : T) ))) ; % altruist genotypes

% The 'avgtagfreq' matrix gives the equilibrium 
% average-over-time-and-over-tags tag frequency. We obtain it in three
% steps.
tagfreqs = sum(pop(:,1,:,round(T/2): T));
propgens = 1/numel(round(T/2): T);
avgtagfreq(cur_r,cur_theta) = sum(sum((tagfreqs.^2) .* propgens));

% The poly matrix gives the equilibrium polymorphism. We obtain it in two
% further steps.
tagavgtime = mean(tagfreqs,4); 
poly(cur_r,cur_theta) = sqrt(sum(tagavgtime.*((tagavgtime - avgtagfreq(cur_r,cur_theta)).^2))); %  avg deviation of 'avg tag freq over time' from mean (measures polymorpshim - tag divergence)

% The fluc matrix gives the equilibrium fluctuation.
fluc(cur_r,cur_theta) = sqrt(sum(sum(propgens.*tagfreqs.*((tagfreqs- tagavgtime).^2)))); % avg distance of tag from its 'over time mean freq' (measures oscillation)

% This deletes the matrices that we defined in intermediary steps to 
% calculate our summary statistics. 
clear tagfreqs propgens tagavgtime

end
end