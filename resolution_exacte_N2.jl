function resolution_modele_niveau_2(instance, variante)
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

    # Pré-calculs essentiels (niveau 1 : couverture)
    temps_precalcul_positions_unites = @elapsed E1 = calcul_positions_unites(instance, Ebis) # positions à portée d'une unité pour un relais donné (et un temps donné)
    temps_precalcul_positions_bases = @elapsed E2 = calcul_positions_bases(instance, Ebis) # positions à portée d'une base pour un relais donné

    # Pré-calculs essentiels (niveau 2 : messages)
    temps_precalcul_positions_relais = @elapsed E3 = calcul_positions_relais(instance, Ebis) # positions à portée d'une autre position pour un relais donné

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

    # Création du modèle
    println("\n========== Création du modèle ==========")
    if variante == 1
        temp_creation_modele = @elapsed modele, temps_R3, temps_R4 = creation_modele_niveau_2_A_A(instance, Ebis, E1, E2, E3, liste_renforcements, liste_relais_incompatibles, eta, unites_hors_atteinte)
    elseif variante == 2
        temp_creation_modele = @elapsed modele, temps_R3, temps_R4 = creation_modele_niveau_2_A_S(instance, Ebis, E1, E2, E3, liste_renforcements, liste_relais_incompatibles, eta, unites_hors_atteinte)   
    elseif variante == 3
        temp_creation_modele = @elapsed modele, temps_R3, temps_R4 = creation_modele_niveau_2_B_A(instance, Ebis, E1, E2, E3, liste_renforcements, liste_relais_incompatibles, eta, unites_hors_atteinte)       
    elseif variante == 4
        temp_creation_modele = @elapsed modele, temps_R3, temps_R4 = creation_modele_niveau_2_B_S(instance, Ebis, E1, E2, E3, liste_renforcements, liste_relais_incompatibles, eta, unites_hors_atteinte)      
    end
 
    println("\n - Nombre de variables : ", num_variables(modele))
    nb_contraintes = 0
    for (F, S) in list_of_constraint_types(modele)
        nb_contraintes += num_constraints(modele, F, S)
    end
    println("\n - Nombre de contraintes : ", nb_contraintes)
    choix = choix_binaire("\n --> Souhaitez-vous enregistrer le modèle dans un fichier (o/n) ? ")
    if choix == "o"
        nom_dossier = string(today())*"_"*Dates.format(now(), "HH:MM:SS")
        run(`mkdir modeles/$(nom_dossier)`)
        write_to_file(modele, "modeles/$(nom_dossier)/modele.dat", format=MOI.FileFormats.FORMAT_LP)
        println("\n /!\\ Le modèle est disponible dans le dossier \"modeles/$(nom_dossier)/\" /!\\ ")
    end
    println("\n========== Création du modèle ==========")
   
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

    if termination_status(modele) == MOI.INFEASIBLE
        println("\n - Échec : problème non réalisable")
        statut = 0
    elseif termination_status(modele) == MOI.OPTIMAL # Solution optimale
        println("\n - Solution optimale trouvée")
        statut = 1
    elseif termination_status(modele) == MOI.TIME_LIMIT && has_values(modele) # Temps limite atteint mais solution réalisable sous-optimale disponible
        println("\n - Solution réalisable (possiblement sous-optimale) trouvée dans le temps imparti")
        statut = 1
    elseif termination_status(modele) == MOI.TIME_LIMIT # Temps limite atteint et pas de solution
        println("\n - Échec : temps limite de résolution atteint (> $(temps_limite) seconde(s)) ")
        statut = 0
    end

    if statut == 1 # Solution disponible
        print("\n --> Appuyez sur la touche \"Entrée\" pour afficher les résultats")
        readline()
        solution = lecture_resultats_modele_niveau_2(instance, modele, Ebis, E1, E2)
    elseif statut == 0 # Pas de solution
        solution = Solution(0, 0, Int[], Int[], Int[], Int[], Int[], Int[])
    end

    return solution
end

