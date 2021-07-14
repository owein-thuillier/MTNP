function resolution_modele_niveau_1_biobj(instance)       
    configuration = ""
    # Prétraitements
    println("\n========== Prétraitements ==========")
    println("\n P1 : désactivation des positions inutiles (i.e. ne pouvant couvrir aucune base ET aucune unité)")
    choix_P1 = choix_binaire(" --> Souhaitez-vous effectuer ce prétraitement (o/n) ? ")
    if choix_P1 == "o"
        configuration *= "P1 "
        temps_P1 = @elapsed positions_non_couvrantes(instance)
    else
        temps_P1 = 0.0
    end
    Ebis = Int[] # On cherche les positions actives (sous-ensemble de positions)
    for position in 1:instance.contexte.nE
        if instance.contexte.Ebool[position] == true # position active
            push!(Ebis, position)
        end
    end

    # Pré-calculs essentiels
    temps_precalcul_positions_unites = @elapsed E1 = calcul_positions_unites(instance, Ebis)
    temps_precalcul_positions_bases = @elapsed E2 = calcul_positions_bases(instance, Ebis)

    # Renforcement du modèle
    println("\n========== Renforcement du modèle ==========")
    println("\n R1 : modélisation forte")
    choix = choix_binaire(" --> Souhaitez-vous ajouter cette contrainte (o/n) ? ")
    if choix == "o"
        configuration *= "R1 "
        R1 = true
    else
        R1 = false
    end

    println("\n R2 : pas plus d'un relais d'un même type sur une position donnée (cassage de symétries)")
    choix = choix_binaire(" --> Souhaitez-vous ajouter cette contrainte (o/n) ? ")
    if choix == "o"
        configuration *= "R2 "
        R2 = true
    else
        R2 = false
    end

    println("\n R3 : déploiement des plus gros HAPS en priorité (contraintes de domination)")
    choix = choix_binaire(" --> Souhaitez-vous ajouter cette contrainte (o/n) ? ")
    if choix == "o"
        configuration *= "R3 "
        R3 = true
    else
        R3 = false
    end

    println("\n R4 : déploiement des meilleurs relais en priorité (contraintes de domination)")
    choix = choix_binaire(" --> Souhaitez-vous ajouter cette contrainte (o/n) ? ")
    if choix == "o"
        configuration *= "R4 "
        R4 = true
    else
        R4 = false
    end
 
    println("\n R5 : k-relais incompatibles (\"knapsack cover inequalities\")")
    choix = choix_binaire(" --> Souhaitez-vous ajouter cette contrainte (o/n) ? ")
    if choix == "o"
        print(" --> k : ")
        k = parse(Int64, readline())
        temps_R5 = @elapsed liste_relais_incompatibles = k_relais_incompatibles(instance, k)
        println(" Nombre de $k-uplets de relais incompatibles : $(length(liste_relais_incompatibles))")
        configuration *= "R5 "
        R5 = true
    else
        liste_relais_incompatibles = []
        R5 = false
        temps_R5 = 0.0
    end   

    println("\n R6 : borne supérieure sur le nombre de relais par position")
    choix = choix_binaire(" --> Souhaitez-vous ajouter cette contrainte (o/n) ? ")
    if choix == "o"
        temps_R6 = @elapsed eta = borne_superieure_nombre_relais_par_position(instance)
        println(" Borne supérieure : $(eta)")
        configuration *= "R6 "
        R6 = true
    else
        eta = -1
        R6 = false
        temps_R6 = 0.0
    end   

    println("\n R7 : unités hors d'atteinte instant t")
    choix = choix_binaire(" --> Souhaitez-vous ajouter cette contrainte (o/n) ? ")
    if choix == "o"
        temps_R7 = @elapsed unites_hors_atteinte = unites_hors_atteinte_instant_t(instance, Ebis)
        println(" Nombre d'unités hors d'atteinte : $(length(unites_hors_atteinte))")
        configuration *= "R7 "
        R7 = true
    else
        unites_hors_atteinte = []
        R7 = false
        temps_R7 = 0.0
    end  

    liste_renforcements = [R1, R2, R3, R4, R5, R6, R7]
    
    temp_creation_modele = @elapsed modele, temps_R3, temps_R4 = creation_modele_niveau_1_biobj(instance, Ebis, E1, E2, liste_renforcements, liste_relais_incompatibles, eta, unites_hors_atteinte) 
    
    # Choix de la méthode de résolution
    println("\n Choix de la méthode de résolution :")
    println(" -----------------------------------")
    println("    1) ε-contrainte (YN)")
    println("    2) Chalmet (YN)")
    println("    3) Aneja & Nair (YSN)")
    println("    4) Lexicographique (YLEX)")
    choix = choix_multiple("\n --> Votre choix : ", 4) 
    if choix == 1
        methode = :epsilon
    elseif choix == 2
        methode = :chalmet
    elseif choix == 3
        methode = :dichotomy
    elseif choix == 4
        methode = :lexico
    end
      
    # Choix du solveur
    solveur = choix_solveur(modele)
    set_optimizer(modele, solveur)

    # Choix de la verbosité
    verbosite = choix_verbosite(modele, solveur)

    # Limite de temps 
    limite_temps = choix_binaire("\n --> Souhaitez-vous fixer une limite de temps (o/n) ? ")
    if limite_temps == "o"
        print("\n --> Temps limite (en secondes) : ")
        temps_limite = parse(Float64, readline())
        set_time_limit_sec(modele, temps_limite)
    end

    # Résolution
    if verbosite == "o"
        println("\n========== Détails de la résolution ==========\n")
        vSolve(modele, method=methode)
        print("\n========== Détails de la résolution ==========")
    else
        print("\n - Résolution en cours...")
        vSolve(modele, method=methode)
    end

    # Affichage des temps
    precision = 4 # Précision des résultats (nombre de décimales)
    temps_resolution = solve_time(modele)
    println("\n\n========== Affichage des temps ==========")
    if choix_P1 == "o"
        temps_P1 = trunc(temps_P1, digits=precision)
        println("\n - Temps prétraitement P1 (positions inutiles) : $(temps_P1) seconde(s)")
    end
    temps_precalcul_positions_unites = trunc(temps_precalcul_positions_unites, digits=precision)
    println("\n - Temps précalcul n°1 (unités) : $(temps_precalcul_positions_unites) seconde(s)")
    temps_precalcul_positions_bases = trunc(temps_precalcul_positions_bases, digits=precision)
    println("\n - Temps précalcul n°2 (bases) : $(temps_precalcul_positions_bases) seconde(s)")
    if R3 == true
        temps_R3 = trunc(temps_R3, digits=precision)
        println("\n - Temps précalcul R3 (domination HAPS) : $(temps_R3) seconde(s)")
    end
    if R4 == true
        temps_R4 = trunc(temps_R4, digits=precision)
        println("\n - Temps précalcul R4 (domination relais) : $(temps_R4) seconde(s)")
    end
    if R5 == true
        temps_R5 = trunc(temps_R5, digits=precision)
        println("\n - Temps précalcul R5 (relais incompatibles) : $(temps_R5) seconde(s)")
    end
    if R6 == true
        temps_R6 = trunc(temps_R6, digits=precision)
        println("\n - Temps précalcul R6 (borne supérieure) : $(temps_R6) seconde(s)")
    end
    if R7 == true
        temps_R7 = trunc(temps_R7, digits=precision)
        println("\n - Temps précalcul R7 (unités hors d'atteinte) : $(temps_R7) seconde(s)")
    end
    temp_creation_modele = trunc(temp_creation_modele, digits=precision)
    println("\n - Temps création modèle : $(temp_creation_modele) seconde(s)")
    temps_resolution = trunc(temps_resolution, digits=precision)
    println("\n - Temps résolution : $(temps_resolution) seconde(s)")
    println("\n -----------------------------------------")
    total = trunc(temps_P1 + temps_precalcul_positions_unites + temps_precalcul_positions_bases + temps_R3 + temps_R4 + temps_R5 + temps_R6 + temps_R7 + temp_creation_modele + temps_resolution, digits=4)
    println("\n - Temps total : $(total) seconde(s)")
    println("\n - Configuration : ", configuration)
    println("\n========== Affichage des temps ==========")
    
    println("\n Liste des points non dominés : ")
    println(" ------------------------------ ")
    Y_N = getY_N(modele)
    for i in 1:length(Y_N)
        println("    $i) z1 = $(Y_N[i][1]); z2 = $(Y_N[i][2])")
    end  
    
    print("\n --> Choix de la solution à afficher : ")
    num = parse(Int64, readline())
    zILP = Y_N[num][1]
    solution = lecture_resultats_modele_niveau_1(instance, modele, solveur, Ebis, E1, E2, num, zILP)
    return solution
