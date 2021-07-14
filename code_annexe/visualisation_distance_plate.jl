using PyPlot

function plot_base(x,y)
    # Murs
    Z = [trunc.([0.05*i, 0.05*i], digits=2) for i in 0:20]
    cpt = 1
    for z in Z 
        if z == [0.0,0.0] 
            # marker="", markersize=0.2, markeredgecolor="black", 
            plot([x-10,x+10], [y+10,y+10], z, color="#6b705c", linewidth=1, zorder=16, clip_on=false) # mur haut 
            plot([x-10,x+10], [y-10,y-10], z, color="#6b705c", linewidth=1, zorder=16, clip_on=false) # mur bas
            plot([x-10,x-10], [y-10,y+10], z, color="#6b705c", linewidth=1, zorder=16, clip_on=false) # mur gauche
            plot([x+10,x+10], [y-10,y+10], z, color="#6b705c", linewidth=1, zorder=16, clip_on=false) # mur droite
        elseif z == [1.0, 1.0]
            plot([x-10,x+10], [y+10,y+10], z, color="#6b705c", linewidth=1, zorder=18, clip_on=false) # mur haut 
            plot([x-10,x+10], [y-10,y-10], z, color="#6b705c", linewidth=1, zorder=18, clip_on=false) # mur bas
            plot([x-10,x-10], [y-10,y+10], z, color="#6b705c", linewidth=1, zorder=18, clip_on=false) # mur gauche
            plot([x+10,x+10], [y-10,y+10], z, color="#6b705c", linewidth=1, zorder=18, clip_on=false) # mur droite
        else
            if cpt % 2 == 0
                couleur = "#E4E4DD"
            else
                couleur = "#E4E4DD"
            end
            plot([x-10,x+10], [y+10,y+10], z, color=couleur, linewidth=1, zorder=16, clip_on=false) # mur haut 
            plot([x-10,x+10], [y-10,y-10], z, color=couleur, linewidth=1, zorder=16, clip_on=false) # mur bas
            plot([x-10,x-10], [y-10,y+10], z, color=couleur, linewidth=1, zorder=16, clip_on=false) # mur gauche
            plot([x+10,x+10], [y-10,y+10], z, color=couleur, linewidth=1, zorder=16, clip_on=false) # mur droite
            cpt += 1
        end
    end
    # Toit
    cpt = 1
    for i in x-9.9:0.1:x+9.9
        if cpt % 2 == 0
            couleur = "#E4E4DD"
        else
            couleur = "#E4E4DD"
        end
        plot([i,i], [y-10,y+10], [1.0,1.0], color=couleur, marker="", linewidth=1, zorder=17, clip_on=false) # toit
        cpt += 1
    end 
