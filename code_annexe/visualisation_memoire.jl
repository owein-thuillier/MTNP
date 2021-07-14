using PyPlot
using Random

function plot_base(x, y)
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

function generation_sol_1(ax)
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




    # Démarcations (arrêtes)
    #plot([0, 0], [0, 0], [0, -500], color="#081c15", linewidth=1, zorder=10)
    #plot([1000, 1000], [0, 0], [0, -500], color="#081c15", linewidth=1, zorder=10)
    #plot([1000, 1000], [1000, 1000], [0, -500], color="#081c15", linewidth=1, zorder=10)

    # Affichage dimensions
    #ax.plot([0,1000], [-50,-50], [0,0], color="white", marker="", markersize=5, zorder=10)
    #ax.plot([1050,1050], [0,1000], [0,0], color="white", marker="", markersize=5, zorder=10)
end

function generation_sol_2(ax)
    # Grille
    pas = 50
    i = 0
    #while i < 1010
    #    ax.plot([i, i], [-10, 1010], [0], color="white", linewidth=0.1, zorder=15, clip_on=false) # Longueur
    #    ax.plot([-10, 1010], [i, i], [0], color="white", linewidth=0.1, zorder=15, clip_on=false) # Largeur
    #    i += pas
    #end    
    while i < 1000
        ax.plot([i, i], [0, 1000], [0], color="white", linewidth=0.1, zorder=15, clip_on=false) # Longueur
        ax.plot([0, 1000], [i, i], [0], color="white", linewidth=0.1, zorder=15, clip_on=false) # Largeur
        i += pas
    end
    
end

function generation_sol_3(ax)
    # Plan tombant 1
    x = [-10 1010; -10 1010]
    y = [-10 -10; -10 -10]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)  
end

function generation_sol_4(ax)
    # Plan tombant 2
    x = [1010 1010; 1010 1010]
    y = [-10 1010; -10 1010]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)   
end

function generation_sol_5(ax)
    # Plan tombant 3
    x = [-10 1010; -10 1010]
    y = [1010 1010; 1010 1010]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false) 
end

function generation_sol_6(ax)
    # Plan tombant 4
    x = [-10 -10; -10 -10]
    y = [-10 1010; -10 1010]
    z = [0 0; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false) 
end

function generation_sol_7(ax) 
    # Fermeture
    x = [-10 -10; 1010 1010]
    y = [-10 1010; -10 1010]
    z = [-15 -15; -15 -15]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false) 
end

function generation_ciel_1(ax)
    # Troposphère (15 km)
    x = [-10 -10; -10 -10]
    y = [-10 1010; -10 1010]
    z = [0 0; 15 15]
    plot_surface(x,y,z, color="#48cae4", alpha=0.9, shade=false, zorder=-10, clip_on=false)
end

function generation_ciel_2(ax)
    # Troposphère (15 km)
    x = [-10 1010; -10 1010]
    y = [1010 1010; 1010 1010]
    z = [0 0; 15 15]
    plot_surface(x,y,z, color="#48cae4", alpha=0.9, shade=false, zorder=-10, clip_on=false)
end

function generation_ciel_3(ax)
    # Stratosphère (15-50 km)
    x = [-10 -10; -10 -10]
    y = [-10 1010; -10 1010]
    z = [15 15; 50 50]
    plot_surface(x,y,z, color="#00b4d8", alpha=0.9, shade=false, zorder=-10, clip_on=false)
end


function generation_ciel_4(ax)
    # Stratosphère (15-50 km)
    x = [-10 1010; -10 1010]
    y = [1010 1010; 1010 1010]
    z = [15 15; 50 50]
    plot_surface(x,y,z, color="#00b4d8", alpha=0.9, shade=false, zorder=-10, clip_on=false)

end

function generation_ciel_5(ax)
    # Mésosphère (50-85 km)
    x = [-10 -10; -10 -10]
    y = [-10 1010; -10 1010]
    z = [50 50; 85 85]
    plot_surface(x,y,z, color="#0096c7", alpha=0.9, shade=false, zorder=-10, clip_on=false)
end