function creation_modele_niveau_2_A_A(instance, Ebis, E1, E2, E3, liste_renforcements, liste_relais_incompatibles, eta, unites_hors_atteinte)
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
 
    # Variables niveau 1  
    @variables(modele, begin 
        x[1:nH, Ebis], Bin # Matrice éventuellement creuse (si positions inactives)
        y[1:nR, Ebis], Bin # ""    @ Main ~/src/resolution_exacte_N1.jl:237
        z[1:nU, 1:nT], Bin
        end)

    # Contraintes niveau 1
    @constraint(modele, c_1[h in 1:nH], sum(x[h,pos] for pos in Ebis) <= 1) # Un HAPS peut être déployé sur, au plus, une position

    @constraint(modele, c_2[pos in Ebis], sum(x[h,pos] for h in 1:nH) <= 1) # Une position peut accueillir, au plus, un HAPS

    @constraint(modele, c_3[pos in Ebis], sum(x[h,pos] for h in 1:nH) <= sum(y[r,pos] for r in 1:nR)) # Si aucun relais placé sur une position, alors pas de HAPS déployé sur cette position

    @constraint(modele, c_4[r in 1:nR], sum(y[r,pos] for pos in Ebis) <= 1) # Un relais peut être placé sur, au plus, une position

    @constraint(modele, c_5[pos in Ebis], sum(w[r] * y[r,pos] for r in 1:nR) <= W[h] * sum(x[h,pos] for h in 1:nH)) # Respect de la masse maximale au sein du HAPS déployé sur une position (si HAPS déployé, autrement pas de relais sur cette position)
    
    @constraint(modele, c_6[pos in Ebis], sum(p[r] * y[r,pos] for r in 1:nR) <= P[h] * sum(x[h,pos] for h in 1:nH)) # Idem avec puissance maximale

    @constraint(modele, c_7[t=1:nT, u=1:nU], sum(y[r,pos] for c in Cu[u], r in R[c], pos in E1[u][r][t] if r in 1:nR) >= z[u,t]) # Unité couverte si un relais compatible avec l'un de ses types de communication est placé sur une position à portée

    @constraint(modele, c_8[b=1:nB], sum(y[r,pos] for c in Cb[b], r in R[c], pos in E2[b][r] if r in 1:nR) >= 1) # Idem avec bases militaires mais on force la couverture de celles-ci
    
    if liste_renforcements[1] || liste_renforcements[2] == true
        # R1 ou R2
        @variable(modele, omega[Ebis], Bin) 
        @constraint(modele, c_aux[pos in Ebis], omega[pos] == sum(x[h, pos] for h in 1:nH))
    end

    if liste_renforcements[1] == true
        # R1
        @constraint(modele, c_R1[r in 1:nR, pos in Ebis], y[r, pos] <= omega[pos])
    end

    if liste_renforcements[2] == true
        # R2
        @constraint(modele, c_R2[pos in Ebis, c=1:nC], sum(y[r,pos] for r in R[c] if r in 1:nR) <= omega[pos])
    end

    if liste_renforcements[3] == true
        temps_R3 = @elapsed dominationHAPS = domination_HAPS(instance)
        for h in 1:nH
            for h_bis in dominationHAPS[h]
                @constraint(modele,  sum(x[h_bis, pos] for pos in Ebis) <=  sum(x[h, pos] for pos in Ebis)) 
            end
        end
    else
        temps_R3 = 0.0
    end

    if liste_renforcements[4] == true
        temps_R4 = @elapsed dominationRelais = domination_relais(instance)
        for r in 1:nR
            for r_bis in dominationRelais[r]
                @constraint(modele, sum(y[r_bis, pos] for pos in Ebis) <= sum(y[r, pos] for pos in Ebis))
            end
        end
    else
        temps_R4 = 0.0
    end
  
    if liste_renforcements[5] == true
         @constraint(modele, c_R5[uplet in liste_relais_incompatibles, pos in Ebis], sum(y[r, pos] for r in uplet) <= length(uplet)-1)      
    end
   
    if liste_renforcements[6] == true
         @constraint(modele, c_R6[pos in Ebis], sum(y[r, pos] for r in 1:nR) <= eta)      
    end
    
    if liste_renforcements[7] == true
        @constraint(modele, c_R7[t in 1:nT, u in unites_hors_atteinte[t]], z[u,t] == 0)      
    end
    
    # Variables niveau 2
   @variables(modele, begin 
        a[Ebis, Ebis, 1:nR], Bin
        f[Ebis, Ebis, Ebis] >= 0
        sigma[Ebis, Ebis], Bin
   end)
    
    # Contraintes niveau 2
    d = Array{Int, 2}(undef, nE, nE)
    for pos in Ebis
        for pos_bis in Ebis
            if pos == pos_bis
                d[pos,pos_bis] = nH - 1
            else
                d[pos,pos_bis] = -1
            end
        end
    end
    
    #@constraint(modele, c_11[c in 1:nC, r in R[c], pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= (1/2)*(y[r,pos] + sum(y[r_bis,pos_bis] for r_bis in R[c] if r!=r_bis)))

    @constraint(modele, c_11[r in 1:nR, pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= y[r,pos])
    @constraint(modele, c_11_bis[r in 1:nR, pos in Ebis, pos_bis in Ebis; !(pos_bis in E3[pos][r])], a[pos,pos_bis,r] == 0)
    @constraint(modele, c_11_ter[c in 1:nC, r in R[c], pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= sum(y[r_bis,pos_bis] for r_bis in R[c] if r!=r_bis))

    @constraint(modele, c_12[i in Ebis, pos in Ebis, pos_bis in Ebis; pos != pos_bis], f[pos,pos_bis,i] <= nH*sum(a[pos,pos_bis,r] for r in 1:nR))
    #@constraint(modele, c_12[pos in Ebis, pos_bis in Ebis; pos != pos_bis], sum(f[pos,pos_bis,i] for i in Ebis) <= nE*nH*sum(a[pos,pos_bis,r] for r in 1:nR))

    @constraint(modele, c_13[pos in Ebis, pos_bis in Ebis], omega[pos] + omega[pos_bis] - 1 <= sigma[pos,pos_bis])

    @constraint(modele, c_14[i in Ebis, pos in Ebis], sum(f[pos_bis,pos,i] for pos_bis in Ebis if pos_bis!=pos) + d[pos,i]*sigma[pos,i] >= sum(f[pos,pos_bis,i] for pos_bis in Ebis if pos_bis!=pos))

    # Fonction objectif
    @objective(modele, Max, sum(z[u,t] for u in 1:nU, t in 1:nT))

    return modele, temps_R3, temps_R4
end

function creation_modele_niveau_2_A_S(instance, Ebis, E1, E2, E3, liste_renforcements, liste_relais_incompatibles, eta, unites_hors_atteinte)
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
 
    # Variables niveau 1  
    @variables(modele, begin 
        x[1:nH, Ebis], Bin # Matrice éventuellement creuse (si positions inactives)
        y[1:nR, Ebis], Bin # ""    @ Main ~/src/resolution_exacte_N1.jl:237
        z[1:nU, 1:nT], Bin
        end)

    # Contraintes niveau 1
    @constraint(modele, c_1[h in 1:nH], sum(x[h,pos] for pos in Ebis) <= 1) # Un HAPS peut être déployé sur, au plus, une position

    @constraint(modele, c_2[pos in Ebis], sum(x[h,pos] for h in 1:nH) <= 1) # Une position peut accueillir, au plus, un HAPS

    @constraint(modele, c_3[pos in Ebis], sum(x[h,pos] for h in 1:nH) <= sum(y[r,pos] for r in 1:nR)) # Si aucun relais placé sur une position, alors pas de HAPS déployé sur cette position

    @constraint(modele, c_4[r in 1:nR], sum(y[r,pos] for pos in Ebis) <= 1) # Un relais peut être placé sur, au plus, une position

    @constraint(modele, c_5[pos in Ebis], sum(w[r] * y[r,pos] for r in 1:nR) <= W[h] * sum(x[h,pos] for h in 1:nH)) # Respect de la masse maximale au sein du HAPS déployé sur une position (si HAPS déployé, autrement pas de relais sur cette position)
    
    @constraint(modele, c_6[pos in Ebis], sum(p[r] * y[r,pos] for r in 1:nR) <= P[h] * sum(x[h,pos] for h in 1:nH)) # Idem avec puissance maximale

    @constraint(modele, c_7[t=1:nT, u=1:nU], sum(y[r,pos] for c in Cu[u], r in R[c], pos in E1[u][r][t] if r in 1:nR) >= z[u,t]) # Unité couverte si un relais compatible avec l'un de ses types de communication est placé sur une position à portée

    @constraint(modele, c_8[b=1:nB], sum(y[r,pos] for c in Cb[b], r in R[c], pos in E2[b][r] if r in 1:nR) >= 1) # Idem avec bases militaires mais on force la couverture de celles-ci
    
    if liste_renforcements[1] || liste_renforcements[2] == true
         # R1 ou R2
        @variable(modele, omega[Ebis], Bin) 
        @constraint(modele, c_aux[pos in Ebis], omega[pos] == sum(x[h, pos] for h in 1:nH))
    end

    if liste_renforcements[1] == true
        # R1
        @constraint(modele, c_R1[r in 1:nR, pos in Ebis], y[r, pos] <= omega[pos])
    end

    if liste_renforcements[2] == true
        # R2
        @constraint(modele, c_R2[pos in Ebis, c=1:nC], sum(y[r,pos] for r in R[c] if r in 1:nR) <= omega[pos])
    end

    if liste_renforcements[3] == true
        temps_R3 = @elapsed dominationHAPS = domination_HAPS(instance)
        for h in 1:nH
            for h_bis in dominationHAPS[h]
                @constraint(modele,  sum(x[h_bis, pos] for pos in Ebis) <=  sum(x[h, pos] for pos in Ebis)) 
            end
        end
    else
        temps_R3 = 0.0
    end

    if liste_renforcements[4] == true
        temps_R4 = @elapsed dominationRelais = domination_relais(instance)
        for r in 1:nR
            for r_bis in dominationRelais[r]
                @constraint(modele, sum(y[r_bis, pos] for pos in Ebis) <= sum(y[r, pos] for pos in Ebis))
            end
        end
    else
        temps_R4 = 0.0
    end
  
    if liste_renforcements[5] == true
         @constraint(modele, c_R5[uplet in liste_relais_incompatibles, pos in Ebis], sum(y[r, pos] for r in uplet) <= length(uplet)-1)      
    end
   
    if liste_renforcements[6] == true
         @constraint(modele, c_R6[pos in Ebis], sum(y[r, pos] for r in 1:nR) <= eta)      
    end
    
    if liste_renforcements[7] == true
        @constraint(modele, c_R7[t in 1:nT, u in unites_hors_atteinte[t]], z[u,t] == 0)      
    end
    
    # Variables niveau 2
   @variables(modele, begin 
        a[Ebis, Ebis, 1:nR], Bin
        f[Ebis, Ebis, Ebis] >= 0
        sigma[Ebis, Ebis], Bin
   end)
    
    # Contraintes niveau 2
    d = Array{Int, 2}(undef, nE, nE)
    for pos in Ebis
        for pos_bis in Ebis
            if pos == pos_bis
                d[pos,pos_bis] = nH - 1
            else
                d[pos,pos_bis] = -1
            end
        end
    end
    
    #@constraint(modele, c_11[c in 1:nC, r in R[c], pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= (1/2)*(y[r,pos] + sum(y[r_bis,pos_bis] for r_bis in R[c] if r!=r_bis)))

    @constraint(modele, c_11[r in 1:nR, pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= y[r,pos])
    @constraint(modele, c_11_bis[r in 1:nR, pos in Ebis, pos_bis in Ebis; !(pos_bis in E3[pos][r])], a[pos,pos_bis,r] == 0)
    @constraint(modele, c_11_ter[c in 1:nC, r in R[c], pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= sum(y[r_bis,pos_bis] for r_bis in R[c] if r!=r_bis))

    @constraint(modele, c_12[i in Ebis, pos in Ebis, pos_bis in Ebis; pos != pos_bis], f[pos,pos_bis,i] <= nH*sum(a[pos,pos_bis,r] for r in 1:nR))
    #@constraint(modele, c_12[pos in Ebis, pos_bis in Ebis; pos != pos_bis], sum(f[pos,pos_bis,i] for i in Ebis) <= nE*nH*sum(a[pos,pos_bis,r] for r in 1:nR))
    
    @constraint(modele, c_S[pos in Ebis, pos_bis in Ebis], sum(a[pos,pos_bis,r] for r in 1:nR) <= nC*sum(a[pos_bis,pos,r] for r in 1:nR))

    @constraint(modele, c_13[pos in Ebis, pos_bis in Ebis], omega[pos] + omega[pos_bis] - 1 <= sigma[pos,pos_bis])

    @constraint(modele, c_14[i in Ebis, pos in Ebis], sum(f[pos_bis,pos,i] for pos_bis in Ebis if pos_bis!=pos) + d[pos,i]*sigma[pos,i] >= sum(f[pos,pos_bis,i] for pos_bis in Ebis if pos_bis!=pos))

    # Fonction objectif
    @objective(modele, Max, sum(z[u,t] for u in 1:nU, t in 1:nT))

    return modele, temps_R3, temps_R4
end


function creation_modele_niveau_2_B_A(instance, Ebis, E1, E2, E3, liste_renforcements, liste_relais_incompatibles, eta, unites_hors_atteinte)
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
 
    # Variables niveau 1 
    @variables(modele, begin 
        x[1:nH, Ebis], Bin # Matrice éventuellement creuse (si positions inactives)
        y[1:nR, Ebis], Bin # ""    @ Main ~/src/resolution_exacte_N1.jl:237
        z[1:nU, 1:nT], Bin
        end)

    # Contraintes niveau 1
    @constraint(modele, c_1[h in 1:nH], sum(x[h,pos] for pos in Ebis) <= 1) # Un HAPS peut être déployé sur, au plus, une position

    @constraint(modele, c_2[pos in Ebis], sum(x[h,pos] for h in 1:nH) <= 1) # Une position peut accueillir, au plus, un HAPS

    @constraint(modele, c_3[pos in Ebis], sum(x[h,pos] for h in 1:nH) <= sum(y[r,pos] for r in 1:nR)) # Si aucun relais placé sur une position, alors pas de HAPS déployé sur cette position

    @constraint(modele, c_4[r in 1:nR], sum(y[r,pos] for pos in Ebis) <= 1) # Un relais peut être placé sur, au plus, une position

    @constraint(modele, c_5[pos in Ebis], sum(w[r] * y[r,pos] for r in 1:nR) <= W[h] * sum(x[h,pos] for h in 1:nH)) # Respect de la masse maximale au sein du HAPS déployé sur une position (si HAPS déployé, autrement pas de relais sur cette position)
    
    @constraint(modele, c_6[pos in Ebis], sum(p[r] * y[r,pos] for r in 1:nR) <= P[h] * sum(x[h,pos] for h in 1:nH)) # Idem avec puissance maximale

    @constraint(modele, c_7[t=1:nT, u=1:nU], sum(y[r,pos] for c in Cu[u], r in R[c], pos in E1[u][r][t] if r in 1:nR) >= z[u,t]) # Unité couverte si un relais compatible avec l'un de ses types de communication est placé sur une position à portée

    @constraint(modele, c_8[b=1:nB], sum(y[r,pos] for c in Cb[b], r in R[c], pos in E2[b][r] if r in 1:nR) >= 1) # Idem avec bases militaires mais on force la couverture de celles-ci
    
    if liste_renforcements[1] || liste_renforcements[2] == true
         # R1 ou R2
        @variable(modele, omega[Ebis], Bin) 
        @constraint(modele, c_aux[pos in Ebis], omega[pos] == sum(x[h, pos] for h in 1:nH))
    end

    if liste_renforcements[1] == true
        # R1
        @constraint(modele, c_R1[r in 1:nR, pos in Ebis], y[r, pos] <= omega[pos])
    end

    if liste_renforcements[2] == true
        # R2
        @constraint(modele, c_R2[pos in Ebis, c=1:nC], sum(y[r,pos] for r in R[c] if r in 1:nR) <= omega[pos])
    end

    if liste_renforcements[3] == true
        temps_R3 = @elapsed dominationHAPS = domination_HAPS(instance)
        for h in 1:nH
            for h_bis in dominationHAPS[h]
                @constraint(modele,  sum(x[h_bis, pos] for pos in Ebis) <=  sum(x[h, pos] for pos in Ebis)) 
            end
        end
    else
        temps_R3 = 0.0
    end

    if liste_renforcements[4] == true
        temps_R4 = @elapsed dominationRelais = domination_relais(instance)
        for r in 1:nR
            for r_bis in dominationRelais[r]
                @constraint(modele, sum(y[r_bis, pos] for pos in Ebis) <= sum(y[r, pos] for pos in Ebis))
            end
        end
    else
        temps_R4 = 0.0
    end
  
    if liste_renforcements[5] == true
         @constraint(modele, c_R5[uplet in liste_relais_incompatibles, pos in Ebis], sum(y[r, pos] for r in uplet) <= length(uplet)-1)      
    end
   
    if liste_renforcements[6] == true
         @constraint(modele, c_R6[pos in Ebis], sum(y[r, pos] for r in 1:nR) <= eta)      
    end
    
    if liste_renforcements[7] == true
        @constraint(modele, c_R7[t in 1:nT, u in unites_hors_atteinte[t]], z[u,t] == 0)      
    end
    
    # Variables niveau 2
    @variables(modele, begin 
        a[Ebis, Ebis, 1:nR], Bin
        f[Ebis, Ebis, Ebis] >= 0
        OMEGA[Ebis, Ebis], Bin
        sigma[1:nB, Ebis], Bin
        a_bis[Ebis, Ebis, 1:nB], Bin
        a_reel[Ebis, Ebis], Bin
    end)
    
    # Contraintes niveau 2
    d = Array{Int, 2}(undef, nE, nE)
    for pos in Ebis
        for pos_bis in Ebis
            if pos == pos_bis
                d[pos,pos_bis] = nH - 1
            else
                d[pos,pos_bis] = -1
            end
        end
    end

    #@constraint(modele, c_11[c in 1:nC, r in R[c], pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= (1/2)*(y[r,pos] + sum(y[r_bis,pos_bis] for r_bis in R[c] if r!=r_bis)))

    @constraint(modele, c_11[r in 1:nR, pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= y[r,pos])
    @constraint(modele, c_11_bis[r in 1:nR, pos in Ebis, pos_bis in Ebis; !(pos_bis in E3[pos][r])], a[pos,pos_bis,r] == 0)
    @constraint(modele, c_11_ter[c in 1:nC, r in R[c], pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= sum(y[r_bis,pos_bis] for r_bis in R[c] if r!=r_bis))

    #@constraint(modele, c_12[i in Ebis, pos in Ebis, pos_bis in Ebis; pos != pos_bis], f[pos,pos_bis,i] <= nH*(sum(a[pos,pos_bis,r] for r in 1:nR) + sum(a_bis[pos,pos_bis,b] for b in 1:nB)))
    @constraint(modele, c_12[i in Ebis, pos in Ebis, pos_bis in Ebis; pos != pos_bis], f[pos,pos_bis,i] <= nH*a_reel[pos,pos_bis])

    #@constraint(modele, c_12[pos in Ebis, pos_bis in Ebis; pos != pos_bis], sum(f[pos,pos_bis,i] for i in Ebis) <= nE*nH*sum(a[pos,pos_bis,r] for r in 1:nR))

    @constraint(modele, c_13[pos in Ebis, pos_bis in Ebis], omega[pos] + omega[pos_bis] - 1 <= OMEGA[pos,pos_bis])

    @constraint(modele, c_14[i in Ebis, pos in Ebis], sum(f[pos_bis,pos,i] for pos_bis in Ebis if pos_bis!=pos) + d[pos,i]*OMEGA[pos,i] >= sum(f[pos,pos_bis,i] for pos_bis in Ebis if pos_bis!=pos))
    
    
    @constraint(modele, c_15[pos in Ebis, pos_bis in Ebis, b in 1:nB; pos_bis != pos], a_bis[pos,pos_bis,b] <= sigma[b,pos])
    @constraint(modele, c_15_bis[pos in Ebis, pos_bis in Ebis, b in 1:nB; pos_bis != pos], a_bis[pos,pos_bis,b] <= sigma[b,pos_bis])
    
    @constraint(modele, c_16[b in 1:nB, pos in Ebis], sigma[b,pos] <= sum(y[r,pos] for c in Cb[b], r in R[c] if pos in E2[b][r]))  
     
    @constraint(modele, c_17[pos in Ebis, pos_bis in Ebis; pos != pos_bis], a_reel[pos,pos_bis] <= sum(a[pos,pos_bis,r] for r in 1:nR) + sum(a_bis[pos,pos_bis,b] for b in 1:nB))


    # Fonction objectif
    @objective(modele, Max, sum(z[u,t] for u in 1:nU, t in 1:nT))

    return modele, temps_R3, temps_R4
end

function creation_modele_niveau_2_B_S(instance, Ebis, E1, E2, E3, liste_renforcements, liste_relais_incompatibles, eta, unites_hors_atteinte)
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
 
    # Variables niveau 1  
    @variables(modele, begin 
        x[1:nH, Ebis], Bin # Matrice éventuellement creuse (si positions inactives)
        y[1:nR, Ebis], Bin # ""    @ Main ~/src/resolution_exacte_N1.jl:237
        z[1:nU, 1:nT], Bin
        end)

    # Contraintes niveau 1
    @constraint(modele, c_1[h in 1:nH], sum(x[h,pos] for pos in Ebis) <= 1) # Un HAPS peut être déployé sur, au plus, une position

    @constraint(modele, c_2[pos in Ebis], sum(x[h,pos] for h in 1:nH) <= 1) # Une position peut accueillir, au plus, un HAPS

    @constraint(modele, c_3[pos in Ebis], sum(x[h,pos] for h in 1:nH) <= sum(y[r,pos] for r in 1:nR)) # Si aucun relais placé sur une position, alors pas de HAPS déployé sur cette position

    @constraint(modele, c_4[r in 1:nR], sum(y[r,pos] for pos in Ebis) <= 1) # Un relais peut être placé sur, au plus, une position

    @constraint(modele, c_5[pos in Ebis], sum(w[r] * y[r,pos] for r in 1:nR) <= W[h] * sum(x[h,pos] for h in 1:nH)) # Respect de la masse maximale au sein du HAPS déployé sur une position (si HAPS déployé, autrement pas de relais sur cette position)
    
    @constraint(modele, c_6[pos in Ebis], sum(p[r] * y[r,pos] for r in 1:nR) <= P[h] * sum(x[h,pos] for h in 1:nH)) # Idem avec puissance maximale

    @constraint(modele, c_7[t=1:nT, u=1:nU], sum(y[r,pos] for c in Cu[u], r in R[c], pos in E1[u][r][t] if r in 1:nR) >= z[u,t]) # Unité couverte si un relais compatible avec l'un de ses types de communication est placé sur une position à portée

    @constraint(modele, c_8[b=1:nB], sum(y[r,pos] for c in Cb[b], r in R[c], pos in E2[b][r] if r in 1:nR) >= 1) # Idem avec bases militaires mais on force la couverture de celles-ci
    
    if liste_renforcements[1] || liste_renforcements[2] == true
         # R1 ou R2
        @variable(modele, omega[Ebis], Bin) 
        @constraint(modele, c_aux[pos in Ebis], omega[pos] == sum(x[h, pos] for h in 1:nH))
    end

    if liste_renforcements[1] == true
        # R1
        @constraint(modele, c_R1[r in 1:nR, pos in Ebis], y[r, pos] <= omega[pos])
    end

    if liste_renforcements[2] == true
        # R2
        @constraint(modele, c_R2[pos in Ebis, c=1:nC], sum(y[r,pos] for r in R[c] if r in 1:nR) <= omega[pos])
    end

    if liste_renforcements[3] == true
        temps_R3 = @elapsed dominationHAPS = domination_HAPS(instance)
        for h in 1:nH
            for h_bis in dominationHAPS[h]
                @constraint(modele,  sum(x[h_bis, pos] for pos in Ebis) <=  sum(x[h, pos] for pos in Ebis)) 
            end
        end
    else
        temps_R3 = 0.0
    end

    if liste_renforcements[4] == true
        temps_R4 = @elapsed dominationRelais = domination_relais(instance)
        for r in 1:nR
            for r_bis in dominationRelais[r]
                @constraint(modele, sum(y[r_bis, pos] for pos in Ebis) <= sum(y[r, pos] for pos in Ebis))
            end
        end
    else
        temps_R4 = 0.0
    end
  
    if liste_renforcements[5] == true
         @constraint(modele, c_R5[uplet in liste_relais_incompatibles, pos in Ebis], sum(y[r, pos] for r in uplet) <= length(uplet)-1)      
    end
   
    if liste_renforcements[6] == true
         @constraint(modele, c_R6[pos in Ebis], sum(y[r, pos] for r in 1:nR) <= eta)      
    end
    
    if liste_renforcements[7] == true
        @constraint(modele, c_R7[t in 1:nT, u in unites_hors_atteinte[t]], z[u,t] == 0)      
    end
    
    # Variables niveau 2
    @variables(modele, begin 
        a[Ebis, Ebis, 1:nR], Bin
        f[Ebis, Ebis, Ebis] >= 0
        OMEGA[Ebis, Ebis], Bin
        sigma[1:nB, Ebis], Bin
        a_bis[Ebis, Ebis, 1:nB], Bin
        a_reel[Ebis, Ebis], Bin
    end)    
    
    # Contraintes niveau 2
    d = Array{Int, 2}(undef, nE, nE)
    for pos in Ebis
        for pos_bis in Ebis
            if pos == pos_bis
                d[pos,pos_bis] = nH - 1
            else
                d[pos,pos_bis] = -1
            end
        end
    end

    #@constraint(modele, c_11[c in 1:nC, r in R[c], pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= (1/2)*(y[r,pos] + sum(y[r_bis,pos_bis] for r_bis in R[c] if r!=r_bis)))

    @constraint(modele, c_11[r in 1:nR, pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= y[r,pos])
    @constraint(modele, c_11_bis[r in 1:nR, pos in Ebis, pos_bis in Ebis; !(pos_bis in E3[pos][r])], a[pos,pos_bis,r] == 0)
    @constraint(modele, c_11_ter[c in 1:nC, r in R[c], pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= sum(y[r_bis,pos_bis] for r_bis in R[c] if r!=r_bis))

    #@constraint(modele, c_12[i in Ebis, pos in Ebis, pos_bis in Ebis; pos != pos_bis], f[pos,pos_bis,i] <= nH*(sum(a[pos,pos_bis,r] for r in 1:nR) + sum(a_bis[pos,pos_bis,b] for b in 1:nB)))
    @constraint(modele, c_12[i in Ebis, pos in Ebis, pos_bis in Ebis; pos != pos_bis], f[pos,pos_bis,i] <= nH*a_reel[pos,pos_bis])

    #@constraint(modele, c_12[pos in Ebis, pos_bis in Ebis; pos != pos_bis], sum(f[pos,pos_bis,i] for i in Ebis) <= nE*nH*sum(a[pos,pos_bis,r] for r in 1:nR))
    
    @constraint(modele, c_S[pos in Ebis, pos_bis in Ebis], sum(a[pos,pos_bis,r] for r in 1:nR) <= nC*sum(a[pos_bis,pos,r] for r in 1:nR))

    @constraint(modele, c_13[pos in Ebis, pos_bis in Ebis], omega[pos] + omega[pos_bis] - 1 <= OMEGA[pos,pos_bis])

    @constraint(modele, c_14[i in Ebis, pos in Ebis], sum(f[pos_bis,pos,i] for pos_bis in Ebis if pos_bis!=pos) + d[pos,i]*OMEGA[pos,i] >= sum(f[pos,pos_bis,i] for pos_bis in Ebis if pos_bis!=pos))
    
    @constraint(modele, c_15[pos in Ebis, pos_bis in Ebis, b in 1:nB; pos_bis != pos], a_bis[pos,pos_bis,b] <= sigma[b,pos])
    @constraint(modele, c_15_bis[pos in Ebis, pos_bis in Ebis, b in 1:nB; pos_bis != pos], a_bis[pos,pos_bis,b] <= sigma[b,pos_bis])
       
    @constraint(modele, c_16[b in 1:nB, pos in Ebis], sigma[b,pos] <= sum(y[r,pos] for c in Cb[b], r in R[c] if pos in E2[b][r]))  
     
    @constraint(modele, c_17[pos in Ebis, pos_bis in Ebis; pos != pos_bis], a_reel[pos,pos_bis] <= sum(a[pos,pos_bis,r] for r in 1:nR) + sum(a_bis[pos,pos_bis,b] for b in 1:nB))

    # Fonction objectif
    @objective(modele, Max, sum(z[u,t] for u in 1:nU, t in 1:nT))

    return modele, temps_R3, temps_R4
end



function lecture_resultats_modele_niveau_2(instance, modele, Ebis, E1, E2)
    println("\n========== Affichage des résultats ==========")
    z1 = trunc(Int, objective_value(modele))
    println("\n --> Nombre total d'unités non couvertes : ", z1, "/", instance.contexte.nU*instance.contexte.nT, " (",trunc((z1/(instance.contexte.nU*instance.contexte.nT))*100, digits=2),"%)")

    x = round.(Int, value.(modele[:x]))
    y = round.(Int, value.(modele[:y]))
    deploiement_haps = [-1 for i in 1:instance.contexte.nH] # deploiement_haps[h] : position sur laquelle est déployé le HAPS h (si déployé)
    placement_relais = [-1 for i in 1:instance.contexte.nR] # placement_relais[r] : HAPS sur lequel est placé le relais r (si placé)
    for h in 1:instance.contexte.nH
        deploye = false
        for pos in Ebis
            if x[h,pos] == 1
                position = instance.contexte.E[pos]
                println("\n - HAPS $h déployé à la position ($(position.x), $(position.y))")
                deploiement_haps[h] = pos
                for c in 1:instance.contexte.nC
                    for r in instance.contexte.R[c]
                        if y[r,pos] == 1
                            println("\n     - Relais $r (type $c) placé dans ce HAPS")
                            placement_relais[r] = h
                        end
                    end
                end
            end
        end
    end

    z = round.(Int, value.(modele[:z])) # On arrondit car Cbc renvoie parfois 0.999999... (tolérance)
    unites_couvertes = Vector{Vector{Vector{Vector{Int}}}}(undef, instance.contexte.nU) # unites_couvertes[u][t][c] : ensemble des HAPS couvrant l'unité u au temps t pour le type de communication c (dont dispose l'unité u)
    nb_unites_non_couvertes = [0 for i in 1:instance.contexte.nT]
    for u in 1:instance.contexte.nU
        unites_couvertes[u] = Vector{Vector{Vector{Int}}}(undef, instance.contexte.nT)
        for t in 1:instance.contexte.nT
            unites_couvertes[u][t] = [Int[] for c in 1:instance.contexte.nC]
            if z[u,t] == 1 # L'unité u est couverte au temps t
                for c in instance.contexte.Cu[u]
                    # On cherche par quel(s) types de communication
                    for h in 1:instance.contexte.nH
                        # Par quel HAPS
                        for r in instance.contexte.R[c]
                            # Quel relais
                            for pos in E1[u][r][t] 
                                # Positions potentiellement couvrantes si relais r placé
                                if x[h,pos] == 1 && y[r,pos] == 1
                                    # Si HAPS déployé ET relais déployé alors unité couverte par ce HAPS et pour ce type de communication                        
                                    push!(unites_couvertes[u][t][c], h)
                                    break
                                end
                            end
                        end
                    end
                end
                nb_unites_non_couvertes[t] += 1
            end
        end        
    end

    bases_couvertes = Vector{Vector{Vector{Int}}}(undef, instance.contexte.nB) # unites_couvertes[b][c] : ensemble des HAPS couvrant l'unité b pour le type de communication c (dont dispose l'unité u)
    for b in 1:instance.contexte.nB
        bases_couvertes[b] = [Int[] for c in 1:instance.contexte.nC]
        for c in instance.contexte.Cb[b]
            for h in 1:instance.contexte.nH
            # Par quel HAPS
                for r in instance.contexte.R[c]
                    # Quel relais
                    for pos in E2[b][r] 
                        # Positions potentiellement couvrantes si relais r placé
                        if x[h,pos] == 1 && y[r,pos] == 1
                            # Si HAPS déployé ET relais déployé alors base couverte par ce HAPS et pour ce type de communication                        
                            push!(bases_couvertes[b][c], h)
                            break
                        end
                    end
               end 
            end           
        end
    end
 
    #recepteur = round.(Int, value.(modele[:sigma]))
    arcs = round.(Int, value.(modele[:a]))
    transmission_haps = Vector{Vector{Vector{Int}}}(undef, instance.contexte.nH) # transmission_haps[h][c] : HAPS vers lequel le HAPS h peut transmettre via le type de communication c
    for h in 1:instance.contexte.nH
        transmission_haps[h] = [Int[] for c in 1:instance.contexte.nC]
    end
    for pos in Ebis
        for pos_bis in Ebis
            for c in 1:instance.contexte.nC
                for r in instance.contexte.R[c]
                    if arcs[pos,pos_bis,r] == 1 # transmission de la position pos vers la position pos_bis via le relais r de type c
                        for h in 1:instance.contexte.nH
                            for h_bis in 1:instance.contexte.nH
                                if x[h,pos] == 1 && x[h_bis, pos_bis] == 1
                                    #println(" Transmission de $h vers $h_bis par relais $r de type $c")
                                    #println(" ET $(recepteur[c,pos_bis])")
                                    push!(transmission_haps[h][c], h_bis)
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    println("\n========== Affichage des résultats ==========")

    solution = Solution(1, z1, nb_unites_non_couvertes, deploiement_haps, placement_relais, unites_couvertes, bases_couvertes, transmission_haps)
    return solution
end

function distance_air_air(instance, p1, p2)
    return sqrt((p2.x - p1.x)^2 + (p2.y - p1.y)^2)
end

function calcul_positions_relais(instance, Ebis)
    E3 = Vector{Vector{Vector{Int}}}(undef, instance.contexte.nE)
    # E3[e][r] : ensemble des positions à portée de la position e pour le relais r
    for position in Ebis
        E3[position] = Vector{Vector{Int}}(undef, instance.contexte.nR)
        for r in 1:instance.contexte.nR
            E3[position][r] = Int[]
            for position_bis in 1:instance.contexte.nE
                p1 = instance.contexte.E[position]
                p2 = instance.contexte.E[position_bis]
                position_active = instance.contexte.Ebool[position]
                position_bis_active = instance.contexte.Ebool[position_bis]
                if distance_air_air(instance, p1, p2) <= instance.contexte.s[r] && position != position_bis && position_active == true && position_bis_active == true
                    push!(E3[position][r], position_bis)
                end
            end
        end
    end
    return E3
end


