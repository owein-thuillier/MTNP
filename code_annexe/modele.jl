function creation_modele_niveau_2(instance, Ebis, E1, E2, E3, ajout_R1)
    # Initialisation du modèle
    modele = Model()
    
    # Données
    nT = instance.contexte.nT
    nH = instance.contexte.nH
    nE = instance.contexte.nE
    nC = instance.contexte.nC
    nU = instance.contexte.nU
    nB = instance.contexte.nB
    nR = instance.contexte.nR
    nRc = instance.contexte.nRc
    R = instance.contexte.R
    Cb = instance.contexte.Cb
    Cu = instance.contexte.Cu
    W = instance.contexte.W
    P = instance.contexte.P
    w = instance.contexte.w
    p =instance.contexte.p

    # Variables    
    @variables(modele, begin 
        x[1:nH, Ebis], Bin
        y[1:nR, Ebis], Bin 
        z[1:nU, 1:nT], Bin
        end)

    @variables(modele, begin 
        a[Ebis, Ebis, 1:nR], Bin
        #a_bis[Ebis, Ebis], Bin 
        #sigma[1:nC, Ebis], Bin
        f[Ebis, Ebis, Ebis] >= 0, Int
        d[Ebis, Ebis], Int
        end)

    # Contraintes niveau 1
    @constraint(modele, c_1[h=1:nH], sum(x[h,pos] for pos in Ebis) <= 1)

    @constraint(modele, c_2[pos in Ebis], sum(x[h,pos] for h in 1:nH) <= 1)

    @constraint(modele, c_3[r=1:nR], sum(y[r,pos] for pos in Ebis) <= 1)

    @constraint(modele, c_4[pos in Ebis, c=1:nC], sum(y[r,pos] for r in R[c]) <= 1)

    @constraint(modele, c_5[pos in Ebis], sum(w[r] * y[r,pos] for r in 1:nR) <= W[h] * sum(x[h,pos] for h in 1:nH)) 
    
    @constraint(modele, c_6[pos in Ebis], sum(p[r] * y[r,pos] for r in 1:nR) <= P[h] * sum(x[h,pos] for h in 1:nH))

    @constraint(modele, c_7[t=1:nT, u=1:nU], sum(y[r,pos] for c in Cu[u], r in R[c], pos in E1[u][r][t]) >= 1 - z[u,t])

    @constraint(modele, c_8[b=1:nB], sum(y[r,pos] for c in Cb[b], r in R[c], pos in E2[b][r]) >= 1)

    # Contraintes niveau 2
    @constraint(modele, c_9[pos in Ebis], d[pos,pos] <= sum(x[h,pos_bis] for h in 1:nH, pos_bis in Ebis) - 1)

    @constraint(modele, c_9_bis[pos in Ebis], d[pos,pos] >= 0)

    @constraint(modele, c_10[pos in Ebis, pos_bis in Ebis; pos != pos_bis], d[pos,pos_bis] <= 0)

    @constraint(modele, c_10_bis[pos in Ebis, pos_bis in Ebis; pos != pos_bis], d[pos,pos_bis] >= -1)

    @constraint(modele, c_10_ter[pos in Ebis, pos_bis in Ebis; pos != pos_bis], d[pos,pos_bis] <= -(sum(x[h,pos] for h in 1:nH) + sum(x[h_bis,pos_bis] for h_bis in 1:nH) - 1))

    #@constraint(modele, c_10[pos in Ebis, c in 1:nC], sigma[c,pos] <= sum(y[r,pos] for r in R[c]))

    #@constraint(modele, c_11[c in 1:nC, r in R[c], pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= (1/2)*(y[r,pos] + sigma[c,pos_bis]))

    @constraint(modele, c_11[c in 1:nC, r in R[c], pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= (1/2)*(y[r,pos] + sum(y[r_bis,pos_bis] for r_bis in R[c] if r!=r_bis)))

    @constraint(modele, c_11_bis[r in 1:nR, pos in Ebis, pos_bis in Ebis; !(pos_bis in E3[pos][r])], a[pos,pos_bis,r] == 0)

    #@constraint(modele, c_12[pos in Ebis, pos_bis in Ebis; pos != pos_bis], a_bis[pos,pos_bis] <= sum(a[pos,pos_bis,r] for r in 1:nR))

    #@constraint(modele, c_13[i in Ebis, pos in Ebis, pos_bis in Ebis; pos != pos_bis], f[pos,pos_bis,i] <= (nH - 1)*a_bis[pos,pos_bis])
    @constraint(modele, c_13[i in Ebis, pos in Ebis, pos_bis in Ebis; pos != pos_bis], f[pos,pos_bis,i] <= (nH - 1)*sum(a[pos,pos_bis,r] for r in 1:nR))

    @constraint(modele, c_14[i in Ebis, pos in Ebis], sum(f[pos_bis,pos,i] for pos_bis in Ebis if pos_bis!=pos) + d[pos,i] == sum(f[pos,pos_bis,i] for pos_bis in Ebis if pos_bis!=pos))

    # Contraintes renforcement
    if ajout_R1 == true
        @variable(modele, omega[Ebis], Bin) 
        @constraint(modele, c_R11[pos in Ebis], omega[pos] == sum(x[h, pos] for h in 1:nH))
        @constraint(modele, c_R12[r=1:nR, pos in Ebis], y[r, pos] <= omega[pos])
    end

    # Fonction objectif
    @objective(modele, Min, sum(z[u,t] for u in 1:nU, t in 1:nT))

    return modele
end