end

function creation_modele_niveau_1_biobj(instance, Ebis, E1, E2, liste_renforcements) 
    modele = vModel() 

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
        x[1:nH, Ebis], Bin # Matrice éventuellement creuse (si positions inactives)
        y[1:nR, Ebis], Bin # ""
        z[1:nU, 1:nT], Bin
        tau, Int
        end)   

    # Contraintes
    @constraint(modele, c_1[h=1:nH], sum(x[h,pos] for pos in Ebis) <= 1) # Un HAPS peut être déployé sur, au plus, une position

    @constraint(modele, c_2[pos in Ebis], sum(x[h,pos] for h in 1:nH) <= 1) # Une position peut acceuilir, au plus, un HAPS

    @constraint(modele, c_3[pos in Ebis], sum(x[h,pos] for h in 1:nH) <= sum(y[r,pos] for r in 1:nR)) # Si aucun relais placé sur une position, alors pas de HAPS déployé sur cette position

    @constraint(modele, c_4[r=1:nR], sum(y[r,pos] for pos in Ebis) <= 1) # Un relais peut être placé sur, au plus, une position

    @constraint(modele, c_5[pos in Ebis], sum(w[r] * y[r,pos] for r in 1:nR) <= W[h] * sum(x[h,pos] for h in 1:nH)) # Respect de la masse maximale au sein du HAPS déployé sur une position (si HAPS déployé, autrement pas de relais sur cette position)
    
    @constraint(modele, c_6[pos in Ebis], sum(p[r] * y[r,pos] for r in 1:nR) <= P[h] * sum(x[h,pos] for h in 1:nH)) # Idem avec puissance maximale

    @constraint(modele, c_7[t=1:nT, u=1:nU], sum(y[r,pos] for c in Cu[u], r in R[c], pos in E1[u][r][t]) >= z[u,t]) # Unité couverte si un relais compatible avec l'un de ses types de communication est placé sur une position à portée

    @constraint(modele, c_8[b=1:nB], sum(y[r,pos] for c in Cb[b], r in R[c], pos in E2[b][r]) >= 1) # Idem avec bases militaires mais on force la couverture de celles-ci

    @constraint(modele, c_A[u=1:nU], sum(1 - z[u,t] for t in 1:instance.contexte.nT) <= tau)
    
    if liste_renforcements[1] || liste_renforcements[2] == true
         # R1 ou R2
        @variable(modele, omega[Ebis], Bin) 
        @constraint(modele, c_aux[pos in Ebis], omega[pos] == sum(x[h, pos] for h in 1:nH))
    end

    if liste_renforcements[1] == true
        # R1
        @constraint(modele, c_R1[r=1:nR, pos in Ebis], y[r, pos] <= omega[pos])
    end

    if liste_renforcements[2] == true
        # R2
        @constraint(modele, c_R2[pos in Ebis, c=1:nC], sum(y[r,pos] for r in R[c]) <= omega[pos])
    end

    if liste_renforcements[3] == true
        temps_precalcul_domination_HAPS = @elapsed dominationHAPS = domination_HAPS(instance)
        for h in 1:nH
            for h_bis in dominationHAPS[h]
                @constraint(modele,  sum(x[h_bis, pos] for pos in Ebis) <=  sum(x[h, pos] for pos in Ebis)) 
            end
        end
    else
        temps_precalcul_domination_HAPS = 0.0
    end

    if liste_renforcements[4] == true
        temps_precalcul_domination_relais = @elapsed dominationRelais = domination_relais(instance)
        for r in 1:nR
            for r_bis in dominationRelais[r]
                @constraint(modele, sum(y[r_bis, pos] for pos in Ebis) <= sum(y[r, pos] for pos in Ebis))
            end
        end
    else
        temps_precalcul_domination_relais = 0.0
    end

    # Fonctions objectifs
    @addobjective(modele, Max, sum(z[u,t] for u in 1:nU, t in 1:nT))
    @addobjective(modele, Min, tau)

    return modele, temps_precalcul_domination_HAPS, temps_precalcul_domination_relais
end

