function resolution_modele_niveau_1(instance, seeding=false)
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

    # Création du modèle
    println("\n========== Création du modèle ==========")
    temp_creation_modele = @elapsed modele, temps_R3, temps_R4 = creation_modele_niveau_1(instance, Ebis, E1, E2, liste_renforcements, liste_relais_incompatibles, eta, unites_hors_atteinte)

    # Seeding solution (heuristique) : warm start
    if seeding == true
        solution_approchee = resolution_approchee_niveau_1(instance)
        x = modele[:x]
        y = modele[:y]
        for h in 1:instance.contexte.nH
            if solution_approchee.deploiement_haps[h] != []
                pos = solution_approchee.deploiement_haps[h]
                set_start_value(x[h,pos], 1)
                for r in 1:instance.contexte.nR
                    if solution_approchee.placement_relais[r] == h
                        set_start_value(y[r,pos], 1)
                    end
                end
            end
        end
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
    if verbosite == "o"
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
        solution = lecture_resultats_modele_niveau_1(instance, modele, solveur, Ebis, E1, E2)
    elseif statut == 0 # Pas de solution
        solution = Solution(0, 0, Int[], Int[], Int[], Int[], Int[], Int[])
    end

    return solution
end

function creation_modele_niveau_1(instance, Ebis, E1, E2, liste_renforcements, liste_relais_incompatibles=[], eta=0, unites_hors_atteinte=[]) 
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
        x[1:nH, Ebis], Bin # Matrice éventuellement creuse (si positions inactives)
        y[1:nR, Ebis], Bin 
        z[1:nU, 1:nT], Bin
        end)

    # Contraintes
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


    # Fonction objectif
    @objective(modele, Max, sum(z[u,t] for u in 1:nU, t in 1:nT))

    return modele, temps_R3, temps_R4
end

function lecture_resultats_modele_niveau_1(instance, modele, solveur, Ebis, E1, E2, num=0, zILP=0)
    println("\n========== Affichage des résultats ==========")
    if num == 0
        zILP = trunc(Int, objective_value(modele))
    end
    zILP_pourcent = trunc((zILP/(instance.contexte.nU*instance.contexte.nT))*100, digits=2)
    zILP_pourcent = string(zILP_pourcent)
    zILP_temp = split(zILP_pourcent, ".")
    if length(zILP_temp[2]) == 1
        zILP_temp[2] = zILP_temp[2] * " "
    end
    if length(zILP_temp[1]) == 1
        zILP_temp[1] = "  " * zILP_temp[1]
    elseif length(zILP_temp[1]) == 2
        zILP_temp[1] = " " * zILP_temp[1] 
    end
    zILP_pourcent = zILP_temp[1] * "." * zILP_temp[2]

    if num == 0
        choix_relaxation = choix_binaire("\n --> Souhaitez-vous calculer la valeur de la relaxation linéaire (o/n) ? ")
    else
        choix_relaxation = "n"
    end
    if choix_relaxation == "o"
        # Calcul de la solution optimale du problème relaxé (relaxation linéaire)
        modele_bis = copy(modele)
        set_optimizer(modele_bis, solveur)
        relax_integrality(modele_bis)
        set_silent(modele_bis)
        optimize!(modele_bis)
        zLP = objective_value(modele_bis)
        zLP_pourcent = trunc((zLP/(instance.contexte.nU*instance.contexte.nT))*100, digits=2)
        zLP_pourcent = string(zLP_pourcent)
        zLP_temp = split(zLP_pourcent, ".")
        if length(zLP_temp[2]) == 1
            zLP_temp[2] = zLP_temp[2] * " "
        end
        if length(zLP_temp[1]) == 1
            zLP_temp[1] = "  " * zLP_temp[1]
        elseif length(zLP_temp[1]) == 2
            zLP_temp[1] = " " * zLP_temp[1] 
        end
        zLP_pourcent = zLP_temp[1] * "." * zLP_temp[2]
        # Calcul du GAP d'intégrité 
        if zILP == 0.0
            gap = 0.0
        else
            gap = trunc(((zLP - zILP)/zILP)*100, digits=2)
        end
        gap = string(gap)
        gap_temp = split(gap, ".")
        if length(gap_temp[2]) == 1
            gap_temp[2] = gap_temp[2] * " "
        end
        if length(gap_temp[1]) == 1
            gap_temp[1] = "  " * gap_temp[1]
        elseif length(gap_temp[1]) == 2
            gap_temp[1] = " " * gap_temp[1] 
        end
        gap = gap_temp[1] * "." * gap_temp[2]
    else
        zLP_pourcent = "   ?  "
        gap = "   ?  "
    end

    # Affichage des résultats
    println("\n     --------------------------------------------")
    println("     |    zILP (%)  |   zLP (%)   |   GAP (%)   | ")
    println("     --------------------------------------------")
    println("     |    $(zILP_pourcent)    |   $(zLP_pourcent)    |   $(gap)    | ")
    println("     --------------------------------------------")

    println("\n - Nombre total d'unités couvertes : ", zILP, "/", instance.contexte.nU*instance.contexte.nT)
    println("\n - Taux de couverture : $(parse(Float64, zILP_pourcent)) %")

    print("\n --> Appuyez sur la touche \"Entrée\" pour continuer")
    readline()

    
    if num == 0
        x = round.(Int, value.(modele[:x]))
        y = round.(Int, value.(modele[:y]))
    else
        x = round.(Int, value.(modele[:x], num))
        y = round.(Int, value.(modele[:y], num))    
    end
    deploiement_haps = [-1 for i in 1:instance.contexte.nH] # deploiement_haps[h] : position sur laquelle est déployé le HAPS h (si déployé)
    placement_relais = [-1 for i in 1:instance.contexte.nR] # placement_relais[r] : HAPS sur lequel est placé le relais r (si placé)
    for h in 1:instance.contexte.nH
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

    if num == 0
        z = round.(Int, value.(modele[:z])) # On arrondit car Cbc renvoie parfois 0.999999... (tolérance)
    else
        z = round.(Int, value.(modele[:z], num)) # On arrondit car Cbc renvoie parfois 0.999999... (tolérance)  
    end
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

    println("\n========== Affichage des résultats ==========")

    solution = Solution(1, zILP, nb_unites_non_couvertes, deploiement_haps, placement_relais, unites_couvertes, bases_couvertes, Int[])
    return solution
