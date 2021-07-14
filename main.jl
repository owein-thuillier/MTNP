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
using vOptGeneric

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
include("resolution_biobjectif_N1.jl") 

# Résolution approchée
include("resolution_approchee_N1.jl")

########### Programme principal ###########

function main()
    # Nettoyage de la console
    clear()
    ascii_art_mtnp()

    # Choix de l'instance
    instance = lecture_instance()
    
    # Affichage du contexte
    choix = choix_binaire("\n --> Souhaitez-vous afficher le contexte (o/n) ? ")
    if choix == "o"
        affichage_contexte(instance)
    end

    # Visualisation du scenario
    choix = choix_binaire("\n --> Souhaitez-vous visualiser le scénario (o/n) ? ")
    if choix == "o"
        visualisation_scenario(instance)
    end

    # Poursuivre vers la résolution
    choix = choix_binaire("\n --> Souhaitez-vous poursuivre vers la résolution (o/n) ? ")
    if choix == "o"
        # Choix du niveau
        println("\n Choix du niveau :")
        println(" -----------------")
        println("    1) Niveau 1 (localisation et couverture) ")       
        println("    2) Niveau 2 (connexité) ")       
        choix = choix_multiple("\n --> Votre choix : ", 2)            
        if choix == 1
            solution = choix_resolution_niveau_1(instance)        
        elseif choix == 2
            solution = choix_resolution_niveau_2(instance)       
        end

        # Visualisation de la solution
        if solution.statut == 1
            choix = choix_binaire("\n --> Souhaitez-vous visualiser la solution (o/n) ? ")
            if choix == "o"
                visualisation(instance, solution)
            end
        end
    end

    # Fin
    ascii_art_fin()
end


function choix_resolution_niveau_1(instance)
    # Résolution
    println("\n Choix de la méthode de résolution : ")
    println(" -----------------------------------")
    println("    Niveau 1 - monoobjectif ")
    println("    1) Résolution exacte")
    println("    2) Résolution approchée (heuristique) ")
    println("    Niveau 2 - biobjectif ")
    println("    3) Résolution exacte")
    choix = choix_multiple("\n --> Votre choix : ", 3) 
    if choix == 1
        solution = resolution_modele_niveau_1(instance)
    elseif choix == 2
        solution = resolution_approchee_niveau_1(instance)
    elseif choix == 3
        solution = resolution_modele_niveau_1_biobj(instance)
    end
    return solution
end

function choix_resolution_niveau_2(instance)
    # Résolution
    println("\n Choix de la méthode de résolution : ")
    println(" -----------------------------------")
    println("    Niveau 2 ")
    println("    1) Variante A : cas Asymétrique ")
    println("    2) Variante A : cas Symétrique ")
    println("    3) Variante B : cas Asymétrique ")
    println("    4) Variante B : cas Symétrique ")
    choix = choix_multiple("\n --> Votre choix : ", 4) 
    if choix == 1
        solution = resolution_modele_niveau_2(instance, 1)
    elseif choix == 2
        solution = resolution_modele_niveau_2(instance, 2)
    elseif choix == 3
        solution = resolution_modele_niveau_2(instance, 3)
    elseif choix == 4
        solution = resolution_modele_niveau_2(instance, 4)    
    end
    return solution
end





main()






