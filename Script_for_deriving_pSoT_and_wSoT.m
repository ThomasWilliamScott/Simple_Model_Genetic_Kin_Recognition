% This script derives p_SoT (helper proportion) and w_SoT (number of 
% juvenile offspring) as a function of tag frequency.

clearvars
close all
clc

% This defines the following symbolic (i.e., not numeric) variables
syms csearch alpha theta x p b c mu A psi L x1 p1 x2 p2 pbar;

% This is the expression for the competition term.
A = (b-c).*p.*((theta+(1-theta).*x)./(1-alpha.*(1-x).*(1-theta))) - csearch .* (alpha.*(1-x).*(1-theta))./(1-alpha.*(1-x).*(1-theta));

% This is the expression for the fitness of helpers using tag i.
wi1 = 1 + (-csearch.*alpha.*(1-x) .*(1-theta)  +     b.*(theta+(1-theta).* x.*p)-c.*(theta+(1-theta).*x)) ./(1-alpha.*(1-x).*(1-theta) ) -A;

% This is the expression for the fitness of defectors using tag i.
wi0 = 1 + (-csearch.*alpha.*(1-x).*(1-theta) +b.*((1-theta).*x.*p))./(1-alpha.*(1-x).*(1-theta) ) -A;

% This equation gives helper proportion after one time step, where each 
% time step occurs rapidly compared to a change in tag frequency 
% (separation of timescales). We set it equal to zero, which corresponds to
% the case where helper proportion is no longer changing (equilibrium).
eqn = (1-mu) .* p  .* (wi1) + mu .*(1-p) .* (wi0) - p == 0; 

% We derive pSoT as the helper proportion that arises at the point where
% helper proportion is no longer changing (equilibrium).
pSoT = simplify(solve(eqn,p));

% We derive w_SoT by substituting pSoT into the equation for tag 
% fitness. Note that tag fitness here is the expected number of juvenile 
% offspring, not the expected number of adult offspring (i.e., tag 
% fitness_juv), as we explain in the main text). Note also that there are
% technically two pSoT values, but only the second value makes sense (lies 
% between 0 and 1) - that is why we use pSoT(2) rather than pSoT(1) in the 
% substitution below. 
wSoT = simplify(1+(-csearch.*alpha.*(1-x).*(1-theta)+(b-c).*pSoT(2).*(theta+(1-theta).*x))./(1-alpha.*(1-x).*(1-theta) ) );

% This saves the symbolic expression for wSoT (as well as the other 
% expressions and variables defined in this script), to be loaded in other
% scripts. 
save("Symbolic_Expressions.mat")