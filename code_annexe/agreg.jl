using PyPlot

function trace_unite(x,y)
    trace = [[x,y]]
    for i in 1:8
        choix = rand([[0,10], [0,-10], [10,0], [-10,0], [10,10], [-10,-10], [10,-10], [-10,10]])
        push!(trace, [trace[end][1] + choix[1], trace[end][2] + choix[2]])
    end
    return trace[1:end]
end


function main()
   # Initialisation graphique
   ion()
   fig = figure("Boids")
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
   ax.plot([], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
   ax.legend(loc="upper right", fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
   affichage_etat_courant = ax.text(18, 935, s="", fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)
   #affichage_etat_courant = ax.text(36, 910, s="", fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)
   
   #affichage_etat_courant.set_text("État : 2/2")
   affichage_etat_courant.set_text("Agrégation")
   etat_1(ax)
   etat_2(ax)
end

function etat_1(ax)
    ax.plot([400], [500], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    ax.plot([100], [200], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    ax.plot([900], [600], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    ax.plot([700], [300], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)
end

function etat_2(ax)
    ax.plot([350], [450], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    ax.plot([950], [550], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    ax.plot([650], [350], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    ax.plot([200], [700], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    ax.plot([400], [900], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)
end

function etat_1_old(ax)
    ax.plot([350], [300], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=0.5, linestyle="", zorder=21, clip_on=false)

    
    ax.plot([550], [550], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=0.5, linestyle="", zorder=21, clip_on=false)

    
    
    ax.plot([100], [700], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=0.5, linestyle="", zorder=21, clip_on=false)

    ax.plot([600], [800], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=0.5, linestyle="", zorder=21, clip_on=false)

    ax.plot([750], [200], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=0.5, linestyle="", zorder=21, clip_on=false)
   
    
    ax.plot([900], [500], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=0.5, linestyle="", zorder=21, clip_on=false)
    
end

function etat_2_old(ax)
   ax.plot([400], [350], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)

    
   ax.plot([500], [500], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)

   
    ax.plot([150], [650], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)

    
    ax.plot([550], [850], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)
 
    
    ax.plot([700], [200], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)

    ax.plot([900], [450], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false)    
 
end

#### Obstacles

function obstacles()
   # Initialisation graphique
   ion()
   fig = figure("Boids")
   ax = fig.add_subplot(111)
   grid(false)
   xlim(0, 1000)
   ylim(0, 1000)
   # Création du sol
   sol = matplotlib.patches.Rectangle((0, 0), 1000, 1000, linewidth=1, edgecolor="white", facecolor="#40916c")
   ax.add_patch(sol)
    # Grille
    pas = 25
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
   
   sol = matplotlib.patches.Rectangle((250, 350), 100, 200, linewidth=1, facecolor="cyan", alpha=0.5, label="Obstacles")
   ax.add_patch(sol)
   
   
   sol = matplotlib.patches.Rectangle((0, 825), 450, 50, linewidth=1, facecolor="cyan", alpha=0.5)
   ax.add_patch(sol)
   
   
   sol = matplotlib.patches.Rectangle((725, 0), 50, 225, linewidth=1, facecolor="cyan", alpha=0.5)
   ax.add_patch(sol)
   
   sol = matplotlib.patches.Rectangle((725, 275), 50, 150, linewidth=1, facecolor="cyan", alpha=0.5)
   ax.add_patch(sol)
   
   
   sol = matplotlib.patches.Rectangle((725, 425), 100, 50, linewidth=1, facecolor="cyan", alpha=0.5)
   ax.add_patch(sol)
   
   sol = matplotlib.patches.Rectangle((900, 425), 100, 50, linewidth=1, facecolor="cyan", alpha=0.5)
   ax.add_patch(sol)
   
   ax.legend(loc="upper right", fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function pas_100()
   # Initialisation graphique
   ion()
   fig = figure("Boids")
   ax = fig.add_subplot(111)
   grid(false)
   xlim(0, 1000)
   ylim(0, 1000)
   # Création du sol
   ax.plot([], [], marker="s", color="green", linestyle="", alpha=0.4, label="0")
   ax.plot([], [], marker="s", color="red", linestyle="", label="1")
   sol = matplotlib.patches.Rectangle((0, 0), 1000, 1000, linewidth=1, edgecolor="white", facecolor="lime", alpha=0.6)
   ax.add_patch(sol)
    # Grille
    pas = 100
    i = pas
    while i < 1000
        ax.plot([i, i], [0, 1000], color="white", linewidth=0.2) # Longueur
        ax.plot([0, 1000], [i, i], color="white", linewidth=0.2) # Largeur
        i += pas
    end 

   # Boucle
   ax.set_facecolor("#14213d")
   fig.set_facecolor("#14213d")
   ax.tick_params(axis="x", colors="#14213d")
   ax.tick_params(axis="y", colors="#14213d")
   
   
   sol = matplotlib.patches.Rectangle((200, 300), 200, 300, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol)
   
   sol = matplotlib.patches.Rectangle((0, 800), 500, 100, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol)
   
   sol = matplotlib.patches.Rectangle((700, 0), 100, 500, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol)
   
   sol = matplotlib.patches.Rectangle((800, 400), 200, 100, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol)

   ax.legend(loc="upper right", fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function pas_50()
   # Initialisation graphique
   ion()
   fig = figure("Boids")
   ax = fig.add_subplot(111)
   grid(false)
   xlim(0, 1000)
   ylim(0, 1000)
   # Création du sol
   ax.plot([], [], marker="s", color="green", linestyle="", alpha=0.4, label="0")
   ax.plot([], [], marker="s", color="red", linestyle="", label="1")
   sol = matplotlib.patches.Rectangle((0, 0), 1000, 1000, linewidth=1, edgecolor="white", facecolor="lime", alpha=0.6)
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
   ax.tick_params(axis="x", colors="#14213d")
   ax.tick_params(axis="y", colors="#14213d")
   
   
   sol = matplotlib.patches.Rectangle((250, 350), 100, 200, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol)
   
   sol = matplotlib.patches.Rectangle((0, 800), 450, 100, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol)
   
   sol = matplotlib.patches.Rectangle((700, 0), 100, 500, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol)
   
   sol = matplotlib.patches.Rectangle((800, 400), 50, 100, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol)
   
   sol = matplotlib.patches.Rectangle((900, 400), 100, 100, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol)

   ax.legend(loc="upper right", fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function pas_25()
   # Initialisation graphique
   ion()
   fig = figure("Boids")
   ax = fig.add_subplot(111)
   grid(false)
   xlim(0, 1000)
   ylim(0, 1000)
   # Création du sol
   ax.plot([], [], marker="s", color="green", linestyle="", alpha=0.4, label="0")
   ax.plot([], [], marker="s", color="red", linestyle="", label="1")
   sol = matplotlib.patches.Rectangle((0, 0), 1000, 1000, linewidth=1, edgecolor="white", facecolor="lime", alpha=0.6)
   ax.add_patch(sol)
    # Grille
    pas = 25
    i = pas
    while i < 1000
        ax.plot([i, i], [0, 1000], color="white", linewidth=0.2) # Longueur
        ax.plot([0, 1000], [i, i], color="white", linewidth=0.2) # Largeur
        i += pas
    end 

   # Boucle
   ax.set_facecolor("#14213d")
   fig.set_facecolor("#14213d")
   ax.tick_params(axis="x", colors="#14213d")
   ax.tick_params(axis="y", colors="#14213d")
   
   
   sol = matplotlib.patches.Rectangle((250, 350), 100, 200, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol)
   
   sol = matplotlib.patches.Rectangle((0, 825), 450, 50, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol)
   
   sol = matplotlib.patches.Rectangle((725, 0), 50, 225, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol) 
 
   sol = matplotlib.patches.Rectangle((725, 275), 50, 200, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol) 
   
   sol = matplotlib.patches.Rectangle((775, 425), 50, 50, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol)
   
   sol = matplotlib.patches.Rectangle((900, 425), 100, 50, linewidth=1, facecolor="red", alpha=0.6)
   ax.add_patch(sol)

   ax.legend(loc="upper right", fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

pas_25()
