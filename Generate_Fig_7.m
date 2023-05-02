% This script generates Figure 7. This figure illustrates the summary 
% statistics (fluctuation, polymorphism, etc.) in a single trial.

close all
clearvars
clc

% SPECIFY PARAMETER VALUES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tag=2; % L_max (tag availability).
csearch=0; % cost of abandoning a social partner for a new encounter.
mu=0.0005; % trait mutation rate. 
tagSkewIni=0.999; % Initial frequency of the most abundant tag (the remaining 1-tagSkewIni is randomly distributed to the remaining 1-L_max tags).
b=3; % benefit of help.
c=1; % cost of help.
helpini=0.1; % initial population helper frequency.
T=4000; % number of generations each trial is run for.
alpha=0; % partner search potential.
r=0.26; % recombination rate.
theta=0.22; % poulation viscosity.
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

% We define a 4D matrix 'pop', which we use to track genotype frequencies.
% In pop, column 1 gives genotype frequency at the start of the generation.
% Column 2 gives helper ID (1 for helpers; 0 for defectors). Column 3 gives
% the genotype frequency just after selection but before recombination. 
% Column 4 gives genotype frequency just after recombination but before 
% mutation. Row 1 stores data for nonhelper genotypes, and row 2 stores 
% data for helper genotypes. The third dimension specifies the tag (meaning
% there are L_max entries). The fourth dimension specifies the generation 
% (meaning there are T entries).  
pop = zeros(2,4,tag,T+1);

% We populate the "first generation" entries of pop, using the popIni
% matrix that we just used to specify our initial genotype freqeunceis.
pop(:,:,:,1) = popIni;
pop(2,2,:,:) = 1;

% We define the following array, which we will use to track the freqeuncy
% of each tag across every generation.
tagfreqs = zeros(tag,T);

% This loops over all 'T' generations.
for t=1:T

% We populate the tagfreqs array with the freqeuncy of each tag in this
% generation.
tagfreqs(:,t) =   reshape(sum(pop(:,1,:,t)),[tag,1]);

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

% We plot the frequency of each tag across all generations of the trial.
hold on
for l=1:tag
plot(1:T,tagfreqs(l,:))
end
hold off

% We intend to add lines showing the average-over-time-and-over-tags tag 
% frequency, as well as the average-over-time frequency of each tag. To do 
% so, we first record the frequency of each tag across each generation in 
% the second half of the trial: 
tagfreqs2nd = sum(pop(:,1,:,round(T/2): T));

% We can then calcuate the average frequency of each tag, taken across all
% generations in the second half of the trial. We then plot these
% average-over-time tag frequencies.
tagavgtime = mean(tagfreqs2nd,4); % average freq of each tag over time
yline(tagavgtime(1),'LineStyle','--','LineWidth',2,'Color',[0, 0.4470, 0.7410])
yline(tagavgtime(2),'LineStyle','--','LineWidth',2,'Color',[0.8500, 0.3250, 0.0980])

% We then caculate the number of generations that feature in the second 
% half of the trial, and take the inverse of this. 
propgens = 1/numel(round(T/2): T);

% We can then use tagfreqs2nd and propgens to calculate the
% average-over-time-and-over-tags tag frequency, which we plot.
avgtagfreq = sum(sum((tagfreqs2nd.^2) .* propgens));
yline(avgtagfreq,'LineStyle','--','LineWidth',2)

% We then calculate poly and fluc as follows. We do not plot these values,
% but we do cite them in the legend.
poly = sqrt(sum(tagavgtime.*((tagavgtime - avgtagfreq).^2))); %  avg deviation of 'avg tag freq over time' from mean (measures polymorpshim - tag divergence).
fluc = sqrt(sum(sum(propgens.*tagfreqs2nd.*((tagfreqs2nd- tagavgtime).^2)))); % avg distance of tag from its 'over time mean freq' (measures oscillation).

% The following lines are for formatting the plot.
xlim([1 T])
ylim([0 1])
set(gcf,'color','white')
box off
set(gca,'fontsize', 18)

