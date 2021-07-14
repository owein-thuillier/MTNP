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
        if b == liste_boids[end]
            push!(liste_plot, plot(x, y, color="lime", markeredgecolor="black", marker="^", linestyle="", markersize=7, zorder=2))             
        else
            push!(liste_plot, plot(x, y, color="#ffe8d6", markeredgecolor="black", marker="^", linestyle="", markersize=7, zorder=2))       
        end
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

function regle_1(nU, b, liste_boids, t) 
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
    #if t == 5 && b == liste_boids[end]
    #    plot([centre_masse[1]], [centre_masse[2]], linestyle="", marker=".", markersize=15, markeredgecolor="white", markerfacecolor="pink")
    #end
    #centre_masse = [500, 500]
    return [(centre_masse[1] - b[1])*facteur_cohesion/100, (centre_masse[2] - b[2])*facteur_cohesion/100]
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
        v1 = regle_1(nU, b, liste_boids, t) 
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

function main()
   global trace_active = true
   global vitesse_limite = 20
   global distance_proximite = 70
   global facteur_repulsion = 1
   global facteur_cohesion = 1
   global facteur_alignement = 1
   nU = 5
   nT = 100
   x_limite = 1000
   y_limite = 1000
   scenario = ["" for u in 1:nU]
   # Initialisation graphique
    ion()
    fig = figure("Boids")
    ax = fig.add_subplot(111)
    grid(false)
    xlim(0, x_limite)
    ylim(0, y_limite)
    # Création du sol
    sol = matplotlib.patches.Rectangle((0, 0), 1000, 1000, linewidth=1, edgecolor="black", facecolor="#40916c")
    ax.add_patch(sol)
    # Grille
    pas = 50
    i = pas
    while i < 1000
        ax.plot([i, i], [0, 1000], color="white", linewidth=0.2) # Longueur
        ax.plot([0, 1000], [i, i], color="white", linewidth=0.2) # Largeur
        i += pas
    end 
   
   # Initialisation boids
   trace = [Vector{Vector{Float64}}(undef, 3) for i in 1:sum(nU)]
   for i in 1:length(trace)
       trace[i] = [Vector{Float64}(undef, 2) for j in 1:3]
   end
   liste_boids = initialisation(nU, trace)

   # Boucle
   ax.set_facecolor("#14213d")
   fig.set_facecolor("#14213d")
   ax.tick_params(axis="x", colors="white")
   ax.tick_params(axis="y", colors="white")
   ax.plot([], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
   #ax.plot([],[], linestyle="", marker=".", markersize=15, markeredgecolor="white", markerfacecolor="pink", label="Centre de masse perçu")
   ax.legend(loc="upper right", fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
   affichage_nb_images_seconde = ax.text(18, 935, s="", fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)
   affichage_etat_courant = ax.text(18, 830, s="", fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)
   #ax.set_aspect("equal")
   liste_plot = []
   for t in 1:nT
       #affichage_nb_images_seconde.set_text("Nombre d'images par seconde = 10")
       #affichage_etat_courant.set_text("État : $t/$(nT)")
       affichage(nU, liste_plot, liste_boids, trace, t)
       #savefig("images/image_"*string(t))
       mouvoir_boids(nU, liste_boids, trace, scenario, t, nT) 
       sleep(0.1) 
       reset_affichage(liste_plot)
       liste_plot = []
   end
   close()
   for u in 1:nU
      # println("// Déplacements de l'unité terrestre $u sur un horizon temporel (x_$u^t, y_$u^t)")
      # println(scenario[u])
   end
end

function trace_unite(x,y)
    trace = [[x,y]]
    for i in 1:6
        choix = rand([[0,10], [0,-10], [10,0], [-10,0], [10,10], [-10,-10], [10,-10], [-10,10]])
        push!(trace, [trace[end][1] + choix[1], trace[end][2] + choix[2]])
    end
    return trace[1:end]
end


function main_bis()
   # Initialisation graphique
    ion()
    fig = figure("Boids")
    ax = fig.add_subplot(111)
    grid(false)
    xlim(0, 1000)
    ylim(0, 1000)
    # Création du sol
    sol = matplotlib.patches.Rectangle((0, 0), 1000, 1000, linewidth=1, edgecolor="black", facecolor="#40916c")
    ax.add_patch(sol)
    # Grille
    pas = 50
    i = pas
    while i < 1000
        ax.plot([i, i], [0, 1000], color="white", linewidth=0.2) # Longueur
        ax.plot([0, 1000], [i, i], color="white", linewidth=0.2) # Largeur
        i += pas
    end 
    ax.set_facecolor("#14213d")
    fig.set_facecolor("#14213d")
    ax.tick_params(axis="x", colors="white")
    ax.tick_params(axis="y", colors="white")
    ax.plot([], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    ax.legend(loc="upper right", fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
    ax.plot([400], [500], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = [[400, 500], [420, 450]]
    ax.plot([trace[i][1] for i in 1:2], [trace[i][2] for i in 1:2], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
    ax.plot([350], [450], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = [[350, 450], [350, 400]]
    ax.plot([trace[i][1] for i in 1:2], [trace[i][2] for i in 1:2], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
    ax.plot([300], [500], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = [[300, 500], [290, 450]]
    ax.plot([trace[i][1] for i in 1:2], [trace[i][2] for i in 1:2], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
    ax.plot([350], [500], color="lime", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = [[350, 500], [330, 550]]
    ax.plot([trace[i][1] for i in 1:2], [trace[i][2] for i in 1:2], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
end

function main_ter()
   # Initialisation graphique
    ion()
    fig = figure("Boids")
    ax = fig.add_subplot(111)
    grid(false)
    xlim(0, 1000)
    ylim(0, 1000)
    # Création du sol
    sol = matplotlib.patches.Rectangle((0, 0), 1000, 1000, linewidth=1, edgecolor="black", facecolor="#40916c")
    ax.add_patch(sol)
    # Grille
    pas = 50
    i = pas
    while i < 1000
        ax.plot([i, i], [0, 1000], color="white", linewidth=0.2) # Longueur
        ax.plot([0, 1000], [i, i], color="white", linewidth=0.2) # Largeur
        i += pas
    end 
    ax.set_facecolor("#14213d")
    fig.set_facecolor("#14213d")
    ax.tick_params(axis="x", colors="white")
    ax.tick_params(axis="y", colors="white")
    ax.plot([], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    ax.legend(loc="upper right", fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
    ax.plot([960], [500], color="lime", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = [[960, 500], [930, 450]]
    ax.plot([trace[i][1] for i in 1:2], [trace[i][2] for i in 1:2], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
    ax.plot([50, 950], [50, 50], color="red", alpha = 0.4, zorder=10)
    ax.plot([50, 950], [950, 950], color="red", alpha = 0.4, zorder=10)
    ax.plot([50, 50], [50, 950], color="red", alpha = 0.4, zorder=10)
    ax.plot([950, 950], [50, 950], color="red", alpha = 0.4, zorder=10)
end

function main_quater()
   # Initialisation graphique
    ion()
    fig = figure("Boids")
    ax = fig.add_subplot(111)
    grid(false)
    xlim(0, 1000)
    ylim(0, 1000)
    # Création du sol
    sol = matplotlib.patches.Rectangle((0, 0), 1000, 1000, linewidth=1, edgecolor="black", facecolor="#40916c")
    ax.add_patch(sol)
    # Grille
    pas = 50
    i = pas
    while i < 1000
        ax.plot([i, i], [0, 1000], color="white", linewidth=0.2) # Longueur
        ax.plot([0, 1000], [i, i], color="white", linewidth=0.2) # Largeur
        i += pas
    end 
    ax.set_facecolor("#14213d")
    fig.set_facecolor("#14213d")
    ax.tick_params(axis="x", colors="white")
    ax.tick_params(axis="y", colors="white")
    ax.plot([], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    sol = matplotlib.patches.Rectangle((400, 200), 100, 400, linewidth=1, facecolor="cyan", alpha=0.5, label="Obstacles")
    ax.add_patch(sol)
    ax.legend(loc="upper right", fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
    ax.plot([350], [300], color="white", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = [[350, 300], [330, 240]]
    ax.plot([trace[i][1] for i in 1:2], [trace[i][2] for i in 1:2], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
end
main_quater()
