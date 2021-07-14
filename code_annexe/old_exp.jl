function test()
    bibliotheque = "0"
    # Lecture du contexte
    chemin_contexte = "bibliotheques_instances/"*bibliotheque*"/contexte.txt"
    contexte = lire_contexte(chemin_contexte)
    temps_n = 0.0
    temps_o = 0.0
    for i in 1:10
        println(" - scenario $i")
        # Lecture du scénario
        chemin_scenario = "bibliotheques_instances/"*bibliotheque*"/scenarios/scenario_"*string(i)*".txt"
        scenario = lire_scenario(chemin_scenario, contexte)
        # Création de l'instance
        instance = Instance(contexte, scenario)
        # Pré-calculs essentiels
        Ebis = Int[] # On cherche les positions actives (sous-ensemble de positions)
        for position in 1:instance.contexte.nE
            if instance.contexte.Ebool[position] == true # position active
                push!(Ebis, position)
            end
        end
        K = []
        temps_precalcul_positions_unites = @elapsed E1 = calcul_positions_unites(instance, Ebis)
        temps_precalcul_positions_bases = @elapsed E2 = calcul_positions_bases(instance, Ebis)
        modele = creation_modele_niveau_1(instance, Ebis, K, E1, E2, true, true)
        set_optimizer(modele, Gurobi.Optimizer)
        optimize!(modele)
        temps_n += solve_time(modele)

        K = calcul_couples_inutiles(instance, Ebis)
        modele = creation_modele_niveau_1(instance, Ebis, K, E1, E2, true, true)
        set_optimizer(modele, Gurobi.Optimizer)
        optimize!(modele)
        temps_o += solve_time(modele)
        println("    - temps o : $temps_o")
        println("    - temps n : $temps_n")
    end
    temps_o = temps_o/10
    temps_n = temps_n/10
    println(" o : ", temps_o)
    println(" n : ", temps_n)
end

function temp_1()
    bibliotheque = "0"
    # Lecture du contexte
    chemin_contexte = "bibliotheques_instances/"*bibliotheque*"/contexte.txt"
    contexte = lire_contexte(chemin_contexte)
    z = 0.0
    t = 0.0
    for i in 1:10
        println(" - scenario $i")
        # Lecture du scénario
        chemin_scenario = "bibliotheques_instances/"*bibliotheque*"/scenarios/scenario_"*string(i)*".txt"
        scenario = lire_scenario(chemin_scenario, contexte)
        # Création de l'instance
        instance = Instance(contexte, scenario)
        # Pré-calculs essentiels
        z_temp, t_temp = temp(instance)
        println("    -  z : $z")
        println("    -  t : $t")
        z += z_temp
        t += t_temp
    end
    z = z/10
    t = t/10
    println("    -  z : $z")
    println("    -  t : $t")
end

function temp(instance)
    deb = time()
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
    modele = creation_modele_heuristique_2(instance, Ebis, E1, E2) 
    set_optimizer(modele, Gurobi.Optimizer)

    #set_time_limit_sec(modele, 10)
    optimize!(modele)
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
    modele = creation_modele_N1(instance, Ebis_new, E1, E2, true, true) 
    set_optimizer(modele, Gurobi.Optimizer)
    optimize!(modele)

    z1 = trunc(Int, objective_value(modele))
    z1 = z1/(instance.contexte.nU*instance.contexte.nT)*100
    t = time()-deb
    return z1, t
end
