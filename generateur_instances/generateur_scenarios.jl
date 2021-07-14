########### Importations ###########

# Dépendances
using Dates
using PyPlot
using JuMP
using Ipopt
#using Mosek
#using NLopt

# Essentiels
include("controles_saisies.jl")
include("boids.jl")

########## Générateur de scénarios ##########

function generation_scenarios()
    # Nettoyage de la console
    clear()

    println("\n========== Générateur de scénarios ==========")

    println("\n Lecture des paramètres : ")
    println(" ------------------------ ")
    println("    1) Depuis fichier contexte ")
    println("    2) Manuel ")
    choix = choix_multiple("\n --> Votre choix : ", 2)

    if choix == 1
        nT, nU = lecture_depuis_fichier()
    elseif choix == 2
        nT, nU = lecture_manuel()
    end

    println("\n Choix du type de déplacement des unités terrestres : ")
    println(" ---------------------------------------------------- ")
    println("    1) Aléatoire ")
    println("    2) Points de passage ")
    println("    3) Boids ")
    choix = choix_multiple("\n --> Votre choix : ", 3)

    if choix == 1
        print("\n --> Choix du pas (> 0) : ")
        pas = parse(Float64, readline())
    end

    print("\n --> Nombre de scénarios à générer : ")
    nb_scenarios = parse(Int, readline())    
    nom_dossier = string(today())*"_"*Dates.format(now(), "HH:MM:SS")
    run(`mkdir scenarios/$(nom_dossier)`)
    for i in 1:nb_scenarios
        if choix == 1
            print("\n - Scénario $i : ")
            scenario = scenario_aleatoire(nT, nU, pas)
            println("OK")
        elseif choix == 2
            print("\n - Scénario $i : ")          
            scenario = scenario_points_de_passage(nT, 1, [nU], 1000, 1000)
            println("OK")
        elseif choix == 3
            print("\n - Scénario $i : ")
            scenario = boids(nT, nU)
            println("OK")
        end
        ecrire_scenario(nom_dossier, scenario, i)
    end
    println("\n /!\\ Les différents scénarios sont disponibles dans le dossier \"scenarios/$(nom_dossier)/\" /!\\ ")
    println("\n========== Générateur de scénarios ==========")
end

function lecture_manuel()
    print("\n --> Nombre d'états : ")
    nT = parse(Int, readline())

    print("\n --> Nombre d'unités : ")
    nU = parse(Int, readline())

    return nT, nU
end

function lecture_depuis_fichier()
    print("\n --> Chemin vers le fichier contexte à lire : ")
    chemin = readline()

    lignes = Vector{String}
    open(chemin) do fichier
        lignes = readlines(fichier)
    end

    nT, _, _, _, nU = parse.(Int, split(lignes[2], ","))
    return nT, nU
end

########## Écriture dans un fichier ##########

function ecrire_scenario(nom_dossier, scenario, i)
    open("scenarios/$(nom_dossier)/scenario_$i.txt", "w") do fichier
           write(fichier, scenario)
    end
end

########## Scénario aléatoire ##########

function scenario_aleatoire(nT, nU, pas)
    directions = [("O",1), ("NO",2), ("N",3), ("NE",4), ("E",5), ("SE",6), ("S",7), ("SO",8)] # Points cardinaux élémentaires
    correspondance = [(-pas, 0),  (-pas, pas), (0, pas), (pas, pas), (pas, 0), (pas, -pas), (0, -pas), (-pas, -pas)] # Correspondance entre direction et déplacement de l'unité sur le plan
    #liste_deplacements = Vector{Vector{Tuple}}(undef, sum(nUc))
    scenario = ""
    for u in 1:nU
        # Une unité
        scenario *= "// Déplacements de l'unité terrestre $u sur un horizon temporel (x_$u^t, y_$u^t) \n"
        liste_deplacements_unite = Vector{Tuple}(undef, nT)
        point = (rand(pas:pas:1000-pas), rand(pas:pas:1000-pas))
        liste_deplacements_unite[1] = point # Point de départ de l'unité (sur une position multiple de "pas")
        scenario *= "(" * string(point[1]) * "," * string(point[2]) * "), "
        for t in 2:nT
            # Un état particulier
            deplacement_valide = false
            nouvelle_coord = ()
            while !(deplacement_valide)
                direction = rand(directions)
                nouvelle_coord = liste_deplacements_unite[t-1] .+ correspondance[direction[2]]
                if (nouvelle_coord[1] >= pas && nouvelle_coord[1] <= 1000-pas) && (nouvelle_coord[2] >= pas && nouvelle_coord[2] <= 1000-pas) # On reste dans la boîte définie (avec une protection pour éviter d'être sur les bords)
                    deplacement_valide = true
                end
            end
            liste_deplacements_unite[t] = nouvelle_coord
            scenario *= "(" * string(nouvelle_coord[1]) * "," * string(nouvelle_coord[2])
            if t != nT
                scenario *= "), "
            end
        end
        scenario *= ")\n\n"
    end
    return scenario
