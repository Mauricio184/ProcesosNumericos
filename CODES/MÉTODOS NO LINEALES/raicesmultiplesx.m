 %% Método de Raíces Múltiples

function Tabla= raicesmultiplesx()
sym x
c=1;

    f=str2sym(input('Ingrese la función','s'))
    bool=input("Ingrese 0 si desea decimales correctos o 1 si requiere el resultado con cifras significativas");
    xi(1)=input('Ingrese el valor xi');  %Porque se pone xi(1) con el 1 adentro del paréntesis
    niter=input('Ingrese el número de iteraciones que permitirá');

    if bool==0
    pq=input('Ingrese el número de decimales correctos');
    Tol=0.5*10^-pq;
    else 
    pq=input("Escriba el número de cifras significativas con las que va a trabajar");
    Tol=5*10^-pq;
    end 

    E=Tol+1; %Porque el E= Tol+1
    fderivada=diff(f);
    fderivadasegunda=diff(fderivada);

    while E>Tol && c<=niter   % E>Tol citerio de parada OPTIMISTA
      it(c) = c; %Para que se usa esto
      fxi(c)=eval(subs(f,xi(c)));
      fprima(c)=eval(subs(fderivada,xi(c)));
      fprimasegunda(c)=eval(subs(fderivadasegunda,xi(c)));
      if (fprima(c))^2-fxi(c)*fprimasegunda(c) ==0
          disp("Error en el método. División sobre cero no está matemáticamente definida")
          return
      end

      x2(c)=xi(c)- (fxi(c)*fprima(c))/((fprima(c))^2-fxi(c)*fprimasegunda(c));       
      xi(c+1)=x2(c);
      Erelativo(c)=abs((x2(c)-xi(c))/x2(c)*100); 
      EAbsoluto(c)=abs(x2(c)-xi(c));
     


      if bool==0
          E=EAbsoluto(c);  %E(c)=EAbsoluto(c) porque no se pone E(c)
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
    
    VarNames = ["Iteración", "xi", "f(xi)", "f'xi","f''(xi)", "x2" RAR]; %Nombre de las leyendas
    Tabla = table(it',xi(1:end-1)',fxi', fprima',fprimasegunda', x2', ERROR','VariableNames', VarNames); %Valores
    writetable(Tabla,'MetododeRaiceMultiples_Tabla.xlsx','Sheet',R);
end 

%   xi(1:end-1)' Qué significado tenía (1:end-1)' hasta el penúltimo


