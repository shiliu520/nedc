function a = acceleration_vs_time(t, time_boundaries, accelerations)
    % 定义各阶段的时间边界和对应的加速度
    % time_boundaries = [0; t_sample];
    % accelerations = [a_smaple(1); a_sample];

    % 初始化加速度输出为0（默认情况）
    a = 0;

    % 根据时间所处的区间来确定对应的加速度
    for i = 1:length(time_boundaries) - 1
        if t >= time_boundaries(i) && t < time_boundaries(i + 1)
            a = accelerations(i+1);
            break;  % 找到对应的区间后就退出循环
        end
    end
end