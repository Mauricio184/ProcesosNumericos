%% secante 
%xi1=xi-1
function Tabla= secantex()
sym x
c=1;
    f=str2sym(input("Ingrese la función",'s'))
    bool=input('Ingrese 0 si desea error en decimales correctos y 1 si lo desea cifras significativas');
    xi(1)=input('Ingrese el valor más grande de su intervalo')
    xi1(1)=input('Ingrese el valor más pequeño de su intervalo')
    niter=input('Ingrese el máximo número de iteraciones que permitirá')
    
    Nnnn = 3;
    for i = 1:Nnnn
        if bool==0
        pq = input("Escriba número de decimales correctos");
        Tol = 0.5*10^-pq;
        break

        elseif bool==1
        pq = input("Escriba nùmero de cifras significativas");
        Tol = 5*10^-pq;
        break
        else
        disp("Error, operacion no reconocida.")
        end
        if i == Nnnn
            return
        end
    end

        E = Tol + 1;

    while E>Tol && c<=niter
        it(c) = c;
        fxi(c)=eval(subs(f,xi(c)));
        fxi1(c)=eval(subs(f,xi1(c)));
        if fxi1(c)-fxi(c) ==0
            disp("División por cero, error en el método")
            return
        end
        x2(c)=xi(c)-((fxi(c))*(xi1(c)-xi(c))/(fxi1(c)-fxi(c)));
        Erelativo(c)=abs((x2(c)-xi(c))/x2(c)*100); 
        EAbsoluto(c)=abs(x2(c)-xi(c));
        xi(c+1)=x2(c);
        xi1(c+1)=xi(c);
      
       

        if bool == 0
            E = EAbsoluto(c);
        else
            E =Erelativo(c);
        end 
        c=c+1;
    end

    if bool == 0
        ERROR = EAbsoluto;
        RAR = "Error Absoluto";
        R="DECIMALES CORRECTOS";
        else
        ERROR = Erelativo;
        RAR = "Error Relativo";
        R="CIFRAS SIGNIFICATIVAS";
    end
    
    VarNames = ["Iteración", "x_i", "x_(i-1)", "f(x_i)", "f(x_(i-1))", "x2" RAR];
    Tabla = table(it',xi(1:end-1)',xi1(1:end-1)',fxi', fxi1', x2', ERROR', 'VariableNames',VarNames);
    writetable(Tabla,'MetododeSecante_Tabla.xlsx','Sheet',R);
end 

