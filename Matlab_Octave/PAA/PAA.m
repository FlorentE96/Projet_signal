function [W_reduite] = PAA( W, fenetre, seuil )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    taille_W = length(W);
    fenetre=6;   % On fixe fenetre = pas pour eviter des problemes de tailles
    seuil = 10;
    pas=fenetre;
    debut=ceil(pas/2);
    Rapport=floor(taille_W/pas);
    taille=floor(taille_W/fenetre);
    taille_W_reduite=Rapport*pas;

    if mod(taille_W,taille)~=0 %Si la taille de W n'est pas un multiple de la taille
        W_reduite = ones(1,taille);
        W=W(1:taille*fenetre);
        for i=1:1:taille
            W_reduite(i)= (1/fenetre)*(sum(W(fenetre*(i-1)+1:fenetre*i)));
            if abs(W_reduite(i)-W(fenetre*(i-1)+1))> seuil | abs(W_reduite(i)-W(fenetre*(i)))> seuil
                if abs(W_reduite(i)-W(fenetre*(i-1)+1)) >= abs(W_reduite(i)-W(fenetre*(i)))
                    W_reduite(i)=W(fenetre*(i));
                else
                    W_reduite(i)=W(fenetre*(i-1));
                end
            end
        end
    else 
        W_reduite = ones(1,taille);
        for i=1:1:taille
            W_reduite(i)= (1/fenetre)*(sum(W(fenetre*(i-1)+1:fenetre*i)));
            if abs(W_reduite(i)-W(fenetre*(i-1)+1))> seuil | abs(W_reduite(i)-W(fenetre*(i)))> seuil
                if abs(W_reduite(i)-W(fenetre*(i-1)+1)) >= abs(W_reduite(i)-W(fenetre*(i)))
                    W_reduite(i)=W(fenetre*(i));
                else
                    W_reduite(i)=W(fenetre*(i-1));
                end
            end
        end
    end

end


