%% Método de Newton 


function Tabla= newtonx()
sym x
c=1;

    f=str2sym(input('Ingrese la función','s'))
    bool=input("Ingrese 0 si desea DECIMALES CORRECTOS o 1 si requiere el resultado con CIFRAS SIGNIFICATIVAS");
    xi(1)=input('Ingrese el valor xi');  
    niter=input('Ingrese el número de interaciones que permitirá');
    
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

    E=Tol+1; %Porque el E= Tol+1
    fderivada=diff(f);

    while E>Tol && c<=niter   % E>Tol citerio de parada OPTIMISTA
      it(c) = c; 
      fxi(c)=eval(subs(f,xi(c))); %Evalua la función en xi
      fprima(c)=eval(subs(fderivada,xi(c)));  %Evalua la función derivada en xi
      if fprima(c)==0
          disp("No es posible realizar una división por cero")
          return
      end
      x2(c)=xi(c)-((fxi(c))/fprima(c));
      xi(c+1)=x2(c);
      Erelativo(c)=abs((x2(c)-xi(c))/x2(c)*100); 
      EAbsoluto(c)=abs(x2(c)-xi(c));

 

      if bool==0
          E=EAbsoluto(c);  
      else
          E=Erelativo(c);
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
    

    VarNames = ["Iteración", "xi", "f(xi)", "f'xi", "x2" RAR]; %Nombre de las leyendas
    Tabla = table(it',xi(1:end-1)',fxi', fprima', x2', ERROR','VariableNames', VarNames); %Valores
    writetable(Tabla,'MetododeNewton_Tabla.xlsx','Sheet',R);

end 

%   xi(1:end-1)' Qué significado tenía (1:end-1)' hasta el penúltimo