end

########## Scénario points de passage ##########

function on_click(event, liste_plot, liste_points, liste_couleurs, cpt_c, cpt_u, nT)
    x = event.xdata; y = event.ydata
    push!(liste_points[cpt_c[1]][cpt_u[1]], (x,y))
    if length(liste_points[cpt_c[1]][cpt_u[1]]) <= nT # On ne peut pas placer plus de points de passage qu'on ne dispose d'états
        if length(liste_points[cpt_c[1]][cpt_u[1]]) > 1
            x_prec = liste_points[cpt_c[1]][cpt_u[1]][end-1][1]; y_prec = liste_points[cpt_c[1]][cpt_u[1]][end-1][2]
            push!(liste_plot, plot([x_prec, x], [y_prec, y], color="white", markerfacecolor="gold", marker=".", zorder=10, markersize=10, linewidth=0.5))
            savefig("animation/image_A_"*string(length(liste_points[cpt_c[1]][cpt_u[1]]))) 

        else
            push!(liste_plot, plot(x, y, color="white", linestyle="", marker=".", markerfacecolor="gold", zorder=10, markersize=10)) 
            savefig("animation/image_A_1")
        end
    else
        println("\n /!\\ Vous ne pouvez pas placer plus de points de passage /!\\")
    end
end

function plot_seuil(x, y, portee)
    for p in 0:1:portee
        nb_points = 60
        theta = range(0, 2 * pi, length=nb_points)
        rayon = p
        X = x .+ rayon*cos.(theta)
        Y = y .+ rayon*sin.(theta)
            plot([X[k] for k in 1:nb_points], [Y[k] for k in 1:nb_points], color="cyan", marker="", zorder=15, markersize=4, alpha=0.2, clip_on=false)
    end
end

function obstacles_old()
   #sol = matplotlib.patches.Rectangle((0, 300), 650, 100, linewidth=1, facecolor="cyan", alpha=0.5, label="Obstacles")
   #ax.add_patch(sol)
   #sol = matplotlib.patches.Rectangle((250, 400), 200, 200, linewidth=1, facecolor="cyan", alpha=0.5)
   #ax.add_patch(sol)
   #sol = matplotlib.patches.Rectangle((100, 700), 100, 300, linewidth=1, facecolor="cyan", alpha=0.5)
   #ax.add_patch(sol)
   
   
   #sol = matplotlib.patches.Rectangle((200, 0), 100, 600, linewidth=1, facecolor="cyan", alpha=0.5, label="Obstacles")
   #ax.add_patch(sol)   
   #sol = matplotlib.patches.Rectangle((200, 700), 100, 300, linewidth=1, facecolor="cyan", alpha=0.5)
   #ax.add_patch(sol)   
       
   #sol = matplotlib.patches.Rectangle((600, 0), 100, 200, linewidth=1, facecolor="cyan", alpha=0.5)
   #ax.add_patch(sol)   
   #sol = matplotlib.patches.Rectangle((600, 300), 100, 700, linewidth=1, facecolor="cyan", alpha=0.5)
   #ax.add_patch(sol) 
   
   #sol = matplotlib.patches.Rectangle((0, 0), 0, 0, linewidth=1, facecolor="cyan", alpha=0.5, label="Obstacles")
   #ax.add_patch(sol)
   #plot_seuil(100, 350, 50)
   #plot_seuil(300, 200, 100) 
   #plot_seuil(200, 700, 80)  
   #plot_seuil(500, 500, 120)     
   #plot_seuil(350, 500, 30)   
   #plot_seuil(600, 200, 90)        
   #plot_seuil(300, 900, 60)      
   #plot_seuil(750, 650, 40)             
   #plot_seuil(800, 300, 70)    
   #plot_seuil(750, 500, 20) 
   #plot_seuil(850, 450, 30) 
   #plot_seuil(900, 600, 60)  
   #plot_seuil(900, 100, 60)                       
   #plot_seuil(200, 450, 20)    
   #plot_seuil(100, 100, 60) 
   #plot_seuil(100, 850, 30)         
