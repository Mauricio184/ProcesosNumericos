%% Método de Regla Falsa

function Tabla= reglafalsax()
sym x
c=1;

    f=str2sym(input("Ingrese la función: ",'s'))
    xi=input("Escribir valor inferior: " )
    xs=input("Escribir el valor superior: ")
    %Tol=input("Escribir la tolerancia que desea manejar: ")
    niter=input("Escribir el máximo número de iteraciones que permitirá: ")
    for i = 1:3
        bool=input("Escriba 0 si quiere D.C, 1 si C.S: ")
        
        if bool==0
            pq = input("Escriba nùmero de decimales correctos: ");
            Tol = 0.5*10^-pq;
             R="DECIMALES CORRECTOS";
            break
        elseif bool==1
            pq = input("Escriba nùmero de cifras significativas: ");
            Tol = 5*10^-pq;
             R="DECIMALES CIFRAS SIGNIFICATIVAS";
            break
        else
            disp("Error, operacion no reconocida.")
        end
    end

    fi=eval(subs(f,xi)); %Función f evaluada en el valor inferior
    fs=eval(subs(f,xs)); %Función f evaluada en el valor superior
    if fi==0
        s=xi;
        E=0;
        fprintf('%f es raiz de f(x)',xi)
    elseif fs==0
        s=xs;
        E=0;
        fprintf('%f es raiz de f(x)',xs)

        %Si fi o fs evaluación de f en el valor superior o inferior son
        %iguales a cero ya tenemos la solución
    elseif fs*fi<0 %Si esto se cumple es porque una está arriba del eje x y otra por debajo
        c=0;
        xm(c+1)=(xi*fs-xs*fi)/(fs-fi); %Fórmula de regla falsa tal cual
       
        fm(c+1)=eval(subs(f,xm(c+1)));    
        fe=fm(c+1);    %Variable Dummy: Permite guardar memoria, se podría eliminar.

        E(c+1)=Tol+1; %Error Absoluto
        Er(c+1)=Tol+1;  %Relativo
        if bool == 0
            error=E(c+1);
        else
            error=Er(c+1);
        end

        while error>Tol && fe~=0 && c<niter
            if fi*fe<0
                xs=xm(c+1);
                fs=eval(subs(f,xs));
            else
                xi=xm(c+1);
                fi=eval(subs(f,xi));
            end
            xa=xm(c+1);
            if (fs-fi)==0
                disp("Error en el método, división por CERO no está matemáticamente definida")
                return
            end
            xm(c+2)=(xi*fs-xs*fi)/(fs-fi);  %De aqui en adelante si quisieramos almacenar xm le pondríamos xm(c+2)  %Con respecto al de bisección solo se cambió la linea 62
            fm(c+2)=eval(subs(f,xm(c+2)));
            fe=fm(c+2);
            E(c+2)=abs(xm(c+2)-xa);
            Er(c+2)=E(c+2)/abs(xm(c+2));
            if bool==0
                error=E(c+2);
            else
                error=Er(c+2);
            end
            c=c+1;
        end
        if fe==0
           s=xm; %xm(c+2)
           fprintf('%f es raiz de f(x)',xm(c+1)) 
        elseif error<Tol %Criterio de parada Optimista. En el criterio pesimista, el código nunca termina
           s=xm; %xm(c+2)
           fprintf('%f es una aproximación de una raiz de f(x) con una tolerancia= %f',xm(c+1),Tol)
            %en el primer %f se pone el valor de xm(c+1) y en el segundo %f la
            %tolerancia

           %fprint es similar a disp pero se le pueden meter varias
           %variables al mismo tiempo
        else 
           s=xm;      
           fprintf('Fracasó en %f iteraciones',niter) 
        end
    else
       fprintf('El intervalo es inadecuado')         
    end    


    if bool == 0
        Err = "Error Absoluto";
        RAR = E;
        R="DECIMALES CORRECTOS";
    else
        Err = "Error Relativo";
        RAR = Er;
        R="CIFRAS SIGNIFICATIVAS";
    end
    
    VarNames = ["Iteración", "x", "f(x)", Err];
    ier = 1:c+1;
    Tabla = table(ier',xm',fm',RAR', 'VariableNames',VarNames)
    writetable(Tabla,'MetododeReglaFalsa_Tabla.xlsx','Sheet',R);
end