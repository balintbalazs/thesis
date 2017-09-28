exp = 50;
delayAfter = 12;
% expTicks = 0:0.1:exp;
% delayAfterTicks = 0:0.1:delayAfter;
p = 0.2;

n_exp = exp;
n_acc = n_exp * p / 2;
n_lin = n_exp * (1-p);

Vamp = 0.5;
Voffset = 0;

h = (1-p)/(1-0.5*p)*Vamp;
acc = -(Vamp-h)*2/n_acc/n_acc;
slope = -2*h/n_lin;

%%
tick = 0.1;
t_acc = 0:tick:(n_acc-tick);
t_lin = 0:tick:(n_lin-tick);
t_exp = 0:tick:(n_exp-tick);
t_delay = 0:tick:(delayAfter-tick);
t = 0:tick:(exp+delayAfter-tick);

%%
v0 = 0;
v_acc = Vamp + v0.*t_acc + 0.5*acc.*t_acc.^2;
%%
v0 = v0 + n_acc.*acc;
v_lin = h    + v0.*t_lin;
% v_lin = slope;
%%
v0 = v0;
v_dec = -h    + v0.*t_acc - 0.5*acc.*t_acc.^2;
%%
plot(t_exp, [v_acc, v_lin, v_dec])
%% flyback
back_acc = Vamp * 2 / (delayAfter/2)^2;
t_back_acc = 0:tick:(delayAfter/2 - tick);

v0 = 0;
v_back_acc = -Vamp - v0*t_back_acc + t_back_acc.^2 * back_acc * 0.5;
v0 = v0 + back_acc * delayAfter/2;
v_back_dec = Voffset + v0*t_back_acc - t_back_acc.^2 * back_acc * 0.5;
% y(61) = 0;
% y(62:121) = -1 * y(60:1);
plot(t_delay, [v_back_acc, v_back_dec])

%%
t = 0:tick:(exp + delayAfter - tick);
plot(t, [v_acc, v_lin, v_dec, v_back_acc, v_back_dec])