function resolution_modele_niveau_2(instance)
    # Pré-traitement
    choix_pretraitement = choix_binaire("\n --> Souhaitez-vous désactiver les positions non-couvrantes (o/n) ? ")
    if choix_pretraitement == "o"
        temps_pretraitement = @elapsed positions_non_couvrantes(instance)
    end

    Ebis = Int[] # On cherche les positions actives (sous-ensemble de positions)
    for position in 1:instance.contexte.nE
        if instance.contexte.Ebool[position] == true # position active
            push!(Ebis, position)
        end
    end

    # Pré-calculs (niveau 1 : couverture)
    temps_precalcul_unites = @elapsed E1 = calcul_positions_unites(instance, Ebis) # positions à portée d'une unité pour un relais donné (et un temps donné)
    temps_precalcul_bases = @elapsed E2 = calcul_positions_bases(instance, Ebis) # positions à portée d'une base pour un relais donné

    # Pré-calculs (niveau 2 : messages)
    temps_precalcul_positions = @elapsed E3 = calcul_positions_relais(instance, Ebis) # positions à portée d'une autre position pour un relais donné

    # Création du modèle
    println("\n========== Création du modèle ==========")
    choix = choix_binaire("\n --> Souhaitez-vous ajouter la contrainte additionnelle R1 (o/n) ? ")
    ajout_R1 = choix == "o" ? true : false
    choix = choix_binaire("\n --> Souhaitez-vous ajouter la contrainte additionnelle R2 (o/n) ? ")
    ajout_R2 = choix == "o" ? true : false
    temp_creation_modele = @elapsed modele = creation_modele_niveau_2(instance, Ebis, E1, E2, E3, ajout_R1, ajout_R2)
 
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
    println("\n Choix du solveur : ")
    println(" ------------------ ")
    println("    Non-commerciaux ")
    println("    1) GLPK (GNU Linear Programming Kit)")
    println("    2) CBC (COIN-OR Branch and Cut)")
    println("    3) SCIP (Solving Constraint Integer Programs)")
    println("    Commerciaux ")
    println("    4) Gurobi")
    println("    5) CPLEX")
    println("    6) Mosek")
    choix = choix_multiple("\n --> Votre choix : ", 6) 
    if choix == 1
        set_optimizer(modele, GLPK.Optimizer)
        choix_verbosite = gestion_parametres_GLPK(modele)
    elseif choix == 2
        set_optimizer(modele, Cbc.Optimizer)
        choix_verbosite = gestion_parametres_CBC(modele)
    elseif choix == 3
         set_optimizer(modele, SCIP.Optimizer)
         choix_verbosite = gestion_parametres_SCIP(modele)
    elseif choix == 4
        print("\n - ") 
        set_optimizer(modele, Gurobi.Optimizer)
        choix_verbosite = gestion_parametres_Gurobi(modele)
    elseif choix == 5
        set_optimizer(modele, CPLEX.Optimizer)
        choix_verbosite = gestion_parametres_CPLEX(modele)
    elseif choix == 6
        set_optimizer(modele, Mosek.Optimizer)
        choix_verbosite = gestion_parametres_Mosek(modele)
    end

    # Limite de temps 
    choix_p1 = choix_binaire("\n --> Souhaitez-vous fixer une limite de temps (o/n) ? ")
    if choix_p1 == "o"
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
    if choix_pretraitement == "o"
        println("\n - Temps pré-traitement : $(trunc(temps_pretraitement, digits=precision)) seconde(s)")
    end
    println("\n - Temps pré-calcul n°1 (unités) : $(trunc(temps_precalcul_unites, digits=precision)) seconde(s)")
    println("\n - Temps pré-calcul n°2 (bases) : $(trunc(temps_precalcul_bases, digits=precision)) seconde(s)")
    println("\n - Temps pré-calcul n°3 (positions/relais) : $(trunc(temps_precalcul_positions, digits=precision)) seconde(s)")
    println("\n - Temps création modèle : $(trunc(temp_creation_modele, digits=precision)) seconde(s)")
    println("\n - Temps résolution : $(trunc(temps_resolution, digits=precision)) seconde(s)")
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
        println("\n - Échec : temps limite de résolution atteint (> $(temps_limite/(10^3)) seconde(s)) ")
        statut = 0
    end

    if statut == 1 # Solution disponible
        print("\n --> Appuyez sur la touche \"Entrée\" pour afficher les résultats")
        readline()
        solution = lecture_resultats_modele_niveau_2(instance, modele, Ebis, E1, E2)
    elseif statut == 0 # Pas de solution
        solution = Solution(0, 0, Int[], Int[], Int[], Int[], Int[])
    end

    return solution
end