function generation_ciel_6(ax)
    # Mésosphère (50-85 km)
    x = [-10 1010; -10 1010]
    y = [1010 1010; 1010 1010]
    z = [50 50; 85 85]
    plot_surface(x,y,z, color="#0096c7", alpha=0.9, shade=false, zorder=-10, clip_on=false)

end

function generation_ciel_7(ax)
    # Thermosphère (85-500 km)
    x = [-10 -10; -10 -10]
    y = [-10 1010; -10 1010]
    z = [85 85; 500 500]
    plot_surface(x,y,z, color="#0077b6", alpha=0.9, shade=false, zorder=100, clip_on=false) 
end

function generation_ciel_8(ax)
    # Thermosphère (85-500 km)
    x = [-10 1010; -10 1010]
    y = [1010 1010; 1010 1010]
    z = [85 85; 500 500]
    plot_surface(x,y,z, color="#0077b6", alpha=0.9, shade=false, zorder=-10, clip_on=false)
end

function generation_ciel_9(ax)
    ax.plot([-10,-10], [-10,1010], [20,20], color="white", marker="", markersize=5, linestyle="--", linewidth=1, alpha=0.7, zorder=15, clip_on=false)
end

function generation_ciel_10(ax)
    ax.plot([-10,1010], [1010,1010], [20,20], color="white", marker="", markersize=5, linestyle="--", linewidth=1, alpha=0.7, zorder=15, clip_on=false)
end


function generation_ciel_11(ax)
    ax.plot([-10,-10], [-10,1010], [100,100], color="red", marker="", markersize=5, linestyle="--", linewidth=1, alpha=0.7, zorder=18, clip_on=false)
end

function generation_ciel_12(ax)
    ax.plot([-10,1010], [1010,1010], [100,100], color="red", marker="", markersize=5, linestyle="--", linewidth=1, alpha=0.7, zorder=18, clip_on=false)
end


