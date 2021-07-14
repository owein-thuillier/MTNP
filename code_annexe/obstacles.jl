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
    z = [0 0; -4 -4]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)  

    # Plan tombant 2
    x = [1000 1000; 1000 1000]
    y = [0 1000; 0 1000]
    z = [0 0; -4 -4]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)   

    # Plan tombant 3
    x = [0 1000; 0 1000]
    y = [1000 1000; 1000 1000]
    z = [0 0; -4 -4]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false) 

    # Plan tombant 4
    x = [0 0; 0 0]
    y = [0 1000; 0 1000]
    z = [0 0; -4 -4]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false) 

    # Fermeture
    x = [0 0; 1000 1000]
    y = [0 1000; 0 1000]
    z = [-4 -4; -4 -4]
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


function main()
    ion()
    using3D()
    fig = figure("Outil de visualisation")
    ax = fig.add_subplot(111, projection="3d")
    ax.margins(0)
    ax.view_init(elev=17, azim=-16)
    ax.dist = 4
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(-10, 10)
    fig.set_facecolor("#14213d")
    ax.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    pas = 50
    X = ones(length(0:pas:1000))' .* [0:pas:1000;]
    Y = [0:pas:1000;]' .* ones(length(0:pas:1000))
    Z = rand(length(0:pas:1000),length(0:pas:1000))*0
    plot_surface(X, Y, Z, color="#40916c", edgecolor="white", linewidth=0.2, alpha=1, shade=false, zorder=-5, clip_on=false)   
    
    generation_sol(ax)  
    generation_etoiles(ax)
    
    ax.plot([500], [500], [8], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=20, zorder=25, clip_on=false, label=L"Un HAPS $h \in \mathcal{H}$ déployé sur une position $e \in \mathcal{E}$")
    ax.plot([500, 500], [500, 500], [2, 8], color="black", linestyle="dotted", zorder=22, clip_on=false)
    ax.plot([500, 500], [500, 500], [0, 2], color="black", linestyle="dotted", zorder=19, clip_on=false)   
    
    # Obstacle 1
    #obstacle_1(ax) 
     
    # Obstacle 2
    #obstacle_2(ax)    
    
    # Obstacle 3
    #obstacle_3(ax) 
     
    # Obstacle 4
    obstacle_4(ax) 
       
    ax.plot([],[],[], marker="s",  linestyle="", markersize=15, color="cyan", label="Obstacle")
    ax.plot([],[],[], marker="s",  linestyle="", markersize=15, color="red", label="Zone hors d'atteinte (angle mort)")
    ax.plot([],[],[], markersize=15, color="limegreen", label="Champ de vision du HAPS")
    ax.legend(loc="upper left", bbox_to_anchor=(0.7, 1.1), fontsize=14, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function obstacle_4(ax)
    for z in 6.1:0.01:9
        ax.plot([450,550], [450,450], [z,z], color="cyan", zorder=10, clip_on=false)   
        ax.plot([450,550], [550,550], [z,z], color="cyan", zorder=10, clip_on=false)  
        ax.plot([450,450], [450,550], [z,z], color="cyan", zorder=6, clip_on=false)        
        ax.plot([550,550], [450,550], [z,z], color="cyan", zorder=30, alpha=0.08, clip_on=false)                                                        
    end
    ax.plot([500, 500], [300,500], [0,8], color="limegreen", clip_on=false, zorder=9, linewidth=1)
    ax.plot([500, 500], [700,500], [0,8], color="limegreen", clip_on=false, zorder=11, linewidth=1)
    ax.plot([300, 500], [500,500], [0,8], color="limegreen", clip_on=false, zorder=9, linewidth=1)
    ax.plot([700, 500], [500,500], [0,8], color="limegreen", clip_on=false, zorder=9, linewidth=1)
  
    ax.plot([700, 500], [300,500], [0,8], color="limegreen", clip_on=false, zorder=9, linewidth=1)
    ax.plot([700, 500], [700,500], [0,8], color="limegreen", clip_on=false, zorder=11, linewidth=1)
    ax.plot([300, 500], [700,500], [0,8], color="limegreen", clip_on=false, zorder=11, linewidth=1)   
    ax.plot([300, 500], [300,500], [0,8], color="limegreen", clip_on=false, zorder=9, linewidth=1)    
        
    for y in 0:1:300
        ax.plot([0,1000], [y,y], [0,0], color="red", alpha=0.3, zorder=7, clip_on=false)       
    end
    for y in 700:1:1000
        ax.plot([0,1000], [y,y], [0,0], color="red", alpha=0.3, zorder=7, clip_on=false)       
    end
    for y in 302:1:698
        ax.plot([702,998], [y,y], [0,0], color="red", alpha=0.3, zorder=7, clip_on=false)       
    end
    for y in 302:1:698
        ax.plot([0,300], [y,y], [0,0], color="red", alpha=0.3, zorder=7, clip_on=false)       
    end

end

function obstacle_3(ax)
    for z in 0:0.01:1
        ax.plot([850,850], [5,1000], [z,z], color="cyan", zorder=10, clip_on=false)          
    end
    for y in 0:1:1000
        ax.plot([850,903], [y,y], [0,0], color="red", alpha=0.3, zorder=7, clip_on=false)       
    end 
    ax.plot([903, 500], [500,500], [0,8], color="limegreen", clip_on=false, zorder=19, linewidth=1)
    ax.plot([903, 500], [0,500], [0,8], color="limegreen", clip_on=false, zorder=19, linewidth=1)
    ax.plot([903, 500], [1000,500], [0,8], color="limegreen", clip_on=false, zorder=19, linewidth=1)
    ax.plot([903, 500], [250,500], [0,8], color="limegreen", clip_on=false, zorder=19, linewidth=1)
    ax.plot([903, 500], [750,500], [0,8], color="limegreen", clip_on=false, zorder=21, linewidth=1)
end

function obstacle_1(ax)
    # Ostacle 1
    for z in 0:0.01:8
        ax.plot([450,550], [300,300], [z,z], color="cyan", zorder=10, clip_on=false)       
    end 
    for y in 0:1:300
        ax.plot([450,550], [y,y], [0,0], color="red", alpha=0.3, zorder=7, clip_on=false)       
    end 
    for x in 553:1:630
        ax.plot([x,550], [0,300], [0,0], color="red", alpha=0.1, zorder=7, clip_on=false)       
    end 
    for x in 370:1:450
        ax.plot([x,450], [0,300], [0,0], color="red", alpha=0.1, zorder=7, clip_on=false)       
    end 
    ax.plot([630, 500], [0,500], [0,8], color="limegreen", clip_on=false, zorder=19, linewidth=1)   
    ax.plot([370, 500], [0,500], [0,8], color="limegreen", clip_on=false, zorder=8, linewidth=1)       
    ax.plot([550, 500], [300,500], [0,8], color="limegreen", clip_on=false, zorder=8, linewidth=1)       
    ax.plot([450, 500], [300,500], [0,8], color="limegreen", clip_on=false, zorder=8, linewidth=1)  
end

function obstacle_2(ax)
    # Obstacle 2
    for y in 450:1:550
        ax.plot([450,550], [y,y], [2,2], color="cyan", zorder=20, clip_on=false)       
    end 
    for y in 432:1:568
        ax.plot([432,568], [y,y], [0,0], color="red", alpha=0.3, zorder=10, clip_on=false)       
    end 
    ax.plot([568, 500], [432,500], [0,8], color="limegreen", clip_on=false, zorder=21, linewidth=1)   
    ax.plot([500, 500], [432,500], [0,8], color="limegreen", clip_on=false, zorder=21, linewidth=1)
    ax.plot([568, 500], [500,500], [0,8], color="limegreen", clip_on=false, zorder=21, linewidth=1)   
    ax.plot([568, 500], [568,500], [0,8], color="limegreen", clip_on=false, zorder=21, linewidth=1)   
    ax.plot([500, 500], [568,500], [0,8], color="limegreen", clip_on=false, zorder=19, linewidth=1)  
    ax.plot([432, 500], [432,500], [0,8], color="limegreen", clip_on=false, zorder=21, linewidth=1) 
    ax.plot([432, 500], [500,500], [0,8], color="limegreen", clip_on=false, zorder=19, linewidth=1)  
    ax.plot([432, 500], [568,500], [0,8], color="limegreen", clip_on=false, zorder=19, linewidth=1)     
end

function procedure()
    ion()
    using3D()
    fig = figure("Outil de visualisation")
    ax = fig.add_subplot(111, projection="3d")
    ax.margins(0)
    ax.view_init(elev=17, azim=-16)
    ax.dist = 4
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(-10, 10)
    fig.set_facecolor("#14213d")
    ax.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    pas = 50
    X = ones(length(0:pas:1000))' .* [0:pas:1000;]
    Y = [0:pas:1000;]' .* ones(length(0:pas:1000))
    Z = rand(length(0:pas:1000),length(0:pas:1000))*0
    plot_surface(X, Y, Z, color="#40916c", edgecolor="white", linewidth=0.2, alpha=1, shade=false, zorder=-5, clip_on=false)   
    
    generation_sol(ax)  
    generation_etoiles(ax)
end

####### Discrétisation 3D

function generation_sol_bis(ax)
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


    # Plan tombant 1
    x = [0 1000; 0 1000]
    y = [0 0; 0 0]
    z = [0 0; -4 -4]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)  

    # Plan tombant 2
    x = [1000 1000; 1000 1000]
    y = [0 1000; 0 1000]
    z = [0 0; -4 -4]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)   

    # Plan tombant 3
    x = [0 1000; 0 1000]
    y = [1000 1000; 1000 1000]
    z = [0 0; -4 -4]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false) 

    # Plan tombant 4
    x = [0 0; 0 0]
    y = [0 1000; 0 1000]
    z = [0 0; -4 -4]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false) 

    # Fermeture
    x = [0 0; 1000 1000]
    y = [0 1000; 0 1000]
    z = [-4 -4; -4 -4]
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