function creation_modele_niveau_2(instance, Ebis, E1, E2, E3, ajout_R1, ajout_R2)
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
        a_bis[Ebis, Ebis], Bin 
        sigma[1:nC, Ebis], Bin
        f[Ebis, Ebis, Ebis] >= 0, Int
        d[Ebis, Ebis], Int
        end)

    # Contraintes niveau 1
    @constraint(modele, c_1[h=1:nH], sum(x[h,pos] for pos in Ebis) <= 1)

    @constraint(modele, c_2[pos in Ebis], sum(x[h,pos] for h in 1:nH) <= 1)

    @constraint(modele, c_3[r=1:nR], sum(y[r,pos] for pos in Ebis) <= 1)

    @constraint(modele, c_4[pos in Ebis], sum(w[r] * y[r,pos] for r in 1:nR) <= sum(W[h] * x[h,pos] for h in 1:nH))

    @constraint(modele, c_5[pos in Ebis], sum(p[r] * y[r,pos] for r in 1:nR) <= sum(P[h] * x[h,pos] for h in 1:nH))

    @constraint(modele, c_6[t=1:nT, u=1:nU], sum(y[r,pos] for c in Cu[u], r in R[c], pos in E1[u][r][t]) >= 1 - z[u,t] )

    @constraint(modele, c_7[b=1:nB], sum(y[r,pos] for c in Cb[b], r in R[c], pos in E2[b][r]) >= 1)

    # Contraintes niveau 2
    @constraint(modele, c_8[pos in Ebis], d[pos,pos] == sum(x[h,pos_bis] for h in 1:nH, pos_bis in Ebis) - 1)

    @constraint(modele, c_9[pos in Ebis, pos_bis in Ebis; pos != pos_bis], d[pos,pos_bis] == -sum(x[h,pos_bis] for h in 1:nH))

    @constraint(modele, c_10[pos in Ebis, c in 1:nC], sigma[c,pos] <= sum(y[r,pos] for r in R[c]))

    @constraint(modele, c_11[c in 1:nC, r in R[c], pos in Ebis, pos_bis in E3[pos][r]], a[pos,pos_bis,r] <= (1/2)*(y[r,pos] + sigma[c,pos_bis]))

    @constraint(modele, c_11_bis[r in 1:nR, pos in Ebis, pos_bis in Ebis; !(pos_bis in E3[pos][r])], a[pos,pos_bis,r] == 0)

    @constraint(modele, c_12[pos in Ebis, pos_bis in Ebis; pos != pos_bis], a_bis[pos,pos_bis] <= sum(a[pos,pos_bis,r] for r in 1:nR))

    @constraint(modele, c_13[i in Ebis, pos in Ebis, pos_bis in Ebis; pos != pos_bis], f[pos,pos_bis,i] <= (nH - 1)*a_bis[pos,pos_bis])

    @constraint(modele, c_14[i in Ebis, pos in Ebis], sum(f[pos_bis,pos,i] for pos_bis in Ebis if pos_bis!=pos) + d[pos,i] - sum(f[pos,pos_bis,i] for pos_bis in Ebis if pos_bis!=pos) <= (nH - 1)*(1 - sum(x[h,pos] for h in 1:nH)) )

    @constraint(modele, c_14_bis[i in Ebis, pos in Ebis], sum(f[pos_bis,pos,i] for pos_bis in Ebis if pos_bis!=pos) + d[pos,i] - sum(f[pos,pos_bis,i] for pos_bis in Ebis if pos_bis!=pos) >= -(nH - 1)*(1 - sum(x[h,pos] for h in 1:nH)) )

    # Contraintes renforcement
    if ajout_R1 == true
        @constraint(modele, c_R1[pos in Ebis, c=1:nC], sum(y[r,pos] for r in R[c]) <= 1)
    end
    
    if ajout_R2 == true
        @variable(modele, temp[1:nE], Bin) 
        @constraint(modele, c_R21[pos in Ebis], temp[pos] == sum(x[h, pos] for h in 1:nH))
        @constraint(modele, c_R22[pos in Ebis, r=1:nR], y[r, pos] <= temp[pos])
    end

    # Fonction objectif
    @objective(modele, Min, sum(z[u,t] for u in 1:nU, t in 1:nT))

    return modele
end

function lecture_resultats_modele_niveau_2(instance, modele, Ebis, E1, E2)
    println("\n========== Affichage des résultats ==========")
    z1 = trunc(Int, objective_value(modele))
    println("\n --> Nombre total d'unités non couvertes : ", z1, "/", instance.contexte.nU*instance.contexte.nT, " (",trunc((z1/(instance.contexte.nU*instance.contexte.nT))*100, digits=2),"%)")

    d = round.(Int, value.(modele[:d]))
    println(d)
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
            if z[u,t] == 0 # L'unité u est couverte au temps t
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
            elseif z[u,t] == 1
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
 
    recepteur = round.(Int, value.(modele[:sigma]))
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
