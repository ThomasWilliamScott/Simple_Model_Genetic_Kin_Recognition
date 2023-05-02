% This script plots Fig. 4, which is a plot of cooperator proportion 
% (pSoT) against tag frequency (x), derived for the 'separation of
% timescales' model.

clearvars
close all
clc

% This loads the symbolic variables and expressions, including: csearch,
% alpha, theta, b, c, mu_Trait, w_SoT, etc.
load("Symbolic_Expressions.mat")

% This defines an array comprising the variables: csearch, alpha, theta, b,
% c, mu_Trait. 
variables = [csearch,  alpha,  theta,  b,       c,      mu      ];

% This array specifies particular numerical values for the variable array
% defined above.
data1S =     [0,       0,      0.2,    0.03,    0.01,    0.0005   ];

% This array specifies particular numerical values for the variable array
% defined above. It is the same as the previous numerical array ('data1S') 
% except that it assumes a lower mu_Trait value.
data2S =     [0,       0,      0.2,    0.03,    0.01,    0.00000001  ];

% We use hold so that we can plot two lines, one for each of the numerical
% data arrays defined above ('data1S','data2S'). Here, pSoT(2) is the
% helper proportion for the separation of timescales model, which we loaded
% from the 'Symbolic_Expressions.mat' file. 
hold on
fplot(vpa(subs(pSoT(2),variables,data1S)),[0,1],'LineWidth', 2, 'LineStyle','-','Color',[0, 0.4470, 0.7410]) % NB it is technically pSoT(2) that is pSoT
fplot(vpa(subs(pSoT(2),variables,data2S)),[0,1],'LineWidth', 2, 'LineStyle','--','Color',[0.8500, 0.3250, 0.0980]	) % NB it is technically pSoT(2) that is pSoT

% This plots a horizontal line, showing the helper proportion that would
% arise if the trait mutation rate were maximal.
yline(0.5,'LineWidth', 2, 'LineStyle','--','Color',[0.9290, 0.6940, 0.1250]	)
hold off

% The following lines are for formatting the plot.
ylim([0,1])
xlim([0,1])
set(gcf,'color','white')
box off
set(gca,'fontsize', 18)