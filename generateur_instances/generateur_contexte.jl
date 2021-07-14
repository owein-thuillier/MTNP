########### Importations ###########

# Dépendances
using Dates
using Random

# Essentiels
include("controles_saisies.jl")	


########## Générateur de contexte ##########

function generation_contexte()
    # Nettoyage de la console
    clear()

    println("\n========== Générateur de contexte ==========")
    contexte = ""
    
    print("\n --> Nombre d'états : ")
    nT = readline()
    contexte *= "// Nombre d'états (#T), de HAPS (#H), de positions envisageables pour le déploiement (#E) de types de communication (#C), d'unités (#U) et de bases (#B)\n"
    contexte *= nT * ", "

    print("\n --> Nombre de HAPS : ")
    nH = readline()
    contexte *= nH * ", "
    nH = parse(Int, nH)

    choix_quadrillage = choix_binaire("\n --> Souhaitez-vous générer un quadrillage pour les positions de déploiement (o/n) ? ")  
    if choix_quadrillage == "o"
        println("\n    - Quadrillage (1000 * 1000)")
        print("       --> Pas : ")
        pas = parse(Int, readline())
        X = [0:pas:1000;]; Y = [0:pas:1000;]
        E = [(x,y) for x in X, y in Y]
        nE = length(E)
        println("\n --> Nombre de positions envisageables pour le déploiement d'un HAPS : $nE")
        contexte *= string(nE) * ", "
    elseif choix_quadrillage == "n"
        print("\n --> Nombre de positions envisageables pour le déploiement d'un HAPS : ")
        nE = readline()
        contexte *= nE * ", "
        nE = parse(Int, nE)
    end

    print("\n --> Nombre de types de communication : ")
    nC = readline()
    contexte *= nC * ", "
    nC = parse(Int, nC)

    print("\n --> Nombre d'unités : ")
    nU = readline()
    contexte *= nU * ", "
    nU = parse(Int, nU)

    print("\n --> Nombre de bases : ")
    nB = readline()
    contexte *= nB * "\n\n"
    nB = parse(Int, nB)

    print("\n --> Altitude de déploiement des HAPS : ")
    A = readline()
    contexte *= "// Altitude de déploiement des HAPS (A)\n"
    contexte *= A * "\n\n"

    nRc = []
    contexte *= "// Nombre de relais par type de communication (R_1, R_2, ...)\n"
    choix, a, b = choix_saisie("\n --> Souhaitez-vous saisir manuellement le nombre de relais par type de communication (o/n) ? ")
    for c in 1:nC
        print("\n --> Nombre de relais de type $c : ")
        if choix == "o"
            val = readline()
        elseif choix == "n"
            val = rand(a:b)
            println("$val")
            val = string(val)
        end
        if c != nC
            contexte *= val * ", "
        else
            contexte *= val * "\n"
        end
        push!(nRc, parse(Int, val))
    end
    contexte *= "\n"
    
    contexte *= "// Types de communication de chaque unité (C_u)\n"
    choix, a, b = choix_saisie("\n --> Souhaitez-vous saisir manuellement les types de communication de chaque unité (o/n) ? ")
    for u in 1:nU
        if choix == "o"
            println("\n - Unité $u : ")
            print("\n   --> Nombre de types de communication : ")
            nCu = parse(Int, readline())
            reste = [1:nC;]
            for c in 1:nCu
                println("\n      Types restants : $reste")
                print("      --> Type $c : ")
                Cu_i = readline()
                filter!(el->el!=parse(Int, Cu_i),reste)
                if c != nCu
                    contexte *= Cu_i * ", "
                else
                    contexte *= Cu_i * "\n"
                end
            end
        elseif choix == "n"
            print("\n --> Types de communication de l'unité $u : ")
            nCu = rand([a:b;])
            Cu = shuffle(1:nC)[1:nCu]
            cpt = 1
            for Cu_i in Cu
                if cpt != nCu
                    print("$(Cu_i), ")
                    contexte *= string(Cu_i) * ", "
                else
                    println("$(Cu_i)")
                    contexte *= string(Cu_i) * "\n"
                end
                cpt += 1
            end
        end
    end
    contexte *= "\n"

    contexte *= "// Types de communication de chaque base (C_b)\n"
    choix, a, b = choix_saisie("\n --> Souhaitez-vous saisir manuellement les types de communication de chaque base (o/n) ? ")
    for base in 1:nB
        if choix == "o"
            println("\n - Base $base : ")
            print("\n   --> Nombre de types de communication : ")
            nCb = parse(Int, readline())
            reste = [1:nC;]
            for c in 1:nCb
                println("\n      Types restants : $reste")
                print("      --> Type $c : ")
                Cb_i = readline()
                filter!(el->el!=parse(Int, Cb_i),reste)
                if c != nCb
                    contexte *= Cb_i * ", "
                else
                    contexte *= Cb_i * "\n"
                end
            end
        elseif choix == "n"
            print("\n --> Types de communication de la base $base : ")
            nCb = rand([a:b;])
            Cb = shuffle(1:nC)[1:nCb]
            cpt = 1
            for Cb_i in Cb
                if cpt != nCb
                    print("$(Cb_i), ")
                    contexte *= string(Cb_i) * ", "
                else
                    println("$(Cb_i)")
                    contexte *= string(Cb_i) * "\n"
                end
                cpt += 1
            end
        end
    end
    contexte *= "\n"

    contexte *= "// Positions des bases (x_b, y_b)\n"
    choix, a, b = choix_saisie("\n --> Souhaitez-vous saisir manuellement les positions des bases (o/n) ? ")
    for base in 1:nB
        println("\n - Base $base : ")
        print("   --> x : ")
        if choix == "o"
            x = readline()
        elseif choix == "n"
            x = rand(a:b)
            println("$x")
            x = string(x)
        end
        print("   --> y : ")
        if choix == "o"
            y = readline()
        elseif choix == "n"
            y = rand(a:b)
            println("$y")
            y = string(y)
        end
        contexte *= x * ", " * y * "\n"
    end
    contexte *= "\n"

    contexte *= "// Positions envisageables pour le déploiement d'un HAPS (x_e, y_e)\n"
    if choix_quadrillage == "o"
        cpt = 1
        for (x,y) in E
            println("\n - Position $cpt : ")
            println("   --> x : $x")
            println("   --> y : $y")
            contexte *= string(x) * ", " * string(y) * "\n"
            cpt += 1
        end
        contexte *= "\n"
    elseif choix_quadrillage == "n"
        choix, a, b = choix_saisie("\n --> Souhaitez-vous saisir manuellement les positions enviseables pour le déploiement des HAPS (o/n) ? ")
        for position in 1:nE
            println("\n - Position $position : ")
            print("   --> x : ")
            if choix == "o"
                x = readline()
            elseif choix == "n"
                x = rand(a:b)
                println("$x")
                x = string(x)
            end
            print("   --> y : ")
            if choix == "o"
                y = readline()
            elseif choix == "n"
                y = rand(a:b)
                println("$y")
                y = string(y)
            end
            contexte *= x * ", " * y * "\n"
        end
        contexte *= "\n"
    end

    contexte *= "// Poids et puissance maximale de chacun des HAPS (W_h, P_h)\n"
    choix_poids, a_poids, b_poids = choix_saisie("\n --> Souhaitez-vous saisir manuellement les poids maximales de chacun des HAPS (o/n) ? ")
    choix_puissance, a_puissance, b_puissance = choix_saisie("\n --> Souhaitez-vous saisir manuellement les puissances maximales de chacun des HAPS (o/n) ? ")
    for h in 1:nH
        println("\n - HAPS $h : ")
        print("   --> Poids maximal : ")
        if choix_poids == "o"
            W = readline()
        elseif choix_poids == "n"
            W = rand(a_poids:b_poids)
            println("$W")
            W = string(W)
        end
        print("   --> Puissance maximale : ")
        if choix_puissance == "o"
            P = readline()
        elseif choix_puissance == "n"
            P = rand(a_puissance:b_puissance)
            println("$P")
            P = string(P)
        end
        contexte *= W * ", " * P * "\n"
    end
    contexte *= "\n"

    choix_poids, a_poids, b_poids = choix_saisie("\n --> Souhaitez-vous saisir manuellement les poids de chacun des relais (o/n) ? ")
    choix_puissance, a_puissance, b_puissance = choix_saisie("\n --> Souhaitez-vous saisir manuellement les puissances de chacun des relais (o/n) ? ")
    choix_portee, a_portee, b_portee = choix_saisie("\n --> Souhaitez-vous saisir manuellement les portées (seuils) de chacun des relais (o/n) ? ")
    cpt = 1
    for c in 1:nC
        contexte *= "// Poids, puissance et portée de chacun des relais de type $c (w_r, p_r, s_r)\n"
        println("\n - Relais de type $c")
        for r in 1:nRc[c]
            println("\n   - Relais $cpt : ")
            print("      --> Poids : ")
            if choix_poids == "o"
                w = readline()
            elseif choix_poids == "n"
                w = rand(a_poids:b_poids)
                println("$w")
                w = string(w)
            end
            print("      --> Puissance : ")
            if choix_puissance == "o"
                p = readline()
            elseif choix_puissance == "n"
                p = rand(a_puissance:b_puissance)
                println("$p")
                p = string(p)
            end
            print("      --> Portée (seuil) : ")
            if choix_portee == "o"
                s = readline()
            elseif choix_portee == "n"
                s = rand(a_portee:b_portee)
                println("$s")
                s = string(s)
            end
            cpt += 1
            contexte *= w * ", " * p * ", " * s * "\n"
        end
        if c != nC
            contexte *= "\n"
        end
    end

    nom_dossier = string(today())*"_"*Dates.format(now(), "HH:MM:SS")
    run(`mkdir contextes/$(nom_dossier)`)
    open("contextes/$(nom_dossier)/contexte.txt", "w") do fichier
        write(fichier, contexte)
    end

    println("\n /!\\ Le contexte est disponible dans le dossier \"contextes/$(nom_dossier)/\" /!\\ ")
    println("\n========== Générateur de contexte ==========")
end

generation_contexte()
