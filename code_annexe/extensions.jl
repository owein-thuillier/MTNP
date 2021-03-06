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
    # Ancienne m??thode, g??n??re des ralentissements
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

    # D??marcations (arr??tes)
    #plot([0, 0], [0, 0], [0, -500], color="#081c15", linewidth=1, zorder=10)
    #plot([1000, 1000], [0, 0], [0, -500], color="#081c15", linewidth=1, zorder=10)
    #plot([1000, 1000], [1000, 1000], [0, -500], color="#081c15", linewidth=1, zorder=10)

    # Affichage dimensions
    #ax.plot([0,1000], [-50,-50], [0,0], color="white", marker="", markersize=5, zorder=10)
    #ax.plot([1050,1050], [0,1000], [0,0], color="white", marker="", markersize=5, zorder=10)
end

function generation_etoiles(ax)
    # Seed : cha??ne de caract??res vers suite d'entiers (conversion via code ASCII) 
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

function generation_ciel(ax)
    ###### Fond n??1 ######

    # Troposph??re (15 km)
    x = [0 1000; 0 1000]
    y = [1000 1000; 1000 1000]
    z = [0 0; 15 15]
    plot_surface(x,y,z, color="#48cae4", alpha=0.9, shade=false, zorder=0, clip_on=false)

    # Stratosph??re (15-50 km)
    x = [0 1000; 0 1000]
    y = [1000 1000; 1000 1000]
    z = [15 15; 50 50]
    plot_surface(x,y,z, color="#00b4d8", alpha=0.9, shade=false, zorder=0, clip_on=false)

    # M??sosph??re (50-85 km)
    x = [0 1000; 0 1000]
    y = [1000 1000; 1000 1000]
    z = [50 50; 85 85]
    plot_surface(x,y,z, color="#0096c7", alpha=0.9, shade=false, zorder=0, clip_on=false)

    # Thermosph??re (85-500 km)
    x = [0 1000; 0 1000]
    y = [1000 1000; 1000 1000]
    z = [85 85; 500 500]
    plot_surface(x,y,z, color="#0077b6", alpha=0.9, shade=false, zorder=0, clip_on=false)

   ###### Fond n??2 ######

    # Troposph??re (15 km)
    x = [0 0; 0 0]
    y = [0 1000; 0 1000]
    z = [0 0; 15 15]
    plot_surface(x,y,z, color="#48cae4", alpha=0.9, shade=false, zorder=0, clip_on=false)

    # Stratosph??re (15-50 km)
    x = [0 0; 0 0]
    y = [0 1000; 0 1000]
    z = [15 15; 50 50]
    plot_surface(x,y,z, color="#00b4d8", alpha=0.9, shade=false, zorder=0, clip_on=false)

    # M??sosph??re (50-85 km)
    x = [0 0; 0 0]
    y = [0 1000; 0 1000]
    z = [50 50; 85 85]
    plot_surface(x,y,z, color="#0096c7", alpha=0.9, shade=false, zorder=0, clip_on=false)

    # Thermosph??re (85-500 km)
    x = [0 0; 0 0]
    y = [0 1000; 0 1000]
    z = [85 85; 500 500]
    plot_surface(x,y,z, color="#0077b6", alpha=0.9, shade=false, zorder=0, clip_on=false) 
end

