clc       %Limpiar el panel de trabajo
clear     %Borra Memoria
close all %Cerrar Ventanas

%Constantes del Problema - Utilizar un modelo que sea funcinal
%Recomendable que sea un Grashoff de Clase 1
%Los ángulos se dan radianes siempre que estén fuera de una función
%trigonométrica
r1=5;
r2=3;
r3=6;
r4=5;
phi1=0.2;

%Variables de Cinemática
phi20=0;
omega20=1;
alpha20=0;

q=[0.2;
   0.7;    %Semilla (Vector q)
   1.2];   %Se ve más como un vector columna

contador=0;

for t=0:0.1:7    %Tiempo
    contador=contador+1;
    tol=100;   
    iter=0;    
    while tol>1e-7 && iter<100
        iter=iter+1;
        %Por lo general lo único que cambia es la ecuación de cierre (Fq)
        %y el Jacobiano (J) según el ejercicio.
        Fq=[-r1*cos(phi1)+r2*cos(q(1))+r3*cos(q(2))-r4*cos(q(3));
            -r1*sin(phi1)+r2*sin(q(1))+r3*sin(q(2))-r4*sin(q(3));
            q(1)-phi20-omega20*t-0.5*alpha20*t^2];

        J=[-r2*sin(q(1)), -r3*sin(q(2)), r4*sin(q(3));
            r2*cos(q(1)), r3*cos(q(2)), -r4*cos(q(3));
            1, 0, 0];

        qi=-inv(J)*Fq+q;   %Newton Raphson
        tol=norm(Fq,2);     %Verifica si es cercano a cero (0)
        q=qi;              %Actualiza el valor de "q"
    end
    
    if iter>=99
        disp('No hubo convergencia')
    end
    
    %q=mod(q,2*pi);      %Si "q" supera 2pi (360) numericamente
                         % lo deja dentro del intervalo [0, 360]

    P(:,contador)=q;     %Matriz Histórica de Posición

    %Cálculo de Velocidad
    v=-inv(J)*[0; 0; -omega20-alpha20*t];
    V(:,contador)=v;     %Matriz Histórica de Velocidad
    
    %Cálculo de la Aceleración
    Jp=[-r2*cos(q(1))*v(1), -r3*cos(q(2))*v(2), r4*cos(q(3))*v(3);
        -r2*sin(q(1))*v(1), -r3*sin(q(2))*v(2), r4*sin(q(3))*v(3);
        0, 0, 0];
    
    phi_t_pp=[0;0;-alpha20];
    a=-inv(J)*(Jp*v+phi_t_pp);
    Ac(:,contador)=a;      %Matriz Histórica de Aceleración
end


VarNames=["Posiciones del Sistema"];
Tabla=table(P','VariableNames',VarNames);

Nombre='Solución Newton-Raphson.xlsx';
writetable(Tabla,Nombre,'Sheet',1)
