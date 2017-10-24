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

TTL = 3.3;
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
v0 = v0 + n_acc.*acc;
v_lin = h    + v0.*t_lin;
% v_lin = slope;
v0 = v0;
v_dec = -h    + v0.*t_acc - 0.5*acc.*t_acc.^2;
% plot(t_exp, [v_acc, v_lin, v_dec])
%% flyback
back_acc = Vamp * 2 / (delayAfter/2)^2;
t_back_acc = 0:tick:(delayAfter/2 - tick);

v0 = 0;
v_back_acc = -Vamp - v0*t_back_acc + t_back_acc.^2 * back_acc * 0.5;
v0 = v0 + back_acc * delayAfter/2;
v_back_dec = Voffset + v0*t_back_acc - t_back_acc.^2 * back_acc * 0.5;
% y(61) = 0;
% y(62:121) = -1 * y(60:1);
% plot(t_delay, [v_back_acc, v_back_dec])

%%
t = 0:tick:(exp + delayAfter - tick);
subplot(3,1,3)
galvo = [v_acc, v_lin, v_dec, v_back_acc, v_back_dec];
t = [t-exp-delayAfter, t, t+exp+delayAfter];
% galvo
% plot(t, repmat(galvo, 1,3))
% ylim([-0.6, 0.6])

%% camera
cam_exp = ones(size(t_exp)) * TTL;
cam_delay = zeros(size(t_delay));
% subplot(3,1,1)
% plot(t, repmat([cam_exp, cam_delay], 1, 3))
% ylim([0, 1.2])

%% laser digital
l_acc = zeros(size(t_acc));
l_lin = ones(size(t_lin)) * TTL;
l_dec = l_acc;
l_delay = zeros(size(t_delay));
% subplot(3,1,2)
% plot(t, repmat([l_acc, l_lin, l_dec, l_delay], 1, 3))
% ylim([0, 1.2])

%%
traces = [
        repmat([cam_exp, cam_delay], 1, 3);
        repmat([l_acc, l_lin, l_dec, l_delay], 1, 3);
        repmat(galvo, 1,3)];
    
ylims = [-TTL*0.2, TTL*1.2; -TTL*0.2, TTL*1.2; -0.7, 0.7];
titles = {'camera', 'laser', 'scanner'};
ytickss = { [0, TTL],
            [0, TTL],
            [-Vamp, 0, Vamp]};
lines = [0, n_acc, n_acc+n_lin, exp, exp+delayAfter];
colors = {'r', [0,0.7,0], [0,0.7,0], 'r', 'r'};
ylabels = {'V_{cam} [V]', 'V_{las} [V]', 'V_{scan} [V]'};

for i =1:3
    subplot(3,1,i)
    hold off
    plot(t,traces(i,:),'lineWidth',1.5)
    hold on
    for j = 1:length(lines)
        plot([lines(j), lines(j)], [-20, 20], ':', 'lineWidth', 1, 'color', colors{j})
    end
    
    title(titles(i))
    pad = 2;
    xlim([-pad, exp+delayAfter+pad])
    ylim(ylims(i,:))
    yticks(ytickss{i})
    ylabel(ylabels(i));
    if i == 3
        xlabel('time (ms)')
%         yticklabels({'-V_{amp}', '0', 'V_{amp}'})
    end
end

subplot(3,1,1)
text(56, TTL*0.15, 'delay', 'HorizontalAlignment', 'center')
text(25, TTL*0.9, 'exposure', 'HorizontalAlignment', 'center')

subplot(3,1,3)
text(2.5, 0.4, 'acc.', 'HorizontalAlignment', 'center')
text(50-2.5, -0.3, 'dec.', 'HorizontalAlignment', 'center')
text(25, 0.2, 'linear', 'HorizontalAlignment', 'center')
text(55, -0.3, 'return', 'HorizontalAlignment', 'left')

set(gcf, 'color', 'w')

