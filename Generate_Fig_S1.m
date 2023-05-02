% This script plots Supplementary Figures 1 a - e. These plots show all
% data obtained for the full model. They plot fluc*, poly*, coop* and L*,
% for different values of r and theta. They also plot tag frequencies 
% across time for illustrative single trials.

close all
clearvars
clc

% This parameter specifies how many generations the the illustrative single
% trials are plotted for.
Tsingle = 20000; 

% Specifies the initial frequency of one tag. The remaining 1-tagSkewIni is
% randomly distributed amongst the remaining tags.
tagSkewIni = 0.9; 

% Initial frequency of the helping allele.
helpini = 0.1; 

% This loops over 5 'parts'. Here, parts 1 - 5 correspond to Figs S1 a - e.
for part = 1:5

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The following if statements serve to assign parameter values. The if
% statements are required so that each 'part' plots data for different
% parameter values.

if part == 5
tag=2;
else
tag=100;
end

if part == 2 || part == 4 || part == 5
csearch = 0.0001;
else
csearch = 0;
end

if part == 3
alpha=0;
else
alpha=1;
end

if part == 4
mu=0.002;
else
mu=0.0005;
end

if part==3
b=3;
c=1;
else
b=0.3;
c=0.1;
end

% This parameter specifies how many generations the the heatmap trials are 
% recorded for.
T = 100000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This loads up the data generated for the specified parameter values. The
% data was generated using the 'Script_for_generating_heatmap_data.m'
% script.
load("Tag = "+tag+". T = "+T+". csearch = "+csearch+". alpha = "+alpha+". mu = "+mu+". tagSkewIni = "+tagSkewIni+". b = "+b+". c = "+c+". helpini = "+helpini+" .mat")

% The following 2 lines ensure that any complex numbers are converted to
% n/a. We note that complex numbers occasionally arose due to rounding
% errors (rather than due to some coding error).
fluc(imag(fluc) ~= 0) = NaN;
poly(imag(poly) ~= 0) = NaN;

% The following if statement specifies values for thetas and rs. These
% respectively give the theta (population viscosity) and r (recombination)
% values assumed in the illustrative single trials. 
if part == 1 || part == 3 
thetas = 0.1;
rs=0.1;
elseif part==2
thetas = 0.1;
rs=0.3;
elseif part==4
thetas = 0.05;
rs=0.4;    
elseif part == 5
thetas = 0.3;
rs=0.3;
end

% A) TAG NUMBER PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This specifies that the first subplot out of five is about to be plotted. 
figure
subplot(5,1,1) 

% This plots L* as a heatmap, where theta and r vary across the x and y
% axes.
imagesc(thetaR,rR,1./avgtagfreq)

% This flips the heatmap so that the y axis runs from low (bottom) to high
% (top).
set(gca,'YDir','normal')

% We add two vertical white lines to the plot. The first (left-hand) line
% shows where genetic kin recognition is favoured over defection. The
% second (right-hand) line shows where indiscriminate helping is favoured
% over defection.
hold on
line([c/(c-c*tag+tag*b),c/(c-c*tag+tag*(b))],[0,1],'color','w','Linestyle','-','LineWidth',1) 
line([c/b,c/b],[0,1],'color','w','Linestyle','-','LineWidth',1)
hold off

% This adds a rectangle to highlight the position in the heatmap where the
% illustrative single trial is taken from.
rectangle('Position',[thetas(1) - (( thetaR(end)-thetaR(1) ) / (numel(thetaR)-1))/2  , rs(1) - (( rR(end)-rR(1) ) / (numel(rR)-1))/2 , ( thetaR(end)-thetaR(1) ) / (numel(thetaR)-1) , ( rR(end)-rR(1) ) / (numel(rR)-1)],'EdgeColor','r','LineWidth',1)

% The following lines add and format a colorbar (i.e. a legend for the 
% heatmap).
colorbar
caxis([1 tag]);
colorbar('Ticks',[1,1+(tag-1)/2,tag])

% The following lines are for formatting
set(gcf,'color','white')
axis([min(thetaR) max(thetaR) min(rR) max(rR)])
yspace=min(rR):max(rR)/5:max(rR);
yticks([yspace]);
yticklabels({yspace});
xspace = min(thetaR):max(thetaR)/5:max(thetaR);
xticks([xspace])
xticklabels({xspace})

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% B) POLYMORPHISM PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This specifies that the second subplot out of five is about to be 
% plotted. 
subplot(5,1,2) 

% This plots poly* as a heatmap, where theta and r vary across the x and y
% axes.
imagesc(thetaR,rR,poly)

% This flips the heatmap so that the y axis runs from low (bottom) to high
% (top).
set(gca,'YDir','normal')

% We add two vertical white lines to the plot. The first (left-hand) line
% shows where genetic kin recognition is favoured over defection. The
% second (right-hand) line shows where indiscriminate helping is favoured
% over defection.
hold on
line([c/(c-c*tag+tag*b),c/(c-c*tag+tag*(b))],[0,1],'color','w','Linestyle','-','LineWidth',1) 
line([c/b,c/b],[0,1],'color','w','Linestyle','-','LineWidth',1) 
hold off

% This adds a rectangle to highlight the position in the heatmap where the
% illustrative single trial is taken from.
rectangle('Position',[thetas(1) - (( thetaR(end)-thetaR(1) ) / (numel(thetaR)-1))/2  , rs(1) - (( rR(end)-rR(1) ) / (numel(rR)-1))/2 , ( thetaR(end)-thetaR(1) ) / (numel(thetaR)-1) , ( rR(end)-rR(1) ) / (numel(rR)-1)],'EdgeColor','r','LineWidth',1)

