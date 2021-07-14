########### Importations ###########

# Système
using Dates
using Random

# Affichage graphique
using PyCall
using PyPlot
#pygui(:qt5)
#Path = PyPlot.matplotlib.path.Path

# Modélisation
using JuMP

# Solveurs libres
using GLPK
using Cbc
using SCIP
#using vOptGeneric

# Solveurs commerciaux
using Gurobi
#using CPLEX
#using MosekTools

# Divers
include("ascii_art.jl")

# Essentiels
include("structures.jl")
include("parser.jl")
include("utilitaires.jl")
include("visualisation.jl")
include("controles_saisies.jl")
include("parametres_solveurs.jl")

# Résolution exacte
include("resolution_exacte_N1.jl") # Couverture 
include("resolution_exacte_N2.jl") # Messages 

# Résolution biobjectif
#include("bi_objectif.jl") 

# Résolution approchée
include("resolution_approchee_N1.jl")

function exemple()
    liste_bib = ["0", "A_1"]# "A_2", "A_3", "A_4", "A_5", "A_6", "A_7", "A_8", "A_9", "A_10", "A_11", "A_12", "B_1", "B_2", "B_3", "B_4", "B_5", "B_6", "B_7", "B_8", "B_9", "B_10", "B_11", "B_12"]
#liste_bib = ["C_1", "C_2", "C_3", "C_4", "C_5", "C_6", "C_7", "C_8", "C_9", "C_10", "C_11", "C_12", "D_1", "D_2", "D_3", "D_4", "D_5", "D_6", "D_7", "D_8", "D_9", "D_10", "D_11", "D_12"]
    resultats = ""
    for bibliotheque in liste_bib
        println(" - Bibliothèque : $bibliotheque")
        io = open("resultats", "w") # Fichier de sortie pour les résultats
        chemin_contexte = "bibliotheques_instances/"*bibliotheque*"/contexte.txt"
        contexte = lire_contexte(chemin_contexte)
        for solveur in [Gurobi.Optimizer] # [Gurobi.Optimizer, CPLEX.Optimizer, Cbc.Optimizer, GLPK.Optimizer, Mosek.Optimizer, SCIP.Optimizer]
            println("     - Solveur : $solveur")
            tMoy = 0.0
            tMin = Inf32
            tMax = -Inf32
            optMoy = 0.0
            optMin = Inf32
            optMax = -Inf32
            n = 0 # Nombre d'instances résolues dans le temps imparti
            for i in 1:20
                println("         - Scenario $i")
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
                temps_precalcul_positions_unites = @elapsed E1 = calcul_positions_unites(instance, Ebis)
                temps_precalcul_positions_bases = @elapsed E2 = calcul_positions_bases(instance, Ebis)
                liste_renforcements = [true, true, false, false, false, false, false]
                modele, _ = creation_modele_niveau_1(instance, Ebis, E1, E2, liste_renforcements)
                set_time_limit_sec(modele, 600) 
                set_optimizer(modele, solveur)
                optimize!(modele)
                if termination_status(modele) == MOI.OPTIMAL
                    n += 1
                    t_temp = solve_time(modele)  
                    tMoy += t_temp
                    if t_temp < tMin
                        tMin = t_temp      
                    end
                    if t_temp > tMax
                        tMax = t_temp           
                    end    
                    zILP = trunc(Int, objective_value(modele))
                    zILP_pourcent = trunc((zILP/(instance.contexte.nU*instance.contexte.nT))*100, digits=2) 
                    optMoy += zILP_pourcent 
                    if zILP_pourcent < optMin
                        optMin = zILP_pourcent      
                    end
                    if zILP_pourcent > optMax
                        optMax = zILP_pourcent           
                    end      
                end           
            end
            tMoy = tMoy/n
            optMoy = optMoy/n
            println(solveur)
            println(" tMin : ", tMin)
            println(" tMoy : ", tMoy)
            println(" tMax : ", tMax)
            println(" n : ", n)
            println(" optMin : ", optMin)
            println(" optMoy : ", optMoy)
            println(" optMax : ", optMax)
            resultats *= "$bibliotheque & " * string(n) * " & "  * string(round(tMin, digits=2)) * " & " * string(round(tMoy, digits=2)) * " & " * string(round(tMax,digits=2)) * " & " * string(round(optMin, digits=2)) * " & " * string(round(optMoy, digits=2)) * " & " * string(round(optMax,digits=2)) * " \\\\ \n"  
        end
        #println(res)
        write(io, resultats)
        close(io)
    end
    println("\n==================== \n")
    println(resultats)
    println("==================== \n")
end

exemple()
