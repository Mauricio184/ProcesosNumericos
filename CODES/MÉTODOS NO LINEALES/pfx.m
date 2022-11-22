%Punto fijo: se ingresa el valor inicial (x0), la tolerancia del error (Tol) y el màximo nùmero de iteraciones (niter) 

function Tabla = pfx()
    syms x

    f=str2sym(input("Ingrese la función: ",'s'))
    g=str2sym(input("Ingrese la función g(x): ",'s'))
    bool=input("Ingrese 0 si desea DECIMALES CORRECTOS o 1 si requiere el resultado con CIFRAS SIGNIFICATIVAS");
    x0=input("Escribir valor de la condición incial: " )
    niter=input("Escribir el máximo número de iteraciones que permitirá: ")

    for i = 1:3
        if bool==0
        pq=input('Ingrese el número de DECIMALES CORRECTOS que desea');
        Tol=0.5*10^-pq;
        break
        elseif bool==1
        pq=input("Escriba el número de CIFRAS SIGNIFICATIVAS con las que quiere trabajar");
        Tol=5*10^-pq;
        break
        else
        disp("Error, operacion no reconocida.")
        end
    end


        c=0;
        fm(c+1) = eval(subs(f,x0)); %Ver el valor de la primera iteración de f
        fe=fm(c+1); %Valor dummy 
        Eabsoluto(c+1)=Tol+1;%guarda el error en la primera iteración, se inicializa la iteración poniendole un +1
        Erelativo(c+1)=Tol+1;
        error=Eabsoluto(c+1); %Coge el elemento actual del error y lo llama el error más actualizado 

        %Error inicial = tolerancia + 1
        xn(c+1)=x0; %Primera iteración de x
        N(c+1)=c; %Contador de las iteraciones, c empieza en cero 
        while error>Tol && fe~=0 && c<niter   %&& fe~=0  función a la cual le queremos encontrar la raíz evaluada en cero ya es cero, entonces ya tenemos la raíz
            xn(c+2)=eval(subs(g,x0));
            fm(c+2)=eval(subs(f,xn(c+2))); %Evaluar lo qu salga de g(x) en f(x) y si este último da cero ya terminamos 
            fe=fm(c+2);  %Actualiza el valor de fe
            Eabsoluto(c+2)=abs((xn(c+2)-x0)); 
            Erelativo(c+2)=abs((xn(c+2)-x0))/xn(c+2) %Error relativo 
             if bool==0
                 error=Eabsoluto(c+2)  %E(c)=EAbsoluto(c) porque no se pone E(c)
             else
                 error=Erelativo(c+2)
             end 
            x0=xn(c+2);
            N(c+2)=c+1;
            c=c+1;
        end

        if bool == 0
        ERROR = Eabsoluto;
        RAR = "Error Absoluto";
        R="DECIMALES CORRECTOS";
        else
        ERROR = Erelativo;
        RAR = "Error Relativo";
        R="CIFRAS SIGNIFICATIVAS";
        end


        VarNames = ["Iteración", "xi", "f(xi)", RAR]; %Nombre de las leyendas
        Tabla = table(N',xn',fm', ERROR','VariableNames', VarNames); %Valores
        writetable(Tabla,'MetododePuntoFijo_Tabla.xlsx','Sheet',R);

end