using PyPlot

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
   ax.plot([], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unité terrestre")  
   ax.legend(loc="upper right", fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
   #affichage_etat_courant = ax.text(36, 910, s="", fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)
   ax.plot([500], [500], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")    
   ax.plot([500], [700], color="white", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black")  
   ax.plot([700], [700], color="white", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black")   
   ax.plot([700], [500], color="white", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black")      
   ax.plot([700], [300], color="white", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black")   
   ax.plot([500], [300], color="white", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black")  
   ax.plot([300], [300], color="white", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black")   
   ax.plot([300], [500], color="white", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black")    
   ax.plot([300], [700], color="white", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black")                                                                                   
end

function plot_contours(x, y, pas, id)
    points = [(pas, pas), (pas, 0), (pas, -pas), (0, -pas), (-pas, -pas), (-pas, 0), (-pas, pas), (0, pas)]
    for i in id
        xTemp = points[i][1]
        yTemp = points[i][2]
        plot([x + xTemp], [y + yTemp], color="white", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black")  
    end
end

function main2()
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
   ax.plot([], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unité terrestre")  
   #affichage_etat_courant = ax.text(36, 910, s="", fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)
   sol = matplotlib.patches.Rectangle((250, 200), 100, 400, linewidth=1, facecolor="cyan", alpha=0.5, label="Obstacles")
   ax.add_patch(sol)
   sol = matplotlib.patches.Rectangle((600, 600), 300, 100, linewidth=1, facecolor="cyan", alpha=0.5)
   ax.add_patch(sol)   
   sol = matplotlib.patches.Rectangle((0, 800), 200, 200, linewidth=1, facecolor="cyan", alpha=0.5)
   ax.add_patch(sol) 
   sol = matplotlib.patches.Rectangle((700, 0), 200, 300, linewidth=1, facecolor="cyan", alpha=0.5)
   ax.add_patch(sol) 
   sol = matplotlib.patches.Rectangle((450, 200), 250, 100, linewidth=1, facecolor="cyan", alpha=0.5)
   ax.add_patch(sol) 
   sol = matplotlib.patches.Rectangle((100, 400), 150, 100, linewidth=1, facecolor="cyan", alpha=0.5)
   ax.add_patch(sol) 
   sol = matplotlib.patches.Rectangle((350, 750), 100, 100, linewidth=1, facecolor="cyan", alpha=0.5)
   ax.add_patch(sol)
   ax.legend(loc="upper right", fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)

   #ax.plot([100], [100], color="white", marker="^", linestyle="", alpha=1, markersize=10, markeredgecolor="black", label="Unité terrestre")     
   #plot_contours(100, 100, 75, [1,2,3,4,5,6,7,8])
   #ax.plot([175], [175], color="lime", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black", label="Unité terrestre")   
   
   #ax.plot([175], [175], color="white", marker="^", linestyle="", alpha=1, markersize=10, markeredgecolor="black", label="Unité terrestre")     
   #plot_contours(175, 175, 100, [2,3,4,5,6,7,8]) 
   #ax.plot([275], [75], color="lime", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black", label="Unité terrestre")    
   
   #ax.plot([275], [75], color="white", marker="^", linestyle="", alpha=1, markersize=10, markeredgecolor="black")  
   #plot_contours(275, 75, 150, [1, 2,3,4,5,6,7])  
   #ax.plot([425], [225], color="lime", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black")    
   
   #ax.plot([425], [225], color="white", marker="^", linestyle="", alpha=1, markersize=10, markeredgecolor="black")    
   #plot_contours(425, 225, 125, [1,3,4,5,8])  
   #ax.plot([425], [350], color="lime", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black")   
   
   #ax.plot([425], [350], color="white", marker="^", linestyle="", alpha=1, markersize=10, markeredgecolor="black")    
   #plot_contours(425, 350, 100, [1,2,4,8])   
   #ax.plot([525], [350], color="lime", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black")   
   
   ax.plot([525], [350], color="white", marker="^", linestyle="", alpha=1, markersize=10, markeredgecolor="black")  
   plot_contours(525, 350, 75, [1,2,6,7,8]) 
   ax.plot([525], [425], color="lime", marker="^", linestyle="", alpha=0.4, markersize=10, markeredgecolor="black")     
end

main2()