end

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
    x = [0 0; 1000 1000]
    y = [0 1000; 0 1000]
    z = [0 0; 0 0]
    plot_surface(x,y,z, color="#40916c", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)
    # Grille
    pas = 50
    i = 0
    while i < 1000
        ax.plot([i, i], [0, 1000], [0], color="white", linewidth=0.1, zorder=15, clip_on=false) # Longueur
        ax.plot([0, 1000], [i, i], [0], color="white", linewidth=0.1, zorder=15, clip_on=false) # Largeur
        i += pas
    end

    # Plan tombant 1
    x = [0 1000; 0 1000]
    y = [0 0; 0 0]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)  

    # Plan tombant 2
    x = [1000 1000; 1000 1000]
    y = [0 1000; 0 1000]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)   

    # Plan tombant 3
    x = [0 1000; 0 1000]
    y = [1000 1000; 1000 1000]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false) 

    # Plan tombant 4
    x = [0 0; 0 0]
    y = [0 1000; 0 1000]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false) 

    # Fermeture
    x = [0 0; 1000 1000]
    y = [0 1000; 0 1000]
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
    x = [0 1000; 0 1000]
    y = [1000 1000; 1000 1000]
    z = [0 0; 15 15]
    plot_surface(x,y,z, color="#48cae4", alpha=0.9, shade=false, zorder=0, clip_on=false)

    # Stratosphère (15-50 km)
    x = [0 1000; 0 1000]
    y = [1000 1000; 1000 1000]
    z = [15 15; 50 50]
    plot_surface(x,y,z, color="#00b4d8", alpha=0.9, shade=false, zorder=0, clip_on=false)

    # Mésosphère (50-85 km)
    x = [0 1000; 0 1000]
    y = [1000 1000; 1000 1000]
    z = [50 50; 85 85]
    plot_surface(x,y,z, color="#0096c7", alpha=0.9, shade=false, zorder=0, clip_on=false)

    # Thermosphère (85-500 km)
    x = [0 1000; 0 1000]
    y = [1000 1000; 1000 1000]
    z = [85 85; 500 500]
    plot_surface(x,y,z, color="#0077b6", alpha=0.9, shade=false, zorder=0, clip_on=false)

   ###### Fond n°2 ######

    # Troposphère (15 km)
    x = [0 0; 0 0]
    y = [0 1000; 0 1000]
    z = [0 0; 15 15]
    plot_surface(x,y,z, color="#48cae4", alpha=0.9, shade=false, zorder=0, clip_on=false)

    # Stratosphère (15-50 km)
    x = [0 0; 0 0]
    y = [0 1000; 0 1000]
    z = [15 15; 50 50]
    plot_surface(x,y,z, color="#00b4d8", alpha=0.9, shade=false, zorder=0, clip_on=false)

    # Mésosphère (50-85 km)
    x = [0 0; 0 0]
    y = [0 1000; 0 1000]
    z = [50 50; 85 85]
    plot_surface(x,y,z, color="#0096c7", alpha=0.9, shade=false, zorder=0, clip_on=false)

    # Thermosphère (85-500 km)
    x = [0 0; 0 0]
    y = [0 1000; 0 1000]
    z = [85 85; 500 500]
    plot_surface(x,y,z, color="#0077b6", alpha=0.9, shade=false, zorder=0, clip_on=false) 
end

