%MatJacobiSeid: Calcula la solución del sistema
%Ax=b con base en una condición inicial x0,mediante el método de Jacobi o
%de Gauss Seidel (Matricial), depende del método elegido, se elige 0 o 1 en met
%respectivamente

function Tabla = Jacobi_Seid_SOR_Completo()
    c=0;
    
    % Entradas
    x0= input('Ingrese el Vector Inicial (semilla): ')
    A= input('Ingrese la Matriz A (Sistema de Ecuaciones): ')
    b= input('Ingrese el Vector b (Vector de Resutados): ')

    bul= input('Ingrese "1" si desea D.C o "2" si desea C.S: ')
    if bul==1
        num= input('Ingrese el número de Decimales Correctos: ')
        Tol = 0.5*10^(-num);
    elseif bul==2
        num= input('Ingrese el número de Cifras Siginificativas: ')
        Tol= 5*10^(-num);
    else
        disp('Meta eso bien, por andar de canson empieza de nuevo.')
        return
    end

    niter= input('Ingrese el número de Iteraciones: ')
    try
        niter = niter + 1;
    catch exception
        throw(exception)
    end

    met=input('Ingrese "0" si desea trabajar con el método de Jacobi,"1" si desea trabajar \ncon el método de Gaus-Seidel o "2" si desea trabajar con el método de SOR: ')
    if met==2
        w=input('Ingrese un "w" óptimo: ')
        if ~isa(w,'double') || (w<0 || w>2)    %Compara si la clase del objeto w es un 'Double' (Número decimal)
            disp('El valor no es adecuado para trabajar.')
            return
        end
    end

    if isrow(x0)
        x0 = x0';
    end

    if isrow(b)
        b=b';
    end

    % Ciclo
    error=Tol+1;
    D=diag(diag(A));
    L=-tril(A,-1);
    U=-triu(A,+1);
    xmat = x0;
    E(c+1)=Tol+1;
    N(c+1)=0;

    while error>Tol && c<niter
        if met==0    %Jacobi
            T=inv(D)*(L+U);
            C=inv(D)*b;
            x1=T*x0+C;

        elseif met==1    %Gauss-Seidel
            T=inv(D-L)*(U);
            C=inv(D-L)*b;
            x1=T*x0+C;

        elseif met==2    %SOR
            T=inv(D-w*L)*((1-w)*D+w*U);
            C=w*inv(D-w*L)*b;
            x1=T*x0+C;

        else
            disp('Meta eso bien sapo hpta <3.')
            return
        end

        % Error
        if bul==1
            E(c+2)=norm(x1-x0,'inf');     %Error Absoluto

        elseif bul==2
            E(c+2)=(norm(x1-x0,'inf'))/norm(x1,'inf');      %Error Relativo
        end

        N(c+2)=c+1;
        error=E(c+2);
        xmat = [xmat x1];    %Crear matriz con los resultados
        x0=x1;
        c=c+1;
    end

    if error < Tol
        s=x0;
        n=c;
        s
        fprintf('Es una aproximación de la solución del sistmea con una tolerancia= %f: ',Tol)
    else 
        s=x0;
        n=c;
        fprintf('Fracasó en %f iteraciones: ',niter) 
    end

    xmat=[xmat]';

    %Tabla en Matlab (Command Window)
    VarNames=["Iteraciones", "Xi (Soluciones)", "Error"];
    Tabla=table(N', xmat, E', 'VariableNames', VarNames);

    %Tabla en Excel (Archivo Separado)
    Nombre='Solución del Sistema.xlsx';
    writetable(Tabla,Nombre,'Sheet',1);

end