function label_1(ax)
    text3D(x=0, y=-150, z=15, s="15 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=6, zorder=15, clip_on=false)
    text3D(x=0, y=10, z=7.5, s="Troposphère", zdir="y", color="black", zorder=15, clip_on=false, fontsize=10)
end

function label_2(ax)
    text3D(x=0, y=10, z=35, s="Stratosphère", zdir="y", color="black", zorder=15, clip_on=false, fontsize=10)
    text3D(x=0, y=-150, z=50, s="50 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=6, zorder=15, clip_on=false)
end

function label_3(ax)
    text3D(x=0, y=10, z=67.5, s="Mésosphère", zdir="y", color="black", zorder=15, clip_on=false, fontsize=10)
    text3D(x=0, y=-150, z=85, s="85 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=6, zorder=15, clip_on=false)
end

function label_4(ax)
    text3D(x=0, y=10, z=115, s="Thermosphère", zdir="y", color="black", zorder=15, clip_on=false, fontsize=10)
end

function label_5(ax)
    text3D(x=0, y=200, z=22, s="Altitude de déploiement des HAPS", zdir="y", color="black", fontsize=7, zorder=15, clip_on=false)
    text3D(x=0, y=-150, z=20, s="20 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=6, zorder=15, clip_on=false)
end

function label_6(ax)
    text3D(x=0, y=375, z=102, s="Ligne de Kármán", zdir="y", color="black", fontsize=7, zorder=15, clip_on=false)
    text3D(x=0, y=-150, z=100, s="100 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=6, zorder=15, clip_on=false)
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
    x = rand([-1000:-1000;], 800)
    y = rand([-2000:2000;], 800)
    z = rand([-200:400;], 800)
    for g in 0:15
        ax.plot(x[1+50*g:50*(g+1)], y[1+50*g:50*(g+1)], z[1+50*g:50*(g+1)], color="white", marker=".", linestyle="", alpha=rand([0.4:0.1:1;]), markersize=alpha=rand([0.5:0.1:1;]), zorder=0, clip_on=false)       
    end

    # Fond 2
    x = rand([-1000:2000;], 800)
    y = rand([2000:2000;], 800)
    z = rand([-200:400;], 800)
    for g in 0:15
        ax.plot(x[1+50*g:50*(g+1)], y[1+50*g:50*(g+1)], z[1+50*g:50*(g+1)], color="white", marker=".", linestyle="", alpha=rand([0.4:0.1:1;]), markersize=alpha=rand([0.5:0.1:1;]), zorder=0, clip_on=false)       
    end

    # Soleil
    #ax.plot([-800], [-100], [70], color="#a10702", marker="o", markersize=105, linestyle="", alpha=0.5, zorder=-1)
    #ax.plot([-800], [-100], [70], color="#ff6600", marker="o", markersize=100, linestyle="", alpha=1, zorder=0)
end

function outil_visualisation_1()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d") 
    ax.view_init(elev=13, azim=-17)
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    tight_layout(pad=0)
end

function outil_visualisation_2()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d") 
    ax.margins(0)
    ax.view_init(elev=13, azim=-17)
    ax.dist = 10
    fig.set_facecolor("#14213d")
    ax.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    ax.set_zticks([0, 15, 20, 50, 85, 500])
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    #tight_layout(pad=0)
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
end


function etape_1_1()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d") 
end


function etape_1_2()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
end

function etape_1_3()
    # echelle
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
end

function etape_1_4()
    # labels en moins
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    ax.set_zticklabels([])
end

function etape_1_5()
    # fond
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.margins(0)    
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    ax.set_zticklabels([])
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
end

function etape_1_6()
    # marges horizontales et verticales
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.margins(0)
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    ax.set_zticklabels([])
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
end

function etape_1_7()
    # suppression grille
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    ax.set_zticklabels([])    
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    #axis("off")
    ax.grid(false)
end

function etape_1_8()
    # suppression axes
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    ax.set_zticklabels([])    
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
end


function etape_1_9()
    # étoiles
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)
end

function etape_1_10()
    # comete
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)
    
        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
     t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
end

function etape_1_11()
    # surface
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)
    
        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
end

function etape_1_12()
    # grille
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)
    
        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
end

function etape_1_13()
    ion()
    fig = figure("Outil de création de scénarios")
    ax = fig.add_subplot(111)
    grid(false)
    xlim(0, 1000)
    ylim(0, 1000)
    axis("off")
    ax.grid(false) 
    plt.axis("equal")  
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
end

function etape_1_14()
    ion()
    fig = figure("Outil de création de scénarios")
    ax = fig.add_subplot(111)
    grid(false)
    xlim(-10, 1010)
    ylim(-10, 1010)
    axis("off")
    ax.grid(false) 
    plt.axis("equal")    
    # Création du sol
    sol = matplotlib.patches.Rectangle((-10, -10), 1020, 1020, linewidth=1, edgecolor="black", facecolor="#40916c")
    ax.add_patch(sol)
    # Grille
    pas = 50
    i = 0
    while i < 1010
        ax.plot([i, i], [-10, 1010], color="white", linewidth=0.2) # Longueur
        ax.plot([-10, 1010], [i, i], color="white", linewidth=0.2) # Largeur
        i += pas
    end 
end

function etape_1_15()
    # plan tombant 1
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)
    
        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
end


function etape_1_16()
    # plan tombant 2
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)
    
        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
end

function etape_1_17()
    # plan tombant 3
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=4, azim=154) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)
    

    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
end

function etape_1_18()
    # plan tombant 4
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=4, azim=154) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)
    

    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
end

function etape_1_19()
    # fermeture
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=-25, azim=-16) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
end

function etape_1_20()
    # tropo 1
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
end

function etape_1_21()
    # tropo 2
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
end

function etape_1_22()
    # strato 1
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
end

function etape_1_23()
    # strato 2
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)        
end

function etape_1_24()
    # meso 1
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
end

function etape_1_25()
    # meso 2
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=13, azim=-17) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
    generation_ciel_6(ax)        
end


function etape_1_26()
    # thermo 1
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=16, azim=-37) 
    ax.dist = 17
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
    generation_ciel_6(ax)         
    generation_ciel_7(ax)      
end

function etape_1_27()
    # thermo 2
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=16, azim=-37) 
    ax.dist = 17
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
    generation_ciel_6(ax)         
    generation_ciel_7(ax)  
    generation_ciel_8(ax)              
end


function etape_1_28()
    # ligne 20 km
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=16, azim=-37) 
    ax.dist = 17
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
    generation_ciel_6(ax)         
    generation_ciel_7(ax)  
    generation_ciel_8(ax) 
    generation_ciel_9(ax)                           
