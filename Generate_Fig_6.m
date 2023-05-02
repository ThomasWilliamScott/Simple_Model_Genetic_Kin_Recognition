% This figure plots Figure 6, which is the summary figure, showing when
% genetic kin recognition evolves in the full model when theta and r vary.
% Technically, the figure generated here is not actually the version of the
% figure that features in the main text. The final figure is made by
% manipulating this one in powerpoint.

close all
clc
clearvars

% SPECIFY PARAMETER VALUES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tag=10; % L_max (tag availability).
csearch=0.0001; % cost of abandoning a social partner for a new encounter.
mu=0.0005; % trait mutation rate. 
tagSkewIni=0.9; % Initial frequency of the most abundant tag (the remaining 1-tagSkewIni is randomly distributed to the remaining 1-L_max tags).
b=0.3; % benefit of help.
c=0.1; % cost of help.
helpini=0.1; % initial population helper frequency.
T=100000; % number of generations each trial is run for.
alpha=1; % partner search potential.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This loads the data that was already generated for our specified
% parameter values. The data was generated using the
% 'Script_for_generating_heatmap_data.m' script.
load("Tag = "+tag+". T = "+T+". csearch = "+csearch+". alpha = "+alpha+". mu = "+mu+". tagSkewIni = "+tagSkewIni+". b = "+b+". c = "+c+". helpini = "+helpini+" .mat")

% This sets n/a for any entries that contain complex numbers (note that 
% complex mumbers appear in very few entries, and when they do, it has been 
% caused by rounding errors).
fluc(imag(fluc) ~= 0) = NaN;
poly(imag(poly) ~= 0) = NaN;

% We plot a heatmap, showing the number of tags segregating at equilibrium
% as a colour, and with recombination and population viscosity on the y and
% x axis respectively.
imagesc(thetaR,rR,1./avgtagfreq)

% This ensures that the y axis runs from low (bottom) to high (top).
set(gca,'YDir','normal')

% We add two white vertical lines to the heatmap. The first (left-hand) 
% line shows when kin discrimination is favoured over defection. The second 
% (right-hand) line shows when indiscriminate helping is favoured over
% defection.
hold on
line([c/(c-c*tag+tag*b),c/(c-c*tag+tag*(b))],[0,1],'color','w','Linestyle','-','LineWidth',1)
line([c/b,c/b],[0,1],'color','w','Linestyle','-','LineWidth',1) 
hold off

% The following lines are for formatting the plot.
axis([min(thetaR) max(thetaR) min(rR) max(rR)])
yspace=min(rR):max(rR)/5:max(rR);
yticks([yspace]);
yticklabels({yspace});
xspace = min(thetaR):max(thetaR)/5:max(thetaR);
xticks([xspace])
xticklabels({xspace})
set(gcf,'color','white')
set(gca,'fontsize', 18);