function labels(ax)
    # Ligne des 20 km
    ax.plot([0,0], [0,1000], [20,20], color="white", marker="", markersize=5, linestyle="--", linewidth=1, alpha=0.7, zorder=15, clip_on=false)
    ax.plot([0,1000], [1000,1000], [20,20], color="white", marker="", markersize=5, linestyle="--", linewidth=1, alpha=0.7, zorder=15, clip_on=false)
    text3D(x=0, y=200, z=22, s="Altitude de d??ploiement des HAPS", zdir="y", color="black", fontsize=10, zorder=15, clip_on=false)

    # Ligne de K??rm??n
    ax.plot([0,0], [0,1000], [100,100], color="red", marker="", markersize=5, linestyle="--", linewidth=1, alpha=0.7, zorder=18, clip_on=false)
    ax.plot([0,1000], [1000,1000], [100,100], color="red", marker="", markersize=5, linestyle="--", linewidth=1, alpha=0.7, zorder=18, clip_on=false)
    text3D(x=0, y=375, z=102, s="Ligne de K??rm??n", zdir="y", color="black", fontsize=7, zorder=15, clip_on=false)

    # Labels
    text3D(x=0, y=-95, z=15, s="15 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=15, clip_on=false)
    text3D(x=0, y=-95, z=20, s="20 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=15, clip_on=false)
    text3D(x=0, y=10, z=7.5, s="Troposph??re", zdir="y", color="black", zorder=15, clip_on=false, fontsize=14)
    text3D(x=0, y=10, z=35, s="Stratosph??re", zdir="y", color="black", zorder=15, clip_on=false)
    text3D(x=0, y=-90, z=50, s="50 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=15, clip_on=false)
    text3D(x=0, y=10, z=67.5, s="M??sosph??re", zdir="y", color="black", zorder=15, clip_on=false)
    text3D(x=0, y=-90, z=85, s="85 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=15, clip_on=false)
    text3D(x=0, y=10, z=100, s="Thermosph??re", zdir="y", color="black", zorder=15, clip_on=false)
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
    affichage_etat_courant.set_text("??tat : 1/20")     
    plot_base(400,400)
    plot_seuil(ax,400,400,100,"crimson")   
    plot_seuil(ax,400,400,150,"cyan")   
    plot_seuil(ax,400,400,200,"lime")  
    
    # couv
    ax.plot([450], [450], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(450,450)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    vect = [400 - 450, 400 - 450, 1 - 0]    
    point_1 = [450, 450, 0]
    point_2 = point_1 .+ (1/2) .* vect 
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="cyan", linestyle="--",  linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="crimson", linestyle="--",  linewidth=1, zorder=18, clip_on=false)     
    
    
    # couv       
    ax.plot([510], [280], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(510,280)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([510, 400], [280, 400], [0, 1], color="lime", linestyle="--",  linewidth=1, zorder=19, clip_on=false)  

           
    # couv
    ax.plot([320], [300], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(320,300)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    vect = [400 - 320, 400 - 300, 1 - 0]    
    point_1 = [320, 300, 0]
    point_2 = point_1 .+ (1/2) .* vect 
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="cyan", linestyle="--",  linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="lime", linestyle="--",  linewidth=1, zorder=18, clip_on=false)     
    
    
    # pas couv
    ax.plot([270], [450], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(270,450)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
 
    ax.plot([700], [200], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(700,200)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
    ax.plot([500], [900], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(500,900)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
    ax.plot([100], [200], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(100,200)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
   
    ax.plot([200], [800], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(200,800)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 

 
    
    
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Relais de type 1") 
    ax.plot([], [], [], color="lime", marker="", markersize=10, label="Relais de type 2") 
    ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Relais de type 3")    
    ax.plot([], [], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unit??s terrestres")  
    ax.plot([], [], [], color="#E4E4DD", marker="s", markeredgecolor="#6b705c", linestyle="", markersize=15, label="Base") 
    ax.legend(loc="upper left", bbox_to_anchor=(0.90, 0.95), fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

###################

function generation_sol(ax)

    # Plan tombant 1
    x = [0 1000; 0 1000]
    y = [0 0; 0 0]
    z = [0 0; -4 -4]
    plot_surface(x, y, z, color="#774936", edgecolor="black", alpha=1, shade=false, zorder=-5, clip_on=false)  


    # D??marcations (arr??tes)
    #plot([0, 0], [0, 0], [0, -500], color="#081c15", linewidth=1, zorder=10)
    #plot([1000, 1000], [0, 0], [0, -500], color="#081c15", linewidth=1, zorder=10)
    #plot([1000, 1000], [1000, 1000], [0, -500], color="#081c15", linewidth=1, zorder=10)

    # Affichage dimensions
    #ax.plot([0,1000], [-50,-50], [0,0], color="white", marker="", markersize=5, zorder=10)
    #ax.plot([1050,1050], [0,1000], [0,0], color="white", marker="", markersize=5, zorder=10)
end

function terrain()
    ion()
    using3D()
    fig = figure("Outil de visualisation")
    ax = fig.add_subplot(111, projection="3d")
    ax.margins(0)
    ax.view_init(elev=17, azim=-90)
    ax.dist = 3.8
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
    
    for i in length(0:pas:1000)-5:length(0:pas:1000)
        for j in length(0:pas:1000)-5:length(0:pas:1000)
            Z[i,j] = rand()*6
        end
    end

    for i in 1:6
        for j in length(0:pas:1000)-5:length(0:pas:1000)
            Z[i,j] = rand()*6
        end
    end 
    


    generation_etoiles(ax) 
    generation_sol(ax)
    #ax.plot(vec(reshape(X, 1, 441)) , vec(reshape(Y, 1, 441)), vec(reshape(Z, 1, 441)), linestyle="", color="white", marker=".", markersize=1, alpha=1, zorder=-5, clip_on=false)
    #plot_wireframe(X, Y, Z, color="white", edgecolor="white", linewidth=0.2, alpha=1, zorder=-5, clip_on=false)
    plot_surface(X, Y, Z, color="#40916c", edgecolor="white", linewidth=0.2, alpha=1, shade=false, zorder=-5, clip_on=false)
       
    # Rivi??re
    riviere(ax)
    
    # Route
    route(ax)
    
    # Pont
    pont(ax)
    
    # D??sert
    desert(ax)

    # Nuages 
    nuage(ax) 
    
    # for??t
    foret(ax)
    
    # Brume
    brume(ax) 
    
    # Chemin
    chemin(ax)
    
    # B??timent
    batiments(ax)
end 

function batiments(ax)
 ??  # Face
    plot([690,730], [170, 170], [0,0], color="black", clip_on=false, zorder=7, linewidth=1)
    plot([750,790], [170, 170], [0,0], color="black", clip_on=false, zorder=7, linewidth=1)
    plot([690,790], [170, 170], [1,1], color="black", clip_on=false, zorder=7, linewidth=1)
    plot([690,690], [170, 170], [0,1], color="black", clip_on=false, zorder=7, linewidth=1)
    plot([790,790], [170, 170], [0,1], color="black", clip_on=false, zorder=7, linewidth=1)
    
    plot([730,730], [170, 170], [0,0.5], color="black", clip_on=false, zorder=7, linewidth=1)
    plot([750,750], [170, 170], [0,0.5], color="black", clip_on=false, zorder=7, linewidth=1)        
    plot([730,750], [170, 170], [0.5,0.5], color="black", clip_on=false, zorder=7, linewidth=1)    
    
    # Porte
    for x in 730:1:750
        plot([x,x], [170, 170], [0,0.5], color="#936639", clip_on=false, zorder=6, linewidth=1)       
    end   
    plot([740,740], [170, 170], [0,0.5], color="black", clip_on=false, zorder=7, linewidth=0.5)              
    plot([737], [170], [0.25], color="black", marker=".",  markersize=1, clip_on=false, zorder=7, linewidth=0.5)   
    plot([743], [170], [0.25], color="black", marker=".",  markersize=1, clip_on=false, zorder=7, linewidth=0.5)   
                
    # Fenetre gauche      
    for x in 700:1:720
        plot([x,x], [170, 170], [0.3,0.7], color="#94d2bd", clip_on=false, zorder=7, linewidth=1, alpha=0.3)       
    end      
    plot([700,720], [170, 170], [0.5,0.5], color="black", clip_on=false, zorder=7, linewidth=0.5)   
    plot([710,710], [170, 170], [0.3,0.7], color="black", clip_on=false, zorder=7, linewidth=0.5)   

              
    # Fenetre droite       
    for x in 760:1:780
        plot([x,x], [170, 170], [0.3,0.7], color="#94d2bd", clip_on=false, zorder=7, linewidth=1, alpha=0.3)       
    end  
    plot([760,780], [170, 170], [0.5,0.5], color="black", clip_on=false, zorder=7, linewidth=0.5)   
    plot([770,770], [170, 170], [0.3,0.7], color="black", clip_on=false, zorder=7, linewidth=0.5) 
            
    plot([700,720], [170, 170], [0.3,0.3], color="black", clip_on=false, zorder=8, linewidth=1)    
    plot([700,720], [170, 170], [0.7,0.7], color="black", clip_on=false, zorder=8, linewidth=1)   
    plot([700,700], [170, 170], [0.3,0.7], color="black", clip_on=false, zorder=8, linewidth=1)   
    plot([720,720], [170, 170], [0.3,0.7], color="black", clip_on=false, zorder=8, linewidth=1)       
    for x in 690:1:700
        plot([x,x], [170, 170], [0,1], color="lightgray", clip_on=false, zorder=6, linewidth=1)    
    end
    for x in 690:1:730
        plot([x,x], [170, 170], [0,0.3], color="lightgray", clip_on=false, zorder=6, linewidth=1)    
    end
    for x in 690:1:730
        plot([x,x], [170, 170], [0.7,1], color="lightgray", clip_on=false, zorder=6, linewidth=1)    
    end
    for x in 720:1:730
        plot([x,x], [170, 170], [0,1], color="lightgray", clip_on=false, zorder=6, linewidth=1)    
    end    
    
    
    plot([760,780], [170, 170], [0.3,0.3], color="black", clip_on=false, zorder=8, linewidth=1)    
    plot([760,780], [170, 170], [0.7,0.7], color="black", clip_on=false, zorder=8, linewidth=1)   
    plot([760,760], [170, 170], [0.3,0.7], color="black", clip_on=false, zorder=8, linewidth=1)   
    plot([780,780], [170, 170], [0.3,0.7], color="black", clip_on=false, zorder=8, linewidth=1)     
    for x in 750:1:760
        plot([x,x], [170, 170], [0,1], color="#ced4da", clip_on=false, zorder=6, linewidth=1)    
    end
    for x in 750:1:790
        plot([x,x], [170, 170], [0,0.3], color="#ced4da", clip_on=false, zorder=6, linewidth=1)    
    end
    for x in 750:1:790
        plot([x,x], [170, 170], [0.7,1], color="#ced4da", clip_on=false, zorder=6, linewidth=1)    
    end
    for x in 780:1:790
        plot([x,x], [170, 170], [0,1], color="#ced4da", clip_on=false, zorder=6, linewidth=1)    
    end
    
    for x in 730:1:750
        plot([x,x], [170, 170], [0.5,1], color="#ced4da", clip_on=false, zorder=6, linewidth=1)    
    end
    
    plot([690,690], [170, 270], [0,0], color="black", clip_on=false, zorder=7, linewidth=1)  
    plot([690,690], [270, 270], [0,1], color="black", clip_on=false, zorder=7, linewidth=1) 
    for z in 0:0.01:1
        plot([690,690], [170, 270], [z,z], color="#ced4da", clip_on=false, zorder=6, linewidth=1)        
    end 
                
    # Toit
    plot([690,690], [170, 270], [1,1], color="black", clip_on=false, zorder=7, linewidth=1)  
    plot([790,790], [170, 270], [1,1], color="black", clip_on=false, zorder=7, linewidth=1)    
    plot([690,790], [270, 270], [1,1], color="black", clip_on=false, zorder=7, linewidth=1)
    for y in 170:1:270
        plot([690,790], [y, y], [1,1], color="#adb5bd", clip_on=false, zorder=6, linewidth=1)    
    end
    
    
    # Tour controle
    plot([900,920], [170,170], [0,0], color="black", clip_on=false, zorder=18, linewidth=1)
    plot([930,950], [170,170], [0,0], color="black", clip_on=false, zorder=18, linewidth=1)
    plot([920,920], [170,170], [0,0.5], color="black", clip_on=false, zorder=18, linewidth=1)
    plot([930,930], [170,170], [0,0.5], color="black", clip_on=false, zorder=18, linewidth=1)
    plot([920,930], [170,170], [0.5,0.5], color="black", clip_on=false, zorder=18, linewidth=1)
    plot([900,900], [170,170], [0,2], color="black", clip_on=false, zorder=18, linewidth=1)
    plot([900,900], [220,220], [0,2], color="black", clip_on=false, zorder=18, linewidth=1)
    plot([900,950], [170,170], [2,2], color="black", clip_on=false, zorder=18, linewidth=1)
    plot([900,900], [170,220], [0,0], color="black", clip_on=false, zorder=18, linewidth=1)
    plot([950,950], [170,170], [0,2], color="black", clip_on=false, zorder=18, linewidth=1)
    
    
    # Porte
    for x in 920:1:930
        plot([x,x], [170, 170], [0,0.5], color="#936639", clip_on=false, zorder=5, linewidth=1)       
    end   
    plot([923], [170], [0.25], color="black", marker=".",  markersize=1, clip_on=false, zorder=6, linewidth=0.5)   
                
    
    for z in 0:0.01:2
        plot([900,920], [170, 170], [z,z], color="#ced4da", clip_on=false, zorder=17) 
        plot([930,950], [170, 170], [z,z], color="#ced4da", clip_on=false, zorder=17)                  
    end
    for z in 0.5:0.01:2
        plot([900,950], [170, 170], [z,z], color="#ced4da", clip_on=false, zorder=17) 
    end
   
    plot([900,950], [150,150], [0.52,0.52], color="black", clip_on=false, zorder=20, linewidth=1)
    plot([900,900], [150,170], [0.52,0.52], color="black", clip_on=false, zorder=20, linewidth=1)
    plot([950,950], [150,170], [0.52,0.52], color="black", clip_on=false, zorder=20, linewidth=1)
    
    for y in 150:1:170
        plot([900,950], [y, y], [0.52,0.52], color="#adb5bd", clip_on=false, zorder=19, linewidth=1)        
    end 
   
    for z in 0:0.01:2
        plot([900,900], [170, 220], [z,z], color="#ced4da", clip_on=false, zorder=17, linewidth=1)        
    end  
    
    plot([900,950], [220,220], [2,2], color="black", clip_on=false, zorder=18, linewidth=1)
    plot([900,900], [170,220], [2,2], color="black", clip_on=false, zorder=18, linewidth=1)
    plot([950,950], [170,220], [2,2], color="black", clip_on=false, zorder=18, linewidth=1)
    
    for y in 170:1:220
        plot([900,950], [y, y], [2,2], color="#ced4da", clip_on=false, zorder=17, linewidth=1)        
    end 
    
    plot([910,910], [180,180], [2,2.4], color="black", clip_on=false, zorder=18, linewidth=1.5)
    plot([910,910], [210,210], [2,2.4], color="black", clip_on=false, zorder=18, linewidth=1.5)
    plot([940,940], [180,180], [2,2.4], color="black", clip_on=false, zorder=18, linewidth=1.5)
    plot([940,940], [210,210], [2,2.4], color="black", clip_on=false, zorder=18, linewidth=1.5)
    
    plot([910,940], [180,180], [2.4,2.4], color="black", clip_on=false, zorder=20, linewidth=1.5)
    plot([910,940], [210,210], [2.4,2.4], color="black", clip_on=false, zorder=20, linewidth=1.5)
    plot([910,910], [180,210], [2.4,2.4], color="black", clip_on=false, zorder=20, linewidth=1.5)
    plot([940,940], [180,210], [2.4,2.4], color="black", clip_on=false, zorder=20, linewidth=1.5)
    
    for y in 180:1:210
        plot([910,940], [y, y], [2.4,2.4], color="#adb5bd", clip_on=false, zorder=19, linewidth=1)        
    end 
    
    # Lampadaires
    for x in 50:100:950
        ax.plot([x, x], [30, 30], [0.5, 0], color="black", clip_on=false, zorder=10, marker=".", markersize=10, markerfacecolor="darkorange", markeredgecolor="black", markevery=2)
    end    
end


function riviere(ax)
    for y in 300:1:330
        ax.plot([0, 600], [y, y], [0, 0], color="#00b4d8", clip_on=false, zorder=10)    
    end
    
    for y in 420:1:450
        ax.plot([0, 600], [y, y], [0, 0], color="#00b4d8", clip_on=false, zorder=10)    
    end
    
    for y in 330:1:420
        ax.plot([0, 600], [y, y], [0, 0], color="#0096c7", clip_on=false, zorder=10)    
    end
    
    
    for x in 520:1:580
        ax.plot([x,x], [330, 1000], [0, 0], color="#0096c7", clip_on=false, zorder=10)    
    end
    for x in 500:1:520
        ax.plot([x,x], [430, 1000], [0, 0], color="#00b4d8", clip_on=false, zorder=10)    
    end
     for x in 580:1:600
        ax.plot([x,x], [330, 1000], [0, 0], color="#00b4d8", clip_on=false, zorder=10)    
    end
    

    for y in 300:1:450
        ax.plot([0, 0], [y, y], [0, -20], color="#00b4d8", clip_on=false, zorder=-10)    
    end
    
    for x in 500:1:600
        ax.plot([x, x], [1000, 1000], [0, -20], color="#00b4d8", clip_on=false, zorder=-10)    
    end
end

function chemin(ax)
    ax.plot([810,810], [150, 300], [0, 0], color="black", clip_on=false, zorder=7, linewidth=1)
    ax.plot([840,840], [150, 250], [0, 0], color="black", clip_on=false, zorder=7, linewidth=1)
    for y in 150:1:300
        ax.plot([810,840], [y, y], [0, 0], color="#a68a64", clip_on=false, zorder=6, linewidth=1)       
    end
    
    ax.plot([810,1000], [300, 300], [0, 0], color="black", clip_on=false, zorder=7, linewidth=1)
    ax.plot([840,1000], [250, 250], [0, 0], color="black", clip_on=false, zorder=7, linewidth=1)
    for x in 840:1:1000
        ax.plot([x,x], [250, 300], [0, 0], color="#a68a64", clip_on=false, zorder=6, linewidth=1)       
    end
end


function route(ax)
    # Route 1

    for x in 350:1:400
        if x == 350 || x == 400
            plot([x, x], [450,1000], [0, 0], color="black", clip_on=false, zorder=6, linewidth=1)        
        else
            plot([x, x], [450,1000], [0, 0], color="gray", clip_on=false, zorder=5)       
        end   
    end
    
    for y in 450:100:950
        plot([375, 375], [y,y+50], [0, 0], color="white", clip_on=false, zorder=6, linewidth=1)        
    end
    
    # Route 2
    for x in 350:1:400
        if x == 350 || x == 400
            plot([x, x], [150,300], [0, 0], color="black", clip_on=false, zorder=6,  linewidth=1)                         
        else
            plot([x, x], [150,300], [0, 0], color="gray", clip_on=false, zorder=5,  linewidth=1)       
        end   
    end
    
    for y in 150:100:300
        plot([375, 375], [y,y+50], [0, 0], color="white", clip_on=false, zorder=6, linewidth=1)        
    end
    
    # Route 3
    for y in 50:1:150
        if y == 150
            plot([0, 350], [y,y], [0, 0], color="black", clip_on=false, zorder=6,  linewidth=1) 
            plot([400, 1000], [y,y], [0, 0], color="black", clip_on=false, zorder=6,  linewidth=1)                                                 
        elseif y == 50
            plot([0, 1000], [y,y], [0, 0], color="black", clip_on=false, zorder=6,  linewidth=1) 
        else
            plot([0, 1000], [y,y], [0, 0], color="gray", clip_on=false, zorder=5,  linewidth=1)
        end   
    end
    
    for x in 50:100:950
        plot([x, x+50], [100,100], [0, 0], color="white", clip_on=false, zorder=6, linewidth=1)        
    end
        
end

function pont(ax)
    # Pont
    for x in 350:1:400
        if x == 350 || x == 400
            ax.plot([x, x], [300, 325], [0, 0.3], color="black", clip_on=false, zorder=11, linewidth=1.5)    
        else
            ax.plot([x, x], [300, 325], [0, 0.3], color="sienna", clip_on=false, zorder=10)    
        end
    end
    
    for x in 350:1:400
        if x == 400
            ax.plot([x, x], [450, 425], [0, 0.3], color="black", clip_on=false, zorder=20, linewidth=1.5)    
        else
            ax.plot([x, x], [450, 425], [0, 0.3], color="sienna", clip_on=false, zorder=10)    
        end
    end
    
    for x in 350:1:400
        if x == 350 || x == 400
            ax.plot([x, x], [325, 425], [0.3, 0.3], color="black", clip_on=false, zorder=20, linewidth=1.5)    
        else
            ax.plot([x, x], [325, 425], [0.3, 0.3], color="sienna", clip_on=false, zorder=10)    
        end
    end
    
end

function brume(ax)
    for y in 150:1:300
        for z in 0.25:0.01:0.4
            ax.plot([400, 675], [y, y], [z, z], color="white", clip_on=false, zorder=15, alpha=0.01)
        end
    end
end

function desert(ax)
    for y in 400:1:700
        ax.plot([603,1000], [y,y], [0,0], color="#f9c74f", clip_on=false, zorder=10)    
    end
    for y in 400:1:1000
        ax.plot([603,700], [y,y], [0,0], color="#f9c74f", clip_on=false, zorder=10)    
    end
    

    for i in 1:50
        x = rand([603:997;])
        y = rand([403:697;])
        plot([x,x], [y,y], [0,0.2], color="green", clip_on=false, zorder=10)
    end
    for i in 1:20
        x = rand([603:697;])
        y = rand([703:1000;])
        plot([x,x], [y,y], [0,0.2], color="green", clip_on=false, zorder=10)
    end
end

function foret(ax)
    for i in 1:150
        x = rand([10:340;])
        y = rand([460:700;])
        ax.plot([x, x], [y, y], [0.5, 0], color="brown", clip_on=false, zorder=10, marker=".", markersize=10, markerfacecolor="green", markeredgecolor="green", markevery=2)
    end
    for i in 1:25
        x = rand([300:340;])
        y = rand([700:990;])
        ax.plot([x, x], [y, y], [0.5, 0], color="brown", clip_on=false, zorder=10, marker=".", markersize=10, markerfacecolor="green", markeredgecolor="green", markevery=2)
    end
    for i in 1:75
        x = rand([410:490;])
        y = rand([460:990;])
        ax.plot([x, x], [y, y], [0.5, 0], color="brown", clip_on=false, zorder=10, marker=".", markersize=10, markerfacecolor="green", markeredgecolor="green", markevery=2)
    end
    for i in 1:150
        x = rand([10:340;])
        y = rand([155:290;])
        ax.plot([x, x], [y, y], [0.5, 0], color="brown", clip_on=false, zorder=10, marker=".", markersize=10, markerfacecolor="green", markeredgecolor="green", markevery=2)
    end
    for i in 1:150
        x = rand([10:990;])
        y = rand([10:40;])
       # ax.plot([x, x], [y, y], [0.5, 0], color="brown", clip_on=false, zorder=10, marker=".", markersize=10, markerfacecolor="green", markeredgecolor="green", markevery=2)
    end
end

function nuage(ax)
    for y in 700:1:800
        for z in 2:0.05:3
            plot([0, 300], [y, y], [z, z], color="white", clip_on=false, zorder=10, alpha=0.05)      
        end
    end    
    for x in 300:1:350
        for z in 3.5:0.05:4.5
            plot([x, x], [710, 1000], [z, z], color="white", clip_on=false, zorder=10, alpha=0.1)      
        end
    end 
end

function test()
A = []
X = []
Y = []
for i in 0:100
    for j in 0:100
        garde = true
        for p1 in A
            if sqrt((i - p1[1])^2 + (j - p1[2])^2) < 10
                garde = false
                break
            end
        end
        if garde == true
            push!(X, i)
            push!(Y, j)
            push!(A, [i,j]) 
        end
    end
end
println(A)
plot(X,Y, color="black", marker=".", linestyle="")
end

#####

function old_relief()
  for i in 1:length(0:pas:1000)
        Z[i,i] = rand()*4
    end
    for i in 1:length(0:pas:1000)-2
        Z[i,i+1] = rand()*4
        Z[i,i+2] = rand()*4
    end
     for i in 3:length(0:pas:1000)
        Z[i,i-1] = rand()*4
        Z[i,i-2] = rand()*4
    end
           
    for i in 0:length(0:pas:1000)-1
        Z[i + 1, length(0:pas:1000) - i] = rand()*4
    end
     for i in 0:length(0:pas:1000)-3
        Z[i + 2,length(0:pas:1000) - i] = rand()*4
        Z[i + 3,length(0:pas:1000) - i] = rand()*4
    end
     for i in 2:length(0:pas:1000)-1
        Z[i,length(0:pas:1000) - i] = rand()*4
        Z[i - 1,length(0:pas:1000) - i] = rand()*4
    end
end

function terrain_bis()
    ion()
    using3D()
    fig = figure("Outil de visualisation")
    ax = fig.add_subplot(111, projection="3d")
    ax.margins(0)
    ax.view_init(elev=20, azim=-80)
    ax.dist = 4.5
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
    
  
    for i in 1:length(0:pas:1000)
        Z[i,1] = rand()*5
        Z[i,2] = rand()*5
        Z[i,3] = rand()*5
    end          
     for i in 1:length(0:pas:1000)
        Z[i,21] = rand()*5
        Z[i,20] = rand()*5
        Z[i,19] = rand()*5
    end           
    for i in 1:length(0:pas:1000)
        Z[1,i] = rand()*5
        Z[2,i] = rand()*5
        Z[3,i] = rand()*5
    end  
    for i in 1:length(0:pas:1000)
        Z[21,i] = rand()*5
        Z[20,i] = rand()*5
        Z[19,i] = rand()*5
    end  
        
    generation_etoiles(ax) 
    #ax.plot(vec(reshape(X, 1, 441)) , vec(reshape(Y, 1, 441)), vec(reshape(Z, 1, 441)), linestyle="", color="white", marker=".", markersize=1, alpha=1, zorder=-5, clip_on=false)
    #plot_wireframe(X, Y, Z, color="white", edgecolor="white", linewidth=0.2, alpha=1, zorder=-5, clip_on=false)
    plot_surface(X, Y, Z, color="#40916c", edgecolor="white", linewidth=0.2, alpha=1, shade=false, zorder=-5, clip_on=false)     

end


############"



function terrain_ter()
    ion()
    using3D()
    fig = figure("Outil de visualisation")
    ax = fig.add_subplot(111, projection="3d")
    ax.margins(0)
    ax.view_init(elev=14, azim=-47)
    ax.dist = 4.5
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
    
  
    for i in 5:8
        for j in 5:8
            Z[i,j] = rand()*1
        end
    end     
    Z[6,7] = 2 
    Z[6,6] = 2 
    Z[7,6] = 2 
    Z[7,7] = 2
          
    generation_etoiles(ax) 
    #ax.plot(vec(reshape(X, 1, 441)) , vec(reshape(Y, 1, 441)), vec(reshape(Z, 1, 441)), linestyle="", color="white", marker=".", markersize=1, alpha=1, zorder=-5, clip_on=false)
    #plot_wireframe(X, Y, Z, color="white", edgecolor="white", linewidth=0.2, alpha=1, zorder=-5, clip_on=false)
    plot_surface(X, Y, Z, color="#40916c", edgecolor="white", linewidth=0.2, alpha=1, shade=false, zorder=-5, clip_on=false)     


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
    
    ax.plot([275], [275], [2.2], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false, label=L"Une unit?? $u \in \mathcal{U}$  ?? un instant $t \in \mathcal{T}$")  
    ax.plot([800], [800], [11], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=20, zorder=25, clip_on=false, label=L"Un HAPS $h \in \mathcal{H}$ d??ploy?? sur une position $e \in \mathcal{E}$")
    ax.plot([800, 800], [800, 800], [2.2, 11], color="lime", zorder=19, clip_on=false)
    ax.plot([800, 800], [800, 800], [0, 2.2], color="black", linestyle="dotted", zorder=19, clip_on=false)
    ax.legend(loc="upper left", bbox_to_anchor=(-0.85, 1.1), fontsize=14, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
    

    # Triangle au sol
    ax.plot([275, 800], [275, 275], [2.2, 2.2], color="pink", zorder=14, clip_on=false)
    ax.plot([800, 800], [275, 800], [2.2, 2.2], color="yellow", zorder=14, clip_on=false)
    ax.plot([275, 800], [275, 800], [2.2, 2.2], color="red", zorder=14, clip_on=false)
    ax.plot([800, 800], [275, 275], [0, 2.2], color="black", linestyle="dotted", zorder=14, clip_on=false)

    # Angle droit 1 (triangle sol)
    ax.plot([760, 760], [275, 315], [2.2, 2.2], color="white", zorder=15, clip_on=false)
    ax.plot([760, 800], [315, 315], [2.2, 2.2], color="white", zorder=15, clip_on=false)

    # Angle droit 2 (triangle a??rien)
    ax.plot([780, 780], [780, 780], [2.2, 3], color="white", zorder=15, clip_on=false)
    ax.plot([780, 800], [780, 800], [3, 3], color="white", zorder=15, clip_on=false)

    # Distance unit??/haps
    ax.plot([275, 800], [275, 800], [2.2, 11], color="cyan", zorder=15, clip_on=false)

    # Rep??re
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
    ax.plot([0, 0], [0, 0], [0, 12], color="white", zorder=20, linewidth=1, clip_on=false)
    for i in -5:0.1:0
        ax.plot([0, 0], [i, 0], [11.5, 12], color="white", zorder=20, linewidth=1, clip_on=false)    
    end
    for i in 0:0.1:5
        ax.plot([0, 0], [i, 0], [11.5, 12], color="white", zorder=20, linewidth=1, clip_on=false)          
    end
end 

terrain_ter()


