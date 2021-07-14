using PyPlot

function temp(ax)
    ax.plot([50], [50], [100], color="red", marker="o", linestyle="", markersize=10, label="HAPS", zorder=15)
    ax.plot([50, 50], [50, 50], [0, 100], color="black", linestyle="dotted", zorder=10)

    ax.plot([20], [80], [100], color="red", marker="o", linestyle="", markersize=10, zorder=15)
    ax.plot([20, 20], [80, 80], [0, 100], color="black", linestyle="dotted", zorder=10)

    ax.plot([80], [65], [100], color="red", marker="o", linestyle="", markersize=10, zorder=15)
    ax.plot([80, 80], [65, 65], [0, 100], color="black", linestyle="dotted", zorder=10)
end


function demo1()
    fig = figure()
    ax = Axes3D(fig)
    suptitle("Instance didactique (t = 1)", fontsize=15)
    etat_courant = ax.text2D(0.05, 0.85, "", transform=ax.transAxes, fontsize=12)
    xlim(0, 100)
    ylim(0, 100)
    zlim(0, 100)

    # Meshgrid
    xIt = 0:5:100
    yIt = 0:5:100
    x = xIt' .* ones(length(xIt))
    y = ones(length(yIt))' .* yIt
    z = x .* 0
    plot_surface(x, y, z, color="forestgreen", edgecolor="none", alpha=1, shade=false)

    # Fond n°1
    x = [0 100; 0 100]
    y = [100 100; 100 100]
    z = [0 0; 100 100]
    plot_surface(x,y,z, color="deepskyblue", alpha=1, shade=false)

    # Fond n°2
    x = [0 0; 0 0]
    y = [0 100; 0 100]
    z = [0 0; 100 100]
    plot_surface(x,y,z, color="deepskyblue", alpha=1, shade=false)

    # Temps t = 1
    # HAPS (ballon-sonde) 1
    ax.plot([30], [25], [90], color="orange", marker="o", linestyle="", markersize=20, label="HAPS", zorder=15)
    ax.plot([30, 30], [25, 25], [0, 90], color="black", linestyle="dotted", zorder=10)
     
    # HAPS 2
    ax.plot([75], [55], [90], color="orange", marker="o", linestyle="", markersize=20, zorder=15)
    ax.plot([75, 75], [55, 55], [0, 90], color="black", linestyle="dotted", zorder=10)


    # Déploiement possible
    ax.plot([75], [55], [0], color="pink", marker="x", linestyle="", markersize=10)
    ax.plot([70], [80], [0], color="pink", marker="x", linestyle="", markersize=10)
    ax.plot([90], [20], [0], color="pink", marker="x", linestyle="", markersize=10)
    ax.plot([30], [25], [0], color="pink", marker="x", linestyle="", markersize=10, label="Déploiement possible", zorder=9)

    # Communication type 1 haps 1
    theta = range(0, 2 * pi, length=400)
    x = 30 .+ 20*cos.(theta)
    y = 25 .+ 20*sin.(theta)
    ax.plot(x, y, [0 for i in 1:length(x)], color="red", marker=".", linestyle="", zorder=20, label=L"Port$\acute{e}$e communication type 1", markersize=4)

    # Communication type 2 haps 1
    theta = range(0, 2 * pi, length=400)
    x = 30 .+ 10*cos.(theta)
    y = 25 .+ 10*sin.(theta)
    ax.plot(x, y, [0 for i in 1:length(x)], color="blue", marker=".", linestyle="", zorder=20, label=L"Port$\acute{e}$e communication type 2", markersize=4)

    # Communication type 1 haps 2
    theta = range(0, 2 * pi, length=400)
    x = 75 .+ 20*cos.(theta)
    y = 55 .+ 20*sin.(theta)
    ax.plot(x, y, [0 for i in 1:length(x)], color="red", marker=".", linestyle="", zorder=20, markersize=4)



    # Unités type 1
    ax.plot([30], [30], [0], color="red", marker="^", alpha=1.0, linestyle="", zorder=5, label=L"Unités de type 1")
    ax.plot([20], [40], [0], color="red", marker="^", alpha=1.0, linestyle="", zorder=5)
    ax.plot([30, 30], [30,25], [0,90], color="red", linestyle="--",  linewidth=0.6)
    ax.plot([20, 30], [40,25], [0,90], color="red", linestyle="--",  linewidth=0.6)

    # Unités type 2
    ax.plot([35], [25], [0], color="blue", marker="^", alpha=1.0, linestyle="", zorder=5, label=L"Unité de type 2")
    ax.plot([35, 30], [25,25], [0,90], color="blue", linestyle="--",  linewidth=0.6)

    # Directions
    ax.plot([35, 85], [25,25], [0,0], color="black", linestyle="-",  linewidth=0.6, label="Déplacements t+1")
    ax.plot([83, 85], [27,25], [0,0], color="black", linestyle="-",  linewidth=0.6)
    ax.plot([83, 85], [23,25], [0,0], color="black", linestyle="-",  linewidth=0.6)

    ax.plot([30, 70], [30,70], [0,0], color="black", linestyle="-",  linewidth=0.6)
    ax.plot([70, 70], [68,70], [0,0], color="black", linestyle="-",  linewidth=0.6)
    ax.plot([68, 70], [70,70], [0,0], color="black", linestyle="-",  linewidth=0.6)

    ax.plot([20, 65], [40,80], [0,0], color="black", linestyle="-",  linewidth=0.6)
    ax.plot([65, 65], [78,80], [0,0], color="black", linestyle="-",  linewidth=0.6)
    ax.plot([63, 65], [80,80], [0,0], color="black", linestyle="-",  linewidth=0.6)
    
    # Affichage
    legend(loc="best")
    show()
