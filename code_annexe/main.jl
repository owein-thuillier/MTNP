function experimentation()
    # Lecture du contexte
    chemin_contexte = "instances/bibliotheque_1/contexte"
    contexte = lire_contexte(chemin_contexte)

    # Lecture du scénario
    chemin_scenario = "instances/bibliotheque_1/scenarios/scenario_6"
    scenario = lire_scenario(chemin_scenario, contexte)

    nb = 3
    nR = contexte.nR
    nRc = contexte.nRc
    w = contexte.w
    p = contexte.p
    x = [4 + i for i in 1:nb]
    y_sans = []
    y_avec = []
    for i in 1:nb
        println("\n --> i : $i")
        nR = nR + contexte.nC
        nRc = nRc .+ 1
        for c in 1:contexte.nC
            push!(w, 30)
            push!(p, 30)
        end
        R = Vector{Vector{Int}}(undef, contexte.nC)
        cpt_r = 1
        for c in 1:contexte.nC
            temp_r = Vector{Int}(undef, nRc[c])
            for r in 1:nRc[c]
                temp_r[r] = cpt_r
                cpt_r += 1
            end
            R[c] = temp_r
        end
        contexte_copie = Contexte(contexte.nT, contexte.nH, contexte.nE, contexte.nC, nR, nRc, contexte.nU, contexte.nUc, R, contexte.U, contexte.D, contexte.L, contexte.W, contexte.P, contexte.E, w, p)
        instance_copie = Instance(contexte_copie, scenario)

        Ebis = calcul_positions(instance_copie)
        modele = creation_modele_3_sans(instance_copie, Ebis)
        temps_resolution = @elapsed optimize!(modele)
        push!(y_sans, temps_resolution)
        println("\n --> Temps résolution (sans) : $(temps_resolution) seconde(s)")
        println(" --> Nombre de coupures (sans) : ", trunc(Int, objective_value(modele)))

        modele = creation_modele_3_avec(instance_copie, Ebis)
        temps_resolution = @elapsed optimize!(modele)
        push!(y_avec, temps_resolution)
        println("\n --> Temps résolution (avec) : $(temps_resolution) seconde(s)")
        println(" --> Nombre de coupures (avec) : ", trunc(Int, objective_value(modele)))
    end
    plot(x, y_sans, label="Sans nouvelle contrainte", marker=".")
    plot(x, y_avec, label="Avec nouvelle contrainte", marker=".")
    grid(true)
    legend(loc="best")
end

function creation_modele_3_sans(instance, Ebis)
    modele = Model(GLPK.Optimizer)
    
    # Données
    nE = instance.contexte.nE
    nR = instance.contexte.nR
    nRc = instance.contexte.nRc
    nH = instance.contexte.nH
    nU = instance.contexte.nU
    nUc = instance.contexte.nUc
    nT = instance.contexte.nT
    nC = instance.contexte.nC
    U = instance.contexte.U
    R = instance.contexte.R
    W = instance.contexte.W
    P = instance.contexte.P
    w = instance.contexte.w
    p =instance.contexte.p

    # Variables
    @variable(modele, x[1:nH, 1:nE], Bin)
    @variable(modele, y[1:nR, 1:nE], Bin) # a_{e,r} + indices commencent à 0
    @variable(modele, z[1:nU, 1:nT], Bin)

    # Contraintes
    @constraint(modele, c_1[h=1:nH], sum(x[h,pos] for pos in 1:nE) <= 1)

    @constraint(modele, c_2[pos=1:nE], sum(x[h,pos] for h in 1:nH) <= 1)

    @constraint(modele, c_3[r=1:nR], sum(y[r,pos] for pos in 1:nE) <= 1)

    @constraint(modele, c_4[pos=1:nE], sum(w[r] * y[r,pos] for r in 1:nR) <= sum(W[h] * x[h,pos] for h in 1:nH))

    @constraint(modele, c_5[pos=1:nE], sum(p[r] * y[r,pos] for r in 1:nR) <= sum(P[h] * x[h,pos] for h in 1:nH))

    @constraint(modele, c_6[t=1:nT, c=1:nC, u in U[c]], sum(y[r,pos] for r in R[c], pos in Ebis[u][t]) >= 1 - z[u,t] )


    # Fonction objectif
    @objective(modele, Min, sum(z[u,t] for u in 1:nU, t in 1:nT))

    return modele
end

function creation_modele_3_avec(instance, Ebis)
    modele = Model(GLPK.Optimizer)
    
    # Données
    nE = instance.contexte.nE
    nR = instance.contexte.nR
    nRc = instance.contexte.nRc
    nH = instance.contexte.nH
    nU = instance.contexte.nU
    nUc = instance.contexte.nUc
    nT = instance.contexte.nT
    nC = instance.contexte.nC
    U = instance.contexte.U
    R = instance.contexte.R
    W = instance.contexte.W
    P = instance.contexte.P
    w = instance.contexte.w
    p =instance.contexte.p

    # Variables
    @variable(modele, x[1:nH, 1:nE], Bin)
    @variable(modele, y[1:nR, 1:nE], Bin) # a_{e,r} + indices commencent à 0
    @variable(modele, z[1:nU, 1:nT], Bin)

    # Contraintes
    @constraint(modele, c_1[h=1:nH], sum(x[h,pos] for pos in 1:nE) <= 1)

    @constraint(modele, c_2[pos=1:nE], sum(x[h,pos] for h in 1:nH) <= 1)

    @constraint(modele, c_3[r=1:nR], sum(y[r,pos] for pos in 1:nE) <= 1)

    @constraint(modele, c_4[pos=1:nE], sum(w[r] * y[r,pos] for r in 1:nR) <= sum(W[h] * x[h,pos] for h in 1:nH))

    @constraint(modele, c_5[pos=1:nE], sum(p[r] * y[r,pos] for r in 1:nR) <= sum(P[h] * x[h,pos] for h in 1:nH))

    @constraint(modele, c_6[t=1:nT, c=1:nC, u in U[c]], sum(y[r,pos] for r in R[c], pos in Ebis[u][t]) >= 1 - z[u,t] )

    @constraint(modele, c_new[pos=1:nE, c=1:nC], sum(y[r,pos] for r in R[c]) <= 1)

    # Fonction objectif
    @objective(modele, Min, sum(z[u,t] for u in 1:nU, t in 1:nT))

    return modele
end

experimentation()
