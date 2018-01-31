clear all; close all;
vec1 = [];
vec2 = [];
vec3 = [];
vec4 = [];
vec5 = [];
for i=1:5
    % Plot for each trial must be saved before the next plot is
    % generated, otherwise it will be overwritten
    m = matfile('pvector','Writable',true);
    m.prec = [];
    m.trial = 0;
    cbirMP
    done = false;
    while length(m.prec)<3
        pause(0.5);
    end
    close all;
    pv = m.prec;
    if i == 1 vec1 = pv; end
    if i == 2 vec2 = pv; end
    if i == 3 vec3 = pv; end
    if i == 4 vec4 = pv; end
    if i == 5 vec5 = pv; end
end
for n=1:5
    x = [1 2 3];
    hold on;
    plot(x,vec1);
    plot(x,vec2);
    plot(x,vec3);
    plot(x,vec4);
    plot(x,vec5);
    legend('Monkey', 'Sunset', 'Horse' ,'Eagle', 'Elephant');
    title('Precision Vs Feedback Trial');
    xlabel('Trial #')
    ylabel('Precision')
    xlim([1 3]); ylim([0 1]); xticks([1:3]); grid on;   
end