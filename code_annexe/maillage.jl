using PyPlot
using Random

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
    x = rand([-1000:2000;], 400)
    y = rand([-2000:2000;], 400)
    z = rand([-200:-200;], 400)
    for g in 0:7
        ax.plot(x[1+50*g:50*(g+1)], y[1+50*g:50*(g+1)], z[1+50*g:50*(g+1)], color="white", marker=".", linestyle="", alpha=rand([0.4:0.1:1;]), markersize=alpha=rand([0.5:0.1:1;]), zorder=0, clip_on=false)       
    end


    # Soleil
    #ax.plot([-800], [-100], [70], color="#a10702", marker="o", markersize=105, linestyle="", alpha=0.5, zorder=-1)
    #ax.plot([-800], [-100], [70], color="#ff6600", marker="o", markersize=100, linestyle="", alpha=1, zorder=0)
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

function plot_seuil(ax,x,y,r,c)
    nb_points = 60
    theta = range(0, 2 * pi, length=nb_points)
    rayon = sqrt(r^2 - (20)^2)
    X = x .+ rayon*cos.(theta)
    Y = y .+ rayon*sin.(theta)
    points_a_conserver = [[]]
    for i in 1:nb_points
        if (X[i] >= -10 && X[i] <= 1010) && (Y[i] >= -10 && Y[i] <= 1010)
            push!(points_a_conserver[end], i)
        else
            push!(points_a_conserver, [])
        end
    end
    for k in 1:length(points_a_conserver)
        ax.plot([X[i] for i in points_a_conserver[k]], [Y[i] for i in points_a_conserver[k]], [0 for i in points_a_conserver[k]], color=c, marker="", zorder=15, markersize=4, alpha=0.8, clip_on=false)
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

