using PyPlot
using Random

function generation_sol(ax)
    # Meshgrid
    # Ancienne méthode, génère des ralentissements
    #xIt = 0:50:1000
    #yIt = 0:50:1000
    #x = xIt' .* ones(length(xIt))
    #y = ones(length(yIt))' .* yIt
    #z = x .* 0
    #plot_surface(x, y, z, color="#239b5e", edgecolor="none", alpha=1, shade=false) # 2d6a4f
    # Surface
    x = [200 200; 800 800]
    y = [200 800; 200 800]
    z = [0 0; 0 0]
    plot_surface(x,y,z, color="#40916c", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)
    # Grille
    pas = 50
    i = 200
    while i < 800
        ax.plot([i, i], [200, 800], [0], color="white", linewidth=0.1, zorder=15, clip_on=false) # Longueur
        ax.plot([200, 800], [i, i], [0], color="white", linewidth=0.1, zorder=15, clip_on=false) # Largeur
        i += pas
    end

    # Plan tombant 1
    x = [200 800; 200 800]
    y = [200 200; 200 200]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)  

    # Plan tombant 2
    x = [800 800; 800 800]
    y = [200 800; 200 800]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)   

    # Plan tombant 3
    x = [200 800; 200 800]
    y = [800 800; 800 800]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false) 

    # Plan tombant 4
    x = [200 200; 200 200]
    y = [200 800; 200 800]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false) 

    # Fermeture
    x = [200 200; 800 800]
    y = [200 800; 200 800]
    z = [-15 -15; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false) 

    # Démarcations (arrêtes)
    #plot([0, 0], [0, 0], [0, -500], color="#081c15", linewidth=1, zorder=10)
    #plot([1000, 1000], [0, 0], [0, -500], color="#081c15", linewidth=1, zorder=10)
    #plot([1000, 1000], [1000, 1000], [0, -500], color="#081c15", linewidth=1, zorder=10)

    # Affichage dimensions
    #ax.plot([0,1000], [-50,-50], [0,0], color="white", marker="", markersize=5, zorder=10)
    #ax.plot([1050,1050], [0,1000], [0,0], color="white", marker="", markersize=5, zorder=10)
end

function generation_ciel(ax)
    ###### Fond n°1 ######

    # Troposphère (15 km)
    x = [200 800; 200 800]
    y = [800 800; 800 800]
    z = [0 0; 15 15]
    plot_surface(x,y,z, color="#48cae4", alpha=0.9, shade=false, zorder=0, clip_on=false)

    # Stratosphère (15-50 km)
    x = [200 800; 200 800]
    y = [800 800; 800 800]
    z = [15 15; 25 25]
    plot_surface(x,y,z, color="#00b4d8", alpha=0.9, shade=false, zorder=0, clip_on=false)

   ###### Fond n°2 ######

    # Troposphère (15 km)
    x = [200 200; 200 200]
    y = [200 800; 200 800]
    z = [0 0; 15 15]
    plot_surface(x,y,z, color="#48cae4", alpha=0.9, shade=false, zorder=0, clip_on=false)

    # Stratosphère (15-50 km)
    x = [200 200; 200 200]
    y = [200 800; 200 800]
    z = [15 15; 25 25]
    plot_surface(x,y,z, color="#00b4d8", alpha=0.9, shade=false, zorder=0, clip_on=false)


    ax.plot([200,200], [200,800], [20,20], color="white", marker="", markersize=5, linestyle="--", alpha=0.7, zorder=15, clip_on=false)
    ax.plot([200,800], [800,800], [20,20], color="white", marker="", markersize=5, linestyle="--", alpha=0.7, zorder=15, clip_on=false)
end

function generation_etoiles(ax)
    # Seed : chaîne de caractères vers suite d'entiers (conversion via code ASCII) 
    chaine = "orion"
    conversion = string.([Int(c) for c in chaine])
    graine = ""
    for c in conversion
        graine *= c
    end
    graine = parse(Int, graine)
    Random.seed!(graine)

    # Fond 1
    x = rand([000:000;], 800)
    y = rand([-2000:2000;], 800)
    z = rand([-200:400;], 800)
    for g in 0:15
        ax.plot(x[1+50*g:50*(g+1)], y[1+50*g:50*(g+1)], z[1+50*g:50*(g+1)], color="white", marker=".", linestyle="", alpha=rand([0.4:0.1:1;]), markersize=alpha=rand([0.5:0.1:1;]), zorder=0, clip_on=false)       
    end

    # Fond 2
    x = rand([000:2000;], 800)
    y = rand([2000:2000;], 800)
    z = rand([-200:400;], 800)
    for g in 0:15
        ax.plot(x[1+50*g:50*(g+1)], y[1+50*g:50*(g+1)], z[1+50*g:50*(g+1)], color="white", marker=".", linestyle="", alpha=rand([0.4:0.1:1;]), markersize=alpha=rand([0.5:0.1:1;]), zorder=0, clip_on=false)       
    end

    # Soleil
    #ax.plot([-800], [00], [70], color="#a10702", marker="o", markersize=105, linestyle="", alpha=0.5, zorder=-1)
    #ax.plot([-800], [00], [70], color="#ff6600", marker="o", markersize=100, linestyle="", alpha=1, zorder=0)