end


function scenario_points_de_passage(nT, nC, nUc, x_limite, y_limite)
    # On ouvre plot 2d, pour chaque unité : on clique gauche pour placer points de passage puis entrée lorsque fin, on voit le chemin produit et on appuie sur entrée pour
    # passer à l'unité suivante, etc.
   # Initialisation graphique
   ion()
   fig = figure("Points de passage")
   ax = fig.add_subplot(111)
   grid(false)
   xlim(0, 1000)
   ylim(0, 1000)
   # Création du sol
   sol = matplotlib.patches.Rectangle((0, 0), 1000, 1000, linewidth=1, edgecolor="white", facecolor="#40916c")
   ax.add_patch(sol)
    # Grille
    pas = 50
    i = pas
    while i < 1000
        ax.plot([i, i], [0, 1000], color="white", linewidth=0.2) # Longueur
        ax.plot([0, 1000], [i, i], color="white", linewidth=0.2) # Largeur
        i += pas
    end 

   # Boucle
   ax.set_facecolor("#14213d")
   fig.set_facecolor("#14213d")
   ax.tick_params(axis="x", colors="white")
   ax.tick_params(axis="y", colors="white")                       
   
   plot([], [], color="white", markerfacecolor="gold", alpha=0.8, linestyle="", marker=".", zorder=10, markersize=10, label="Points de passage") 
   plot([], [], color="white", linestyle="", marker=".", zorder=10, markersize=10, label="Points intermédiaires") 
   ax.legend(loc="upper right", fontsize=14, framealpha=0.8, facecolor="#14213d", labelcolor="white", edgecolor="white").set_zorder(1000)

    # liste_points[c][u][p]
    liste_plot = []
    liste_points = Vector{Vector{Vector{Tuple{Float64, Float64}}}}(undef, nC)
    liste_couleurs = ["white", "yellow", "blue", "cyan", "lime", "darkorchid", "fuchsia", "snow"]
    cpt_c = [1]
    cpt_u = [1]
    scenario = ""
    cid = fig.canvas.mpl_connect("button_press_event", event -> on_click(event, liste_plot, liste_points, liste_couleurs, cpt_c, cpt_u, nT))
    for c in 1:nC
        cpt_u[1] = 1
        liste_points[c] = Vector{Vector{Tuple{Float64, Float64}}}(undef, nUc[c]) 
        ##### Un type de communication
        for u in 1:nUc[cpt_c[1]]
            scenario *= "// Déplacements de l'unité terrestre $u sur un horizon temporel (x_$u^t, y_$u^t) \n"
            ##### Placement des points de passage (chemin)
            liste_points[c][u] = Tuple{Float64, Float64}[]
            suptitle(" Unité : $u", color="white")
            title("#T = 50", color="white")
            println("\n --> Appuyez sur entrée pour terminer le chemin...")
            readline()  
            ##### Distribution uniforme des points sur le chemin
            ## Calcul de la distance totale du chemin  
            # Calcul des distances de chaque tronçons du chemin
            distance_totale = 0
            distance_troncons = Vector{Float64}(undef, length(liste_points[c][u])-1)
            for i in 1:length(liste_points[c][u])-1 
                distance_troncons[i] = sqrt( (liste_points[c][u][i+1][1]-liste_points[c][u][i][1])^2 + 
                                      (liste_points[c][u][i+1][2]-liste_points[c][u][i][2])^2)
                distance_totale += distance_troncons[i]
            end  
            #println("\n Distance totale du chemin : ", distance_totale) 
            nb_points_de_passage = length(liste_points[c][u])
            #println(" Nombre de points de passage : ", nb_points_de_passage) 
            nb_points = nT-nb_points_de_passage
            # Calcul du nombre de points à placer (= nb états - points de passage)
            #println(" Nombre de points à placer : ", nb_points, " (#T = $nT)")
            if nb_points > 0 # On distribue les points restants (s'il y en a)
                # Répartition des points sur les tronçons selon les distances de ceux-ci (pondération)
                nb_points_troncons = [trunc(Int, (distance_troncons[i] / distance_totale) * nb_points) for i in 1:length(liste_points[c][u])-1]
                # Attribution du surplus (à cause de l'arrondi) avec un cycle sur les tronçons tant qu'il en reste
                manque_a_placer = nb_points - sum(nb_points_troncons)
                #println(" Manque à placer : ", manque_a_placer)
                i = 1
                while manque_a_placer != 0
                    nb_points_troncons[i] += 1
                    manque_a_placer -= 1
                    i += 1
                    if i == length(liste_points[c][u]) # On cycle
                        i = 1               
                    end 
                end
                # Résolution de plusieurs programmes non-linéaires (pour déterminer l'espacement idéal des points sur chaque tronçon)
                for i in 1:length(liste_points[c][u])-1
                    if nb_points_troncons[i] > 0
                        #println(" - Tronçon n°$i ")
                        x1 = liste_points[c][u][i][1]
                        y1 = liste_points[c][u][i][2]
                        x2 = liste_points[c][u][i+1][1]
                        y2 = liste_points[c][u][i+1][2]
                        m = (y2 - y1)/(x2 - x1) # Coefficient directeur tronçon
                        p = y1 - m*x1  # Ordonnée à l'origine
                        #println("    - Distance tronçon : $(distance_troncons[i])")
                        #println("    - Fonction affine : $(m)x + $p")
                        #println("    - Nombre de points à placer sur ce tronçon : ", nb_points_troncons[i])
                        # On fait appel à un modèle linéaire simple pour déterminer l'ensemble des points sur les dif$
                        liste_points_troncon = [(x1, y1)]
                        cpt = 1
                        distance_entre_points = distance_troncons[i]/(nb_points_troncons[i] + 1)
                        scenario *= "(" * string(x1) * "," * string(y1) * "), "
                        while cpt <= nb_points_troncons[i]+1
                            x, y = resolution_LP(x2, y2, distance_troncons[i], distance_entre_points, liste_points_troncon, m, p)
                            scenario *= "(" * string(x) * "," * string(y) * "), "
                            push!(liste_plot, plot(x, y, color=liste_couleurs[cpt_c[1]], linestyle="", marker=".", markersize=5))
                            push!(liste_points_troncon, (x, y))
                            cpt += 1
                        end
                        if i == length(liste_points[c][u])-1
                            scenario *= "(" * string(x2) * "," * string(y2) * ")"
                        end
                        sleep(0.1)
                        fig.savefig("animation/image_"*string(i)*".png", format="png")
                    end
                end  
            end            
            print("\n --> Appuyez sur entrée pour passer à l'unité suivante...")
            readline()
            ##### Nettoyage du graphique avant de passer à l'unité suivante
            for plot in liste_plot
                plot[1].remove()
            end
            liste_plot = []
            cpt_u[1] += 1
            scenario *= "\n\n"
        end
        cpt_c[1] += 1
        scenario *= "\n"
    end
    fig.canvas.mpl_disconnect(cid)
    close()
    return scenario
