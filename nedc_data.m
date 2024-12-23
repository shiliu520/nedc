%% cycle
%% pkg load dataframe;
%% pkg load io;
%% pkg load tablicious;
clc;

T = readtable('csv/nedc.csv','ReadVariableNames',true);
c = table2array(T);
nedc.start_velocity = c(:, 1);
nedc.end_velocity = c(:, 2);
nedc.acceleration = c(:, 3);
nedc.duration = c(:, 4);

%%nedc = readtable('nedc.csv');
duration_nedc = nedc.duration;
v_nedc = [0;nedc.end_velocity];
a_nedc = [0;nedc.acceleration];
sum(duration_nedc);
t_nedc = [0;cumsum(duration_nedc)];
v_nedc_sim = struct('signals', [], 'time',[]);
v_nedc_sim.signals.values = v_nedc;
v_nedc_sim.signals.dimensions = 1;
% v_nedc_sim.time = t_nedc;
figure(2);
plot(t_nedc, v_nedc,'b');
figure(3);
plot(t_nedc, a_nedc,'r');

%%udc = readtable('udc.csv');
%%duration_udc = udc.duration;
%%sum(duration_udc)

%%eudc = readtable('eudc.csv');
%%duration_eudc = eudc.duration;
%%sum(duration_eudc)

track_t = t_nedc(t_nedc>=585)-585;
track_v = v_nedc(t_nedc>=585);
track_a = a_nedc(t_nedc>=585);
figure(4);
plot(track_t, track_v, 'k');


dt = 1e-6;
t_sample =cumsum(nedc.duration);
t_sample_minus = t_sample - dt;
t_sample = reshape([t_sample_minus, t_sample]', [], 1);
a_sample = reshape([nedc.acceleration, nedc.acceleration]', [], 1);
t_sample = [0; t_sample];
a_sample = [a_sample; a_sample(end)];
sim('nedc_cycle.slx');
figure(5); hold on;
plot(t_nedc, v_nedc,'b', 'linewidth', 1.5);
plot(t_sim, v_sim, 'k', 'linewidth', 1.5);
legend('nedc\_original\_vel', 'nedc\_acc\_integral\_vel');
xlabel('time/[s]');
ylabel('velocity/[km/h]');
box on;
figure(5);
