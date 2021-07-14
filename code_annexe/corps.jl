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
    x = [-10 -10; 1010 1010]
    y = [-10 1010; -10 1010]
    z = [0 0; 0 0]
    plot_surface(x,y,z, color="#40916c", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)
    # Grille
    pas = 50
    i = 0
    while i < 1010
        ax.plot([i, i], [-10, 1010], [0], color="white", linewidth=0.1, zorder=15, clip_on=false) # Longueur
        ax.plot([-10, 1010], [i, i], [0], color="white", linewidth=0.1, zorder=15, clip_on=false) # Largeur
        i += pas
    end

    # Plan tombant 1
    x = [-10 1010; -10 1010]
    y = [-10 -10; -10 -10]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)  

    # Plan tombant 2
    x = [1010 1010; 1010 1010]
    y = [-10 1010; -10 1010]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)   

    # Plan tombant 3
    x = [-10 1010; -10 1010]
    y = [1010 1010; 1010 1010]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false) 

    # Plan tombant 4
    x = [-10 -10; -10 -10]
    y = [-10 1010; -10 1010]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false) 

    # Fermeture
    x = [-10 -10; 1010 1010]
    y = [-10 1010; -10 1010]
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
    x = rand([-10000:-10000;], 800)
    y = rand([-10000:10000;], 800)
    z = rand([-2000:4000;], 800)
    for g in 0:15
        ax.plot(x[1+50*g:50*(g+1)], y[1+50*g:50*(g+1)], z[1+50*g:50*(g+1)], color="white", marker=".", linestyle="", alpha=rand([0.4:0.1:1;]), markersize=alpha=rand([0.5:0.1:1;]), zorder=0, clip_on=false)       
    end

    # Fond 2
    x = rand([-10000:10000;], 800)
    y = rand([10000:10000;], 800)
    z = rand([-2000:2000;], 800)
    for g in 0:15
        ax.plot(x[1+50*g:50*(g+1)], y[1+50*g:50*(g+1)], z[1+50*g:50*(g+1)], color="white", marker=".", linestyle="", alpha=rand([0.4:0.1:1;]), markersize=alpha=rand([0.5:0.1:1;]), zorder=0, clip_on=false)       
    end

    # Soleil
    #ax.plot([-800], [-100], [70], color="#a10702", marker="o", markersize=105, linestyle="", alpha=0.5, zorder=-1)
    #ax.plot([-800], [-100], [70], color="#ff6600", marker="o", markersize=100, linestyle="", alpha=1, zorder=0)
end