end


function etape_1_29()
    # ligne 20 km bis
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=16, azim=-37) 
    ax.dist = 17
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
    generation_ciel_6(ax)         
    generation_ciel_7(ax)  
    generation_ciel_8(ax) 
    generation_ciel_9(ax)              
    generation_ciel_10(ax)                           
end

function etape_1_30()
    # ligne 20 km bis
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=16, azim=-37) 
    ax.dist = 17
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
    generation_ciel_6(ax)         
    generation_ciel_7(ax)  
    generation_ciel_8(ax) 
    generation_ciel_9(ax)              
    generation_ciel_10(ax)   
    generation_ciel_11(ax)                                                   
end

function etape_1_31()
    # ligne 20 km bis
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=16, azim=-37) 
    ax.dist = 17
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
    generation_ciel_6(ax)         
    generation_ciel_7(ax)  
    generation_ciel_8(ax) 
    generation_ciel_9(ax)              
    generation_ciel_10(ax) 
    generation_ciel_11(ax)                           
    generation_ciel_12(ax)                                                     
end

function etape_1_32()
    # label tropo
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=7, azim=-10) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
    generation_ciel_6(ax)         
    generation_ciel_7(ax)  
    generation_ciel_8(ax) 
    generation_ciel_9(ax)              
    generation_ciel_10(ax) 
    generation_ciel_11(ax)                           
    generation_ciel_12(ax)    
    
    label_1(ax)                                                 
end

function etape_1_33()
    # label strato
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=7, azim=-10) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
    generation_ciel_6(ax)         
    generation_ciel_7(ax)  
    generation_ciel_8(ax) 
    generation_ciel_9(ax)              
    generation_ciel_10(ax) 
    generation_ciel_11(ax)                           
    generation_ciel_12(ax)    
    
    label_1(ax)     
    label_2(ax)                                                                                             
end

function etape_1_34()
    # label méso
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=7, azim=-10) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(60, 110)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

    # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
    generation_ciel_6(ax)         
    generation_ciel_7(ax)  
    generation_ciel_8(ax) 
    generation_ciel_9(ax)              
    generation_ciel_10(ax) 
    generation_ciel_11(ax)                           
    generation_ciel_12(ax)    
    
    label_1(ax)     
    label_2(ax)  
    label_3(ax)                                                                                              
end

function etape_1_35()
    # label thermo
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=7, azim=-10) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(60, 110)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
    generation_ciel_6(ax)         
    generation_ciel_7(ax)  
    generation_ciel_8(ax) 
    generation_ciel_9(ax)              
    generation_ciel_10(ax) 
    generation_ciel_11(ax)                           
    generation_ciel_12(ax)    
    
    label_1(ax)     
    label_2(ax)  
    label_3(ax) 
    label_4(ax)                                                                                                                                                                                           
end

function etape_1_36()
    # label ligne 20
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=7, azim=-10) 
    ax.dist = 10
    #ax.view_init(elev=13, azim=-17) 
    #ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
    generation_ciel_6(ax)         
    generation_ciel_7(ax)  
    generation_ciel_8(ax) 
    generation_ciel_9(ax)              
    generation_ciel_10(ax) 
    generation_ciel_11(ax)                           
    generation_ciel_12(ax)    
    
    label_1(ax)     
    label_2(ax)  
    label_3(ax) 
    label_4(ax)
    label_5(ax)
end

function etape_1_37()
    # label ligne 100
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    ax.view_init(elev=7, azim=-10) 
    ax.dist = 10
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(60, 110)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    generation_etoiles(ax)

        # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
    generation_ciel_6(ax)         
    generation_ciel_7(ax)  
    generation_ciel_8(ax) 
    generation_ciel_9(ax)              
    generation_ciel_10(ax) 
    generation_ciel_11(ax)                           
    generation_ciel_12(ax)    
    
    label_1(ax)     
    label_2(ax)  
    label_3(ax) 
    label_4(ax)
    label_5(ax)
    label_6(ax)
end


#####

