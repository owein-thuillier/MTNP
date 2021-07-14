using PyPlot
using Random

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
    z = rand([-1000:400;], 800)
    for g in 0:15
        ax.plot(x[1+50*g:50*(g+1)], y[1+50*g:50*(g+1)], z[1+50*g:50*(g+1)], color="white", marker=".", linestyle="", alpha=rand([0.4:0.1:1;]), markersize=alpha=rand([0.5:0.1:1;]), zorder=0, clip_on=false)       
    end

    # Fond 2
    x = rand([000:2000;], 800)
    y = rand([2000:2000;], 800)
    z = rand([-1000:400;], 800)
    for g in 0:15
        ax.plot(x[1+50*g:50*(g+1)], y[1+50*g:50*(g+1)], z[1+50*g:50*(g+1)], color="white", marker=".", linestyle="", alpha=rand([0.4:0.1:1;]), markersize=alpha=rand([0.5:0.1:1;]), zorder=0, clip_on=false)       
    end

    # Soleil
    #ax.plot([-800], [00], [70], color="#a10702", marker="o", markersize=105, linestyle="", alpha=0.5, zorder=-1)
    #ax.plot([-800], [00], [70], color="#ff6600", marker="o", markersize=100, linestyle="", alpha=1, zorder=0)
end

function terre(ax)
    # globe
    r1 = 50
    r2 = 80
    THETA = range(-pi, pi, length=20) # longitude
    PHI = range(-pi/2, pi/2, length=20) # latitude
    x = [r1 * cos(theta) * cos(phi) + 500 for theta in THETA, phi in PHI]
    y = [r1 * sin(theta) * cos(phi) + 500 for theta in THETA, phi in PHI]
    z = [r2 * sin(phi) + 50 for theta in THETA, phi in PHI]
    plot_surface(x, y, z, color="#40916c", edgecolor="white", shade=false, linewidth=0.2, alpha=0.5, clip_on=false)


    # noyau
    plot([500], [500], [50], color="white", linestyle="", marker="o", markeredgecolor="black", markersize=15, zorder=-4, label="Centre de la Terre", clip_on=false)
end

