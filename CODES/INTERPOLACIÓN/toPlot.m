function a = toPlot(x_data, Coef, color)

[s, z] = size(Coef);
xx = x_data;
dx = (x_data(end) - x_data(1))/1000;
x = x_data(1):dx:x_data(end);

if s == 1 || z == 1
    
    y = zeros(size(x));
    
    for i = 0:length(Coef)-1
        y = y + Coef(length(Coef) - i)*x.^i;
    end
    
else
    
    y = [];
    xa1 = x(x >= x_data(1) & x <= x_data(2));
    x_data = [x_data 0];
    
    for i = 1:s
        
        a1 = zeros(size(xa1));
        
        for j = 0:z-1
            
            a1 = a1 + Coef(i, z - j)*xa1.^j;
            
        end
        
        y = [y a1];
        xa1 = x(x > x_data(i+1) & x <= x_data(i+2));
        
    end
    
end

a = plot(x, y, color);
hold on
y_data = zeros(size(xx));
for i = 1:length(xx)
    y_data(i) = y(length(x(x<=xx(i))));
end
a = plot(xx, y_data, 'o');
end

