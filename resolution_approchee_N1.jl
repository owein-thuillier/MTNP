##### Heuristique #####

function resolution_approchee_niveau_1(instance)
    temps_pretraitement_positions = @elapsed positions_non_couvrantes(instance)
    Ebis = Int[] 
    for position in 1:instance.contexte.nE
        if instance.contexte.Ebool[position] == true 
            push!(Ebis, position)
        end
    end

    # Pré-calculs essentiels
    temps_precalcul_positions_unites = @elapsed E1 = calcul_positions_unites(instance, Ebis)
    temps_precalcul_positions_bases = @elapsed E2 = calcul_positions_bases(instance, Ebis)

    # Positions importantes
    modele = creation_modele_heuristique(instance, Ebis, E1, E2) 

    # Choix du solveur
    solveur = choix_solveur(modele)
    set_optimizer(modele, solveur)

    # Choix de la verbosité
    verbosite = choix_verbosite(modele, solveur)

    # Limite de temps 
    limite_temps = choix_binaire("\n --> Souhaitez-vous fixer une limite de temps (o/n) ? ")
    if limite_temps == "o"
        print("\n --> Temps limite (en secondes) : ")
        #temps_limite = parse(Float64, readline()) * 10^3 # Secondes vers milli-secondes
        #set_optimizer_attribute(modele, "tm_lim", temps_limite)
        temps_limite = parse(Float64, readline())
        set_time_limit_sec(modele, temps_limite)
    end

    # Résolution
    if choix_verbosite == "o"
        println("\n========== Détails de la résolution ==========\n")
        optimize!(modele)
        print("\n========== Détails de la résolution ==========")
    else
        print("\n - Résolution en cours...")
        optimize!(modele)
    end

    y = round.(Int, value.(modele[:y]))
    Ebis_new = Int[] 
    for pos in Ebis
        for r in 1:instance.contexte.nR
            if y[r,pos] == 1
                if !(pos in Ebis_new)
                    push!(Ebis_new, pos) 
                    #println(" - Relais $r position $pos")
                end
            end
        end
    end
    temps_precalcul_positions_unites = @elapsed E1 = calcul_positions_unites(instance, Ebis_new)
    temps_precalcul_positions_bases = @elapsed E2 = calcul_positions_bases(instance, Ebis_new)

    # Résolution restreinte aux positions sélectionnées
    modele, _= creation_modele_niveau_1(instance, Ebis_new, E1, E2, [true, true, false, false]) 
    set_optimizer(modele, solveur)

    # Résolution
    if choix_verbosite == "o"
        println("\n========== Détails de la résolution ==========\n")
        optimize!(modele)
        print("\n========== Détails de la résolution ==========")
    else
        print("\n - Résolution en cours...")
        optimize!(modele)
    end

    # Solution
    solution = lecture_resultats_modele_niveau_1(instance, modele, solveur, Ebis_new, E1, E2)

    return solution
end

function creation_modele_heuristique(instance, Ebis, E1, E2) 
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
        y[1:nR, Ebis], Bin 
        z[1:nU, 1:nT], Bin
        omega[Ebis], Bin
        end)

    # Contraintes
    #@constraint(modele, c_1[r=1:nR], sum(y[r,pos] for pos in Ebis) <= 1)

    @constraint(modele, c_2[pos in Ebis, r=1:nR], y[r,pos] <= omega[pos])

    @constraint(modele, c_3, sum(omega[pos] for pos in Ebis) == nH)

    @constraint(modele, c_4[t=1:nT, u=1:nU], sum(y[r,pos] for c in Cu[u], r in R[c], pos in E1[u][r][t]) >= z[u,t])

    @constraint(modele, c_5[b=1:nB], sum(y[r,pos] for c in Cb[b], r in R[c], pos in E2[b][r]) >= 1)

    @constraint(modele, c_6[pos in Ebis, c=1:nC], sum(y[r,pos] for r in R[c]) <= 1)

    # Fonction objectif
    @objective(modele, Max, sum(z[u,t] for u in 1:nU, t in 1:nT))

    return modele
end