% The following lines add and format a colorbar (i.e. a legend for the 
% heatmap).
colorbar
caxis([0 1]);
colorbar('Ticks',[0,0.5,1]);

% The following lines are for formatting
axis([min(thetaR) max(thetaR) min(rR) max(rR)])
yspace=min(rR):max(rR)/5:max(rR);
yticks([yspace]);
yticklabels({yspace});
xspace = min(thetaR):max(thetaR)/5:max(thetaR);
xticks([xspace])
xticklabels({xspace})

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% C) FLUCTUATION PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This specifies that the third subplot out of five is about to be plotted. 
subplot(5,1,3) 

% This plots fluc* as a heatmap, where theta and r vary across the x and y
% axes.
imagesc(thetaR,rR,fluc)

% This flips the heatmap so that the y axis runs from low (bottom) to high
% (top).
set(gca,'YDir','normal')

% We add two vertical white lines to the plot. The first (left-hand) line
% shows where genetic kin recognition is favoured over defection. The
% second (right-hand) line shows where indiscriminate helping is favoured
% over defection.
hold on
line([c/(c-c*tag+tag*b),c/(c-c*tag+tag*(b))],[0,1],'color','w','Linestyle','-','LineWidth',1) 
line([c/b,c/b],[0,1],'color','w','Linestyle','-','LineWidth',1) 
hold off

% This adds a rectangle to highlight the position in the heatmap where the
% illustrative single trial is taken from.
rectangle('Position',[thetas(1) - (( thetaR(end)-thetaR(1) ) / (numel(thetaR)-1))/2  , rs(1) - (( rR(end)-rR(1) ) / (numel(rR)-1))/2 , ( thetaR(end)-thetaR(1) ) / (numel(thetaR)-1) , ( rR(end)-rR(1) ) / (numel(rR)-1)],'EdgeColor','r','LineWidth',1)

% The following lines add and format a colorbar (i.e. a legend for the 
% heatmap).
colorbar
caxis([0 1]);
colorbar('Ticks',[0,0.5,1]);

% The following lines are for formatting
set(gca,'YDir','normal')
axis([min(thetaR) max(thetaR) min(rR) max(rR)])
yspace=min(rR):max(rR)/5:max(rR);
yticks([yspace]);
yticklabels({yspace});
xspace = min(thetaR):max(thetaR)/5:max(thetaR);
xticks([xspace])
xticklabels({xspace})

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% D) HELPER FREQUENCY PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This specifies that the fourth subplot out of five is about to be 
% plotted. 
subplot(5,1,4) 

% This plots coop* as a heatmap, where theta and r vary across the x and y
% axes.
imagesc(thetaR,rR,resalt)

% This flips the heatmap so that the y axis runs from low (bottom) to high
% (top).
set(gca,'YDir','normal')

% We add two vertical white lines to the plot. The first (left-hand) line
% shows where genetic kin recognition is favoured over defection. The
% second (right-hand) line shows where indiscriminate helping is favoured
% over defection.
hold on
line([c/(c-c*tag+tag*b),c/(c-c*tag+tag*(b))],[0,1],'color','w','Linestyle','-','LineWidth',1) 
line([c/b,c/b],[0,1],'color','w','Linestyle','-','LineWidth',1) 
hold off

% This adds a rectangle to highlight the position in the heatmap where the
% illustrative single trial is taken from.
rectangle('Position',[thetas(1) - (( thetaR(end)-thetaR(1) ) / (numel(thetaR)-1))/2  , rs(1) - (( rR(end)-rR(1) ) / (numel(rR)-1))/2 , ( thetaR(end)-thetaR(1) ) / (numel(thetaR)-1) , ( rR(end)-rR(1) ) / (numel(rR)-1)],'EdgeColor','r','LineWidth',1)

% The following lines add and format a colorbar (i.e. a legend for the 
% heatmap).
colorbar
caxis([0 1]);
colorbar('Ticks',[0,0.5,1])

% The following lines are for formatting
axis([min(thetaR) max(thetaR) min(rR) max(rR)])
yspace=min(rR):max(rR)/5:max(rR);
yticks([yspace]);
yticklabels({yspace});
xspace = min(thetaR):max(thetaR)/5:max(thetaR);
xticks([xspace])
xticklabels({xspace})

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% E) ILLUSTRATIVE SINGLE TRIALS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Here, we run a single illustrative trial at the theta and r values
% specified by thetas and rs. We run the trial for Tsingle generations.

% This specifies that the fifth subplot out of five is about to be 
% plotted. 
subplot(5,1,5) 

% This sets the T, theta and r values for the illustrative trial.
T = Tsingle ;
theta = thetas;
r = rs;

% We define this empty array, which we will fill with the frequency of each
% tag, recorded in each generation.
tagfreqs=zeros(tag,T);

% This initialises the population genotype frequencies with the same intial
% genotype freqeuncies that the heatmap data were generated with.
pop = zeros(2,4,tag,T+1);
pop(:,:,:,1) = popIni;
pop(2,2,:,:) = 1; 

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

% This plots tag frequencies over generations for the illustrative trial.
hold on
for l=1:tag
plot(1:T,tagfreqs(l,:))
end
hold off

% This is for formatting the plot.
xlim([1 T])
ylim([0 1])

end
