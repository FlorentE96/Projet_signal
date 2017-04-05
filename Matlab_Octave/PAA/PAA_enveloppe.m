function [ W_reduite, X_max_reduite, X_min_reduite ] = PAA_enveloppe( W, pas,seuil)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    fenetre = pas;
    W_reduite = PAA(W,fenetre,seuil);
    [X_max,X_min] = enveloppe(W,pas);
    X_max_reduite = PAA(X_max,fenetre,seuil);
    X_min_reduite = PAA(X_min,fenetre,seuil);
end

