###### zones interets
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

    # Ligne des 20 km
    ax.plot([-10,-10], [-10,1010], [20,20], color="white", marker="", markersize=5, linestyle="--", linewidth=1, alpha=0.7, zorder=15, clip_on=false)
    ax.plot([-10,1010], [1010,1010], [20,20], color="white", marker="", markersize=5, linestyle="--", linewidth=1, alpha=0.7, zorder=15, clip_on=false)
    
    # Labels
    text3D(x=0, y=10, z=7.5, s="Troposphère", zdir="y", color="black", zorder=13, clip_on=false, fontsize=13)
    text3D(x=0, y=10, z=30, s="Stratosphère", zdir="y", color="black", zorder=13, clip_on=false, fontsize=13)
    text3D(x=0, y=-100, z=15, s="15 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=10, zorder=15, clip_on=false)
    text3D(x=0, y=300, z=22, s="Altitude de déploiement des HAPS", zdir="y", color="black", fontsize=10, zorder=15, clip_on=false)
    text3D(x=0, y=-100, z=20, s="20 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=10, zorder=15, clip_on=false)
    text3D(x=0, y=-100, z=50, s="50 km", zdir="y", color="white", bbox=Dict("facecolor"=>"#6096ba", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=10, zorder=15, clip_on=false)
end

function trace_unite(x,y)
    trace = [[x,y]]
    for i in 1:6
        choix = rand([[0,10], [0,-10], [10,0], [-10,0], [10,10], [-10,-10], [10,-10], [-10,10]])
        push!(trace, [trace[end][1] + choix[1], trace[end][2] + choix[2]])
    end
    return trace[1:end]
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

function main()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    axis("off")
    ax.grid(false)
    #ax.view_init(elev=13, azim=-17) 
    #ax.dist = 10
    ax.view_init(elev=15, azim=-13) 
    ax.dist = 5.7
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(-20, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    tight_layout(pad=0)
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
   
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Demande de type 1") 
    ax.plot([], [], [], color="lime", marker="", markersize=10, label="Demande de type 2") 
    ax.plot([], [], [], color="navy", marker="", markersize=10, label="Demande de type 3") 
    ax.plot([], [], [], color="yellow", marker="", markersize=10, label="Demande de type 4") 
    ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Demande de type 5")  
    ax.plot([], [], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="\"Fausses\" unités")  
        
    # Type 1 
    ax.plot([100,50], [100,300], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([100,150], [100,50], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([300,150], [50,50], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([300,400], [50,250], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([250,400], [350,250], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([250,50], [350,300], [0,0], color="cyan", zorder=20, clip_on=false)
    
    # Type 2
    ax.plot([800,800], [-6,300], [0,0], color="lime", zorder=12, clip_on=false)
    ax.plot([1000,800], [300,300], [0,0], color="lime", zorder=12, clip_on=false)
    
    # Type 3
    ax.plot([900,700], [150,500], [0,0], color="navy", zorder=12, clip_on=false)
    ax.plot([900,1000], [150,150], [0,0], color="navy", zorder=12, clip_on=false)
    ax.plot([700,700], [800,500], [0,0], color="navy", zorder=12, clip_on=false)
    ax.plot([1000,700], [800,800], [0,0], color="navy", zorder=12, clip_on=false)

    # Types 4 et 5
    #ax.plot([850,200], [500,500], [0,0], color="white", zorder=12, clip_on=false)
    vect = [850 - 200, 500 - 500, 0]    
    point_1 = [200, 500, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="crimson", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow",  linewidth=1, zorder=18, clip_on=false)     
    #ax.plot([200,200], [500,950], [0,0], color="white", zorder=12, clip_on=false)
    vect = [200 - 200, 500 - 950, 0]    
    point_1 = [200, 950, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="crimson", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow",  linewidth=1, zorder=18, clip_on=false) 
    #ax.plot([200,500], [950,950], [0,0], color="white", zorder=12, clip_on=false)
    vect = [200 - 500, 950 - 950, 0]    
    point_1 = [500, 950, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="crimson", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow",  linewidth=1, zorder=18, clip_on=false) 
    #ax.plot([500,500], [700,950], [0,0], color="white", zorder=12, clip_on=false)
    vect = [500 - 500, 700 - 950, 0]    
    point_1 = [500, 950, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="crimson", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow",  linewidth=1, zorder=18, clip_on=false) 
    #ax.plot([850,500], [700,700], [0,0], color="white", zorder=12, clip_on=false) 
    vect = [850 - 500, 700 - 700, 0]    
    point_1 = [500, 700, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="crimson", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow",  linewidth=1, zorder=18, clip_on=false)    
    #ax.plot([850,850], [500,700], [0,0], color="white", zorder=12, clip_on=false)
    vect = [850 - 850, 500 - 700, 0]    
    point_1 = [850, 700, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="crimson", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow",  linewidth=1, zorder=18, clip_on=false)  
    
    # Type 1     
    # 50
    # 25
    temp = Dict()
    for x in 0:75:1000
        for y in 0:75:1000
            if verif_type1(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    push!(temp[(x,y)], 1)
                else
                    temp[(x,y)] = [1]           
                end
            end
            if verif_type2(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    push!(temp[(x,y)], 2)
                else
                    temp[(x,y)] = [2]           
                end
            end
            if verif_type3(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    push!(temp[(x,y)], 3)
                else
                    temp[(x,y)] = [3]           
                end
            end
            if verif_type4A(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    push!(temp[(x,y)], 4)
                    push!(temp[(x,y)], 5)
                else
                    temp[(x,y)] = [4,5]           
                end
            end
            if verif_type4B(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    push!(temp[(x,y)], 4)
                    push!(temp[(x,y)], 5)
                else
                    temp[(x,y)] = [4,5]           
                end
            end
        end
    end 
    io = open("scenario_1.txt", "w")
    ss = ""
    for (coord, t) in temp
        #println(t)
        ss *= "// Déplacements de l'unité terrestre 1 sur un horizon temporel (x_1^t, y_1^t) \n "
        for t in 1:1
            ss *= "($(coord[1]), $(coord[2])),"
        end   
         ss *= "($(coord[1]), $(coord[2])) \n\n"    
    end     
    write(io, ss)
    close(io)
    ax.legend(loc="upper left", bbox_to_anchor=(1, 0.95), fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function fct(x,xbis,y,ybis)
    a = (ybis-y)/(xbis-x)
    b = y - a*x
    return a,b
end

function verif_type4B(x,y)
    bool = true   
    a, b = fct(900,700,150,500)
    if y > 950
        bool = false
    end
    if y < 700
        bool = false
    end
    if x < 200
        bool = false
    end
    if x > 500
        bool = false
    end
    return bool
end

function verif_type4A(x,y)
    bool = true   
    a, b = fct(900,700,150,500)
    if y < 500
        bool = false
    end
    if y > 700
        bool = false
    end
    if x < 200
        bool = false
    end
    if x > 850
        bool = false
    end
    return bool
end


function verif_type3(x,y)
    bool = true   
    a, b = fct(900,700,150,500)
    if y - a*x - b < 0
        bool = false
    end
    a, b = fct(900,1000,150,150)
    if y < 150
        bool = false
    end
    a, b = fct(700,700,800,500)
    if x < 700
        bool = false
    end
    a, b = fct(1000,700,800,800)
    if y > 800
        bool = false
    end
    return bool
end



function verif_type2(x,y)
    bool = true   
    a, b = fct(800,800,-6,300)
    if x < 800
        bool = false
    end
    a, b = fct(1000,800,300,300)
    if y - a*x - b > 0
        bool = false
    end

    return bool
end

    
function verif_type1(x,y)
    bool = true   
    a, b = fct(100,50,100,300)
    if y - a*x - b < 0
        bool = false
    end
    a, b = fct(100,150,100,50)
    if y - a*x - b < 0
        bool = false
    end
    a, b = fct(300,150,50,50)
    if y - a*x - b < 0
        bool = false
    end
    a, b = fct(300,400,50,250)
    if y - a*x - b < 0
        bool = false
    end
    a, b = fct(250,400,350,250)
    if y - a*x - b > 0
        bool = false
    end
    a, b = fct(250,50,350,300)
    if y - a*x - b > 0
        bool = false
    end
    return bool
end


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


function main_bis()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    axis("off")
    ax.grid(false)
    #ax.view_init(elev=13, azim=-17) 
    #ax.dist = 10
    ax.view_init(elev=15, azim=-13) 
    ax.dist = 5.7
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(-20, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    tight_layout(pad=0)
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
    
    ax.plot([400], [600], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([400, 400], [600, 600], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    plot_seuil(ax,400,600,189,"yellow")  
    ax.plot([200], [800], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([200, 200], [800, 800], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    plot_seuil(ax,200,800,133,"yellow")  
    ax.plot([800], [400], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([800, 800], [400, 400], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    plot_seuil(ax,800,400,176,"navy")  
    ax.plot([1000], [200], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([1000, 1000], [200, 200], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    plot_seuil(ax,1000,200,109,"lime") 
    ax.plot([400], [900], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([400, 400], [900, 900], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    plot_seuil(ax,400,900,120,"crimson") 
    ax.plot([800], [100], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([800, 800], [100, 100], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    plot_seuil(ax,800,100,170,"lime") 
    ax.plot([800], [700], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([800, 800], [700, 700], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    plot_seuil(ax,800,700,139,"navy") 
    ax.plot([200], [200], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([200, 200], [200, 200], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    plot_seuil(ax,200,200,151,"cyan") 
    ax.plot([1000], [600], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([1000, 1000], [600, 600], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    plot_seuil(ax,1000,600,155,"navy") 
    ax.plot([600], [700], [20], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=14, zorder=25, clip_on=false)
    ax.plot([600, 600], [700, 700], [0, 20], color="black", linestyle="dotted", zorder=19, clip_on=false, linewidth=1)
    plot_seuil(ax,600,700,191,"yellow") 
    
    # base
    plot_base(622, 823)
    ax.plot([622, 600], [823, 700], [0, 20], color="yellow", linestyle="--",  linewidth=1, zorder=14, clip_on=false)   
    
    inst1(ax)
   
    # Infos
    suptitle("Visualisation de la solution",  y=0.95, bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=15)
    ax.text2D(-0.52, 0.82, "Nombre total d'unités couvertes : 919/1000 (91.9 %)", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)
    affichage_nb_unites_non_couvertes = ax.text2D(-0.52, 0.66, "", transform=ax.transAxes, fontsize=12, bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8),  zorder=1000)  
    affichage_nb_images_seconde = ax.text2D(-0.52, 0.90, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)
    affichage_etat_courant = ax.text2D(-0.52, 0.74, "", transform=ax.transAxes, fontsize=12,  bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), zorder=1000)  
    affichage_nb_images_seconde.set_text("Nombre d'images par seconde = 10")
    affichage_etat_courant.set_text("État : 1/100")     
    affichage_nb_unites_non_couvertes.set_text("Nombre d'unités couvertes = 5/10 (50.0 %)")
    
    # Positions
    for x in 0:100:1000
        for y in 0:100:1000
            ax.plot([x], [y], [0], color="#f8961e", marker="s", linestyle="", markersize=2.5, alpha=0.6, zorder=14, clip_on=false) 
            #plot_position_valide(coord.x, coord.y)
        end
    end
    
    # Légende
    ax.plot([], [], [], color="white", marker="^", linestyle="", markersize=10, markeredgecolor="black", label="Unités terrestres")  
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Relais de type 1") 
    ax.plot([], [], [], color="lime", marker="", markersize=10, label="Relais de type 2") 
    ax.plot([], [], [], color="navy", marker="", markersize=10, label="Relais de type 3") 
    ax.plot([], [], [], color="yellow", marker="", markersize=10, label="Relais de type 4") 
    ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Relais de type 5") 
    ax.plot([], [], [], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=20,  label="HAPS")
    ax.plot([], [], [], color="#f8961e", marker="s", linestyle="", markersize=10, label="Déploiement possible")
    ax.plot([], [], [], color="#E4E4DD", marker="s", markeredgecolor="#6b705c", linestyle="", markersize=15, label="Base") 
    ax.legend(loc="upper left", bbox_to_anchor=(1, 0.95), fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function inst3(ax)
    ax.plot([320], [40], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(320,40)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    
    ax.plot([150], [460], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(150,460)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)    
    
    ax.plot([980], [40], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(980,40)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
    
    ax.plot([940], [820], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(940,820)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
    
    ax.plot([200], [960], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(200,960)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
    
    ax.plot([820], [470], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(820,470)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
    ax.plot([820, 800], [470, 400], [0, 20], color="navy", linestyle="--",  linewidth=1, zorder=19, clip_on=false)   
    
    
    ax.plot([870], [660], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(870,660)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
    ax.plot([870, 1000], [660, 600], [0, 20], color="navy", linestyle="--",  linewidth=1, zorder=19, clip_on=false) 
    ax.plot([870, 800], [660, 700], [0, 20], color="navy", linestyle="--",  linewidth=1, zorder=19, clip_on=false)   
    
    ax.plot([380], [790], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(380,790)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
    ax.plot([380, 400], [790, 900], [0, 20], color="crimson", linestyle="--",  linewidth=1, zorder=19, clip_on=false) 
    ax.plot([380, 400], [790, 600], [0, 20], color="yellow", linestyle="--",  linewidth=1, zorder=19, clip_on=false)
    
    ax.plot([350], [710], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(350,710)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
    ax.plot([350, 400], [710, 600], [0, 20], color="yellow", linestyle="--",  linewidth=1, zorder=19, clip_on=false) 
    
    ax.plot([120], [750], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(120,750)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false) 
    ax.plot([120, 200], [750, 800], [0, 20], color="yellow", linestyle="--",  linewidth=1, zorder=19, clip_on=false) 
end

function inst2(ax)   
    ax.plot([230], [170], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(230,170)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([230, 200], [170, 200], [0, 20], color="cyan", linestyle="--",  linewidth=1, zorder=19, clip_on=false)   
    
    ax.plot([140], [250], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(140,250)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([140, 200], [250, 200], [0, 20], color="cyan", linestyle="--",  linewidth=1, zorder=19, clip_on=false) 
        
    ax.plot([100], [150], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(100,150)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([100, 200], [150, 200], [0, 20], color="cyan", linestyle="--",  linewidth=1, zorder=19, clip_on=false) 
  
    
    ax.plot([300], [270], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(300,270)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([300, 200], [270, 200], [0, 20], color="cyan", linestyle="--",  linewidth=1, zorder=19, clip_on=false) 
    
    ax.plot([300], [270], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(300,270)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    
    ax.plot([460], [390], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(460,390)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
  
    ax.plot([555], [920], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(555,920)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    
    ax.plot([760], [140], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(760,140)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    ax.plot([760, 800], [140, 100], [0, 20], color="lime", linestyle="--",  linewidth=1, zorder=19, clip_on=false) 
    
    ax.plot([670], [360], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(670,360)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    ax.plot([670, 800], [360, 400], [0, 20], color="navy", linestyle="--",  linewidth=1, zorder=19, clip_on=false) 
    
    ax.plot([950], [400], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(950,400)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    ax.plot([950, 800], [400, 400], [0, 20], color="navy", linestyle="--",  linewidth=1, zorder=19, clip_on=false)     
    
    ax.plot([360], [540], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(360,540)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)
    ax.plot([360, 400], [540, 600], [0, 20], color="yellow", linestyle="--",  linewidth=1, zorder=19, clip_on=false)  
end

function inst1(ax)
    ax.plot([850], [60], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(850,60)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([850, 800], [60, 100], [0, 20], color="lime", linestyle="--",  linewidth=1, zorder=19, clip_on=false)
    
    ax.plot([920], [160], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(920,160)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([920, 1000], [160, 200], [0, 20], color="lime", linestyle="--",  linewidth=1, zorder=19, clip_on=false)    
    ax.plot([920, 800], [160, 100], [0, 20], color="lime", linestyle="--",  linewidth=1, zorder=19, clip_on=false)    
    
    ax.plot([800], [250], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(800,250)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([800, 800], [250, 400], [0, 20], color="navy", linestyle="--",  linewidth=1, zorder=19, clip_on=false)    
    ax.plot([800, 800], [250, 100], [0, 20], color="lime", linestyle="--",  linewidth=1, zorder=19, clip_on=false) 

    ax.plot([700], [460], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(700,460)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([700, 800], [460, 400], [0, 20], color="navy", linestyle="--",  linewidth=1, zorder=19, clip_on=false)    

    ax.plot([700], [460], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(700,460)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([700, 800], [460, 400], [0, 20], color="navy", linestyle="--",  linewidth=1, zorder=19, clip_on=false)  
    

    ax.plot([900], [510], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(900,510)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([900, 800], [510, 400], [0, 20], color="navy", linestyle="--",  linewidth=1, zorder=19, clip_on=false)  
    ax.plot([900, 1000], [510, 600], [0, 20], color="navy", linestyle="--",  linewidth=1, zorder=19, clip_on=false)
    
    ax.plot([740], [700], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(740,700)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([740, 600], [700, 700], [0, 20], color="yellow", linestyle="--",  linewidth=1, zorder=19, clip_on=false)  
    ax.plot([740, 800], [700, 700], [0, 20], color="navy", linestyle="--",  linewidth=1, zorder=19, clip_on=false)   
    
    ax.plot([400], [840], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(740,700)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([400, 400], [840, 900], [0, 20], color="crimson", linestyle="--",  linewidth=1, zorder=19, clip_on=false) 
    
    ax.plot([500], [650], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(500,650)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([500, 400], [650, 600], [0, 20], color="yellow", linestyle="--",  linewidth=1, zorder=19, clip_on=false)   
    ax.plot([500, 600], [650, 700], [0, 20], color="yellow", linestyle="--",  linewidth=1, zorder=19, clip_on=false) 
    
    ax.plot([150], [140], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(500,650)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([150, 200], [140, 200], [0, 20], color="cyan", linestyle="--",  linewidth=1, zorder=19, clip_on=false)   
    
    ax.plot([230], [260], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
    trace = trace_unite(230,260)
    ax.plot([trace[i][1] for i in 1:6], [trace[i][2] for i in 1:6], [0], color="#ffe8d6", marker="", alpha=0.5, zorder=20, linewidth=0.9, clip_on=false)  
    ax.plot([230, 200], [260, 200], [0, 20], color="cyan", linestyle="--",  linewidth=1, zorder=19, clip_on=false) 
end

###### zones dynamiques


function zonesT1(temp)
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    axis("off")
    ax.grid(false)
    #ax.view_init(elev=13, azim=-17) 
    #ax.dist = 10
    ax.view_init(elev=15, azim=-13) 
    ax.dist = 5.7
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(-20, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    tight_layout(pad=0)
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
   
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Demande de type 1") 
    ax.plot([], [], [], color="lime", marker="", markersize=10, label="Demande de type 2") 
    ax.plot([], [], [], color="navy", marker="", markersize=10, label="Demande de type 3") 
    ax.plot([], [], [], color="yellow", marker="", markersize=10, label="Demande de type 4") 
    ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Demande de type 5")  
        
    # Type 1 
    ax.plot([900,700], [800,700], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([400,700], [700,700], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([400,400], [850,700], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([400,600], [850,950], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([800,600], [950,950], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([800,900], [950,800], [0,0], color="cyan", zorder=20, clip_on=false)
 
    # Type 5
    ax.plot([900,300], [200,200], [0,0], color="crimson", zorder=20, clip_on=false)
    ax.plot([200,300], [400,200], [0,0], color="crimson", zorder=20, clip_on=false)    
    ax.plot([200,950], [400,400], [0,0], color="crimson", zorder=20, clip_on=false)    
    ax.plot([900,950], [200,400], [0,0], color="crimson", zorder=20, clip_on=false)    
      
 
    # Type 2 
    ax.plot([600,100], [500,500], [0,0], color="lime", zorder=20, clip_on=false)
    ax.plot([100,100], [900,500], [0,0], color="lime", zorder=20, clip_on=false)    
    ax.plot([100,300], [900,900], [0,0], color="lime", zorder=20, clip_on=false)    
    ax.plot([300,300], [700,900], [0,0], color="lime", zorder=20, clip_on=false)    
    ax.plot([500,300], [600,700], [0,0], color="lime", zorder=20, clip_on=false)    
    ax.plot([500,600], [600,600], [0,0], color="lime", zorder=20, clip_on=false)         
    ax.plot([600,600], [500,600], [0,0], color="lime", zorder=20, clip_on=false)         
           
    for x in 0:40:1000
        for y in 0:40:1000
            if verif_t1D1(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(1 in temp[(x,y)])
                        push!(temp[(x,y)], 1)
                    end
                else
                    temp[(x,y)] = [1]           
                end
            end
            if verif_t5D1(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(5 in temp[(x,y)])
                        push!(temp[(x,y)], 5)
                    end
                else
                    temp[(x,y)] = [5]           
                end
            end
            if verif_t2D1A(x,y) == true || verif_t2D1B(x,y) == true || verif_t2D1C(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(2 in temp[(x,y)])
                        push!(temp[(x,y)], 2)
                    end
                else
                    temp[(x,y)] = [2]           
                end
            end
        end
    end 
    ax.legend(loc="upper left", bbox_to_anchor=(1, 0.95), fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function verif_t2D1C(x,y)
    bool = true   
    if y < 600
        bool = false
    end
    if y > 700
        bool = false
    end
    if x < 100
        bool = false
    end
    a, b = fct(500,300, 600,700)
    if y - a*x - b > 0
        bool = false
    end
    return bool
end


function verif_t2D1B(x,y)
    bool = true   
    if y < 700
        bool = false
    end
    if y > 900
        bool = false
    end
    if x < 100
        bool = false
    end
    if x > 300
        bool = false
    end 
    return bool
end


function verif_t2D1A(x,y)
    bool = true   
    if y < 500
        bool = false
    end
    if y > 600
        bool = false
    end
    if x < 100
        bool = false
    end
    if x > 600
        bool = false
    end 
    return bool
end


function verif_t5D1(x,y)
    bool = true   
    if y < 200
        bool = false
    end
    if y > 400
        bool = false
    end
    a, b = fct(200,300, 400,200)
    if y - a*x - b < 0
        bool = false
    end
    a, b = fct(900,950, 200,400)
    if y - a*x - b < 0
        bool = false
    end
    return bool
end

function verif_t1D1(x,y)
    bool = true   
    if y < 700
        bool = false
    end
    if y > 950
        bool = false
    end
    if x < 400
        bool = false
    end
    a, b = fct(400,600, 850,950)
    if y - a*x - b > 0
        bool = false
    end
    a, b = fct(800,900, 950,800)
    if y - a*x - b > 0
        bool = false
    end
    a, b = fct(900,700, 800,700)
    if y - a*x - b < 0
        bool = false
    end
    return bool
end

function zonesT2(temp)
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    axis("off")
    ax.grid(false)
    #ax.view_init(elev=13, azim=-17) 
    #ax.dist = 10
    ax.view_init(elev=15, azim=-13) 
    ax.dist = 5.7
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(-20, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    tight_layout(pad=0)
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
   
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Demande de type 1") 
    ax.plot([], [], [], color="lime", marker="", markersize=10, label="Demande de type 2") 
    ax.plot([], [], [], color="navy", marker="", markersize=10, label="Demande de type 3") 
    ax.plot([], [], [], color="yellow", marker="", markersize=10, label="Demande de type 4") 
    ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Demande de type 5")  
        
    # Type 1 
    ax.plot([200,700], [700,700], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([200,200], [850,700], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([200,600], [850,950], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([700,600], [700,950], [0,0], color="cyan", zorder=20, clip_on=false)

 
    # Type 5
    ax.plot([900,600], [200,200], [0,0], color="crimson", zorder=20, clip_on=false)
    ax.plot([600,700], [200,400], [0,0], color="crimson", zorder=20, clip_on=false)    
    ax.plot([700,950], [400,400], [0,0], color="crimson", zorder=20, clip_on=false)    
    ax.plot([900,950], [200,400], [0,0], color="crimson", zorder=20, clip_on=false)    
      
 
    # Type 4
    ax.plot([400,600], [100,400], [0,0], color="yellow", zorder=20, clip_on=false)
    ax.plot([400,200], [100,100], [0,0], color="yellow", zorder=20, clip_on=false)   
    ax.plot([200, 100], [100,300], [0,0], color="yellow", zorder=20, clip_on=false)    
    ax.plot([100, 100], [300,400], [0,0], color="yellow", zorder=20, clip_on=false)    
    ax.plot([600, 100], [400,400], [0,0], color="yellow", zorder=20, clip_on=false)       
     
    # Type 2 
    ax.plot([100,100], [900,600], [0,0], color="lime", zorder=20, clip_on=false)    
    ax.plot([100,300], [900,900], [0,0], color="lime", zorder=20, clip_on=false)    
    ax.plot([300,300], [700,900], [0,0], color="lime", zorder=20, clip_on=false)    
    ax.plot([100,300], [600, 700], [0,0], color="lime", zorder=20, clip_on=false)    

    for x in 0:40:1000
        for y in 0:40:1000
            if verif_t1D2(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(1 in temp[(x,y)])
                        push!(temp[(x,y)], 1)
                    end
                else
                    temp[(x,y)] = [1]           
                end
            end
            if verif_t2D2(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(2 in temp[(x,y)])
                        push!(temp[(x,y)], 2)
                    end
                else
                    temp[(x,y)] = [2]           
                end
            end  
            if verif_t4D2(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(4 in temp[(x,y)])
                        push!(temp[(x,y)], 4)
                    end
                else
                    temp[(x,y)] = [4]           
                end
            end 
            if verif_t5D2(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(5 in temp[(x,y)])
                        push!(temp[(x,y)], 5)
                    end
                else
                    temp[(x,y)] = [5]           
                end
            end               
        end
    end

    ax.legend(loc="upper left", bbox_to_anchor=(1, 0.95), fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function verif_t5D2(x,y)
    bool = true   
    if y < 200
        bool = false
    end
    if y > 400
        bool = false
    end
    if x < 100
        bool = false
    end
    a, b = fct(600,700, 200,400)
    if y - a*x - b > 0
        bool = false
    end  
    a, b = fct(900,950, 200,400)
    if y - a*x - b < 0
        bool = false
    end  
    return bool
end


function verif_t4D2(x,y)
    bool = true   
    if y < 100
        bool = false
    end
    if y > 400
        bool = false
    end
    if x < 100
        bool = false
    end
    a, b = fct(400,600, 100,400)
    if y - a*x - b < 0
        bool = false
    end  
    a, b = fct(200, 100, 100,300)
    if y - a*x - b < 0
        bool = false
    end  
    return bool
end


function verif_t2D2(x,y)
    bool = true   
    if y > 900
        bool = false
    end
    if x < 100
        bool = false
    end
    if x > 300
        bool = false
    end
    a, b = fct(100,300, 600, 700)
    if y - a*x - b < 0
        bool = false
    end  
    return bool
end


function verif_t1D2(x,y)
    bool = true   
    if y < 700
        bool = false
    end
    if x < 200
        bool = false
    end
    a, b = fct(200,600, 850,950)
    if y - a*x - b > 0
        bool = false
    end
    a, b = fct(700,600, 700,950)
    if y - a*x - b > 0
        bool = false
    end   
    return bool
end


function zonesT3(temp)
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    axis("off")
    ax.grid(false)
    #ax.view_init(elev=13, azim=-17) 
    #ax.dist = 10
    ax.view_init(elev=15, azim=-13) 
    ax.dist = 5.7
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(-20, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    tight_layout(pad=0)
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
   
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Demande de type 1") 
    ax.plot([], [], [], color="lime", marker="", markersize=10, label="Demande de type 2") 
    ax.plot([], [], [], color="navy", marker="", markersize=10, label="Demande de type 3") 
    ax.plot([], [], [], color="yellow", marker="", markersize=10, label="Demande de type 4") 
    ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Demande de type 5")  
        
 
    # Type 4 et 5  
    #ax.plot([900,950], [200,400], [0,0], color="crimson", zorder=20, clip_on=false)    
    vect = [900 - 950, 200 - 400, 0]    
    point_1 = [950, 400, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="red",  linewidth=1, zorder=18, clip_on=false) 
    #ax.plot([200, 100], [100,300], [0,0], color="yellow", zorder=20, clip_on=false)
    vect = [200 - 100, 100 - 300, 0]    
    point_1 = [100, 300, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="red",  linewidth=1, zorder=18, clip_on=false)           
    #ax.plot([100, 100], [300,400], [0,0], color="yellow", zorder=20, clip_on=false) 
    vect = [100 - 100, 400 - 300, 0]    
    point_1 = [100, 300, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="red", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow",  linewidth=1, zorder=18, clip_on=false)       
    #ax.plot([100, 950], [400,400], [0,0], color="yellow", zorder=20, clip_on=false)
    vect = [100 - 950, 400 - 400, 0]    
    point_1 = [950, 400, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="red",  linewidth=1, zorder=18, clip_on=false)         
    #ax.plot([200, 900], [100,200], [0,0], color="yellow", zorder=20, clip_on=false) 
    vect = [200 - 900, 100 - 200, 0]    
    point_1 = [900, 200, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="red",  linewidth=1, zorder=18, clip_on=false)         
         
    # Type 1 et 2 
    #ax.plot([100,100], [900,600], [0,0], color="lime", zorder=20, clip_on=false) 
    vect = [100 - 100, 900 - 600, 0]    
    point_1 = [100, 600, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="cyan", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="lime",  linewidth=1, zorder=18, clip_on=false)        
    #ax.plot([700,100], [700,600], [0,0], color="lime", zorder=20, clip_on=false) 
    vect = [700 - 100, 700 - 600, 0]    
    point_1 = [100, 600, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="lime", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="cyan",  linewidth=1, zorder=18, clip_on=false)    
    #ax.plot([700,600], [700,950], [0,0], color="cyan", zorder=20, clip_on=false)
    vect = [700 - 600, 700 - 950, 0]    
    point_1 = [600, 950, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="lime", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="cyan",  linewidth=1, zorder=18, clip_on=false)    
    #ax.plot([100,600], [900,950], [0,0], color="cyan", zorder=20, clip_on=false)
    vect = [100 - 600, 900 - 950, 0]    
    point_1 = [600, 950, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="cyan", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="lime",  linewidth=1, zorder=18, clip_on=false) 
    
    # Type 3
    ax.plot([200,200], [450,580], [0,0], color="navy", zorder=20, clip_on=false)       
    ax.plot([200,950], [450,450], [0,0], color="navy", zorder=20, clip_on=false)       
    ax.plot([950,950], [900,450], [0,0], color="navy", zorder=20, clip_on=false)     
    ax.plot([950,700], [900,800], [0,0], color="navy", zorder=20, clip_on=false)         
    ax.plot([950,700], [900,800], [0,0], color="navy", zorder=20, clip_on=false)         
    ax.plot([800,700], [650,800], [0,0], color="navy", zorder=20, clip_on=false)         
    ax.plot([800,200], [650,580], [0,0], color="navy", zorder=20, clip_on=false)         
 
    for x in 0:40:1000
        for y in 0:40:1000
            if verif_t1t2D3(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(1 in temp[(x,y)])
                        push!(temp[(x,y)], 1)
                    end
                    if !(2 in temp[(x,y)])
                        push!(temp[(x,y)], 2)
                    end                   
                else
                    temp[(x,y)] = [1,2]           
                end
            end  
            if verif_t4t5D3(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(4 in temp[(x,y)])
                        push!(temp[(x,y)], 4)
                    end
                    if !(5 in temp[(x,y)])
                        push!(temp[(x,y)], 5)
                    end                   
                else
                    temp[(x,y)] = [4,5]           
                end
            end      
            if verif_t3D3A(x,y) == true || verif_t3D3B(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(3 in temp[(x,y)])
                        push!(temp[(x,y)], 3)
                    end
                else
                    temp[(x,y)] = [3]           
                end
            end                    
        end
    end                                                                 

    ax.legend(loc="upper left", bbox_to_anchor=(1, 0.95), fontsize=15, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function verif_t3D3B(x,y)
    bool = true
    if y < 650
        bool = false
    end
    if x > 950
        bool = false
    end    
    a, b = fct(800,700, 650,800)
    if y - a*x - b < 0
        bool = false
    end 
    a, b = fct(950,700, 900,800)
    if y - a*x - b > 0
        bool = false
    end               
    return bool
end

function verif_t3D3A(x,y)
    bool = true
    if y < 450
        bool = false
    end
    if y > 650
        bool = false
    end
    if x > 950
        bool = false
    end
    if x < 200
        bool = false
    end    
    a, b = fct(800,200, 650,580)
    if y - a*x - b > 0
        bool = false
    end      
    return bool
end

function verif_t4t5D3(x,y)
    bool = true
    if y > 400
        bool = false
    end
    if x < 100
        bool = false
    end
    a, b = fct(900,950, 200,400)
    if y - a*x - b < 0
        bool = false
    end
    a, b = fct(200, 100, 100,300)
    if y - a*x - b < 0
        bool = false
    end 
    a, b = fct(200, 900, 100,200)
    if y - a*x - b < 0
        bool = false
    end         
    return bool
end

function verif_t1t2D3(x,y)
    bool = true
    if x < 100
        bool = false
    end
    a, b = fct(700,100, 700,600)
    if y - a*x - b < 0
        bool = false
    end
    a, b = fct(700,600, 700,950)
    if y - a*x - b > 0
        bool = false
    end  
    a, b = fct(100,600, 900,950)
    if y - a*x - b > 0
        bool = false
    end   
    return bool
end

function final()
    temp = Dict()
    zonesT1(temp)
    zonesT2(temp)
    zonesT3(temp)
    io = open("scenario_1.txt", "w")
    ss = ""
    u = 0
    for (coord, t) in temp
        println(t)
        ss *= "// Déplacements de l'unité terrestre 1 sur un horizon temporel (x_1^t, y_1^t) \n "
        for t in 1:1
            ss *= "($(coord[1]), $(coord[2])),"
        end   
        ss *= "($(coord[1]), $(coord[2])) \n\n"    
        u += 1
    end     
    println(u)
    write(io, ss)
    close(io)                        
end

function temp1()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d")
    axis("off")
    ax.grid(false)
    #ax.view_init(elev=13, azim=-17) 
    #ax.dist = 10
    ax.view_init(elev=15, azim=-13) 
    ax.dist = 5.7
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(-20, 50)
    ax.set_facecolor("#14213d")
    tight_layout(pad=0)
    fig.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    tight_layout(pad=0)
    generation_sol(ax)
    generation_ciel(ax)
    generation_etoiles(ax)
   
    ax.plot([], [], [], color="cyan", marker="", markersize=10, label="Demande de type 1") 
    ax.plot([], [], [], color="lime", marker="", markersize=10, label="Demande de type 2") 
    ax.plot([], [], [], color="navy", marker="", markersize=10, label="Demande de type 3") 
    ax.plot([], [], [], color="yellow", marker="", markersize=10, label="Demande de type 4") 
    ax.plot([], [], [], color="crimson", marker="", markersize=10, label="Demande de type 5")  
        
    # Type 1 
    ax.plot([200,700], [700,700], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([200,200], [850,700], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([200,600], [850,950], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([700,600], [700,950], [0,0], color="cyan", zorder=20, clip_on=false)

 
    # Type 5
    ax.plot([900,600], [200,200], [0,0], color="crimson", zorder=20, clip_on=false)
    ax.plot([600,700], [200,400], [0,0], color="crimson", zorder=20, clip_on=false)    
    ax.plot([700,950], [400,400], [0,0], color="crimson", zorder=20, clip_on=false)    
    ax.plot([900,950], [200,400], [0,0], color="crimson", zorder=20, clip_on=false)    
      
 
    # Type 4
    ax.plot([400,600], [100,400], [0,0], color="yellow", zorder=20, clip_on=false)
    ax.plot([400,200], [100,100], [0,0], color="yellow", zorder=20, clip_on=false)   
    ax.plot([200, 100], [100,300], [0,0], color="yellow", zorder=20, clip_on=false)    
    ax.plot([100, 100], [300,400], [0,0], color="yellow", zorder=20, clip_on=false)    
    ax.plot([600, 100], [400,400], [0,0], color="yellow", zorder=20, clip_on=false)       
     
    # Type 2 
    ax.plot([100,100], [900,600], [0,0], color="lime", zorder=20, clip_on=false)    
    ax.plot([100,300], [900,900], [0,0], color="lime", zorder=20, clip_on=false)    
    ax.plot([300,300], [700,900], [0,0], color="lime", zorder=20, clip_on=false)    
    ax.plot([100,300], [600, 700], [0,0], color="lime", zorder=20, clip_on=false)    

   # Type 1 
    ax.plot([900,700], [800,700], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([400,700], [700,700], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([400,400], [850,700], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([400,600], [850,950], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([800,600], [950,950], [0,0], color="cyan", zorder=20, clip_on=false)
    ax.plot([800,900], [950,800], [0,0], color="cyan", zorder=20, clip_on=false)
 
    # Type 5
    ax.plot([900,300], [200,200], [0,0], color="crimson", zorder=20, clip_on=false)
    ax.plot([200,300], [400,200], [0,0], color="crimson", zorder=20, clip_on=false)    
    ax.plot([200,950], [400,400], [0,0], color="crimson", zorder=20, clip_on=false)    
    ax.plot([900,950], [200,400], [0,0], color="crimson", zorder=20, clip_on=false)    
      
 
    # Type 2 
    ax.plot([600,100], [500,500], [0,0], color="lime", zorder=20, clip_on=false)
    ax.plot([100,100], [900,500], [0,0], color="lime", zorder=20, clip_on=false)    
    ax.plot([100,300], [900,900], [0,0], color="lime", zorder=20, clip_on=false)    
    ax.plot([300,300], [700,900], [0,0], color="lime", zorder=20, clip_on=false)    
    ax.plot([500,300], [600,700], [0,0], color="lime", zorder=20, clip_on=false)    
    ax.plot([500,600], [600,600], [0,0], color="lime", zorder=20, clip_on=false)         
    ax.plot([600,600], [500,600], [0,0], color="lime", zorder=20, clip_on=false)         
        
           
    # Type 4 et 5  
    #ax.plot([900,950], [200,400], [0,0], color="crimson", zorder=20, clip_on=false)    
    vect = [900 - 950, 200 - 400, 0]    
    point_1 = [950, 400, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="red",  linewidth=1, zorder=18, clip_on=false) 
    #ax.plot([200, 100], [100,300], [0,0], color="yellow", zorder=20, clip_on=false)
    vect = [200 - 100, 100 - 300, 0]    
    point_1 = [100, 300, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="red",  linewidth=1, zorder=18, clip_on=false)           
    #ax.plot([100, 100], [300,400], [0,0], color="yellow", zorder=20, clip_on=false) 
    vect = [100 - 100, 400 - 300, 0]    
    point_1 = [100, 300, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="red", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow",  linewidth=1, zorder=18, clip_on=false)       
    #ax.plot([100, 950], [400,400], [0,0], color="yellow", zorder=20, clip_on=false)
    vect = [100 - 950, 400 - 400, 0]    
    point_1 = [950, 400, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="red",  linewidth=1, zorder=18, clip_on=false)         
    #ax.plot([200, 900], [100,200], [0,0], color="yellow", zorder=20, clip_on=false) 
    vect = [200 - 900, 100 - 200, 0]    
    point_1 = [900, 200, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="yellow", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="red",  linewidth=1, zorder=18, clip_on=false)         
         
    # Type 1 et 2 
    #ax.plot([100,100], [900,600], [0,0], color="lime", zorder=20, clip_on=false) 
    vect = [100 - 100, 900 - 600, 0]    
    point_1 = [100, 600, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="cyan", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="lime",  linewidth=1, zorder=18, clip_on=false)        
    #ax.plot([700,100], [700,600], [0,0], color="lime", zorder=20, clip_on=false) 
    vect = [700 - 100, 700 - 600, 0]    
    point_1 = [100, 600, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="lime", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="cyan",  linewidth=1, zorder=18, clip_on=false)    
    #ax.plot([700,600], [700,950], [0,0], color="cyan", zorder=20, clip_on=false)
    vect = [700 - 600, 700 - 950, 0]    
    point_1 = [600, 950, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="lime", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="cyan",  linewidth=1, zorder=18, clip_on=false)    
    #ax.plot([100,600], [900,950], [0,0], color="cyan", zorder=20, clip_on=false)
    vect = [100 - 600, 900 - 950, 0]    
    point_1 = [600, 950, 0]
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="cyan", linewidth=1, zorder=18, clip_on=false) 
    point_1 = point_2  
    point_2 = point_1 .+ (1/2) .* vect
    ax.plot([point_1[1], point_2[1]], [point_1[2], point_2[2]], [point_1[3], point_2[3]], color="lime",  linewidth=1, zorder=18, clip_on=false) 
    
    # Type 3
    ax.plot([200,200], [450,580], [0,0], color="navy", zorder=20, clip_on=false)       
    ax.plot([200,950], [450,450], [0,0], color="navy", zorder=20, clip_on=false)       
    ax.plot([950,950], [900,450], [0,0], color="navy", zorder=20, clip_on=false)     
    ax.plot([950,700], [900,800], [0,0], color="navy", zorder=20, clip_on=false)         
    ax.plot([950,700], [900,800], [0,0], color="navy", zorder=20, clip_on=false)         
    ax.plot([800,700], [650,800], [0,0], color="navy", zorder=20, clip_on=false)         
    ax.plot([800,200], [650,580], [0,0], color="navy", zorder=20, clip_on=false) 
    
    temp = Dict()
    for x in 0:40:1000
        for y in 0:40:1000
            if verif_t1D1(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(1 in temp[(x,y)])
                        push!(temp[(x,y)], 1)
                    end
                else
                    temp[(x,y)] = [1]           
                end
            end
            if verif_t5D1(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(5 in temp[(x,y)])
                        push!(temp[(x,y)], 5)
                    end
                else
                    temp[(x,y)] = [5]           
                end
            end
            if verif_t2D1A(x,y) == true || verif_t2D1B(x,y) == true || verif_t2D1C(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(2 in temp[(x,y)])
                        push!(temp[(x,y)], 2)
                    end
                else
                    temp[(x,y)] = [2]           
                end
            end
        end
    end     
    for x in 0:40:1000
        for y in 0:40:1000
            if verif_t1t2D3(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(1 in temp[(x,y)])
                        push!(temp[(x,y)], 1)
                    end
                    if !(2 in temp[(x,y)])
                        push!(temp[(x,y)], 2)
                    end                   
                else
                    temp[(x,y)] = [1,2]           
                end
            end  
            if verif_t4t5D3(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(4 in temp[(x,y)])
                        push!(temp[(x,y)], 4)
                    end
                    if !(5 in temp[(x,y)])
                        push!(temp[(x,y)], 5)
                    end                   
                else
                    temp[(x,y)] = [4,5]           
                end
            end      
            if verif_t3D3A(x,y) == true || verif_t3D3B(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(3 in temp[(x,y)])
                        push!(temp[(x,y)], 3)
                    end
                else
                    temp[(x,y)] = [3]           
                end
            end                    
        end
    end                                                                 

    for x in 0:40:1000
        for y in 0:40:1000
            if verif_t1D2(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(1 in temp[(x,y)])
                        push!(temp[(x,y)], 1)
                    end
                else
                    temp[(x,y)] = [1]           
                end
            end
            if verif_t2D2(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(2 in temp[(x,y)])
                        push!(temp[(x,y)], 2)
                    end
                else
                    temp[(x,y)] = [2]           
                end
            end  
            if verif_t4D2(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(4 in temp[(x,y)])
                        push!(temp[(x,y)], 4)
                    end
                else
                    temp[(x,y)] = [4]           
                end
            end 
            if verif_t5D2(x,y) == true
                ax.plot([x], [y], [0], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=7, alpha=1.0, linestyle="", zorder=21, clip_on=false)
                if haskey(temp, (x,y))
                    if !(5 in temp[(x,y)])
                        push!(temp[(x,y)], 5)
                    end
                else
                    temp[(x,y)] = [5]           
                end
            end               
        end
    end

end


temp1()