end

function main()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d") 
    ax.margins(0)
    ax.view_init(elev=37, azim=-46)
    ax.dist = 6.5
    fig.set_facecolor("#14213d")
    ax.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    ax.set_zticks([0, 15, 20, 50, 85, 500])
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(-20, 30)
    tight_layout(pad=0)

    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax) 


    # Une unité
    ax.plot([400], [400], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false, label=L"Une unité $u \in \mathcal{U}$  à un instant $t \in \mathcal{T}$")

    # Un HAPS
    ax.plot([600], [600], [20], color="darkorange", marker="o", markeredgecolor="black", linestyle="", markersize=20, zorder=25, clip_on=false, label=L"Un HAPS $h \in \mathcal{H}$ déployé sur une position $e \in \mathcal{E}$")
    ax.plot([600, 600], [600, 600], [0, 20], color="cyan", zorder=19, clip_on=false)
    ax.text2D(0.635, 0.55, L"$A$", transform=ax.transAxes, color="white", zorder=50, size=14)

    # Repère
    # (Ox)
    ax.plot([200, 850], [200, 200], [0, 0], color="white", zorder=20, linewidth=1)
    ax.plot([840, 850], [208, 200], [0, 0], color="white", zorder=20, linewidth=1)
    ax.plot([840, 850], [192, 200], [0, 0], color="white", zorder=20, linewidth=1)
    # (Oy)
    ax.plot([200, 200], [200, 800], [0, 0], color="white", zorder=20, linewidth=1)
    ax.plot([200, 200], [800, 850], [0, 0], color="white", zorder=1, linewidth=1)
    ax.plot([208, 200], [840, 850], [0, 0], color="white", zorder=1, linewidth=1)
    ax.plot([192, 200], [840, 850], [0, 0], color="white", zorder=1, linewidth=1)
    # (Oz)
    ax.plot([200, 200], [200, 200], [0, 30], color="white", zorder=20, linewidth=1)
    ax.plot([200, 200], [208, 200], [28.5, 30], color="white", zorder=1, linewidth=1)
    ax.plot([200, 200], [192, 200], [28.5, 30], color="white", zorder=1, linewidth=1)

    # Projections sur x
    ax.plot([400, 400], [200, 400], [0, 0], color="white", zorder=16, linestyle="dotted")
    ax.text2D(0.268, 0.348, L"$x_u^t$", transform=ax.transAxes, color="white", zorder=50, rotation=-17, size=14)
    ax.plot([600, 600], [200, 400], [0, 0], color="white", zorder=16, linestyle="dotted")
    ax.text2D(0.39, 0.277, L"$x_e$", transform=ax.transAxes, color="white", zorder=50, rotation=-17, size=14)

    # Projections sur y
    ax.plot([600, 800], [400, 400], [0, 0], color="white", zorder=16, linestyle="dotted")
    ax.text2D(0.75, 0.362, L"$y_e$", transform=ax.transAxes, color="white", zorder=50, rotation=21, size=14)
    ax.plot([600, 800], [600, 600], [0, 0], color="white", zorder=16, linestyle="dotted")
    ax.text2D(0.635, 0.278, L"$y_u^t$", transform=ax.transAxes, color="white", zorder=50, rotation=21, size=14)
 
    # Projections sur z
    ax.plot([600, 600], [600, 800], [20, 20], color="white", zorder=10, linestyle="dotted")
    ax.plot([600, 600], [600, 800], [0, 0], color="white", zorder=10, linestyle="dotted")   

    # Triangle au sol
    ax.plot([400, 600], [400, 400], [0, 0], color="pink", zorder=16)
    ax.text2D(0.415, 0.402, L"$|x_e - x_u^t|$", transform=ax.transAxes, color="white", zorder=50, rotation=-16, size=14)
    ax.plot([600, 600], [400, 600], [0, 0], color="yellow", zorder=16)
    ax.text2D(0.57, 0.405, L"$|y_e - y_u^t|$", transform=ax.transAxes, color="white", zorder=50, rotation=18, size=14)
    ax.plot([400, 600], [400, 600], [0, 0], color="red", zorder=16)
    ax.text2D(0.46, 0.46, L"$\sqrt{(x_e - x_u^t)^2 + (y_e - y_u^t)^2}$", transform=ax.transAxes, color="white", zorder=50, size=14)

    # Angle droit 1 (triangle sol)
    ax.plot([580, 580], [400, 420], [0, 0], color="white", zorder=15)
    ax.plot([580, 600], [420, 420], [0, 0], color="white", zorder=15)

    # Angle droit 2 (triangle aérien)
    ax.plot([590, 590], [590, 590], [0, 2], color="white", zorder=15)
    ax.plot([590, 600], [590, 600], [2, 2], color="white", zorder=15)

    # Distance unité/haps
    ax.plot([400, 600], [400, 600], [0, 20], color="blue", zorder=15)
    ax.text2D(0.40, 0.61, L"$\sqrt{(x_e - x_u^t)^2 + (y_e - y_u^t)^2 + A^2}$", transform=ax.transAxes, color="white", zorder=50, rotation=30, size=14)

    # Légende 
    ax.legend(loc="upper left", bbox_to_anchor=(0.35, 0.9), fontsize=16, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

main()
