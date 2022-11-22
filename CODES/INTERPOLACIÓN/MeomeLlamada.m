clc
clear
close all
x = input("Porfavor escribir el vector de valores en x: ") %[1740 2620 3395 4173 4974 5766]
y = input("Porfavor escribir el vector de valores en y: ") %[560 1017 1572 2273 3146 4158]
xval = input("Porfavor escribir el Dato que desea interpolar: ") %4647
[Tabla] = Newtonint(x,y)
[pol] = (Newtonor(x,diag(Tabla,+1)))
xpol=x(1):0.001:x(end);
ypol = zeros(size(xpol));

for i = 1:length(pol)                     %Para crear el polinomio de forma automatica, tomar  
    ypol = ypol + pol(i)*xpol.^(length(pol)-i);  %la posicion de largo del vetor, y elevar a la x^n posicion menos 1 para asegura el correcto grado
end

figure(1)
plot(x,y, 'or',xpol,ypol,'b') 
yval = 0;
for i = 1:length(pol)                     %Para crear el polinomio de forma automatica, tomar  
    yval = yval + pol(i)*xval^(length(pol)-i);  %la posicion de largo del vetor, y evaluar a la x^n posicion menos 1 para asegura el correcto grado
                                                %y la evaluacion automatica
                                                % sin tener que hacer el
                                                % polinomio a mano
end
R = yval;
disp(R)

x_data = x;
Coef = pol;
toPlot(x_data, Coef, 'b')

writematrix(Tabla,'test.xlsx','Sheet',1);