%% Hoop Truss Deployable Mechanism Visualization (Reproduction of Fig. 28)
% Author: Dr. Asad Mirza
% Affiliation: Assistant Research Professor, Biomedical Engineering,
% Florida International University
% Date: July 28, 2025
%
% Description:
% This MATLAB script reproduces Figure 28 from the paper:
%
% Bo Han, Yundou Xu, Jiantao Yao, Dong Zheng, Xiaoyu Guo, Yongsheng Zhao;
% Configuration synthesis of hoop truss deployable mechanisms for space
% antenna based on screw theory. AIP Advances 1 August 2019; 9 (8): 085201.
% https://doi.org/10.1063/1.5115219
%
% The figure illustrates the deployment process of a hoop truss mechanism
% composed of scissor-like (7R) units. These mechanisms are widely used in
% aerospace engineering, particularly in deployable satellite antennas.
%
% Key Features:
% - Simulates the progressive deployment of a circular hoop truss structure.
% - Models structural components: upper/lower hoops, center joints, verticals,
%   scissor arms, and diagonal braces.
% - Supports two visualization modes:
%     1. **Static Mode** – Displays snapshots at user-defined folding angles (ϕ),
%        e.g., folded, partially deployed, and fully deployed.
%     2. **Animation Mode** – Animates continuous deployment from folded to fully deployed.
%
% Usage:
% - Set `mode = "static"` to plot specific deployment states.
%     - Adjust `num_states` to control the number of snapshots.
% - Set `mode = "animation"` to visualize the full deployment sequence.
%     - Adjust `num_frames` to control the smoothness of the animation.
%
% This visualization provides geometric intuition into the deployment kinematics
% and mechanical symmetry of hoop-based deployable structures.

clear,clc,close all
%% ---------------- User Settings ----------------
% mode = "static";         % Options: "animation" or "static"
mode = "animation";         % Options: "animation" or "static"
num_states = 3;          % If static: number of ϕ snapshots (e.g., 3 for closed, partial, open)
num_frames = 50;         % If animation: number of frames in animation

%% ---------------- Parameters -------------------
n = 12;                  % Number of scissor units
L_unit = 400;            % Fully deployed chord length
H_hoop = 800;            % Height
a = 282.84;              % Scissor arm length

z_upper = H_hoop;
z_lower = 0;

% Define range of folding angle ϕ (radians)
phi_start = pi/12;       % Folded (≈15°)
phi_end = pi/2;          % Fully deployed (90°)

if mode == "static"
    phi_vals = linspace(phi_start, phi_end, num_states);
elseif mode == "animation"
    phi_vals = linspace(phi_start, phi_end, num_frames);
else
    error('Invalid mode. Use "animation" or "static".');
end

%% ---------------- Visualization ----------------
if mode == "static"
    figure('Color','w', 'Position', [100, 100, 500*num_states, 500]);
else
    figure('Color','w', 'Position', [100, 100, 500, 500]);
end

for idx = 1:length(phi_vals)
    phi = phi_vals(idx);
    L_cur = 2 * a * sin(phi);
    R_cur = L_cur / (2 * sin(pi/n));
    
    % Node angles and positions
    theta = linspace(0, 2*pi, n+1); theta(end) = [];
    x_nodes = R_cur * cos(theta);
    y_nodes = R_cur * sin(theta);
    z_nodes_upper = z_upper * ones(1, n);
    z_nodes_lower = z_lower * ones(1, n);

    % Compute scissor center joints
    x_centers = zeros(1, n);
    y_centers = zeros(1, n);
    for i = 1:n
        i1 = i; i2 = mod(i, n) + 1;
        mid_x = (x_nodes(i1) + x_nodes(i2)) / 2;
        mid_y = (y_nodes(i1) + y_nodes(i2)) / 2;
        dir_vec = [mid_x, mid_y];
        dir_unit = dir_vec / max(norm(dir_vec), eps);
        h = sqrt(max(a^2 - (L_cur/2)^2, 0));
        x_centers(i) = mid_x - h * dir_unit(1);
        y_centers(i) = mid_y - h * dir_unit(2);
    end

    % Plot
    if mode == "static"
        subplot(1, num_states, idx);
        linkaxes
        title(sprintf('\\phi = %.0f^\\circ', rad2deg(phi)), 'FontWeight','bold');
    else
        figure(1); clf;
    end
    hold on; grid on; axis equal; axis square
    view(-37.5, 30);
    xlabel('X'); ylabel('Y'); zlabel('Z');
    
    % Hoop nodes
    plot3(x_nodes, y_nodes, z_nodes_upper, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'r');
    plot3(x_nodes, y_nodes, z_nodes_lower, 'bo', 'MarkerSize', 4, 'MarkerFaceColor', 'b');

    % Center joints
    plot3(x_centers, y_centers, z_upper*ones(1,n), 'go', 'MarkerSize', 4, 'MarkerFaceColor', 'g');
    plot3(x_centers, y_centers, z_lower*ones(1,n), 'mo', 'MarkerSize', 4, 'MarkerFaceColor', 'm');

    % Scissor arms and verticals
    for i = 1:n
        next = mod(i, n) + 1;
        plot3([x_nodes(i), x_centers(i)], [y_nodes(i), y_centers(i)], [z_upper, z_upper], 'k', 'LineWidth', 2);
        plot3([x_nodes(next), x_centers(i)], [y_nodes(next), y_centers(i)], [z_upper, z_upper], 'k', 'LineWidth', 2);
        plot3([x_nodes(i), x_centers(i)], [y_nodes(i), y_centers(i)], [z_lower, z_lower], 'k', 'LineWidth', 2);
        plot3([x_nodes(next), x_centers(i)], [y_nodes(next), y_centers(i)], [z_lower, z_lower], 'k', 'LineWidth', 2);
        plot3([x_nodes(i), x_nodes(i)], [y_nodes(i), y_nodes(i)], [z_lower, z_upper], 'b', 'LineWidth', 1.5);
    end

    % Diagonal braces
    for i = 1:n
        prev = mod(i-2, n) + 1;
        plot3([x_nodes(i), x_centers(prev)], [y_nodes(i), y_centers(prev)], [z_upper, z_lower], 'r', 'LineWidth', 1.5);
        plot3([x_nodes(i), x_centers(prev)], [y_nodes(i), y_centers(prev)], [z_lower, z_upper], 'r', 'LineWidth', 1.5);
    end

    % Upper and lower hoop
    plot3([x_nodes, x_nodes(1)], [y_nodes, y_nodes(1)], z_upper*ones(1,n+1), 'k--');
    plot3([x_nodes, x_nodes(1)], [y_nodes, y_nodes(1)], z_lower*ones(1,n+1), 'k--');

    xlim(1.5*[-R_cur, R_cur]);
    ylim(1.5*[-R_cur, R_cur]);
    zlim([z_lower, z_upper*1.5]);

    % Add phi label
    if mode == "animation"
        text(-1.4*R_cur, 1.4*R_cur, 1.2*z_upper, ...
             sprintf('\\phi = %.1f^\\circ', rad2deg(phi)), ...
             'FontSize', 14, 'FontWeight', 'bold', ...
             'BackgroundColor', 'w', 'Margin', 3, 'EdgeColor', 'k');
        drawnow;
    end

    exportgraphics(gca,"AnimatedTruss.gif","Append",true)
end