end

function resolution_LP(x2, y2, distance_troncon, distance_entre_points, liste_points_troncon, m, p) 
    ### Création du modèle
    #modele = Model(Mosek.Optimizer)
    modele = Model(Ipopt.Optimizer)
    #set_optimizer_attribute(modele, "algorithm", :LN_COBYLA)
    
    ## Variables
    @variables(modele, begin 
        x
        y 
        end)

    ## Contraintes
    #if rand() < 0.5
   #     p += rand()*20
   # else
   #     p -= rand()*20
   # end
    @constraint(modele, y == m*x + p)
    point_precedent = liste_points_troncon[end]
    @NLconstraint(modele, (y - point_precedent[2])^2 + (x - point_precedent[1])^2  <= (distance_entre_points)^2) # distance respectée
    @NLconstraint(modele, (y - point_precedent[2])^2 + (x - point_precedent[1])^2  >= (distance_entre_points)^2) # distance respectée
    marge = length(liste_points_troncon)-1 
    @NLconstraint(modele, (y - y2)^2 + (x - x2)^2  <= (distance_troncon-(distance_entre_points*marge))^2) # pour être du bon côté

    # Fonction objectif (constante car ici seulement satisfaction de contraintes)
    @NLobjective(modele, Max, 1)

    ### Résolution
    JuMP.optimize!(modele)

    val_x = value.(x); val_y = value.(y)    
    return val_x, val_y
end

function gen()
    nT = 100
    nU = 10
    for i in 1:10
        print("\n - Scénario $i : ")
        scenario = scenario_aleatoire(nT, nU, 20)
        println(" OK")
        ecrire_scenario(scenario, i)
    end
    for i in 11:20
        print("\n - Scénario $i : ")
        scenario = boids(nT, nU)
        println(" OK")
        ecrire_scenario(scenario, i)
    end
end

generation_scenarios()

