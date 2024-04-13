x = 0:100;
y = sin(x)
figure
plot(x, y)

for i = 1:5
    x = 0:pi/100:2*pi;
    y = sin(x*rand());

    % Figure must be included for multiple plots to work!
    figure
    plot(x,y)
end