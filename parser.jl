
########## Lecture d'une instance ##########

function lecture_instance()
    bibliotheque = choix_bibliotheque()

    # Lecture du contexte
    chemin_contexte = "bibliotheques_instances/"*bibliotheque*"/contexte.txt"
    contexte = lire_contexte(chemin_contexte)

    # Lecture du scénario
    scenario = choix_scenario(bibliotheque)
    chemin_scenario = "bibliotheques_instances/"*bibliotheque*"/scenarios/"*scenario
    scenario = lire_scenario(chemin_scenario, contexte)

    # Création de l'instance
    instance = Instance(contexte, scenario)

    return instance
end

function choix_bibliotheque()
    # Choix d'une bibliothèque d'instances
    liste_bibliotheques = readdir("bibliotheques_instances/")
    println("\n Choix de la bibliothèque d'instances : ")
    println(" -------------------------------------- ")
    for i in 1:length(liste_bibliotheques)
        println("     $i) $(liste_bibliotheques[i])")
    end
    choix = choix_multiple("\n --> Votre choix : ", length(liste_bibliotheques))
    bibliotheque = liste_bibliotheques[choix]
    return bibliotheque
end

function choix_scenario(bibliotheque)
    # Choix d'un scénario
    liste_scenarios = readdir("bibliotheques_instances/"*bibliotheque*"/scenarios/")
    println("\n Choix du scénario : ")
    println(" ------------------- ")
    for i in 1:length(liste_scenarios)
        println("     $i) $(liste_scenarios[i])")
    end
    choix = choix_multiple("\n --> Votre choix : ", length(liste_scenarios))
    scenario = liste_scenarios[choix]
    return scenario
end

########## Lecture (parsing) du contexte ##########

function lire_contexte(chemin)
    # Parsing
    lignes = Vector{String}
    open(chemin) do fichier
        lignes = readlines(fichier)
    end

    ligne = 1
    while lignes[ligne] == ""
        ligne += 1
    end 
    ligne += 1

    # Données élémentaires
    nT, nH, nE, nC, nU, nB = parse.(Int, split(lignes[ligne], ","))

    ligne += 1
    while lignes[ligne] == ""
        ligne += 1
    end 
    ligne += 1

    # Altitude
    A = parse(Int, lignes[ligne])

    ligne += 1
    while lignes[ligne] == ""
        ligne += 1
    end 
    ligne += 1

    # Relais
    nRc = [elt for elt in parse.(Int, split(lignes[ligne], ","))] # nRc[c] : nombre de relais de type c
    nR = sum(nRc)
    
    # Construction de l'"ensemble" des relais par type de communication
    # R[c] = [] ensemble des relais de type c
    R = Vector{Vector{Int}}(undef, nC)
    cpt_r = 1
    for c in 1:nC
        temp_r = Vector{Int}(undef, nRc[c])
        for r in 1:nRc[c]
            temp_r[r] = cpt_r
            cpt_r += 1
        end
        R[c] = temp_r
    end

    ligne += 1
    while lignes[ligne] == ""
        ligne += 1
    end 
    ligne += 1


    # Types de communications (par unité) : 1 unité par ligne
    # Cu[u] = [] ensemble des types de communication de l'unité u
    Cu = Vector{Vector{Int}}(undef, nU)
    for u in 1:nU
        Cu[u] = [elt for elt in parse.(Int, split(lignes[ligne], ","))]
        ligne += 1
    end  

    ligne += 1
    while lignes[ligne] == ""
        ligne += 1
    end 
    ligne += 1

    # Types de communications (par base) : 1 base par ligne
    # Cb[b] = [] ensemble des types de communication de la base b
    Cb = Vector{Vector{Int}}(undef, nB)
    for b in 1:nB
        Cb[b] = [elt for elt in parse.(Int, split(lignes[ligne], ","))]
        ligne += 1
    end    

    ligne += 1
    while lignes[ligne] == ""
        ligne += 1
    end 
    ligne += 1  

    # Positions des bases : 1 base par ligne
    # Eb[b] = (x,y) : position base b (point)
    Eb = Vector{Point}(undef, nB)
    for base in 1:nB
        x, y = parse.(Int, split(lignes[ligne], ","))
        point = Point(x, y)
        Eb[base] = point
        ligne += 1
    end

    ligne += 1
    while lignes[ligne] == ""
        ligne += 1
    end 
    ligne += 1

    # Positions envisageables pour le déploiement : 1 position par ligne
    # E[i] = (x,y) : position i (point)
    E = Vector{Point}(undef, nE)
    Ebool = Vector{Bool}(undef, nE) # Liste des positions actives | Ebool[i] = 0 : position inactive (non-couvrante)
    for i in 1:nE
        x, y = parse.(Int, split(lignes[ligne], ","))
        point = Point(x, y)
        E[i] = point
        Ebool[i] = true
        ligne += 1
    end

    ligne += 1
    while lignes[ligne] == ""
        ligne += 1
    end 
    ligne += 1

    # Poids et puissance de chacun des HAPS : 1 HAPS par ligne 
    # W[h] : poids HAPS h
    # P[h] : puissance HAPS h
    W = Vector{Int}(undef, nH)
    P = Vector{Int}(undef, nH)
    for i in 1:nH
        W[i], P[i] = parse.(Int, split(lignes[ligne], ","))
        ligne += 1
    end

    ligne += 1
    while lignes[ligne] == ""
        ligne += 1
    end 
    ligne += 1
        
    # Poids, puissance et portée (seuil) de chacun des relais : 1 paragraphe par type de relais, une ligne par relais de chaque type
    # w[r] : poids relais r
    # p[r] : puissance relais r
    # s[r] : portée (seuil) relais r
    w = Vector{Int}(undef, nR)
    p = Vector{Int}(undef, nR)
    s = Vector{Int}(undef, nR)
    for c in 1:nC
        for r in R[c]
            w[r], p[r], s[r] = parse.(Int, split(lignes[ligne], ","))
            if r != R[c][end]
                ligne += 1
            end
        end
        if c != nC
            ligne += 1
            while lignes[ligne] == ""
                ligne += 1
            end 
            ligne += 1
        end
    end
   
    contexte = Contexte(nT, nH, nE, nC, nU, nB, nR, nRc, A, R, Cu, Cb, Eb, E, Ebool, W, P, w, p, s)
    return contexte
end

########## Lecture (parsing) du scénario ##########

function lire_scenario(chemin, contexte)
    # Parsing
    lignes = Vector{String}
    open(chemin) do fichier
        lignes = readlines(fichier)
    end
    
    # Ensemble des déplacements des unités
    # deplacements[u] : déplacements de l'unité u
    # deplacements[u][t] : position de l'unité u au temps t
    deplacements = Vector{Vector{Point}}(undef, contexte.nU)
    ligne = 2
    for u in 1:contexte.nU
        deplacements[u] = Vector{Point}(undef, contexte.nT)
        temp = split(lignes[ligne], ")")
        temp = split.(temp[1:end-1], "(")
        popfirst!.(temp)
        for t in 1:contexte.nT
           coord = parse.(Float64, split(string(temp[t][1]), ","))
           deplacements[u][t] = Point(coord[1], coord[2])
        end
        ligne += 3
    end
    scenario = Scenario(deplacements)
    return scenario
end