end


function demo2()
    fig = figure()
    ax = Axes3D(fig)
    suptitle("Instance didactique (t = 2)", fontsize=15)
    etat_courant = ax.text2D(0.05, 0.85, "", transform=ax.transAxes, fontsize=12)
    xlim(0, 100)
    ylim(0, 100)
    zlim(0, 100)

    # Meshgrid
    xIt = 0:5:100
    yIt = 0:5:100
    x = xIt' .* ones(length(xIt))
    y = ones(length(yIt))' .* yIt
    z = x .* 0
    plot_surface(x, y, z, color="forestgreen", edgecolor="none", alpha=1, shade=false)

    # Fond n°1
    x = [0 100; 0 100]
    y = [100 100; 100 100]
    z = [0 0; 100 100]
    plot_surface(x,y,z, color="deepskyblue", alpha=1, shade=false)

    # Fond n°2
    x = [0 0; 0 0]
    y = [0 100; 0 100]
    z = [0 0; 100 100]
    plot_surface(x,y,z, color="deepskyblue", alpha=1, shade=false)

    # Temps t = 1
    # HAPS (ballon-sonde) 1
    ax.plot([30], [25], [90], color="orange", marker="o", linestyle="", markersize=20, label="HAPS", zorder=15)
    ax.plot([30, 30], [25, 25], [0, 90], color="black", linestyle="dotted", zorder=10)
     
    # HAPS 2
    ax.plot([75], [55], [90], color="orange", marker="o", linestyle="", markersize=20, zorder=15)
    ax.plot([75, 75], [55, 55], [0, 90], color="black", linestyle="dotted", zorder=10)


    # Déploiement possible
    ax.plot([75], [55], [0], color="pink", marker="x", linestyle="", markersize=10)
    ax.plot([70], [80], [0], color="pink", marker="x", linestyle="", markersize=10)
    ax.plot([90], [20], [0], color="pink", marker="x", linestyle="", markersize=10)
    ax.plot([30], [25], [0], color="pink", marker="x", linestyle="", markersize=10, label="Déploiement possible", zorder=9)

    # Communication type 1 haps 1
    theta = range(0, 2 * pi, length=400)
    x = 30 .+ 20*cos.(theta)
    y = 25 .+ 20*sin.(theta)
    ax.plot(x, y, [0 for i in 1:length(x)], color="red", marker=".", linestyle="", zorder=20, label=L"Port$\acute{e}$e communication type 1", markersize=4)

    # Communication type 2 haps 1
    theta = range(0, 2 * pi, length=400)
    x = 30 .+ 10*cos.(theta)
    y = 25 .+ 10*sin.(theta)
    ax.plot(x, y, [0 for i in 1:length(x)], color="blue", marker=".", linestyle="", zorder=20, label=L"Port$\acute{e}$e communication type 2", markersize=4)

    # Communication type 1 haps 2
    theta = range(0, 2 * pi, length=400)
    x = 75 .+ 20*cos.(theta)
    y = 55 .+ 20*sin.(theta)
    ax.plot(x, y, [0 for i in 1:length(x)], color="red", marker=".", linestyle="", zorder=20, markersize=4)


    # Unités type 1
    ax.plot([70], [70], [0], color="red", marker="^", alpha=1.0, linestyle="", zorder=5, label=L"Unités de type 1")
    ax.plot([65], [80], [0], color="red", marker="^", alpha=1.0, linestyle="", zorder=5)
    ax.plot([70, 75], [70,55], [0,90], color="red", linestyle="--",  linewidth=0.6)
    #ax.plot([20, 30], [40,25], [0,90], color="red", linestyle="--",  linewidth=0.6)

    # Unités type 2
    ax.plot([85], [25], [0], color="blue", marker="^", alpha=1.0, linestyle="", zorder=5, label=L"Unité de type 2")
    #ax.plot([35, 30], [25,25], [0,90], color="blue", linestyle="--",  linewidth=0.6)

    
    # Affichage
    legend(loc="best")
    show()