function main_final()
    ion()
    using3D()
    fig = figure("Outil de visualisation")
    ax = fig.add_subplot(111, projection="3d")
    ax.margins(0)
    ax.view_init(elev=12, azim=-18)
    ax.dist = 4
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(-5, 15)
    fig.set_facecolor("#14213d")
    ax.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)

    
    generation_sol_bis(ax)  
    generation_etoiles(ax)
    
    # Grille
    pas = 200
    i = 0
    while i <= 1000
        for z in 0:3:16
            ax.plot([i, i], [0, 1000], [z], color="white", linewidth=0.1, zorder=15, clip_on=false) # Longueur
            ax.plot([0, 1000], [i, i], [z], color="white", linewidth=0.1, zorder=15, clip_on=false) # Largeur
        end
       
        
        i += pas
    end
    
    for x in 0:pas:1000
        for y in 0:pas:1000
            for z in 0:3:14
                ax.plot([x, x], [y, y], [z, z+3], color="white", linewidth=0.1, zorder=15, clip_on=false) # Longueur            
            end
        end
    end
    
    ax.plot([700], [900], [7], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=20, zorder=25, clip_on=false, label=L"Un HAPS $h \in \mathcal{H}$ déployé sur une position $e \in \mathcal{E}$")
    ax.plot([700, 700], [900, 900], [0, 7], color="black", linestyle="dotted", zorder=22, clip_on=false)
    
    ax.plot([650], [150], [0], color="white", marker="^", zorder=15, linestyle="", markersize=10, markeredgecolor="black", label="Unité terrestre")  
    
    # Obstacle 1
    obstacle_final(ax) 
    
   #ax.plot([], [], marker="s", markeredgecolor="white", color="#14213d", linestyle="", alpha=0.4, label="0")
   #ax.plot([], [], marker="s", color="red", linestyle="", alpha=0.5, label="1")    
    ax.plot([],[],[], marker="s",  linestyle="", markersize=15, color="cyan", label="Obstacle")
    #ax.plot([],[],[], marker="s",  linestyle="", markersize=15, color="red", label="Zone hors d'atteinte (angle mort)")
    #ax.plot([],[],[], markersize=15, color="limegreen", label="Champ de vision du HAPS")
    ax.legend(loc="upper left", bbox_to_anchor=(-0.7, 1.1), fontsize=14, framealpha=0.8, facecolor="#14213d", labelcolor="white", edgecolor="white").set_zorder(1000)
end

function obstacle_final(ax)
    for y in 250:2:350
        for z in 0:0.1:7
            ax.plot([300,700], [y,y], [z,z], color="cyan", zorder=13, alpha=1, linewidth=3, clip_on=false)            
        end
    end     
end

main_final()