end

function positions_non_couvrantes(instance)
    # Précaluls seuils max
    seuil_max = Vector{Int}(undef, instance.contexte.nC)
    for c in 1:instance.contexte.nC
        seuil_max_temp = -Inf32
        for r in instance.contexte.R[c]
            if instance.contexte.s[r] > seuil_max_temp
                seuil_max_temp = instance.contexte.s[r]
            end
        end 
        seuil_max[c] = seuil_max_temp
    end

    # Calcul des positions inutiles
    E = instance.contexte.E
    total = 0
    for position in 1:instance.contexte.nE
        position_active = false
        u = 1
        while u <= instance.contexte.nU && position_active == false 
             seuil_max_unite = maximum([seuil_max[c] for c in instance.contexte.Cu[u]])
             t = 1
             while t <= instance.contexte.nT  && position_active == false
                pos_unite = instance.scenario.deplacements[u][t]
                if distance_sol_air(instance, pos_unite, E[position]) <= seuil_max_unite
                    position_active = true # Position à portée d'au moins une unité
                end
                t += 1
             end
            u += 1
        end
        b = 1
        while b <= instance.contexte.nB && position_active == false
            pos_base = instance.contexte.Eb[b] 
            seuil_max_base = maximum([seuil_max[c] for c in instance.contexte.Cb[b]])
            if distance_sol_air(instance, pos_base, E[position]) <= seuil_max_base
                position_active = true # Position à portée d'au moins une base
            end
            b += 1
        end
        if position_active == false 
            total += 1
            instance.contexte.Ebool[position] = false
        end
    end
    total_pourcentage = trunc((total/instance.contexte.nE)*100, digits=2)
    println("\n - Nombre de positions désactivées : $total/$(instance.contexte.nE) ($(total_pourcentage) %)")
end

function distance_sol_air(instance, p1, p2)
    A = instance.contexte.A
    return sqrt((p2.x - p1.x)^2 + (p2.y - p1.y)^2 + A^2)
end