function main()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d") 
    ax.margins(0)
    ax.view_init(elev=17, azim=48)
    ax.dist = 7
    fig.set_facecolor("#14213d")
    ax.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    xlim(450, 550)
    ylim(450, 550)
    zlim(0, 115)
    tight_layout(pad=0)

    generation_etoiles(ax) 
    terre(ax)

    # Unité
    #ax.plot([xUnite], [yUnite], [zUnite], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false, label=L"Une unité $u \in \mathcal{U}$  à un instant $t \in \mathcal{T}$")
    xUnite = 50 * sin(1.49) * cos(0) + 500
    yUnite = 50 * sin(1.49) * sin(0) + 500
    zUnite = 80 * cos(1.49) + 50
    plot([xUnite], [yUnite], [zUnite], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false, label=L"Une unité $u \in \mathcal{U}$  à un instant $t \in \mathcal{T}$")

    # Trait centre/HAPS
    xHAPS = 50 * sin(0.66) * cos(0) + 500
    yHAPS = 50 * sin(0.66) * sin(0) + 500
    zHAPS = 80 * cos(0.66) + 50
    a = xHAPS - 500 
    b = yHAPS - 500
    c = zHAPS - 50
    ax.plot([500, 500 + a], [500, 500 + b], [50, 50 + c], color="gold", zorder=-5, clip_on=false) 
    ax.plot([500 + a, 500 + 1.4*a], [500 + b, 500 + 1.4*b], [50 + c, 50 + 1.4*c], color="lime", clip_on=false, zorder=5)

    # Trait centre/unité
    ax.plot([500, xUnite], [500, yUnite], [50, zUnite], color="gold", zorder=-5, clip_on=false) 

    # HAPS
    ax.plot([500 + 1.4*a], [500 + 1.4*b], [50 + 1.4*c], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=20, zorder=25, clip_on=false, label=L"Un HAPS $h \in \mathcal{H}$ déployé sur une position $e \in \mathcal{E}$")

    # Distance unité/HAPS
    #ax.plot([xUnite, 500 + a], [yUnite, 500 + b], [zUnite, 50 + c], color="red",  linestyle="dotted", alpha=0.5)
    ax.plot([xUnite, 500 + 1.4*a], [yUnite, 500 + 1.4*b], [zUnite, 50 + 1.4*c], color="cyan", clip_on=false, zorder=5)

    # Angle
    X = []; Y = []; Z = []
    for phi in 0.67:0.01:1.48
        xTemp = 50 * sin(phi) * cos(0) + 500
        yTemp = 50 * sin(phi) * sin(0) + 500
        zTemp = 80 * cos(phi) + 50
        a = xTemp - 500 
        b = yTemp - 500
        c = zTemp - 50
        ax.plot([500, 500 + 0.2*a], [500, 500 + 0.2*b], [50, 50 + 0.2*c], color="pink", zorder=-5, clip_on=false) 
        push!(X, 500 + a)
        push!(Y, 500 + b)
        push!(Z, 50 + c)
        #ax.plot([500 + a], [500 + b], [50 + c], color="red", marker=".", markersize=1, zorder=3, clip_on=false) 
    end
    ax.plot(X, Y, Z, color="red", zorder=3, clip_on=false) 
    
    # Repère
    plot([500, 500], [500, 500], [50, -30], color="white", zorder=-4, clip_on=false)
    plot([500, 500], [500, 500], [140, 50], color="white", zorder=-4, clip_on=false, marker="^", markevery=2, markersize=6)   
    xTemp = 50 * sin(pi/2) * cos(10) + 500
    yTemp = 50 * sin(pi/2) * sin(10) + 500
    zTemp = 80 * cos(pi/2) + 50
    a = xTemp - 500 
    b = yTemp - 500
    c = zTemp - 50
    ax.plot([500, 500 + 1*a], [500, 500 + 1*b], [50, 50 + 1*c], color="white", zorder=-4, clip_on=false)        
    ax.plot([500, 500 - 1*a], [500, 500 - 1*b], [50, 50 - 1*c], color="white", zorder=-4, clip_on=false)     
    ax.plot([500 - 1.25*a, 500 - 1*a], [500 - 1.25*b, 500 - 1*b], [50 - 1.25*c, 50 - 1*c], color="white", zorder=4, clip_on=false, marker=">", markevery=2, markersize=6)     
        
    aBis = 1
    bBis = (-(aBis*a))/b 
    norme = sqrt(aBis^2 + bBis^2)
    aBis = aBis / norme
    bBis = bBis / norme
    ax.plot([500, 500 + 50*aBis], [500, 500 + 50*bBis], [50, 50], color="white", zorder=-4, clip_on=false)        
    ax.plot([500, 500 - 50*aBis], [500, 500 - 50*bBis], [50, 50], color="white", zorder=-4, clip_on=false)   
    ax.plot([500 - 60*aBis, 500 - 50*aBis], [500 - 60*bBis, 500 - 50*bBis], [50, 50], color="white", zorder=-4, clip_on=false, marker=">", markevery=2, markersize=6)   
                        
    # Légende 
    ax.legend(loc="upper left", bbox_to_anchor=(0.45, 0.9), fontsize=16, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
end

function main_bis()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d") 
    ax.margins(0)
    ax.view_init(elev=17, azim=48)
    ax.dist = 7
    fig.set_facecolor("#14213d")
    ax.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    xlim(450, 550)
    ylim(450, 550)
    zlim(0, 115)
    tight_layout(pad=0)

    generation_etoiles(ax) 
    terre(ax)
    
    # Point
    #ax.plot([xUnite], [yUnite], [zUnite], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false, label=L"Une unité $u \in \mathcal{U}$  à un instant $t \in \mathcal{T}$")
    x = 50 * cos(1.485) * cos(1.074) + 500 
    y = 50 * sin(1.485) * cos(1.074) + 500
    z = 80 * sin(1.074) + 50
    plot([x], [y], [z], color="#ffe8d6", marker=".", markeredgecolor="black", markersize=15, alpha=1.0, linestyle="", zorder=21, clip_on=false, label=L"Une unité $u \in \mathcal{U}$  à un instant $t \in \mathcal{T}$")
    # Trait centre/point
    ax.plot([500, x], [500, y], [50, z], color="gold", zorder=-4, clip_on=false) 
    
    # Point projeté
    #ax.plot([xUnite], [yUnite], [zUnite], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false, label=L"Une unité $u \in \mathcal{U}$  à un instant $t \in \mathcal{T}$")
    x = 50 * cos(1.485) * cos(0) + 500 
    y = 50 * sin(1.485) * cos(0) + 500
    z = 80 * sin(0)+ 50
    #plot([x], [y], [z], color="#ffe8d6", marker=".", markeredgecolor="black", markersize=15, alpha=1.0, linestyle="", zorder=21, clip_on=false, label=L"Une unité $u \in \mathcal{U}$  à un instant $t \in \mathcal{T}$")
    # Trait centre/point
    ax.plot([500, x], [500, y], [50, z], color="gold", zorder=-4, clip_on=false) 
    

    
    # Angle vers haut (bleu) ou (vert)
    X = []; Y = []; Z = []
    for phi in 0:0.01:1.074
    #for phi in 1.074:0.01:pi/2
        xTemp = 50 * cos(1.485) * cos(phi) + 500 
        yTemp = 50 * sin(1.485) * cos(phi) + 500
        zTemp = 80 * sin(phi) + 50
        a = xTemp - 500 
        b = yTemp - 500
        c = zTemp - 50
        ax.plot([500, 500 + 1*a], [500, 500 + 1*b], [50, 50 + 1*c], color="blue", zorder=-5, clip_on=false) 
        push!(X, 500 + a)
        push!(Y, 500 + b)
        push!(Z, 50 + c)
        #ax.plot([500 + a], [500 + b], [50 + c], color="red", marker=".", markersize=1, zorder=3, clip_on=false) 
    end
    
    # Angle vers droite (rouge)
    X = []; Y = []; Z = []
    for theta in 0.58:0.01:1.485
        xTemp = 50 * cos(theta) * cos(0) + 500 
        yTemp = 50 * sin(theta) * cos(0) + 500
        zTemp = 80 * sin(0) + 50
        a = xTemp - 500 
        b = yTemp - 500
        c = zTemp - 50
        ax.plot([500, 500 + 1*a], [500, 500 + 1*b], [50, 50 + 1*c], color="red", zorder=-5, clip_on=false) 
        push!(X, 500 + a)
        push!(Y, 500 + b)
        push!(Z, 50 + c)
        #ax.plot([500 + a], [500 + b], [50 + c], color="red", marker=".", markersize=1, zorder=3, clip_on=false) 
    end


    # Repère
    plot([500, 500], [500, 500], [50, -30], color="white", zorder=-4, clip_on=false)
    plot([500, 500], [500, 500], [140, 50], color="white", zorder=-4, clip_on=false, marker="^", markevery=2, markersize=6)   
    xTemp = 50 * sin(pi/2) * cos(10) + 500
    yTemp = 50 * sin(pi/2) * sin(10) + 500
    zTemp = 80 * cos(pi/2) + 50
    a = xTemp - 500 
    b = yTemp - 500
    c = zTemp - 50
    ax.plot([500, 500 + 1*a], [500, 500 + 1*b], [50, 50 + 1*c], color="white", zorder=-4, clip_on=false)        
    ax.plot([500, 500 - 1*a], [500, 500 - 1*b], [50, 50 - 1*c], color="white", zorder=-4, clip_on=false)     
    ax.plot([500 - 1.25*a, 500 - 1*a], [500 - 1.25*b, 500 - 1*b], [50 - 1.25*c, 50 - 1*c], color="white", zorder=4, clip_on=false, marker=">", markevery=2, markersize=6)     
        
    aBis = 1
    bBis = (-(aBis*a))/b 
    norme = sqrt(aBis^2 + bBis^2)
    aBis = aBis / norme
    bBis = bBis / norme
    ax.plot([500, 500 + 50*aBis], [500, 500 + 50*bBis], [50, 50], color="white", zorder=-4, clip_on=false)        
    ax.plot([500, 500 - 50*aBis], [500, 500 - 50*bBis], [50, 50], color="white", zorder=-4, clip_on=false)   
    ax.plot([500 - 60*aBis, 500 - 50*aBis], [500 - 60*bBis, 500 - 50*bBis], [50, 50], color="white", zorder=-4, clip_on=false, marker=">", markevery=2, markersize=6)   
end

function terre_ter(ax)
    # globe
    r1 = 50
    r2 = 80
    THETA = range(-pi, pi, length=20) # longitude
    PHI = range(-pi/2, pi/2, length=20) # latitude
    x = [r1 * cos(theta) * cos(phi) + 500 for theta in THETA, phi in PHI]
    y = [r1 * sin(theta) * cos(phi) + 500 for theta in THETA, phi in PHI]
    z = [r2 * sin(phi) + 50 for theta in THETA, phi in PHI]
    plot_surface(x, y, z, color="#40916c", edgecolor="white", shade=false, linewidth=0.2, alpha=0.5, clip_on=false)


    # noyau
    plot([500], [500], [50], color="white", linestyle="", marker="o", markeredgecolor="black", markersize=15, zorder=-4, label="Centre de la Terre", clip_on=false)
end

function main_ter()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d") 
    ax.margins(0)
    ax.view_init(elev=17, azim=48)
    ax.dist = 7
    fig.set_facecolor("#14213d")
    ax.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    xlim(450, 550)
    ylim(450, 550)
    zlim(0, 115)
    tight_layout(pad=0)

    generation_etoiles(ax) 
    terre_ter(ax)
    
    # Méridien
    # Angle vers haut (bleu) ou (vert)
    X = []; Y = []; Z = []
    for phi in -1.2:0.01:1.8
    #for phi in 1.074:0.01:pi/2
        xTemp = 50 * cos(1.485) * cos(phi) + 500 
        yTemp = 50 * sin(1.485) * cos(phi) + 500
        zTemp = 80 * sin(phi) + 50
        a = xTemp - 500 
        b = yTemp - 500
        c = zTemp - 50
        push!(X, 500 + a)
        push!(Y, 500 + b)
        push!(Z, 50 + c)
    end
    ax.plot(X, Y, Z, color="blue", zorder=3, clip_on=false) 
    
    # Angle vers haut (bleu) ou (vert)
    X = []; Y = []; Z = []
    for phi in -pi:0.01:pi
    #for phi in 1.074:0.01:pi/2
        xTemp = 50 * cos(1.485) * cos(phi) + 500 
        yTemp = 50 * sin(1.485) * cos(phi) + 500
        zTemp = 80 * sin(phi) + 50
        a = xTemp - 500 
        b = yTemp - 500
        c = zTemp - 50
        push!(X, 500 + a)
        push!(Y, 500 + b)
        push!(Z, 50 + c)
    end
    ax.plot(X, Y, Z, color="blue", zorder=-3, clip_on=false, label="Méridien") 
    
    
    # Parallèle
    # Angle vers droite (rouge)
    X = []; Y = []; Z = []
    for theta in -0.6:0.01:2.5
        xTemp = 50 * cos(theta) * cos(0) + 500 
        yTemp = 50 * sin(theta) * cos(0) + 500
        zTemp = 80 * sin(0) + 50
        a = xTemp - 500 
        b = yTemp - 500
        c = zTemp - 50
        #ax.plot([500, 500 + 1*a], [500, 500 + 1*b], [50, 50 + 1*c], color="red", zorder=-5, clip_on=false) 
        push!(X, 500 + a)
        push!(Y, 500 + b)
        push!(Z, 50 + c)
    end   
    ax.plot(X, Y, Z, color="red", zorder=3, clip_on=false, label="Parallèle") 
    
    X = []; Y = []; Z = []
    for theta in 2.5:0.01:6
        xTemp = 50 * cos(theta) * cos(0) + 500 
        yTemp = 50 * sin(theta) * cos(0) + 500
        zTemp = 80 * sin(0) + 50
        a = xTemp - 500 
        b = yTemp - 500
        c = zTemp - 50
        #ax.plot([500, 500 + 1*a], [500, 500 + 1*b], [50, 50 + 1*c], color="red", zorder=-5, clip_on=false) 
        push!(X, 500 + a)
        push!(Y, 500 + b)
        push!(Z, 50 + c)
    end   
    ax.plot(X, Y, Z, color="red", zorder=-3, clip_on=false) 
    
    # Repère
    plot([500, 500], [500, 500], [50, -30], color="white", zorder=-4, clip_on=false)
    plot([500, 500], [500, 500], [140, 50], color="white", zorder=-4, clip_on=false, marker="^", markevery=2, markersize=6)   
    xTemp = 50 * sin(pi/2) * cos(10) + 500
    yTemp = 50 * sin(pi/2) * sin(10) + 500
    zTemp = 80 * cos(pi/2) + 50
    a = xTemp - 500 
    b = yTemp - 500
    c = zTemp - 50
    ax.plot([500, 500 + 1*a], [500, 500 + 1*b], [50, 50 + 1*c], color="white", zorder=-4, clip_on=false)        
    ax.plot([500, 500 - 1*a], [500, 500 - 1*b], [50, 50 - 1*c], color="white", zorder=-4, clip_on=false)     
    ax.plot([500 - 1.25*a, 500 - 1*a], [500 - 1.25*b, 500 - 1*b], [50 - 1.25*c, 50 - 1*c], color="white", zorder=4, clip_on=false, marker=">", markevery=2, markersize=6)     
        
    aBis = 1
    bBis = (-(aBis*a))/b 
    norme = sqrt(aBis^2 + bBis^2)
    aBis = aBis / norme
    bBis = bBis / norme
    ax.plot([500, 500 + 50*aBis], [500, 500 + 50*bBis], [50, 50], color="white", zorder=-4, clip_on=false)        
    ax.plot([500, 500 - 50*aBis], [500, 500 - 50*bBis], [50, 50], color="white", zorder=-4, clip_on=false)   
    ax.plot([500 - 60*aBis, 500 - 50*aBis], [500 - 60*bBis, 500 - 50*bBis], [50, 50], color="white", zorder=-4, clip_on=false, marker=">", markevery=2, markersize=6)  
    
        # Légende 
    ax.legend(loc="upper left", bbox_to_anchor=(-0.15, 0.9), fontsize=16, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)  
end

function poub()
    r1 = 50
    r2 = 80
    for theta in range(0.0, 2*pi, length=20)
        for phi in range(0.0, pi, length=20)
            x = r1 * sin(phi) * cos(theta) + 500
            y = r1 * sin(phi) * sin(theta) + 500
            z = r2 * cos(phi) + 50
            println(x, " ", y, " ", z)
            plot([x], [y], [z], color="white", marker=".")
        end
    end
end



####

function generation_etoiles_bis(ax)
    # Seed : chaîne de caractères vers suite d'entiers (conversion via code ASCII) 
    chaine = "abba"
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
    z = rand([-1000:400;], 800)
    for g in 0:15
        ax.plot(x[1+50*g:50*(g+1)], y[1+50*g:50*(g+1)], z[1+50*g:50*(g+1)], color="white", marker=".", linestyle="", alpha=rand([0.4:0.1:1;]), markersize=alpha=rand([0.5:0.1:1;]), zorder=0, clip_on=false)       
    end

    # Fond 2
    x = rand([-1000:2000;], 800)
    y = rand([2000:2000;], 800)
    z = rand([-1000:400;], 800)
    for g in 0:15
        ax.plot(x[1+50*g:50*(g+1)], y[1+50*g:50*(g+1)], z[1+50*g:50*(g+1)], color="white", marker=".", linestyle="", alpha=rand([0.4:0.1:1;]), markersize=alpha=rand([0.5:0.1:1;]), zorder=0, clip_on=false)       
    end

    # Soleil
    #ax.plot([-800], [00], [70], color="#a10702", marker="o", markersize=105, linestyle="", alpha=0.5, zorder=-1)
    #ax.plot([-800], [00], [70], color="#ff6600", marker="o", markersize=100, linestyle="", alpha=1, zorder=0)
end

function to_cartesians()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d") 
    ax.margins(0)
    ax.view_init(elev=13, azim=6)
    ax.dist = 3.5
    fig.set_facecolor("#14213d")
    ax.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    plot([400, 0], [0, 0], [0, 0], color="white", clip_on=false, marker=">", markevery=2, markersize=6)
    plot([0, 0], [400, 0], [0, 0], color="white", clip_on=false, marker=">", markevery=2, markersize=6)
    plot([0, 0], [0, 0], [30, 0], color="white", clip_on=false, marker="^", markevery=2, markersize=6)
    xlim(-200, 400)
    ylim(-200, 400)
    zlim(-20, 50)
    tight_layout(pad=0)
    
    # trait 1
    plot([200, 0], [200, 0], [0, 0], color="red", clip_on=false, marker="o", markevery=2, markersize=6)  
    
        
    # trait 2
    plot([200, 200], [200, 200], [0, 20], color="green", clip_on=false, marker="", markevery=2, markersize=6)   
    
    # trait 3
    plot([200, 0], [200, 0], [20, 0], color="blue", clip_on=false, marker="o", markevery=2, markersize=6)   
    
    # Projection x
    plot([200, 200], [0, 200], [0, 0], color="white", linestyle="dotted", clip_on=false, marker="", markevery=2, markersize=6, zorder=1)  
    
    # Projection z
    plot([200, 0], [200, 0], [20, 20], color="white", linestyle="dotted", clip_on=false, marker="", markevery=2, markersize=6, zorder=1)  
    
    x = []

    generation_etoiles_bis(ax) 
end


function terre_quater(ax)
    # globe
    r1 = 50
    r2 = 80
    THETA = range(-pi, pi, length=40) # longitude
    PHI = range(-pi/2, pi/2, length=40) # latitude
    x = [r1 * cos(theta) * cos(phi) + 500 for theta in THETA, phi in PHI]
    y = [r1 * sin(theta) * cos(phi) + 500 for theta in THETA, phi in PHI]
    z = [r2 * sin(phi) + 50 for theta in THETA, phi in PHI]
    plot_surface(x, y, z, color="#40916c", edgecolor="white", shade=false, linewidth=0.2, alpha=1, clip_on=false)


end


function main_quater()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d") 
    ax.margins(0)
    ax.view_init(elev=17, azim=48)
    ax.dist = 7
    fig.set_facecolor("#14213d")
    ax.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    xlim(450, 550)
    ylim(450, 550)
    zlim(0, 115)
    tight_layout(pad=0)

    generation_etoiles(ax) 
    terre_quater(ax)
   
    # bas droite
    theta = 1.047
    phi = 0.444
    #ax.plot([50 * cos(theta) * cos(phi) + 500 ], [50 * sin(theta) * cos(phi) + 500], [80 * sin(phi) + 50], marker=".", color="red", zorder=3, clip_on=false)   
    
    # bas gauche
    theta = 0.886
    phi = 0.444
    #ax.plot([50 * cos(theta) * cos(phi) + 500 ], [50 * sin(theta) * cos(phi) + 500], [80 * sin(phi) + 50], marker=".", color="red", zorder=3, clip_on=false)  
    
    # haut gauche
    theta = 0.886
    phi = 0.525
    #ax.plot([50 * cos(theta) * cos(phi) + 500 ], [50 * sin(theta) * cos(phi) + 500], [80 * sin(phi) + 50], marker=".", color="red", zorder=3, clip_on=false)   
    
    # haut droite
    theta = 1.047
    phi = 0.525
    #ax.plot([50 * cos(theta) * cos(phi) + 500 ], [50 * sin(theta) * cos(phi) + 500], [80 * sin(phi) + 50], marker=".", color="red", zorder=3, clip_on=false)  
  
    for theta in 0.89:0.001:1.043
        X = []; Y = []; Z = []
        for phi in 0.447:0.001:0.521
            xTemp = 50 * cos(theta) * cos(phi) + 500 
            yTemp = 50 * sin(theta) * cos(phi) + 500
            zTemp = 80 * sin(phi) + 50
            a = xTemp - 500 
            b = yTemp - 500
            c = zTemp - 50
            push!(X, 500 + a)
            push!(Y, 500 + b)
            push!(Z, 50 + c)
        end     
        ax.plot(X, Y, Z, color="red", zorder=3, clip_on=false, alpha=0.1)     
    end
    ax.plot([], [], [], color="red", marker="s", markersize=15, linestyle="", label="Théâtre d'opération n°1")
    
 
     # bas droite
    theta = 0.403
    phi = 0.201
    #ax.plot([50 * cos(theta) * cos(phi) + 500 ], [50 * sin(theta) * cos(phi) + 500], [80 * sin(phi) + 50], marker=".", color="blue", zorder=3, clip_on=false)   
    
    # bas gauche
    theta = 0.241
    phi = 0.201
    #ax.plot([50 * cos(theta) * cos(phi) + 500 ], [50 * sin(theta) * cos(phi) + 500], [80 * sin(phi) + 50], marker=".", color="blue", zorder=3, clip_on=false)  
    
    # haut gauche
    theta = 0.241
    phi = 0.281
    #ax.plot([50 * cos(theta) * cos(phi) + 500 ], [50 * sin(theta) * cos(phi) + 500], [80 * sin(phi) + 50], marker=".", color="blue", zorder=3, clip_on=false)   
    
    # haut droite
    theta = 0.403
    phi = 0.281
    #ax.plot([50 * cos(theta) * cos(phi) + 500 ], [50 * sin(theta) * cos(phi) + 500], [80 * sin(phi) + 50], marker=".", color="blue", zorder=3, clip_on=false)  
 
     for theta in 0.244:0.001:0.400
        X = []; Y = []; Z = []
        for phi in 0.207:0.001:0.278
            xTemp = 50 * cos(theta) * cos(phi) + 500 
            yTemp = 50 * sin(theta) * cos(phi) + 500
            zTemp = 80 * sin(phi) + 50
            a = xTemp - 500 
            b = yTemp - 500
            c = zTemp - 50
            push!(X, 500 + a)
            push!(Y, 500 + b)
            push!(Z, 50 + c)
        end     
        ax.plot(X, Y, Z, color="blue", zorder=3, clip_on=false, alpha=0.1)     
    end
    ax.plot([], [], [], color="blue", marker="s", markersize=15, linestyle="", label="Théâtre d'opération n°2")
   
    # Légende 
    ax.legend(loc="upper left", bbox_to_anchor=(-0.45, 0.9), fontsize=16, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)  
end


function terrain_old()
    x = range(0.0, 1000, length = 20)
    y = range(0.0, 1000, length = 20)
    z = randn(20, 20)
    plot_surface(x, y, z, color="#40916c", edgecolor="white", shade=false, linewidth=0.2)
end

function terrain()
    ion()
    using3D()
    fig = figure("Outil de visualisation")
    ax = fig.add_subplot(111, projection="3d")
    ax.margins(0)
    ax.view_init(elev=-168, azim=-23)
    ax.dist = 5
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(-10, 10)
    fig.set_facecolor("#14213d")
    ax.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    X = ones(21)' .* [0:50:1000;]
    Y = [0:50:1000;]' .* ones(21)
    Z = rand(21,21)
    for i in 1:21
        for j in 1:21
            #d = sqrt((X[i,j] - 500)^2 + (Y[i,j] - 500)^2)
            #Z[i,j] = 10 - d/800    
            d = abs(Y[i,j] - 500)
            Z[i,j] = (X[i,j]^2 + Y[i,j]^2)/400000
        end
    end
    generation_etoiles(ax) 
    plot_surface(X, Y, Z, color="#40916c", edgecolor="white", linewidth=0.2, alpha=1, shade=false, zorder=-5, clip_on=false)
end

################"

function main_cinqter()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d") 
    ax.margins(0)
    ax.view_init(elev=-6, azim=78)
    ax.dist = 5.4
    fig.set_facecolor("#14213d")
    ax.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    xlim(450, 550)
    ylim(450, 550)
    zlim(0, 115)
    tight_layout(pad=0)

    generation_etoiles(ax) 
    terre_quater(ax)
    # Unité
    #ax.plot([xUnite], [yUnite], [zUnite], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=10, alpha=1.0, linestyle="", zorder=21, clip_on=false, label=L"Une unité $u \in \mathcal{U}$  à un instant $t \in \mathcal{T}$")
    xUnite = 50 * sin(1.23) * cos(0) + 500
    yUnite = 50 * sin(1.23) * sin(0) + 500
    zUnite = 80 * cos(1.23) + 50
    plot([xUnite], [yUnite], [zUnite], color="#ffe8d6", marker="^", markeredgecolor="black", markersize=8, alpha=1.0, linestyle="", zorder=21, clip_on=false, label=L"Une unité $u \in \mathcal{U}$  à un instant $t \in \mathcal{T}$")
     # HAPS 1
    xHAPS = 50 * sin(0.66) * cos(0) + 500
    yHAPS = 50 * sin(0.66) * sin(0) + 500
    zHAPS = 80 * cos(0.66) + 50
    a1 = xHAPS - 500 
    b1 = yHAPS - 500
    c1 = zHAPS - 50
    ax.plot([500 + 1.05*a1], [500 + 1.05*b1], [50 + 1.05*c1], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=10, zorder=25, clip_on=false, label=L"Un HAPS $h \in \mathcal{H}$ déployé sur une position $e \in \mathcal{E}$")   
    ax.plot([500 + a1, 500 + 1.05*a1], [500 + b1, 500 + 1.05*b1], [50 + c1, 50 + 1.05*c1], color="lime", clip_on=false, zorder=5)
    
     # HAPS 2
    xHAPS = 50 * sin(0.86) * cos(0) + 500
    yHAPS = 50 * sin(0.86) * sin(0) + 500
    zHAPS = 80 * cos(0.86) + 50
    a2 = xHAPS - 500 
    b2 = yHAPS - 500
    c2 = zHAPS - 50
    ax.plot([500 + 1.05*a2], [500 + 1.05*b2], [50 + 1.05*c2], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=10, zorder=25, clip_on=false, label=L"Un HAPS $h \in \mathcal{H}$ déployé sur une position $e \in \mathcal{E}$")   
    ax.plot([500 + a2, 500 + 1.05*a2], [500 + b2, 500 + 1.05*b2], [50 + c2, 50 + 1.05*c2], color="lime", clip_on=false, zorder=5)
    
     # HAPS 3
    xHAPS = 50 * sin(1.03) * cos(0) + 500
    yHAPS = 50 * sin(1.03) * sin(0) + 500
    zHAPS = 80 * cos(1.03) + 50
    a = xHAPS - 500 
    b = yHAPS - 500
    c = zHAPS - 50
    ax.plot([500 + 1.05*a], [500 + 1.05*b], [50 + 1.05*c], color="#f8961e", marker="o", markeredgecolor="black", linestyle="", markersize=10, zorder=25, clip_on=false, label=L"Un HAPS $h \in \mathcal{H}$ déployé sur une position $e \in \mathcal{E}$")   
    ax.plot([500 + a, 500 + 1.05*a], [500 + b, 500 + 1.05*b], [50 + c, 50 + 1.05*c], color="lime", clip_on=false, zorder=5)
    
    # Liens
    plot([xUnite, 500 + 1.05*a], [yUnite, 500 + 1.05*b], [zUnite, 50 + 1.05*c], color="white", linestyle="dotted", zorder=2, clip_on=false)
    plot([500 + 1.05*a, 500 + 1.05*a2], [500 + 1.05*b, 500 + 1.05*b2], [50 + 1.05*c, 50 + 1.05*c2], color="white", linestyle="dotted", zorder=2, clip_on=false)
    plot([500 + 1.05*a2, 500 + 1.05*a1], [500 + 1.05*b2, 500 + 1.05*b1], [50 + 1.05*c2, 50 + 1.05*c1], color="white", linestyle="dotted", zorder=2, clip_on=false)
    

end

main_cinqter()
