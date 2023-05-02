% This scfript generates Fig. 5a, b & c, which plot w_SoT (number of 
% juvenile offspring, when helper proportion has evolved to p_SoT), as 
% functions of tag freqeuncy.

close all
clearvars
clc

% This loads the symbolic variables and expressions, including: csearch,
% alpha, theta, b, c, mu_Trait, w_SoT, etc.
load("Symbolic_Expressions.mat")

% This defines an array comprising the variables: csearch, alpha, theta, b,
% c, mu_Trait. 
variables = [csearch,alpha,  theta,  b,      c,      mu      ];

% The following arrays specify particular numerical values for the variable
% array defined above.

% The following 6 arrays store numerical values used to generate Fig. 5a.
data1a =     [0,       0,      0.1,    0.03,    0.01,    0.0001   ];
data2a =     [0,       0,      0.1,    0.03,    0.01,    0.000001  ];
data3a =     [0,       0,      0.25,   0.03,    0.01,    0.0001   ];
data4a =     [0,       0,      0.25,   0.03,    0.01,    0.000001  ];
data5a =     [0,       0,      0.5,    0.03,    0.01,    0.0001   ];
data6a =     [0,       0,      0.5,    0.03,    0.01,    0.000001  ];

% The following 6 arrays store numerical values used to generate Fig. 5b.
data1b =     [0.002,    1,      0.1,    0.03,    0.01,    0.0001   ];
data2b =     [0.002,    1,      0.1,    0.03,    0.01,    0.000001  ];
data3b =     [0.002,    1,      0.25,   0.03,    0.01,    0.0001   ];
data4b =     [0.002,    1,      0.25,   0.03,    0.01,    0.000001  ];
data5b =     [0.002,    1,      0.5,    0.03,    0.01,    0.0001   ];
data6b =     [0.002,    1,      0.5,    0.03,    0.01,    0.000001  ];

% The following 6 arrays store numerical values used to generate Fig. 5c.
data1c =     [0.0002,    1,      0.1,    0.03,    0.01,    0.0001   ];
data2c =     [0.0002,    1,      0.1,    0.03,    0.01,    0.000001  ];
data3c =     [0.0002,    1,      0.25,   0.03,    0.01,    0.0001   ];
data4c =     [0.0002,    1,      0.25,   0.03,    0.01,    0.000001  ];
data5c =     [0.0002,    1,      0.5,    0.03,    0.01,    0.0001   ];
data6c =     [0.0002,    1,      0.5,    0.03,    0.01,    0.000001  ];

% GENERATE FIGURE 4A (ALPHA=0) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We use hold so that we can plot several lines, one for each of the 
% numerical data arrays defined above ('data1a','data2a',etc). Here, wSoT 
% is the tag fitness for the separation of timescales model, which we 
% loaded from the 'Symbolic_Expressions.mat' file. 
figure
hold on
fplot(vpa(subs(wSoT,variables,data1a)),[0,1],'Color',[0, 0.4470, 0.7410],'LineStyle','--','ShowPoles','off') 
fplot(vpa(subs(wSoT,variables,data2a)),[0,1],'Color',[0, 0.4470, 0.7410],'ShowPoles','off') 
fplot(vpa(subs(wSoT,variables,data3a)),[0,1],'Color',[0.8500, 0.3250, 0.0980],'LineStyle','--','ShowPoles','off') 
fplot(vpa(subs(wSoT,variables,data4a)),[0,1],'Color',[0.8500, 0.3250, 0.0980],'ShowPoles','off') 
fplot(vpa(subs(wSoT,variables,data5a)),[0,1],'Color',[0.9290, 0.6940, 0.1250],'LineStyle','--','ShowPoles','off') 
fplot(vpa(subs(wSoT,variables,data6a)),[0,1],'Color',[0.9290, 0.6940, 0.1250],'ShowPoles','off')
hold off

% The following lines are for formatting the plot.
ylim([0.992,1.02])
set(gcf,'color','white')
box off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% GENERATE FIGURE 4B (ALPHA=1, HIGH CSEARCH) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We use hold so that we can plot several lines, one for each of the 
% numerical data arrays defined above ('data1b','data2b',etc). Here, wSoT 
% is the tag fitness for the separation of timescales model, which we 
% loaded from the 'Symbolic_Expressions.mat' file. 
figure
hold on
fplot(vpa(subs(wSoT,variables,data1b)),[0,1],'Color',[0, 0.4470, 0.7410],'LineStyle','--','ShowPoles','off')
fplot(vpa(subs(wSoT,variables,data2b)),[0,1],'Color',[0, 0.4470, 0.7410],'ShowPoles','off') 
fplot(vpa(subs(wSoT,variables,data3b)),[0,1],'Color',[0.8500, 0.3250, 0.0980],'LineStyle','--','ShowPoles','off') 
fplot(vpa(subs(wSoT,variables,data4b)),[0,1],'Color',[0.8500, 0.3250, 0.0980],'ShowPoles','off') 
fplot(vpa(subs(wSoT,variables,data5b)),[0,1],'Color',[0.9290, 0.6940, 0.1250],'LineStyle','--','ShowPoles','off') 
fplot(vpa(subs(wSoT,variables,data6b)),[0,1],'Color',[0.9290, 0.6940, 0.1250],'ShowPoles','off')
hold off

% The following lines are for formatting the plot.
ylim([0.992,1.02])
set(gcf,'color','white')
box off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% GENERATE FIGURE 4C (ALPHA=1, LOW CSEARCH) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We use hold so that we can plot several lines, one for each of the 
% numerical data arrays defined above ('data1c','data2c',etc). Here, wSoT 
% is the tag fitness for the separation of timescales model, which we 
% loaded from the 'Symbolic_Expressions.mat' file. 
figure
hold on
fplot(vpa(subs(wSoT,variables,data1c)),[0,1],'Color',[0, 0.4470, 0.7410],'LineStyle','--','ShowPoles','off') 
fplot(vpa(subs(wSoT,variables,data2c)),[0,1],'Color',[0, 0.4470, 0.7410],'ShowPoles','off') 
fplot(vpa(subs(wSoT,variables,data3c)),[0,1],'Color',[0.8500, 0.3250, 0.0980],'LineStyle','--','ShowPoles','off') 
fplot(vpa(subs(wSoT,variables,data4c)),[0,1],'Color',[0.8500, 0.3250, 0.0980],'ShowPoles','off') 
fplot(vpa(subs(wSoT,variables,data5c)),[0,1],'Color',[0.9290, 0.6940, 0.1250],'LineStyle','--','ShowPoles','off') 
fplot(vpa(subs(wSoT,variables,data6c)),[0,1],'Color',[0.9290, 0.6940, 0.1250],'ShowPoles','off') 
hold off

% The following lines are for formatting the plot.
ylim([0.992,1.02])
set(gcf,'color','white')
box off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