function calcul_positions_unites(instance, Ebis)
    E1 = Vector{Vector{Vector{Vector{Int}}}}(undef, instance.contexte.nU)
    # E1[u][r][t] : ensemble des positions à portée de l'unité u pour le relais r
    for u in 1:instance.contexte.nU
        E1[u] = Vector{Vector{Vector{Int}}}(undef, instance.contexte.nR)
        for r in 1:instance.contexte.nR 
            E1[u][r] = Vector{Vector{Int}}(undef, instance.contexte.nT)
            for t in 1:instance.contexte.nT
                E1[u][r][t] = Int[]
                for index_position in Ebis
                    position = instance.contexte.E[index_position]
                    pos_unite = instance.scenario.deplacements[u][t]
                    position_active = instance.contexte.Ebool[index_position]
                    if distance_sol_air(instance, pos_unite, position) <= instance.contexte.s[r]
                        if !(index_position in E1[u][r][t])
                            push!(E1[u][r][t], index_position)
                        end
                    end
                end
            end  
        end
    end 
    return E1
end

function calcul_positions_bases(instance, Ebis)
    E2 = Vector{Vector{Vector{Int}}}(undef, instance.contexte.nB)
    # E2[b][r] : ensemble des positions à portée de la base b pour le relais r
    for b in 1:instance.contexte.nB
        E2[b] = Vector{Vector{Int}}(undef, instance.contexte.nR)
        for r in 1:instance.contexte.nR 
            E2[b][r] = Int[]
            for index_position in Ebis
                position = instance.contexte.E[index_position]
                pos_base = instance.contexte.Eb[b]
                position_active = instance.contexte.Ebool[index_position]
                if distance_sol_air(instance, pos_base, position) <= instance.contexte.s[r] && position_active == true
                    if !(index_position in E2[b][r])
                        push!(E2[b][r], index_position)
                    end
                end
            end  
        end
    end 
    return E2
end

function domination_HAPS(instance)
    dominationHAPS = Vector{Vector{Int}}(undef, instance.contexte.nH)
    # dominationHAPS[h] : ensemble des HAPS dominés par le HAPS h 
    for h in 1:instance.contexte.nH
        dominationHAPS[h] = Int[]
        for h_bis in 1:instance.contexte.nH
            if h_bis != h
                if instance.contexte.W[h_bis] <= instance.contexte.W[h] && instance.contexte.P[h_bis] <= instance.contexte.P[h] 
                    push!(dominationHAPS[h], h_bis)
                end
            end
        end   
    end
    return dominationHAPS
end

function domination_relais(instance)
    dominationRelais = Vector{Vector{Int}}(undef, instance.contexte.nR)
    # dominationRelais[r] : ensemble des relais dominés par le relais r (de même type)
    for c in 1:instance.contexte.nC
        for r in instance.contexte.R[c]
            dominationRelais[r] = Int[]
            for r_bis in instance.contexte.R[c]
                if r_bis != r && r in 1:instance.contexte.nR && r_bis in 1:instance.contexte.nR
                    if instance.contexte.w[r_bis] <= instance.contexte.w[r] && instance.contexte.p[r_bis] <= instance.contexte.p[r] && instance.contexte.s[r_bis] <= instance.contexte.s[r]
                        push!(dominationRelais[r], r_bis)
                    end
                end
            end  
        end 
    end
    return dominationRelais
end

function k_relais_incompatibles(instance, k)
    liste_relais_incompatibles = [] 
    masseMax = maximum(instance.contexte.W)
    puissanceMax = maximum(instance.contexte.P)
    rec_helper(instance, liste_relais_incompatibles, [], 0.0, 0.0, 1, k, masseMax, puissanceMax)
    #println(liste_relais_incompatibles)
    return liste_relais_incompatibles
end

function rec_helper(instance, liste_relais_incompatibles, liste_courante, masse, puissance, r, k, masseMax, puissanceMax)
    if r < instance.contexte.nR
        if length(liste_courante) == k && (masse > masseMax || puissance > puissanceMax)
            push!(liste_relais_incompatibles, liste_courante)
        elseif length(liste_courante) < k
            liste_courante_gauche = copy(liste_courante)
            rec_helper(instance, liste_relais_incompatibles, liste_courante_gauche, masse, puissance, r+1, k, masseMax, puissanceMax) # récursion à gauche 
            liste_courante_droite = copy(liste_courante)
            push!(liste_courante_droite, r)
            masse_droite = masse + instance.contexte.w[r]
            puissance_droite = masse + instance.contexte.p[r]
            rec_helper(instance, liste_relais_incompatibles, liste_courante_droite, masse_droite, puissance_droite, r+1, k, masseMax, puissanceMax) # récursion à droite     
        end
    end
