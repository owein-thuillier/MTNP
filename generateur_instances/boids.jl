using PyPlot

function initialisation(nU, trace)
    liste_boids = Vector{Vector{Float64}}(undef, nU)
    cpt_b = 1
    for u in 1:nU
        # Positions
        x = rand(0:1000)
        y = rand(0:1000)
        # Vélocités
        vx = 0.0 
        vy = 0.0
        liste_boids[u] = [x, y, vx, vy]
        trace[cpt_b][1] = [x, y]
        cpt_b += 1
    end 
    return liste_boids
end

function affichage(nU, liste_plot, liste_boids, trace, t)
    cpt_b = 1
    for b in liste_boids
        x = b[1] 
        y = b[2] 
        push!(liste_plot, plot(x, y, color="#ffe8d6", markeredgecolor="black", marker="^", linestyle="", markersize=7, zorder=2))
        if t >= 3 && trace_active == true
            push!(liste_plot, plot([trace[cpt_b][i][1] for i in 1:3], [trace[cpt_b][i][2] for i in 1:3], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9))
        elseif t < 3 && trace_active
            push!(liste_plot, plot([trace[cpt_b][i][1] for i in 1:t], [trace[cpt_b][i][2] for i in 1:t], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9))
        end
        cpt_b += 1
    end
end

function reset_affichage(liste_plot)
    for p in liste_plot
        p[1].remove()
    end
end

function regle_1(nU, b, liste_boids) 
    # Cohésion : les boids se dirigent vers le centre de masse du groupe (perçu par le boid courant)
    centre_masse = [0.0, 0.0]
    for b2 in liste_boids
        if b2 != b
            centre_masse[1] += b2[1]
            centre_masse[2] += b2[2]
        end
    end
    centre_masse /= (sum(nU) - 1)
    #plot([b[1], centre_masse[1]], [b[2], centre_masse[2]], color="orange")
    #centre_masse = [500, 500]
    return [(centre_masse[1] - b[1])/facteur_cohesion, (centre_masse[2] - b[2])/facteur_cohesion]
end

function dist(b1, b2)
    return sqrt((b2[1] - b1[1])^2 + (b2[2] - b1[2])^2)
end

function regle_2(b, liste_boids) 
    # Séparation : les boids s'évitent
    repulsion = [0.0, 0.0]
    for b2 in liste_boids
        if b2 != b && dist(b, b2) < distance_proximite
            repulsion[1] -= (b2[1] - b[1])
            repulsion[2] -= (b2[2] - b[2])
        end
    end
    return repulsion * facteur_repulsion
end

function regle_3(nU, b, liste_boids) 
    # Alignement : les boids s'alignent sur la même trajectoire
    alignement = [0.0, 0.0]
    for b2 in liste_boids
        if b2 != b
            alignement[1] += (b2[3])
            alignement[2] += (b2[4])
        end
    end
    alignement /= (sum(nU) - 1)
    return [alignement[1] + b[3], alignement[2] + b[4]]/facteur_alignement
end 

function regle_4(b)
    # On force les boids à rester dans le terrain
    repulsion = [0.0, 0.0]
    if b[1] > 900
        repulsion[1] -= 20
    elseif b[1] < 100
        repulsion[1] += 20
    end
    
    if b[2] > 900
        repulsion[2] -= 20
    elseif b[2] < 100
        repulsion[2] += 20
    end
    #if b[1] > 300 && b[1] < 400 && b[2] > 200 && b[2] < 600 # x [400, 500] y [200, 600]
        #repulsion[1] = -200    
    #end
    #if b[1] > 500 && b[1] < 600 && b[2] > 200 && b[2] < 600
        #repulsion[1] = 200    
    #end
    #if b[1] > 400 && b[1] < 500 && b[2] > 600 && b[2] < 700
        #repulsion[2] = 200    
    #end
    #if b[1] > 400 && b[1] < 500 && b[2] > 100 && b[2] < 200
        #repulsion[2] = -200   
    #end 
    return repulsion
end

function limiter_vitesse(b)
 vitesse_boid = sqrt(b[3]^2 + b[4]^2) 
 if vitesse_boid > vitesse_limite # trop rapide
     b[3] = (b[3] / vitesse_boid) * vitesse_limite
     b[4] = (b[4] / vitesse_boid) * vitesse_limite     
 end
end

function mouvoir_boids(nU, liste_boids, trace, scenario, t, nT) 
    cpt_b = 1
    for b in liste_boids
        # Calcul des vélocités (vecteurs vitesse)
        v1 = regle_1(nU, b, liste_boids) 
        v2 = regle_2(b, liste_boids)
        v3 = regle_3(nU, b, liste_boids)
        v4 = regle_4(b)
               
        # Mise à jour des vélocités en fonction des règles
        b[3] += v1[1] + v2[1] + v3[1] + v4[1]
        b[4] += v1[2] + v2[2] + v3[1] + v4[2]
        limiter_vitesse(b)
        # Mise à jours des positions en fonction des vélocités
        b[1] += b[3]
        b[2] += b[4]
        trace[cpt_b][3] =  trace[cpt_b][2];  trace[cpt_b][2] =  trace[cpt_b][1];  trace[cpt_b][1] = [b[1], b[2]]

        scenario[cpt_b] *= "(" * string(b[1]) * "," * string(b[2])
        if t != nT
            scenario[cpt_b] *= "), "
        else
            scenario[cpt_b] *= ")\n"
        end

        cpt_b += 1
    end
