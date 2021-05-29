close all;clear all;clc

%Cargar la imagen
I = imread('9.jpg');

%Procesamiento de imagen
IG = rgb2gray(I);
BN = imbinarize(IG); %umbral automatico
S = strel('disk',21);
Be = imdilate(BN,S);
B = imfill(Be,'holes');

%Impresion de imagen procesada
% figure, imshow(B);

%Obtencion de las propiedades de cada elemento detectado
[L, n] = bwlabel(double(B));
stats = regionprops(L);

%Calculo de dinero representado por las monedas
cuenta = 0;
figure, imshow(I);
for i=1:length(stats)
    
    %Centroide para ubicar el valor correspondiente de cada moneda
    c = stats(i).Centroid;
    x=c(1);
    y=c(2);
    
    %Determinacion del valor de la moneda segun su area
    if stats(i).Area > 222000
        text(x-100,y,'$1000','color','r','FontSize',15)
        cuenta=cuenta+1000;
    
    elseif stats(i).Area > 183720 & stats(i).Area < 222000
        text(x-100,y,'$500','color','r','FontSize',15)
        cuenta=cuenta+500;
    
    elseif stats(i).Area > 159000 & stats(i).Area < 183720
        text(x-100,y,'$200','color','r','FontSize',15)
        cuenta=cuenta+200;
        
    elseif stats(i).Area > 130000 & stats(i).Area < 159000
        text(x-100,y,'$100','color','r','FontSize',15)
        cuenta=cuenta+100;
    
    elseif stats(i).Area > 80000 & stats(i).Area < 130000
        text(x-100,y,'$50','color','r','FontSize',15)
        cuenta=cuenta+50;
    end
    
%Impresion de las areas correspondientes a cada moneda
%     if stats(i).Area > 20000
%         text(x-20,y-70,num2str(stats(i).Area),'color','r','FontSize',15)
%     end 

end
%Impresion del total calculado
title(['Total: $',num2str(cuenta),' COP'])
disp(cuenta)
     
  