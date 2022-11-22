%Método de Bisección
function Tabla = MetodoBiseccionconmpleto()
    f=str2sym(input("Ingrese la función: ",'s'))
    xi=input("Escribir valor inferior: " )
    xs=input("Escribir el valor superior: ")
    %Tol=input("Escribir la tolerancia que desea manejar: ")
    niter=input("Escribir el máximo número de iteraciones que permitirá: ")

    Nnnn = 3;
    for i = 1:Nnnn %Repite el ciclo 3 veces en dado caso que se equivoque el usuario con la digitación
        bool=input("Escriba 0 si quiere d.c., 1 si c.s: ")
        
        if bool==0
            pq = input("Escriba nùmero de decimales correctos: ");
            Tol = 0.5*10^-pq;
            break
        elseif bool==1
            pq = input("Escriba nùmero de cifras significativas: ");
            Tol = 5*10^-pq;
            break
        else
            disp("Error, operacion no reconocida.")
        end

        if i == Nnnn
            return
        end
    end

 
    fi=eval(subs(f,xi));
    fs=eval(subs(f,xs));
    if fi==0
        s=xi;
        E=0;
        fprintf('%f es raiz de f(x)',xi)
    elseif fs==0
        s=xs;
        E=0;
        fprintf('%f es raiz de f(x)',xs)
    elseif fs*fi<0
        c=0;
        xm(c+1)=(xi+xs)/2;
        fm(c+1)=eval(subs(f,xm(c+1)));
        fe=fm(c+1);
        E(c+1)=Tol+1;
        Er(c+1)=Tol+1;
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
            xm(c+2)=(xi+xs)/2;  %De aqui en adelante si quisieramos almacenar xm le pondríamos xm(c+2)
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
        elseif error<Tol
           s=xm; %xm(c+2)
           fprintf('%f es una aproximación de una raiz de f(x) con una tolerancia= %f',xm(c+1),Tol)
        else 
           s=xm;%xm(c+2)
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
    Tabla = table(ier',xm',fm',RAR', 'VariableNames',VarNames);
    writetable(Tabla,'MetododeBiseccion_Tabla.xlsx','Sheet',R);
   
end