function main1()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=90, azim=0) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
    ax.dist = 7
    #ax.dist = 6.6
    xlim(0, 1000)
    ylim(0, 1000)
    #zlim(0, 50)
    zlim(-20, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)
    ax.plot([-10,1010], [-10,-10], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=1)
    ax.plot([-10,-10], [1010,-10], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=1)   
    ax.plot([-10,1010], [1010,1010], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=1)       
    ax.plot([1010,1010], [-10,1010], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=1)       
        
    for x in 0:200:1000
        for y in 0:200:1000
            ax.plot([x], [y], [0], color="white", marker="s", markersize=5, linestyle="", clip_on=false)
        end
    end
    ax.plot([200], [200], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
    ax.plot([0], [800], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
    ax.plot([600], [400], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
    ax.plot([400], [800], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
    ax.plot([800], [1000], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
    ax.plot([1000], [200], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
    
    A = [(200, 200), (0, 800), (600, 400), (400, 800), (800,1000), (1000,200)]    
    for (x,y) in A
        ax.plot([x], [y], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
        pas = 100
        taille = 1
        for xbis in x - taille*pas:pas:x + taille*pas
            for ybis in y - taille*pas:pas:y + taille*pas
                if xbis >= 0 && xbis <= 1000 && ybis <= 1000 && ybis >= 0
                    ax.plot([xbis], [ybis], [0], color="white", marker="s", markersize=5, linestyle="", clip_on=false)              
                end
            end       
        end
    end
end

function main2()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=90, azim=0) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
    ax.dist = 7
    #ax.dist = 6.6
    xlim(0, 1000)
    ylim(0, 1000)
    #zlim(0, 50)
    zlim(-20, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)
    ax.plot([-10,1010], [-10,-10], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=1)
    ax.plot([-10,-10], [1010,-10], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=1)   
    ax.plot([-10,1010], [1010,1010], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=1)       
    ax.plot([1010,1010], [-10,1010], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=1)       
          
 
          
    A = [(200, 200), (0, 800), (600, 400), (400, 800), (800,1000), (1000,200)]    
    for (x,y) in A
        ax.plot([x], [y], [0], color="white", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
        pas = 100
        taille = 1
        for xbis in x - taille*pas:pas:x + taille*pas
            for ybis in y - taille*pas:pas:y + taille*pas
                if xbis >= 0 && xbis <= 1000 && ybis <= 1000 && ybis >= 0
                    ax.plot([xbis], [ybis], [0], color="white", marker="s", markersize=5, linestyle="", clip_on=false)              
                end
            end       
        end
    end
    
    ax.plot([200], [300], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
    ax.plot([100], [700], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
    ax.plot([700], [400], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
    ax.plot([500], [900], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)    
    ax.plot([900], [1000], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)        
    ax.plot([900], [100], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
    
    ax.plot([200], [200], [0], color="red", marker="s", markersize=5, linestyle="", zorder=11, clip_on=false)
    ax.plot([0], [800], [0], color="red", marker="s", markersize=5, linestyle="", zorder=11, clip_on=false)
    ax.plot([600], [400], [0], color="red", marker="s", markersize=5, linestyle="", zorder=11, clip_on=false)
    ax.plot([400], [800], [0], color="red", marker="s", markersize=5, linestyle="", zorder=11, clip_on=false)
    ax.plot([800], [1000], [0], color="red", marker="s", markersize=5, linestyle="", zorder=11, clip_on=false)
    ax.plot([1000], [200], [0], color="red", marker="s", markersize=5, linestyle="", zorder=11, clip_on=false)     
    
    A = [(200, 300), (100, 700), (700, 400), (500, 900), (900,1000), (900,100)]    
    for (x,y) in A
        ax.plot([x], [y], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
        pas = 50
        taille = 1
        for xbis in x - taille*pas:pas:x + taille*pas
            for ybis in y - taille*pas:pas:y + taille*pas
                if xbis >= 0 && xbis <= 1000 && ybis <= 1000 && ybis >= 0
                    ax.plot([xbis], [ybis], [0], color="white", marker="s", markersize=5, linestyle="", clip_on=false)              
                end
            end       
        end
    end
end

function main3()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=90, azim=0) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
    ax.dist = 7
    #ax.dist = 6.6
    xlim(0, 1000)
    ylim(0, 1000)
    #zlim(0, 50)
    zlim(-20, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)
    ax.plot([-10,1010], [-10,-10], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=1)
    ax.plot([-10,-10], [1010,-10], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=1)   
    ax.plot([-10,1010], [1010,1010], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=1)       
    ax.plot([1010,1010], [-10,1010], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=1)     
     
    A = [(200, 300), (100, 700), (700, 400), (500, 900), (900,1000), (900,100)]    
    for (x,y) in A
        ax.plot([x], [y], [0], color="white", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
        pas = 50
        taille = 1
        for xbis in x - taille*pas:pas:x + taille*pas
            for ybis in y - taille*pas:pas:y + taille*pas
                if xbis >= 0 && xbis <= 1000 && ybis <= 1000 && ybis >= 0
                    ax.plot([xbis], [ybis], [0], color="white", marker="s", markersize=5, linestyle="", clip_on=false)              
                end
            end       
        end
    end 
    
    ax.plot([200], [300], [0], color="red", marker="s", markersize=5, linestyle="", zorder=11, clip_on=false)
    ax.plot([100], [700], [0], color="red", marker="s", markersize=5, linestyle="", zorder=11, clip_on=false)
    ax.plot([700], [400], [0], color="red", marker="s", markersize=5, linestyle="", zorder=11, clip_on=false)
    ax.plot([500], [900], [0], color="red", marker="s", markersize=5, linestyle="", zorder=11, clip_on=false)    
    ax.plot([900], [1000], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=11, clip_on=false)        
    ax.plot([900], [100], [0], color="red", marker="s", markersize=5, linestyle="", zorder=11, clip_on=false)   
    
    ax.plot([250], [300], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
    ax.plot([100], [650], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
    ax.plot([750], [350], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
    ax.plot([450], [950], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)
    ax.plot([900], [1000], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)           
    ax.plot([850], [50], [0], color="lime", marker="s", markersize=5, linestyle="", zorder=10, clip_on=false)    
    
    # Etape 1
        ax.plot([200], [200], [0], color="lime", marker="s", markersize=5, linestyle="", alpha=0.2, zorder=10, clip_on=false)
    ax.plot([0], [800], [0], color="lime", marker="s", markersize=5, linestyle="", alpha=0.2, zorder=10, clip_on=false)
    ax.plot([600], [400], [0], color="lime", marker="s", markersize=5, linestyle="", alpha=0.2, zorder=10, clip_on=false)
    ax.plot([400], [800], [0], color="lime", marker="s", markersize=5, linestyle="", alpha=0.2, zorder=10, clip_on=false)
    ax.plot([800], [1000], [0], color="lime", marker="s", markersize=5, linestyle="", alpha=0.2, zorder=10, clip_on=false)
    ax.plot([1000], [200], [0], color="lime", marker="s", markersize=5, linestyle="", alpha=0.2, zorder=10, clip_on=false)

    # Etape 2
    ax.plot([200], [300], [0], color="lime", marker="s", markersize=5, linestyle="", alpha=0.2,zorder=10, clip_on=false)
    ax.plot([100], [700], [0], color="lime", marker="s", markersize=5, linestyle="", alpha=0.2,zorder=10, clip_on=false)
    ax.plot([700], [400], [0], color="lime", marker="s", markersize=5, linestyle="", alpha=0.2,zorder=10, clip_on=false)
    ax.plot([500], [900], [0], color="lime", marker="s", markersize=5, linestyle="", alpha=0.2,zorder=10, clip_on=false)    
    ax.plot([900], [100], [0], color="lime", marker="s", markersize=5, linestyle="", alpha=0.2,zorder=10, clip_on=false)  
    
end

###

function temp()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=90, azim=0) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
    ax.dist = 7
    #ax.dist = 6.6
    xlim(0, 1000)
    ylim(0, 1000)
    #zlim(0, 50)
    zlim(-20, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    ax.plot([-10,1010], [-10,-10], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=2)
    ax.plot([-10,-10], [1010,-10], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=2)   
    ax.plot([-10,1010], [1010,1010], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=2)       
    ax.plot([1010,1010], [-10,1010], [0,0], color="cyan", clip_on=false, zorder=10, linewidth=2)       
        
    for x in 0:5:1000
        for y in 0:5:1000
            ax.plot([x], [y], [0], color="white", marker="s", markersize=1, linestyle="", clip_on=false)
        end
    end
end


function poub()
    # 79.84%
    # 93.9%
    A = [(915, 640), (765, 240), (935, 185), (65, 440), (760, 550), (510,90), (675,840), (185,125), (465,475), (775, 50)] 
    cpt = 0   
    res = []
    pas = 1
    taille = 1    
    for (x,y) in A
        for xbis in x - taille*pas:pas:x + taille*pas
            for ybis in y - taille*pas:pas:y + taille*pas
                if xbis >= 0 && xbis <= 1000 && ybis <= 1000 && ybis >= 0
                    if !((xbis,ybis) in res)
                        println(xbis, ", ", ybis)
                        push!(res, (xbis,ybis))
                        cpt += 1
                    end
                end
            end       
        end
    end 
    println(cpt)
end

poub()