end

function demo3()
    fig = figure()
    ax = Axes3D(fig)
    suptitle("Instance didactique (t = 2)", fontsize=15)
    etat_courant = ax.text2D(0.05, 0.85, "", transform=ax.transAxes, fontsize=12)
    xlim(0, 100)
    ylim(0, 100)
    zlim(0, 100)

    # Meshgrid
    xIt = 0:5:100
    yIt = 0:5:100
    x = xIt' .* ones(length(xIt))
    y = ones(length(yIt))' .* yIt
    z = x .* 0
    plot_surface(x, y, z, color="forestgreen", edgecolor="none", alpha=1, shade=false)

    # Fond n°1
    x = [0 100; 0 100]
    y = [100 100; 100 100]
    z = [0 0; 100 100]
    plot_surface(x,y,z, color="deepskyblue", alpha=1, shade=false)

    # Fond n°2
    x = [0 0; 0 0]
    y = [0 100; 0 100]
    z = [0 0; 100 100]
    plot_surface(x,y,z, color="deepskyblue", alpha=1, shade=false)

    # Temps t = 1
    # HAPS (ballon-sonde) 1
    ax.plot([30], [25], [90], color="orange", marker="o", linestyle="", markersize=20, label="HAPS", zorder=15)
    ax.plot([30, 30], [25, 25], [0, 90], color="black", linestyle="dotted", zorder=10)
     
    # HAPS 2
    ax.plot([70], [80], [90], color="orange", marker="o", linestyle="", markersize=20, zorder=15)
    ax.plot([70, 70], [80, 80], [0, 90], color="black", linestyle="dotted", zorder=10)


    # Déploiement possible
    ax.plot([75], [55], [0], color="pink", marker="x", linestyle="", markersize=10)
    ax.plot([70], [80], [0], color="pink", marker="x", linestyle="", markersize=10)
    ax.plot([90], [20], [0], color="pink", marker="x", linestyle="", markersize=10)
    ax.plot([30], [25], [0], color="pink", marker="x", linestyle="", markersize=10, label="Déploiement possible", zorder=9)

    # Communication type 1 haps 1
    theta = range(0, 2 * pi, length=400)
    x = 30 .+ 20*cos.(theta)
    y = 25 .+ 20*sin.(theta)
    ax.plot(x, y, [0 for i in 1:length(x)], color="red", marker=".", linestyle="", zorder=20, label=L"Port$\acute{e}$e communication type 1", markersize=4)

    # Communication type 2 haps 1
    theta = range(0, 2 * pi, length=400)
    x = 30 .+ 10*cos.(theta)
    y = 25 .+ 10*sin.(theta)
    ax.plot(x, y, [0 for i in 1:length(x)], color="blue", marker=".", linestyle="", zorder=20, label=L"Port$\acute{e}$e communication type 2", markersize=4)

    # Communication type 1 haps 2
    theta = range(0, 2 * pi, length=400)
    x = 70 .+ 20*cos.(theta)
    y = 80 .+ 20*sin.(theta)
    ax.plot(x, y, [0 for i in 1:length(x)], color="red", marker=".", linestyle="", zorder=20, markersize=4)


    # Unités type 1
    ax.plot([70], [70], [0], color="red", marker="^", alpha=1.0, linestyle="", zorder=5, label=L"Unités de type 1")
    ax.plot([65], [80], [0], color="red", marker="^", alpha=1.0, linestyle="", zorder=5)
    ax.plot([70, 70], [70,80], [0,90], color="red", linestyle="--",  linewidth=0.6)
    ax.plot([65, 70], [80,80], [0,90], color="red", linestyle="--",  linewidth=0.6)

    # Unités type 2
    ax.plot([85], [25], [0], color="blue", marker="^", alpha=1.0, linestyle="", zorder=5, label=L"Unité de type 2")
    #ax.plot([35, 30], [25,25], [0,90], color="blue", linestyle="--",  linewidth=0.6)

    
    # Affichage
    legend(loc="best")
    show()
end

demo3()