function generation_ciel(ax)
    ###### Fond n°1 ######

    # Troposphère (15 km)
    x = [-10 1010; -10 1010]
    y = [1010 1010; 1010 1010]
    z = [0 0; 15 15]
    plot_surface(x,y,z, color="#48cae4", alpha=0.9, shade=false, zorder=-10, clip_on=false)

    # Stratosphère (15-50 km)
    x = [-10 1010; -10 1010]
    y = [1010 1010; 1010 1010]
    z = [15 15; 50 50]
    plot_surface(x,y,z, color="#00b4d8", alpha=0.9, shade=false, zorder=-10, clip_on=false)

    # Mésosphère (50-85 km)
    x = [-10 1010; -10 1010]
    y = [1010 1010; 1010 1010]
    z = [50 50; 85 85]
    plot_surface(x,y,z, color="#0096c7", alpha=0.9, shade=false, zorder=-10, clip_on=false)

    # Thermosphère (85-500 km)
    x = [-10 1010; -10 1010]
    y = [1010 1010; 1010 1010]
    z = [85 85; 500 500]
    plot_surface(x,y,z, color="#0077b6", alpha=0.9, shade=false, zorder=-10, clip_on=false)

   ###### Fond n°2 ######

    # Troposphère (15 km)
    x = [-10 -10; -10 -10]
    y = [-10 1010; -10 1010]
    z = [0 0; 15 15]
    plot_surface(x,y,z, color="#48cae4", alpha=0.9, shade=false, zorder=-10, clip_on=false)

    # Stratosphère (15-50 km)
    x = [-10 -10; -10 -10]
    y = [-10 1010; -10 1010]
    z = [15 15; 50 50]
    plot_surface(x,y,z, color="#00b4d8", alpha=0.9, shade=false, zorder=-10, clip_on=false)

    # Mésosphère (50-85 km)
    x = [-10 -10; -10 -10]
    y = [-10 1010; -10 1010]
    z = [50 50; 85 85]
    plot_surface(x,y,z, color="#0096c7", alpha=0.9, shade=false, zorder=-10, clip_on=false)

    # Thermosphère (85-500 km)
    x = [-10 -10; -10 -10]
    y = [-10 1010; -10 1010]
    z = [85 85; 500 500]
    plot_surface(x,y,z, color="#0077b6", alpha=0.9, shade=false, zorder=-10, clip_on=false) 
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
    text3D(x=0, y=10, z=35, s="Stratosphère", zdir="y", color="black", zorder=15, clip_on=false, fontsize=14)
    text3D(x=0, y=-90, z=50, s="50 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=15, clip_on=false)
    text3D(x=0, y=10, z=67.5, s="Mésosphère", zdir="y", color="black", zorder=15, clip_on=false)
    text3D(x=0, y=-90, z=85, s="85 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=15, clip_on=false)
    text3D(x=0, y=10, z=100, s="Thermosphère", zdir="y", color="black", zorder=15, clip_on=false)
end

function plot_seuil(ax,x,y,r,c, bool=false)
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
        if bool == true
            ax.plot([X[i] for i in points_a_conserver[k]], [Y[i] for i in points_a_conserver[k]], [0 for i in points_a_conserver[k]], color=c, marker="", zorder=15, markersize=4, alpha=0.4, clip_on=false)        
        else
            ax.plot([X[i] for i in points_a_conserver[k]], [Y[i] for i in points_a_conserver[k]], [0 for i in points_a_conserver[k]], color=c, marker="", zorder=15, markersize=4, alpha=0.8, clip_on=false)
        end
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

function main()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=18, azim=-19) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
    ax.dist = 4.3
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
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
    labels(ax)
    affichage_etat_courant = ax.text2D(-0.45, 0.80, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)  
    affichage_etat_courant.set_text("État : 5/20")     
    #plot_base(400,400)
    #plot_seuil(ax,400,400,100,"crimson")   
    #plot_seuil(ax,400,400,150,"cyan")   
    #plot_seuil(ax,400,400,200,"lime")  
    
    
    # couv       
    ax.plot([410], [280], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(410,280)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    plot_seuil(ax,410,280,110,"crimson")  
    plot_seuil(ax,410,280,160,"cyan")  
    plot_seuil(ax,410,280,240,"crimson")   
    plot_seuil(ax,410,280,70,"cyan") 
    ax.plot([600], [750], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(600,750)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    plot_seuil(ax,600,750,70,"lime") 
    plot_seuil(ax,600,750,165,"lime") 
    
    for x in 0:200:1000
        for y in 0:200:1000
            ax.plot([x], [y], [0], color="#f8961e", marker="s", linestyle="", markersize=2.5, alpha=0.6, zorder=14, clip_on=false)
        end
    end
    
    ax.plot([], [], [], color="#f8961e", marker="s", linestyle="", label="Déploiement possible")
    
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Relais de type 1") 
    ax.plot([], [], [], color="lime", marker="", markersize=10, label="Relais de type 2") 
    ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Relais de type 3")    
    ax.plot([], [], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    #ax.plot([], [], [], color="#E4E4DD", marker="s", markeredgecolor="#6b705c", linestyle="", markersize=15, label="Base") 
    ax.legend(loc="upper left", bbox_to_anchor=(0.90, 0.95), fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function main_bis()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=18, azim=-19) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
    ax.dist = 4.3
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
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
    labels(ax)
    affichage_etat_courant = ax.text2D(-0.45, 0.80, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)  
    affichage_etat_courant.set_text("État : 1/20")     
    #plot_base(400,400)
    #plot_seuil(ax,400,400,100,"crimson")   
    #plot_seuil(ax,400,400,150,"cyan")   
    #plot_seuil(ax,400,400,200,"lime")  
    
    
    # couv       
    plot_base(400,500)  
    plot_seuil(ax,400,500,110,"crimson")  
    plot_seuil(ax,400,500,160,"cyan")  
    plot_seuil(ax,400,500,70,"lime") 
    plot_seuil(ax,400,500,250,"lime") 
    
    for x in 0:200:1000
        for y in 0:200:1000
            ax.plot([x], [y], [0], color="#f8961e", marker="s", linestyle="", markersize=2.5, alpha=0.6, zorder=14, clip_on=false)
        end
    end
    
    ax.plot([], [], [], color="#f8961e", marker="s", linestyle="", label="Déploiement possible")
    
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Relais de type 1") 
    ax.plot([], [], [], color="lime", marker="", markersize=10, label="Relais de type 2") 
    ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Relais de type 3")    
    #ax.plot([], [], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    ax.plot([], [], [], color="#E4E4DD", marker="s", markeredgecolor="#6b705c", linestyle="", markersize=15, label="Base") 
    ax.legend(loc="upper left", bbox_to_anchor=(0.90, 0.95), fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function main_ter()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=18, azim=-19) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
    ax.dist = 4.3
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
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
    labels(ax)
    affichage_etat_courant = ax.text2D(-0.45, 0.80, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)  
    affichage_etat_courant.set_text("État : 10/10")     
    #plot_base(400,400)
    #plot_seuil(ax,400,400,100,"crimson")   
    #plot_seuil(ax,400,400,150,"cyan")   
    #plot_seuil(ax,400,400,200,"lime")  
    
    
    # couv       
    plot_base(700,500)  
    
    ax.plot([600], [750], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    ax.plot([650], [700], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=0.5, linestyle="", zorder=21, clip_on=false)
    ax.plot([700], [650], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=0.5, linestyle="", zorder=21, clip_on=false)
    ax.plot([750], [650], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=0.5, linestyle="", zorder=21, clip_on=false)
    ax.plot([800], [650], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=0.5, linestyle="", zorder=21, clip_on=false)
   ax.plot([800], [600], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=0.5, linestyle="", zorder=21, clip_on=false)
    ax.plot([800], [550], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=0.5, linestyle="", zorder=21, clip_on=false)
    ax.plot([800], [500], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=0.5, linestyle="", zorder=21, clip_on=false)
    ax.plot([750], [450], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=0.5, linestyle="", zorder=21, clip_on=false)
    ax.plot([750], [400], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=0.5, linestyle="", zorder=21, clip_on=false)

    plot_seuil(ax,300,600,160,"cyan")  
    plot_seuil(ax,600,600,160,"cyan")  

    ax.plot([300], [600], [0], color="red", marker="s", linestyle="", markersize=4, alpha=0.6, zorder=14, clip_on=false)
    ax.plot([600], [600], [0], color="lime", marker="s", linestyle="", markersize=4, alpha=0.6, zorder=14, clip_on=false)
 
    ax.plot([], [], [], color="lime", marker="s", linestyle="", label="Position utile (couvrante)") 
    ax.plot([], [], [], color="red", marker="s", linestyle="", label="Position inutile (non couvrante)") 
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Relais de type 1") 
    ax.plot([], [], [], color="lime", marker="", markersize=10, label="Relais de type 2") 
    ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Relais de type 3")    
    #ax.plot([], [], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    ax.plot([], [], [], color="#E4E4DD", marker="s", markeredgecolor="#6b705c", linestyle="", markersize=15, label="Base") 
    ax.legend(loc="upper left", bbox_to_anchor=(0.90, 0.95), fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end


function main_quater()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=18, azim=-19) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
    ax.dist = 4.3
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
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
    labels(ax)
    affichage_etat_courant = ax.text2D(-0.45, 0.80, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)  
    affichage_etat_courant.set_text("État : 5/5")     
    #plot_base(400,400)
    #plot_seuil(ax,400,400,100,"crimson")   
    #plot_seuil(ax,400,400,150,"cyan")   
    #plot_seuil(ax,400,400,200,"lime")  
    
    
    # couv 
    ax.plot([500], [450], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=1.0, linestyle="", zorder=21, clip_on=false)      
    ax.plot([500], [500], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=0.5, linestyle="", zorder=21, clip_on=false)
    ax.plot([500], [550], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=0.5, linestyle="", zorder=21, clip_on=false)
    ax.plot([450], [550], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=0.5, linestyle="", zorder=21, clip_on=false)
    ax.plot([450], [600], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=9, alpha=0.5, linestyle="", zorder=21, clip_on=false)

    plot_seuil(ax,500,450,130,"lime", false)  
    plot_seuil(ax,500,450,70,"cyan", false)  
    plot_seuil(ax,500,500,130,"lime", true)  
    plot_seuil(ax,500,500,70,"cyan", true)  
    plot_seuil(ax,500,550,130,"lime", true)  
    plot_seuil(ax,500,550,70,"cyan", true) 
    plot_seuil(ax,450,550,130,"lime", true)  
    plot_seuil(ax,450,550,70,"cyan", true)    
    plot_seuil(ax,500,500,130,"lime", true)  
    plot_seuil(ax,450,600,70,"cyan", true)  

    for x in 0:350:1000
        for y in 0:350:1000
            ax.plot([x], [y], [0], color="#f8961e", marker="s", linestyle="", markersize=2.5, alpha=0.6, zorder=14, clip_on=false)
        end
    end
    
    ax.plot([], [], [], color="#f8961e", marker="s", linestyle="", label="Déploiement possible")
    
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Relais de type 1") 
    ax.plot([], [], [], color="lime", marker="", markersize=10, label="Relais de type 2") 
    ax.plot([], [], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    #ax.plot([], [], [], color="#E4E4DD", marker="s", markeredgecolor="#6b705c", linestyle="", markersize=15, label="Base") 
    ax.legend(loc="upper left", bbox_to_anchor=(0.90, 0.95), fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end



function cinqter()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=18, azim=-19) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
    ax.dist = 4.3
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
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
    labels(ax)
    affichage_etat_courant = ax.text2D(-0.45, 0.80, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)  
    #affichage_etat_courant.set_text("État : 5/5")     
    #plot_base(400,400)
    #plot_seuil(ax,400,400,100,"crimson")   
    #plot_seuil(ax,400,400,150,"cyan")   
    #plot_seuil(ax,400,400,200,"lime")  
       ax.plot([], [], [], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=20,  label="HAPS")

            ax.plot([400], [400], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
            ax.plot([400,400], [400,400], [20,0], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
            
            ax.plot([600], [600], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
            ax.plot([600,600], [600,600], [20,0], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
            
            ax.plot([600], [200], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
            ax.plot([600,600], [200,200], [20,0], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    
    #ax.plot([], [], [], color="#f8961e", marker="s", linestyle="", label="Déploiement possible")
    
    #ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Relais de type 1") 
    #ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Relais de type 2") 
    #ax.plot([], [], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    #ax.plot([], [], [], color="#E4E4DD", marker="s", markeredgecolor="#6b705c", linestyle="", markersize=15, label="Base") 
    ax.legend(loc="upper left", bbox_to_anchor=(0.90, 0.95), fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end


function sixter()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=15, azim=-17) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
    ax.dist = 4.3
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
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
    labels(ax)
    affichage_etat_courant = ax.text2D(-0.45, 0.80, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)  
    #affichage_etat_courant.set_text("État : 5/5")     
    plot_base(600,350)
    #plot_seuil(ax,400,400,100,"crimson")   
    #plot_seuil(ax,400,400,150,"cyan")   
    #plot_seuil(ax,400,400,200,"lime")  
       ax.plot([], [], [], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=20,  label="HAPS")

            ax.plot([600], [600], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
            ax.plot([600,600], [600,600], [20,0], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
 plot_seuil(ax,600,600,300,"cyan") 
       ax.plot([600, 600], [600, 350], [20, 1], color="cyan", linestyle="--",  linewidth=1, zorder=19, clip_on=false)   
            
            ax.plot([600], [200], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
            ax.plot([600,600], [200,200], [20,0], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
  plot_seuil(ax,600,200,190,"lime")   
      ax.plot([600, 600], [200, 350], [20, 1], color="lime", linestyle="--",  linewidth=1, zorder=19, clip_on=false)  
      
            ax.plot([600, 600], [200, 350], [20, 1], color="lime", linestyle="--",  linewidth=1, zorder=19, clip_on=false)   
            
           # ax.plot([600, 600], [200, 600], [20 + 0.5, 20 + 0.5], color="black", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
           # ax.plot([600], [400], [20 + 0.5], color="black", zorder=19, marker=">", markersize=6)
            
           # ax.plot([600, 600], [200, 600], [20 - 0.5, 20 - 0.5], color="black", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
           #ax.plot([600], [400], [20 - 0.5], color="black", zorder=19, marker="<", markersize=6) 
    #ax.plot([], [], [], color="#f8961e", marker="s", linestyle="", label="Déploiement possible")
        ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Relais de type 1") 
    ax.plot([], [], [], color="lime", marker="", markersize=10, label="Relais de type 2") 
    #ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Relais de type 1") 
    #ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Relais de type 2") 
    #ax.plot([], [], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    ax.plot([], [], [], color="#E4E4DD", marker="s", markeredgecolor="#6b705c", linestyle="", markersize=15, label="Base") 
    ax.legend(loc="upper left", bbox_to_anchor=(0.90, 0.95), fontsize=18, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function sexter()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=15, azim=-17) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
    ax.dist = 4.3
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
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
    labels(ax)
    affichage_etat_courant = ax.text2D(-0.45, 0.80, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)  
    #affichage_etat_courant.set_text("État : 5/5")     
    plot_base(600,350)
    plot_base(600,500)
    #plot_seuil(ax,400,400,100,"crimson")   
    #plot_seuil(ax,400,400,150,"cyan")   
    #plot_seuil(ax,400,400,200,"lime")  
       ax.plot([], [], [], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=20,  label="HAPS")

            ax.plot([600], [600], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
            ax.plot([600,600], [600,600], [20,0], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
 plot_seuil(ax,600,600,180,"cyan") 
       ax.plot([600, 600], [600, 500], [20, 1], color="cyan", linestyle="--",  linewidth=1, zorder=19, clip_on=false)   
            
            ax.plot([600], [200], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
            ax.plot([600,600], [200,200], [20,0], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
  plot_seuil(ax,600,200,190,"lime")   
      ax.plot([600, 600], [200, 350], [20, 1], color="lime", linestyle="--",  linewidth=1, zorder=19, clip_on=false)  
      
            ax.plot([600, 600], [200, 350], [20, 1], color="lime", linestyle="--",  linewidth=1, zorder=19, clip_on=false)   
           
            
           ax.plot([600, 600], [350, 500], [0.5, 0.5], color="black", linestyle="dotted", zorder=15, clip_on=false, linewidth=2) 
           ax.plot([600], [440], [0.5], color="black", zorder=19, marker=">", markersize=6)
           ax.plot([600], [410], [0.5], color="black", zorder=19, marker="<", markersize=6)  
    #ax.plot([], [], [], color="#f8961e", marker="s", linestyle="", label="Déploiement possible")
           #  ax.plot([600, 600], [200, 600], [20 + 0.5, 20 + 0.5], color="black", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
          #  ax.plot([600], [400], [20 + 0.5], color="black", zorder=19, marker=">", markersize=6)
            
          #  ax.plot([600, 600], [200, 600], [20 - 0.5, 20 - 0.5], color="black", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
         #  ax.plot([600], [400], [20 - 0.5], color="black", zorder=19, marker="<", markersize=6)    
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Relais de type 1") 
    ax.plot([], [], [], color="lime", marker="", markersize=10, label="Relais de type 2") 
    #ax.plot([], [], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    ax.plot([], [], [], color="#E4E4DD", marker="s", markeredgecolor="#6b705c", linestyle="", markersize=15, label="Base") 
    ax.legend(loc="upper left", bbox_to_anchor=(0.90, 0.95), fontsize=18, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function temp()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=15, azim=-17) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
    ax.dist = 4.3
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
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
    labels(ax)
    affichage_etat_courant = ax.text2D(-0.45, 0.80, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)  
    #affichage_etat_courant.set_text("État : 5/5")     

    #plot_seuil(ax,400,400,100,"crimson")   
    #plot_seuil(ax,400,400,150,"cyan")   
    #plot_seuil(ax,400,400,200,"lime")  
       ax.plot([], [], [], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=20,  label="HAPS")

            ax.plot([600], [600], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
            ax.plot([600,600], [600,600], [20,0], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)  
            
            ax.plot([600], [200], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
            ax.plot([600,600], [200,200], [20,0], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
      
 
            ax.plot([400], [400], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
            ax.plot([400,400], [400,400], [20,0], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
            
            ax.plot([800], [800], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
            ax.plot([800,800], [800,800], [20,0], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)   
    #ax.plot([], [], [], color="#f8961e", marker="s", linestyle="", label="Déploiement possible")
           #  ax.plot([600, 600], [200, 600], [20 + 0.5, 20 + 0.5], color="black", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
          #  ax.plot([600], [400], [20 + 0.5], color="black", zorder=19, marker=">", markersize=6)
            
          #  ax.plot([600, 600], [200, 600], [20 - 0.5, 20 - 0.5], color="black", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
         #  ax.plot([600], [400], [20 - 0.5], color="black", zorder=19, marker="<", markersize=6)    
    #ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Relais de type 1") 
    #ax.plot([], [], [], color="lime", marker="", markersize=10, label="Relais de type 2") 
    #ax.plot([], [], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    ax.plot([], [], [], color="#E4E4DD", marker="s", markeredgecolor="#6b705c", linestyle="", markersize=15, label="Base") 
    ax.legend(loc="upper left", bbox_to_anchor=(0.90, 0.95), fontsize=18, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function tempbis()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=15, azim=-17) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
    ax.dist = 4.3
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
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
    labels(ax)
    affichage_etat_courant = ax.text2D(-0.45, 0.80, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)  
    #affichage_etat_courant.set_text("État : 5/5")     

    #plot_seuil(ax,400,400,100,"crimson")   
    #plot_seuil(ax,400,400,150,"cyan")   
    #plot_seuil(ax,400,400,200,"lime")  
       ax.plot([], [], [], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=20,  label="HAPS")

            ax.plot([600], [600], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
            ax.plot([600,600], [600,600], [20,0], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)  
     plot_seuil(ax,600,600,80,"cyan")   
               plot_seuil(ax,600,600,280,"crimson")   
                                   plot_seuil(ax,600,600,300,"lime")             
            ax.plot([600], [400], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
            ax.plot([600,600], [400,400], [20,0], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
     plot_seuil(ax,600,400,250,"cyan")
          plot_seuil(ax,600,400,50,"crimson")  
                    plot_seuil(ax,600,400,70,"lime")          
     
           ax.plot([600, 600], [400, 600], [20.5, 20.5], color="cyan", linestyle="dotted", zorder=15, clip_on=false, linewidth=2) 
           ax.plot([600], [500], [20.5], color="cyan", zorder=19, marker=">", markersize=6)
            ax.plot([600, 600], [400, 500], [19.5, 19.5], color="crimson", linestyle="dotted", zorder=15, clip_on=false, linewidth=2) 
           ax.plot([600], [450], [19.5], color="crimson", zorder=19, marker="<", markersize=6)
                      ax.plot([600, 600], [500, 600], [19.5, 19.5], color="lime", linestyle="dotted", zorder=15, clip_on=false, linewidth=2) 
           ax.plot([600], [550], [19.5], color="lime", zorder=19, marker="<", markersize=6)
    #ax.plot([], [], [], color="#f8961e", marker="s", linestyle="", label="Déploiement possible")
           #  ax.plot([600, 600], [200, 600], [20 + 0.5, 20 + 0.5], color="black", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
          #  ax.plot([600], [400], [20 + 0.5], color="black", zorder=19, marker=">", markersize=6)
            
          #  ax.plot([600, 600], [200, 600], [20 - 0.5, 20 - 0.5], color="black", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
         #  ax.plot([600], [400], [20 - 0.5], color="black", zorder=19, marker="<", markersize=6)    
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Relais de type 1") 
    ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Relais de type 2") 
        ax.plot([], [], [], color="lime", marker="", markersize=10, label="Relais de type 3") 
    #ax.plot([], [], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    ax.plot([], [], [], color="#E4E4DD", marker="s", markeredgecolor="#6b705c", linestyle="", markersize=15, label="Base") 
    ax.legend(loc="upper left", bbox_to_anchor=(0.90, 0.95), fontsize=18, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function tempter()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=15, azim=-17) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
    ax.dist = 4.3
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
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
    labels(ax)
    affichage_etat_courant = ax.text2D(-0.45, 0.80, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)  
    #affichage_etat_courant.set_text("État : 5/5")     
    for x in 0:150:1000
        for y in 0:150:1000
            ax.plot([x], [y], [0], color="#f8961e", marker="s", linestyle="", markersize=2.5, alpha=0.6, zorder=14, clip_on=false)
        end
    end
                ax.plot([450], [300], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
            ax.plot([450,450], [300,300], [20,0], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)  
    plot_seuil(ax,450,300,193,"cyan")      
    ax.plot([], [], [], color="#f8961e", marker="s", linestyle="", label="Déploiement possible")
      
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Relais de type 1") 
    ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Relais de type 2") 
        ax.plot([], [], [], color="lime", marker="", markersize=10, label="Relais de type 3") 
    #ax.plot([], [], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    ax.plot([], [], [], color="#E4E4DD", marker="s", markeredgecolor="#6b705c", linestyle="", markersize=15, label="Base") 
    ax.legend(loc="upper left", bbox_to_anchor=(0.90, 0.95), fontsize=18, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function visufinal()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=12, azim=-70) 
    #ax.view_init(elev=23, azim=-17)     
    #ax.view_init(elev=21, azim=-107) 
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
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
    affichage_etat_courant = ax.text2D(-0.45, 0.80, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)  
    dist = 20
    cpt = 1
    readline()
    for i in 1:1:15
        ax.dist = dist - i
        sleep(0.1)
        savefig("images/image_"*string(cpt))
        cpt += 1
    end
    for j in 1:2:59
        savefig("images/image_"*string(cpt))
        ax.azim = -70+j
        sleep(0.1)  
        cpt += 1    
    end
        labels(ax)
        savefig("images/image_"*string(cpt))
        cpt += 1
   for i in 0:0.1:0.7
       ax.dist = 5 - i
       savefig("images/image_"*string(cpt))
               cpt += 1
   end
end

visufinal()

