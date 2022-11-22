clc
clear
close all

x = input("Porfavor escribir el vector de valores en x: ") %[1740 2620 3395 4173 4974 5766]
y = input("Porfavor escribir el vector de valores en y: ") %[560 1017 1572 2273 3146 4158]
typ = input("Porfavor escribir '1' para ejecutar con Spline lineal, '2' para ejecutar con spline Cuadrada, O '3' para ejecutar con Spline Cubica: ")
Tabla = Spline(x,y,typ)
% se creo el codigo con el proposito de que reconozca el correcto intervalo en el que se debe evaluar el punto a encontrar,
% y que reconozca las posiciones de cada splines o trazadores, para evaluar en ellas
kkk =input("Porfavor escribir el Dato que desea interpolar: ") %4647
for i = 1:length(x)-1
    if kkk <= x(i+1) && kkk >= x(i) %reconocer el intervalo
        pol = Tabla(i,:); % posicones en la tbala de todos los valores
        break
    end
end

xval = kkk; yval = 0;
for i = 1:length(pol)                       
    yval = yval + pol(i)*xval^(length(pol)-i);  
end

for i = 1:length(x)-1
p(i) = poly2sym(Tabla(i,:));
end

R = yval;
disp(R)


p = vpa(p, 5)

x_data = x;
Coef = Tabla;
toPlot(x_data, Coef, 'b')

writematrix(Coef,'TestSpline.xlsx','Sheet',1);