function labels(ax)
    # Ligne des 20 km
    ax.plot([0,0], [0,1000], [20,20], color="white", marker="", markersize=5, linestyle="--", linewidth=1, alpha=0.7, zorder=15, clip_on=false)
    ax.plot([0,1000], [1000,1000], [20,20], color="white", marker="", markersize=5, linestyle="--", linewidth=1, alpha=0.7, zorder=15, clip_on=false)
    text3D(x=0, y=200, z=22, s="Altitude de déploiement des HAPS", zdir="y", color="black", fontsize=10, zorder=15, clip_on=false)

    # Ligne de Kármán
    ax.plot([0,0], [0,1000], [100,100], color="red", marker="", markersize=5, linestyle="--", linewidth=1, alpha=0.7, zorder=18, clip_on=false)
    ax.plot([0,1000], [1000,1000], [100,100], color="red", marker="", markersize=5, linestyle="--", linewidth=1, alpha=0.7, zorder=18, clip_on=false)
    text3D(x=0, y=375, z=102, s="Ligne de Kármán", zdir="y", color="black", fontsize=7, zorder=15, clip_on=false)

    # Labels
    text3D(x=0, y=-95, z=15, s="15 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=15, clip_on=false)
    text3D(x=0, y=-95, z=20, s="20 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=15, clip_on=false)
    text3D(x=0, y=10, z=7.5, s="Troposphère", zdir="y", color="black", zorder=15, clip_on=false, fontsize=14)
    text3D(x=0, y=10, z=35, s="Stratosphère", zdir="y", color="black", zorder=15, clip_on=false)
    text3D(x=0, y=-90, z=50, s="50 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=15, clip_on=false)
    text3D(x=0, y=10, z=67.5, s="Mésosphère", zdir="y", color="black", zorder=15, clip_on=false)
    text3D(x=0, y=-90, z=85, s="85 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=15, clip_on=false)
    text3D(x=0, y=10, z=100, s="Thermosphère", zdir="y", color="black", zorder=15, clip_on=false)
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
    ax.view_init(elev=12, azim=-41) 
    ax.dist = 4.2
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
    #generation_ciel(ax)
    generation_etoiles(ax)
    
    # Une unité
    #ax.plot([300], [300], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false, label=L"Une unité $u \in \mathcal{U}$  à un instant $t \in \mathcal{T}$")
    plot_base(300,300)
    ax.plot([], [], [], color="#E4E4DD", marker="s", markeredgecolor="#6b705c", linestyle="", markersize=15, label=L"Une base $b \in \mathcal{B}$")  
    
    # Un HAPS
    ax.plot([700], [700], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=20, zorder=25, clip_on=false, label=L"Un HAPS $h \in \mathcal{H}$ déployé sur une position $e \in \mathcal{E}$")
    ax.plot([700, 700], [700, 700], [0, 20], color="lime", zorder=19, clip_on=false)

    # Repère
    # (Ox)
    ax.plot([0, 1000], [0, 0], [0, 0], color="white", zorder=20, linewidth=1, clip_on=false)
    for i in -6:0.1:0
        ax.plot([990, 1000], [i, 0], [0, 0], color="white", zorder=20, linewidth=1)
    end
    for i in 0:0.1:6
        ax.plot([990, 1000], [i, 0], [0, 0], color="white", zorder=20, linewidth=1)
    end

    # (Oy)
    ax.plot([0, 0], [0, 1000], [0, 0], color="white", zorder=20, linewidth=1, clip_on=false)
    for i in -6:0.1:0
        ax.plot([i, 0], [990, 1000], [0, 0], color="white", zorder=20, linewidth=1)
    end
    for i in 0:0.1:6
        ax.plot([i, 0], [990, 1000], [0, 0], color="white", zorder=20, linewidth=1)
    end

    # (Oz)
    ax.plot([0, 0], [0, 0], [0, 25], color="white", zorder=20, linewidth=1, clip_on=false)
    for i in -5:0.1:0
        ax.plot([0, 0], [i, 0], [24.5, 25], color="white", zorder=20, linewidth=1, clip_on=false)    
    end
    for i in 0:0.1:5
        ax.plot([0, 0], [i, 0], [24.5, 25], color="white", zorder=20, linewidth=1, clip_on=false)          
    end


    
    # Projections sur x
    ax.plot([300, 300], [0, 300], [0, 0], color="white", zorder=16, linestyle="dotted", clip_on=false)
    ax.plot([700, 700], [0, 300], [0, 0], color="white", zorder=16, linestyle="dotted", clip_on=false)

    # Projections sur y
    ax.plot([700, 1000], [300, 300], [0, 0], color="white", zorder=16, linestyle="dotted", clip_on=false)
    ax.plot([700, 1000], [700, 700], [0, 0], color="white", zorder=16, linestyle="dotted", clip_on=false)
    
    # Triangle au sol
    ax.plot([300, 700], [300, 300], [0, 0], color="pink", zorder=14)
    ax.plot([700, 700], [300, 700], [0, 0], color="yellow", zorder=14)
    ax.plot([300, 700], [300, 700], [0, 0], color="red", zorder=14)


    # Angle droit 1 (triangle sol)
    ax.plot([660, 660], [300, 340], [0, 0], color="white", zorder=15)
    ax.plot([660, 700], [340, 340], [0, 0], color="white", zorder=15)

    # Angle droit 2 (triangle aérien)
    ax.plot([680, 680], [680, 680], [0, 2], color="white", zorder=15)
    ax.plot([680, 700], [680, 700], [2, 2], color="white", zorder=15)

    # Distance unité/haps
    ax.plot([300, 700], [300, 700], [0, 20], color="cyan", zorder=15)

    # Légende 
    ax.legend(loc="upper left", bbox_to_anchor=(-0.4, 0.95), fontsize=16, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end


main()
