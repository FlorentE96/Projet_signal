function [ X_max, X_min ] = enveloppe( W, pas )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    taille_W = length(W);
    fenetre=6;   % On fixe fenetre = pas pour eviter des problemes de tailles
    seuil = 10;
    pas=fenetre;
    debut=ceil(pas/2);
    Rapport=floor(taille_W/pas);
    taille=floor(taille_W/fenetre);
    taille_W_reduite=Rapport*pas;

    if pas >= (taille_W/2)
        W(1:taille_W)=0;

    elseif pas < (taille_W/2) 
        if mod(pas,2)~=0 %Lorsque le pas est impaire
            if mod(pas,taille_W)~=0 %Si le taille_W n'est pas un multiple de pas
                taille_W=taille_W_reduite;
                W=W(1:taille_W);
                X_max= zeros(1,taille_W);
                X_min= zeros(1,taille_W);

                for i=debut:pas:taille_W 
                        upper = max(W(i-(pas-debut):i+(pas-debut)));
                        lower = min(W(i-(pas-debut):i+(pas-debut)));
                        X_max(i-(pas-debut):i+(pas-debut))= upper;
                        X_min((i-(pas-debut)):i+(pas-debut))= lower;
                end

            else %Si le taille_W est un multiple de pas
                W=W(1:taille_W);
                X_max= zeros(1,taille_W);
                X_min= zeros(1,taille_W);

                for i=debut:pas:taille_W
                        upper = max(W(i-(pas-2):i+(pas-2)));
                        lower = min(W(i-(pas-2):i+(pas-2)));
                        X_max(i-(pas-2):i+(pas-2))= upper;
                        X_min((i-(pas-2)):i+(pas-2))= lower;
                end
            end 

        else %Lorsque le pas est paire
           if mod(pas,taille_W)~=0 %Si le taille_W n'est pas un multiple de pas
                taille_W=taille_W_reduite;
                W=W(1:taille_W);
                X_max= zeros(1,taille_W);
                X_min= zeros(1,taille_W);

                for i=debut:pas:taille_W
                        upper = max(W(i-(debut-1):i+(pas-debut)));
                        lower = min(W(i-(debut-1):i+(pas-debut)));
                        X_max(i-(debut-1):i+(pas-debut))= upper;
                        X_min((i-(debut-1)):i+(pas-debut))= lower;
                end

           else         %Si le taille_W est un multiple de pas
                W=W(1:taille_W);
                X_max= zeros(1,taille_W);
                X_min= zeros(1,taille_W);

                for i=debut:pas:taille_W
                        upper = max(W(i-(debut-1):i+(pas-debut)));
                        lower = min(W(i-(debut-1):i+(pas-debut)));
                        X_max(i-(debut-1):i+(pas-debut))= upper;
                        X_min((i-(debut-1)):i+(pas-debut))= lower;
                end
            end  
        end
    end
end