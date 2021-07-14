function choix_solveur(modele)
    #liste_solveurs = [GLPK.Optimizer, Cbc.Optimizer, SCIP.Optimizer, Gurobi.Optimizer, CPLEX.Optimizer, Mosek.Optimizer]
    liste_solveurs = [GLPK.Optimizer, Cbc.Optimizer, SCIP.Optimizer, Gurobi.Optimizer, Mosek.Optimizer]
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
    println("")
    solveur = liste_solveurs[choix] 
    return solveur
end

function choix_verbosite(modele, solveur)
    if solveur == GLPK.Optimizer
        verbosite = gestion_parametres_GLPK(modele)
    elseif solveur == Cbc.Optimizer
        verbosite = gestion_parametres_CBC(modele)
    elseif solveur == SCIP.Optimizer
        set_optimizer(modele, SCIP.Optimizer)
        verbosite = gestion_parametres_SCIP(modele)
    elseif solveur == Gurobi.Optimizer
        verbosite = gestion_parametres_Gurobi(modele)
    elseif solveur == CPLEX.Optimizer
        verbosite = gestion_parametres_CPLEX(modele)
    elseif solveur == Mosek.Optimizer
        verbosite = gestion_parametres_Mosek(modele)
    end
    return verbosite
end


function gestion_parametres_GLPK(modele)
    choix_verbosite = choix_binaire("\n --> Souhaitez-vous obtenir les détails de la résolution (o/n) ? ")
    if choix_verbosite == "o"
        set_optimizer_attribute(modele, "msg_lev", 3)
    end
    return choix_verbosite
end

function gestion_parametres_CBC(modele)
    choix_verbosite = choix_binaire("\n --> Souhaitez-vous obtenir les détails de la résolution (o/n) ? ")
    if choix_verbosite == "n"
        # CBC verbeux par défaut
        set_optimizer_attribute(modele, "logLevel", 0)
    end
    return choix_verbosite
end

function gestion_parametres_SCIP(modele)
    choix_verbosite = choix_binaire("\n --> Souhaitez-vous obtenir les détails de la résolution (o/n) ? ")
    if choix_verbosite == "n"
        # SCIP verbeux par défaut
        set_optimizer_attribute(modele, "display/verblevel", 0)
    end
    return choix_verbosite
end

function gestion_parametres_CPLEX(modele)
    choix_verbosite = choix_binaire("\n --> Souhaitez-vous obtenir les détails de la résolution (o/n) ? ")
    if choix_verbosite == "n"
        # CPLEX verbeux par défaut
        set_optimizer_attribute(modele, "CPX_PARAM_SCRIND", 0)
    end
    return choix_verbosite
end

function gestion_parametres_Gurobi(modele)
    choix_verbosite = choix_binaire("\n --> Souhaitez-vous obtenir les détails de la résolution (o/n) ? ")
    if choix_verbosite == "n"
        # Gurobi verbeux par défaut
        set_optimizer_attribute(modele, "OutputFlag", 0)    
    end
    return choix_verbosite
end

function gestion_parametres_Mosek(modele)
    choix_verbosite = choix_binaire("\n --> Souhaitez-vous obtenir les détails de la résolution (o/n) ? ")
    if choix_verbosite == "n"
        # Mosek verbeux par défaut
        set_optimizer_attribute(modele, "LOG", 0)    
    end
    return choix_verbosite
end