end

function mouvoir_boids_alea(nU, liste_boids, trace, scenario, t, nT) 
    pas = 20
    directions = [("O",1), ("NO",2), ("N",3), ("NE",4), ("E",5), ("SE",6), ("S",7), ("SO",8)] # Points cardinaux élémentaires
    correspondance = [(-pas, 0),  (-pas, pas), (0, pas), (pas, pas), (pas, 0), (pas, -pas), (0, -pas), (-pas, -pas)] # Correspondance entre
    cpt_b = 1
    for b in liste_boids
            deplacement_valide = false
            nouvelle_coord = ()
            while !(deplacement_valide)
                direction = rand(directions)
                bBis = b[1:2]
                nouvelle_coord = bBis .+ correspondance[direction[2]]
                #println(bBis)
                #println(nouvelle_coord)
                if (nouvelle_coord[1] >= pas && nouvelle_coord[1] <= 1000-pas) && (nouvelle_coord[2] >= pas && nouvelle_coord[2] <= 1000-pas) # On reste dans la boîte définie (avec une protection pour éviter d'être sur les bords)
                    deplacement_valide = true
                end
            end
        # Mise à jours des positions en fonction des vélocités
        b[1] = nouvelle_coord[1]
        b[2] = nouvelle_coord[2]
        trace[cpt_b][3] =  trace[cpt_b][2];  trace[cpt_b][2] =  trace[cpt_b][1];  trace[cpt_b][1] = [b[1], b[2]]

        scenario[cpt_b] *= "(" * string(b[1]) * "," * string(b[2])
        if t != nT
            scenario[cpt_b] *= "), "
        else
            scenario[cpt_b] *= ")\n"
        end
        cpt_b += 1
    end
end


function boids(nT, nU)
   global trace_active = true
   global vitesse_limite = 20
   global distance_proximite = 80
   global facteur_repulsion = 20
   global facteur_cohesion = 5
   global facteur_alignement = 5
   x_limite = 1000
   y_limite = 1000
   scenario = ["" for u in 1:nU]
   # Initialisation graphique
    #ion()
    #fig = figure("Boids")
    #ax = fig.add_subplot(111)
    #grid(false)
    #xlim(0, x_limite)
    #ylim(0, y_limite)
    # Création du sol
    #sol = matplotlib.patches.Rectangle((0, 0), 1000, 1000, linewidth=1, edgecolor="black", facecolor="#40916c")
    #ax.add_patch(sol)
    # Grille
    #pas = 50
    #i = pas
    #while i < 1000
        #ax.plot([i, i], [0, 1000], color="white", linewidth=0.2) # Longueur
        #ax.plot([0, 1000], [i, i], color="white", linewidth=0.2) # Largeur
        #i += pas
    #end 
   
   # Initialisation boids
   trace = [Vector{Vector{Float64}}(undef, 3) for i in 1:sum(nU)]
   for i in 1:length(trace)
       trace[i] = [Vector{Float64}(undef, 2) for j in 1:3]
   end
   liste_boids = initialisation(nU, trace)

   # Boucle
   #ax.set_facecolor("#14213d")
   #fig.set_facecolor("#14213d")
   #ax.tick_params(axis="x", colors="white")
   #ax.tick_params(axis="y", colors="white")
   #suptitle("Visualisation du scénario", y=0.95, bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=15)   
   #ax.plot([], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
   #ax.plot([425], [430], color="red", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Ennemi")  
      
   #sol = matplotlib.patches.Rectangle((400, 200), 100, 400, linewidth=1, facecolor="cyan", alpha=0.5, label="Obstacle")
   #ax.add_patch(sol)
   
   #ax.legend(loc="upper right", fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
   #affichage_nb_images_seconde = ax.text(18, 935, s="", fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)
   #affichage_etat_courant = ax.text(18, 830, s="", fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)
   #ax.set_aspect("equal")
   #liste_plot = []
   #liste_plot = []
   #readline()
   for t in 1:nT
       #affichage_nb_images_seconde.set_text("Nombre d'images par seconde = 10")
       #affichage_etat_courant.set_text("État : $t/$(nT)")
       #affichage(nU, liste_plot, liste_boids, trace, t)
       #fig.savefig("animation/image_"*string(t)*".png", format="png")
       #savefig("images/image_"*string(t))
       mouvoir_boids(nU, liste_boids, trace, scenario, t, nT) 
       #sleep(0.1) 
       #reset_affichage(liste_plot)
       #liste_plot = []
   end
   close()
   scenario_final = ""
   for u in 1:nU
      scenario_final *= "// Déplacements de l'unité terrestre $u sur un horizon temporel (x_$u^t, y_$u^t) \n"
      scenario_final *= string(scenario[u]) * "\n"
      # println("// Déplacements de l'unité terrestre $u sur un horizon temporel (x_$u^t, y_$u^t)")
      # println(scenario[u])
   end
   return scenario_final
end