function etape_2()
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
    generation_etoiles(ax)

    # Comète (trajectoire)
    nT = 100
    XC = [i for i in range(-200, -200, length=nT)]
    YC = [i for i in range(-200, 1200, length=nT)]
    ZC = [i for i in range(40, 10, length=nT)]
    trace_comete = trunc(Int, 0.025*nT)
    t = 50
    ax.plot([XC[t]], [YC[t]], [ZC[t]], color="#caf0f8", alpha=1, marker="o", markersize=5, zorder=0, clip_on=false)
    t <= trace_comete ? ax.plot(XC[1:t], YC[1:t], ZC[1:t], color="#caf0f8", alpha=0.4, marker="", linewidth=1.5, zorder=-10, clip_on=false) : ax.plot(XC[t-trace_comete:t], YC[t-trace_comete:t], ZC[t-trace_comete:t], color="#caf0f8", alpha=0.4, marker="", linewidth=2, zorder=-10, clip_on=false)
    generation_sol_1(ax)
    generation_sol_2(ax)
    generation_sol_3(ax)
    generation_sol_4(ax)
    generation_sol_5(ax)
    generation_sol_6(ax)
    generation_sol_7(ax)
    
    generation_ciel_1(ax)
    generation_ciel_2(ax)
    generation_ciel_3(ax)
    generation_ciel_4(ax)  
    generation_ciel_5(ax)
    generation_ciel_6(ax)         
    generation_ciel_7(ax)  
    generation_ciel_8(ax) 
    generation_ciel_9(ax)              
    generation_ciel_10(ax) 
    generation_ciel_11(ax)                           
    generation_ciel_12(ax)    
    
    ##label_1(ax)     
    ##label_2(ax)  
    label_3(ax) 
    label_4(ax)
    ##label_5(ax)
    text3D(x=0, y=10, z=7.5, s="Troposphère", zdir="y", color="black", zorder=13, clip_on=false, fontsize=14)
    text3D(x=0, y=10, z=35, s="Stratosphère", zdir="y", color="black", zorder=13, clip_on=false, fontsize=14)
    text3D(x=0, y=-100, z=15, s="15 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=10, zorder=15, clip_on=false)
    text3D(x=0, y=300, z=22, s="Altitude de déploiement des HAPS", zdir="y", color="black", fontsize=10, zorder=15, clip_on=false)
    text3D(x=0, y=-100, z=20, s="20 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=10, zorder=15, clip_on=false)
    text3D(x=0, y=-100, z=50, s="50 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=10, zorder=15, clip_on=false)
    #label_6(ax)
    return ax
end

function etape_2_1() 
    # Unités et trace
    ax = etape_2()
    trace = []
    ax.plot([500], [300], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [500, 290], [500, 280], [490, 270], [480, 270], [470, 260], [460, 250]])
    ax.plot([trace[1][i][1] for i in 1:6], [trace[1][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)    
    ax.plot([500], [600], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [490, 600], [480, 600], [470, 590], [460, 580], [450, 570], [450, 560]])
    ax.plot([trace[2][i][1] for i in 1:6], [trace[2][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    ax.plot([200], [500], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [210, 510], [220, 520], [230, 520], [240, 520], [250, 520], [260, 520]])
    ax.plot([trace[3][i][1] for i in 1:6], [trace[3][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
end


function etape_2_2()
    # Bases
    ax = etape_2()
    trace = []
    ax.plot([500], [300], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [500, 290], [500, 280], [490, 270], [480, 270], [470, 260], [460, 250]])
    ax.plot([trace[1][i][1] for i in 1:6], [trace[1][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)    
    ax.plot([500], [600], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [490, 600], [480, 600], [470, 590], [460, 580], [450, 570], [450, 560]])
    ax.plot([trace[2][i][1] for i in 1:6], [trace[2][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    ax.plot([200], [500], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [210, 510], [220, 520], [230, 520], [240, 520], [250, 520], [260, 520]])
    ax.plot([trace[3][i][1] for i in 1:6], [trace[3][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    
    plot_base(250, 650)   
    plot_base(700, 350)   
end

function etape_2_3()
    # Positions
    ax = etape_2()
    trace = []
    ax.plot([500], [300], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [500, 290], [500, 280], [490, 270], [480, 270], [470, 260], [460, 250]])
    ax.plot([trace[1][i][1] for i in 1:6], [trace[1][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)    
    ax.plot([500], [600], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [490, 600], [480, 600], [470, 590], [460, 580], [450, 570], [450, 560]])
    ax.plot([trace[2][i][1] for i in 1:6], [trace[2][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    ax.plot([200], [500], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [210, 510], [220, 520], [230, 520], [240, 520], [250, 520], [260, 520]])
    ax.plot([trace[3][i][1] for i in 1:6], [trace[3][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    
    plot_base(250, 650)   
    plot_base(700, 350) 
    
    pos_ok = []
    for x in 100:100:900
        for y in 100:100:900 
            push!(pos_ok, (x,y))
            ax.plot([x], [y], [0], color="#f8961e", marker="s", linestyle="", markersize=2.5, alpha=0.6, zorder=14, clip_on=false)         
        end
    end
    for x in 0:100:1000
        for y in 0:100:1000
            if !((x,y) in pos_ok)
                ax.plot([x], [y], [0], color="#e5383b", marker="s", linestyle="", markersize=2.5, alpha=0.6, zorder=14, clip_on=false)   
            end      
        end
    end

end

function etape_2_4()
    # HAPS
    ax = etape_2()
    trace = []
    ax.plot([500], [300], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [500, 290], [500, 280], [490, 270], [480, 270], [470, 260], [460, 250]])
    ax.plot([trace[1][i][1] for i in 1:6], [trace[1][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)    
    ax.plot([500], [600], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [490, 600], [480, 600], [470, 590], [460, 580], [450, 570], [450, 560]])
    ax.plot([trace[2][i][1] for i in 1:6], [trace[2][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    ax.plot([200], [500], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [210, 510], [220, 520], [230, 520], [240, 520], [250, 520], [260, 520]])
    ax.plot([trace[3][i][1] for i in 1:6], [trace[3][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    
    plot_base(250, 650)   
    plot_base(700, 350) 
    
    pos_ok = []
    for x in 100:100:900
        for y in 100:100:900 
            push!(pos_ok, (x,y))
            ax.plot([x], [y], [0], color="#f8961e", marker="s", linestyle="", markersize=2.5, alpha=0.6, zorder=14, clip_on=false)         
        end
    end
    for x in 0:100:1000
        for y in 0:100:1000
            if !((x,y) in pos_ok)
                ax.plot([x], [y], [0], color="#e5383b", marker="s", linestyle="", markersize=2.5, alpha=0.6, zorder=14, clip_on=false)   
            end      
        end
    end


    ax.plot([600], [400], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([600, 600], [400, 400], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    
    ax.plot([700], [500], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([700, 700], [500, 500], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    
    ax.plot([600], [600], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([600, 600], [600, 600], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)    
    
    ax.plot([400], [300], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([400, 400], [300, 300], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    
    
    ax.plot([400], [400], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([400, 400], [400, 400], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    
    ax.plot([400], [500], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([400, 400], [500, 500], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    
    
    ax.plot([400], [600], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([400, 400], [600, 600], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1) 
    
    ax.plot([200], [600], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([200, 200], [600, 600], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)      
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

function etape_2_5()
    # Seuils
    ax = etape_2()
    trace = []
    ax.plot([500], [300], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [500, 290], [500, 280], [490, 270], [480, 270], [470, 260], [460, 250]])
    ax.plot([trace[1][i][1] for i in 1:6], [trace[1][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)    
    ax.plot([500], [600], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [490, 600], [480, 600], [470, 590], [460, 580], [450, 570], [450, 560]])
    ax.plot([trace[2][i][1] for i in 1:6], [trace[2][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    ax.plot([200], [500], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    push!(trace, [ [210, 510], [220, 520], [230, 520], [240, 520], [250, 520], [260, 520]])
    ax.plot([trace[3][i][1] for i in 1:6], [trace[3][i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    
    plot_base(250, 650)   
    plot_base(700, 350) 
    
    pos_ok = []
    for x in 100:100:900
        for y in 100:100:900 
            push!(pos_ok, (x,y))
            ax.plot([x], [y], [0], color="#f8961e", marker="s", linestyle="", markersize=2.5, alpha=0.6, zorder=14, clip_on=false)         
        end
    end
    for x in 0:100:1000
        for y in 0:100:1000
            if !((x,y) in pos_ok)
                ax.plot([x], [y], [0], color="#e5383b", marker="s", linestyle="", markersize=2.5, alpha=0.6, zorder=14, clip_on=false)   
            end      
        end
    end


    ax.plot([600], [400], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([600, 600], [400, 400], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    
    ax.plot([700], [500], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([700, 700], [500, 500], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    
    ax.plot([600], [600], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([600, 600], [600, 600], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)    
    
    ax.plot([400], [300], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([400, 400], [300, 300], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    
    
    ax.plot([500], [400], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([500, 500], [400, 400], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    
    ax.plot([400], [500], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([400, 400], [500, 500], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    
    
    ax.plot([400], [600], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([400, 400], [600, 600], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1) 
    
    ax.plot([200], [600], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([200, 200], [600, 600], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)  
    
    
    # Seuils
    plot_seuil(ax,600,400,150,"cyan")  
    plot_seuil(ax,500,400,50,"cyan") 
    plot_seuil(ax,400,300,150,"cyan")     
     
    plot_seuil(ax,700,500,175,"lime") 
    plot_seuil(ax,600,400,130,"lime")    
    
    plot_seuil(ax,500,400,175,"navy") 
    plot_seuil(ax,400,300,120,"navy")    
    plot_seuil(ax,400,500,50,"navy")  
 
    plot_seuil(ax,400,500,160,"yellow")    
    plot_seuil(ax,400,600,40,"yellow")       
    
    plot_seuil(ax,400,600,250,"crimson")
    plot_seuil(ax,200,600,250,"crimson")                                                                        
    plot_seuil(ax,600,600,40,"crimson")  
    
    plot_seuil(ax,600,600,150,"pink")  
    plot_seuil(ax,700,500,50,"pink")  
        
   
    # Arcs
    ax.plot([700, 600], [500, 400], [20, 20], color="lime", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
    ax.plot([(700+600)/2], [(500+400)/2], [20], color="lime", zorder=19, marker="<", markersize=6) 
    
    ax.plot([600, 500], [400, 400], [20, 20], color="cyan", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
    ax.plot([(600+500)/2], [(400+400)/2], [20], color="cyan", zorder=19, marker=">", markersize=6)
    
    ax.plot([500, 400], [400, 300], [20 + 0.5, 20 + 0.5], color="cyan", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
    ax.plot([(500+400)/2], [(400+300)/2], [20 + 0.5], color="cyan", zorder=19, marker=">", markersize=6) 
    ax.plot([500, 400], [400, 300], [20 - 0.5, 20 - 0.5], color="navy", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
    ax.plot([(500+400)/2], [(400+300)/2], [20 - 0.5], color="navy", zorder=19, marker="<", markersize=6)    
    ax.plot([500, 400], [400, 500], [20, 20], color="navy", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
    ax.plot([(500+400)/2], [(400+500)/2], [20], color="navy", zorder=19, marker="<", markersize=6) 
    
    ax.plot([400, 400], [500, 600], [20, 20], color="yellow", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
    ax.plot([(400+400)/2], [(500+600)/2], [20], color="yellow", zorder=19, marker=">", markersize=6)
    
    ax.plot([400, 200], [600, 600], [20 - 0.5, 20 - 0.5], color="crimson", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
    ax.plot([(400+200)/2], [(600+600)/2], [20 - 0.5], color="crimson", zorder=19, marker=">", markersize=6)
    ax.plot([400, 200], [600, 600], [20 + 0.5, 20 + 0.5], color="crimson", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
    ax.plot([(400+200)/2], [(600+600)/2], [20 + 0.5], color="crimson", zorder=19, marker="<", markersize=6)
    ax.plot([400, 600], [600, 600], [20, 20], color="crimson", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
    ax.plot([(400+600)/2], [(600+600)/2], [20], color="crimson", zorder=19, marker="<", markersize=6)   
    
    ax.plot([600, 700], [600, 500], [20, 20], color="pink", linestyle="dotted", zorder=18, clip_on=false, linewidth=2) 
    ax.plot([(600+700)/2], [(600+500)/2], [20], color="pink", zorder=19, marker=">", markersize=6)   
    
    # Liens bases
    ax.plot([700, 700], [350, 500], [0, 20], color="lime", linestyle="--",  linewidth=1, zorder=14, clip_on=false)   
    ax.plot([250, 400], [650, 600], [0, 20], color="crimson", linestyle="--",  linewidth=1, zorder=14, clip_on=false)   
    ax.plot([250, 200], [650, 600], [0, 20], color="crimson", linestyle="--",  linewidth=1, zorder=14, clip_on=false) 
    vect = [600 - 700, 400 - 350, 20 - 1]    
    point_1 = [700, 350, 1]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="cyan", linestyle="--",  linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="lime", linestyle="--",  linewidth=1, zorder=18, clip_on=false) 
    
    # Lien unités 
    vect = [400 - 500, 300 - 300, 20 - 1]    
    point_1 = [500, 300, 1]
    point_2 = point_1 .+ (1/2) .* vect 
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="cyan", linestyle="--",  linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="navy", linestyle="--",  linewidth=1, zorder=18, clip_on=false)      
    ax.plot([500, 500], [300, 400], [0, 20], color="cyan", linestyle="--",  linewidth=1, zorder=14, clip_on=false)  
    ax.plot([200, 200], [500, 600], [0, 20], color="crimson", linestyle="--",  linewidth=1, zorder=14, clip_on=false)     
    ax.plot([200, 400], [500, 600], [0, 20], color="crimson", linestyle="--",  linewidth=1, zorder=14, clip_on=false)  
    ax.plot([500, 600], [600, 600], [0, 20], color="pink", linestyle="--",  linewidth=1, zorder=14, clip_on=false)        
    ax.plot([500, 400], [600, 500], [0, 20], color="yellow", linestyle="--",  linewidth=1, zorder=14, clip_on=false)   
    
    # Infos
    suptitle("Visualisation de la solution",  y=0.95, bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=15)
    ax.text2D(-0.45, 0.82, "Nombre total d'unités couvertes : 30/30 (100.0 %)", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)
    affichage_nb_unites_non_couvertes = ax.text2D(-0.45, 0.66, "", transform=ax.transAxes, fontsize=12, bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8),  zorder=1000)  
    affichage_nb_images_seconde = ax.text2D(-0.45, 0.90, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)
    affichage_etat_courant = ax.text2D(-0.45, 0.74, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)  
    affichage_nb_images_seconde.set_text("Nombre d'images par seconde = 10")
    affichage_etat_courant.set_text("État : 1/10")     
    affichage_nb_unites_non_couvertes.set_text("Nombre d'unités couvertes = 3/3 (100.0 %)")
    
    # Légende
    ax.plot([], [], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Relais de type 1") 
    ax.plot([], [], [], color="lime", marker="", markersize=10, label="Relais de type 2") 
    ax.plot([], [], [], color="navy", marker="", markersize=10, label="Relais de type 3") 
    ax.plot([], [], [], color="yellow", marker="", markersize=10, label="Relais de type 4") 
    ax.plot([], [], [], color="pink", marker="", markersize=10, label="Relais de type 5") 
    ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Relais de type 6") 
    ax.plot([], [], [], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=20,  label="HAPS")
    ax.plot([], [], [], color="#f8961e", marker="s", linestyle="", markersize=10, label="Déploiement possible")
    ax.plot([], [], [], color="#e5383b", marker="s", linestyle="", markersize=10, label="Déploiement impossible")
    ax.plot([], [], [], color="#E4E4DD", marker="s", markeredgecolor="#6b705c", linestyle="", markersize=15, label="Base") 
    ax.legend(loc="upper left", bbox_to_anchor=(0.90, 0.95), fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
    
    # Cerise gâteau
    ax.text2D(0.43, 0.15, "- HAPS 2 \n   Masse : 100 \n   Puissance : 150 \n\n- Relais 3 \n   Type : 1 \n   Masse : 40 \n   Puissance : 90 \n   Portée : 150\n\n- Relais 5 \n   Type : 2 \n   Masse : 50 \n   Puissance : 60 \n   Portée : 130", transform=ax.transAxes, fontsize=10,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)
end



etape_2_5()