end

function borne_superieure_nombre_relais_par_position(instance)
    eta = [-Inf32]
    masseMax = maximum(instance.contexte.W)
    puissanceMax = maximum(instance.contexte.P)
    rec_helper_bis(instance, eta, [], 0.0, 0.0, 1, masseMax, puissanceMax)
    return eta[1]
end

function rec_helper_bis(instance, eta, liste_courante, masse, puissance, r, masseMax, puissanceMax)
    if r < instance.contexte.nR
        if masse < masseMax && puissance < puissanceMax
            if length(liste_courante) > eta[1]
                eta[1] = length(liste_courante)
            end
            liste_courante_gauche = copy(liste_courante)
            rec_helper_bis(instance, eta, liste_courante_gauche, masse, puissance, r+1, masseMax, puissanceMax) # récursion à gauche 
            liste_courante_droite = copy(liste_courante)
            push!(liste_courante_droite, r)
            masse_droite = masse + instance.contexte.w[r]
            puissance_droite = masse + instance.contexte.p[r]
            rec_helper_bis(instance, eta, liste_courante_droite, masse_droite, puissance_droite, r+1, masseMax, puissanceMax) # récursion à droite     
        end
    end
end

function unites_hors_atteinte_instant_t(instance, Ebis)
    unites_hors_atteinte = []
    # Précaluls seuils max
    seuil_max = Vector{Int}(undef, instance.contexte.nC)
    for c in 1:instance.contexte.nC
        seuil_max_temp = -Inf32
        for r in instance.contexte.R[c]
            if instance.contexte.s[r] > seuil_max_temp
                seuil_max_temp = instance.contexte.s[r]
            end
        end 
        seuil_max[c] = seuil_max_temp
    end
    for t in 1:instance.contexte.nT
        instant_t = []
        for u in 1:instance.contexte.nU
            atteignable = false
            for c in instance.contexte.Cu[u]
                for position in Ebis
                    pos_unite = instance.scenario.deplacements[u][t]
                    seuil_max_unite = maximum([seuil_max[c] for c in instance.contexte.Cu[u]])
                    if distance_sol_air(instance, pos_unite, instance.contexte.E[position]) <= seuil_max_unite
                        atteignable = true # Au moins une position à portée de l'unité 
                    end                  
                end
            end
            if atteignable == false
                push!(instant_t, u)
            end
        end 
        push!(unites_hors_atteinte, instant_t)
    end
    return unites_hors_atteinte
end

##### Code inutilisé #####

function calcul_couples_inutiles(instance, Ebis)
    K = Vector{Vector{Int}}(undef, instance.contexte.nE)
    # K[e] : ensemble des relais inutiles à la position e (ne peuvent couvrir aucune unité de même type de communication)
    total = 0
    for index_position in Ebis
        K[index_position] = Int[]
        for c in 1:instance.contexte.nC
            for r in instance.contexte.R[c]
                relais_inutile = true
                position = instance.contexte.E[index_position]
                u = 1
                while u <= instance.contexte.nU && relais_inutile == true
                    if c in instance.contexte.Cu[u] # si unité dispose de ce type de communication
                        t = 1
                        while t <= instance.contexte.nT && relais_inutile == true
                            pos_unite = instance.scenario.deplacements[u][t]
                            if distance_sol_air(instance, position, pos_unite) <= instance.contexte.s[r]
                                relais_inutile = false
                            end
                            t += 1
                        end
                    end
                    u += 1
                end
                b = 1
                while b <= instance.contexte.nB && relais_inutile == true
                    if c in instance.contexte.Cb[b]
                        pos_base = instance.contexte.Eb[b]
                        if distance_sol_air(instance, position, pos_base) <= instance.contexte.s[r]
                            relais_inutile = false
                        end
                    end
                    b += 1
                end
                if relais_inutile == true
                    total += 1
                    push!(K[index_position], r)
                end
            end
        end
    end
    total_pourcentage = trunc((total/(instance.contexte.nR * length(Ebis)))*100, digits=2)
    println("\n - Nombre de couples (relais,position) inutiles : $total/$(instance.contexte.nR * length(Ebis)) ($total_pourcentage %)")
    return K
end




