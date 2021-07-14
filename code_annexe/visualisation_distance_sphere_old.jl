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
    THETA = range(0.0, 2*pi, length=20) # élévation, phi
    PHI = range(0.0, pi, length=20) # théta
    x = [r1 * sin(phi) * cos(theta) + 500 for theta in THETA, phi in PHI]
    y = [r1 * sin(phi) * sin(theta) + 500 for theta in THETA, phi in PHI]
    z = [r2 * cos(phi) + 50 for theta in THETA, phi in PHI]
    plot_surface(x, y, z, color="#40916c", edgecolor="white", shade=false, linewidth=0.2, alpha=0.5)

    # noyau
    plot([500], [500], [50], color="white", linestyle="", marker="o", markeredgecolor="black", markersize=15, zorder=-4, label="Centre de la Terre")
end

function main()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    ax = fig.add_subplot(111, projection="3d") 
    ax.margins(0)
    ax.view_init(elev=14, azim=55)
    ax.dist = 10
    fig.set_facecolor("#14213d")
    ax.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    xlim(450, 550)
    ylim(450, 550)
    zlim(0, 100)
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
    ax.plot([500, 500 + a], [500, 500 + b], [50, 50 + c], color="yellow", zorder=-5) 
    ax.text2D(0.451, 0.658, L"$r_e$", transform=ax.transAxes, color="white", zorder=50, rotation=-48, size=14, alpha=0.5)
    ax.plot([500 + a, 500 + 1.4*a], [500 + b, 500 + 1.4*b], [50 + c, 50 + 1.4*c], color="cyan")
    ax.text2D(0.345, 0.898, L"$A$", transform=ax.transAxes, color="white", zorder=50, rotation=-48, size=14, alpha=1)

    # Trait centre/unité
    ax.plot([500, xUnite], [500, yUnite], [50, zUnite], color="yellow", zorder=-5) 
    ax.text2D(0.39, 0.519, L"$r_e$", transform=ax.transAxes, color="white", zorder=50, rotation=0, size=14, alpha=0.5)

    # HAPS
    ax.plot([500 + 1.4*a], [500 + 1.4*b], [50 + 1.4*c], color="darkorange", marker="o", markeredgecolor="black", linestyle="", markersize=20, zorder=25, clip_on=false, label=L"Un HAPS $h \in \mathcal{H}$ déployé sur une position $e \in \mathcal{E}$")

    # Distance unité/HAPS
    #ax.plot([xUnite, 500 + a], [yUnite, 500 + b], [zUnite, 50 + c], color="red",  linestyle="dotted", alpha=0.5)
    ax.plot([xUnite, 500 + 1.4*a], [yUnite, 500 + 1.4*b], [zUnite, 50 + 1.4*c], color="blue")
    ax.text2D(0.288, 0.75, L"$d$", transform=ax.transAxes, color="white", zorder=50, rotation=90, size=14, alpha=1)

    # Angle
    ax.text2D(0.495, 0.518, L"$\alpha$", transform=ax.transAxes, color="white", zorder=50, rotation=0, size=14, alpha=0.5)
    for phi in 0.68:0.01:1.47
        xTemp = 50 * sin(phi) * cos(0) + 500
        yTemp = 50 * sin(phi) * sin(0) + 500
        zTemp = 80 * cos(phi) + 50
        a = xTemp - 500 
        b = yTemp - 500
        c = zTemp - 50
        ax.plot([500, 500 + 0.1*a], [500, 500 + 0.1*b], [50, 50 + 0.1*c], color="lime", zorder=-5) 
    end

    # Formules
    ax.text2D(0.04, 0.80, "Rayon moyen de la Terre :", transform=ax.transAxes, color="white", zorder=50, rotation=0, size=14, alpha=1)
    ax.text2D(0.04, 0.75, L"$r_e \simeq 6 371$", transform=ax.transAxes, color="white", zorder=50, rotation=0, size=14, alpha=1)
    ax.text2D(0.04, 0.70, "Loi des cosinus :", transform=ax.transAxes, color="white", zorder=50, rotation=0, size=14, alpha=1)
    ax.text2D(0.04, 0.65, L"$d^2 = r_e^2 + (r_e + A)^2 - 2r_e(r_e + A)cos(\alpha)$", transform=ax.transAxes, color="white", zorder=50, rotation=0, size=14, alpha=1)
    ax.text2D(0.04, 0.60, L"$d = \sqrt{r_e^2 + (r_e + A)^2 - 2r_e(r_e + A)cos(\alpha)}$", transform=ax.transAxes, color="white", zorder=50, rotation=0, size=14, alpha=1)


    # Légende 
    ax.legend(loc="upper left", bbox_to_anchor=(0.45, 0.9), fontsize=16, framealpha=0.8, facecolor="whitesmoke", edgecolor="black").set_zorder(1000)
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

function terrain()
    x = range(0.0, 1000, length = 20)
    y = range(0.0, 1000, length = 20)
    z = randn(20, 20)
    plot_surface(x, y, z, color="#40916c", edgecolor="white", shade=false, linewidth=0.2)
end

main()
