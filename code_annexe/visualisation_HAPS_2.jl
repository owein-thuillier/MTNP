using PyPlot
using Random

function fullscreen()
    manager = get_current_fig_manager()
    manager.window.showMaximized()
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

function soute_fermee(ax)
    # Face avant
    x = [250 250; 750 750]
    y = [0 0; 0 0]
    z = [-10 50; -10 50]
    plot_surface(x,y,z, color="grey", edgecolor="white", alpha=1, shade=false, zorder=-5, clip_on=false)
    # Face droite
    x = [750 750; 750 750]
    y = [0 0; 1000 1000]
    z = [-10 50; -10 50]
    plot_surface(x,y,z, color="grey", edgecolor="white", alpha=1, shade=false, zorder=-5, clip_on=false)
    # Toit
    x = [250 250; 750 750]
    y = [0 1000; 0 1000]
    z = [50 50; 50 50]
    plot_surface(x,y,z, color="grey", edgecolor="white", alpha=1, shade=false, zorder=-5, clip_on=false)
end

function soute_ouverte(ax)
    # Face avant
    ax.plot([250,750], [0,0], [-10,-10], color="white", linewidth=1, zorder=100)
    ax.plot([250,750], [0,0], [50,50], color="white", linewidth=1, zorder=100)
    ax.plot([250,250], [0,0], [-10,50], color="white", linewidth=1, zorder=100)
    ax.plot([750,750], [0,0], [-10,50], color="white", linewidth=1, zorder=100)
    # Face derrière
    ax.plot([250,750], [1000,1000], [-10,-10], color="white", linewidth=1, linestyle="--")
    ax.plot([250,750], [1000,1000], [50,50], color="white", linewidth=1, zorder=100)
    ax.plot([250,250], [1000,1000], [-10,50], color="white", linewidth=1, linestyle="--")
    ax.plot([750,750], [1000,1000], [-10,50], color="white", linewidth=1, zorder=100)
    # Face droite
    ax.plot([750,750], [0,1000], [-10,-10], color="white", linewidth=1, zorder=100)
    ax.plot([750,750], [0,1000], [50,50], color="white", linewidth=1, zorder=100)
    # Face gauche
    ax.plot([250,250], [0,1000], [-10,-10], color="white", linewidth=1, linestyle="--")
    ax.plot([250,250], [0,1000], [50,50], color="white", linewidth=1, zorder=100)
end


function relais_rouge(ax)
    # Face avant
    x = [250 250; 750 750]
    y = [600 600; 600 600]
    z = [-10 50; -10 50]
    plot_surface(x,y,z, color="red", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    # Face droite
    x = [750 750; 750 750]
    y = [600 600; 1000 1000]
    z = [-10 50; -10 50]
    plot_surface(x,y,z, color="red", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    # Toit
    x = [250 250; 750 750]
    y = [600 1000; 600 1000]
    z = [50 50; 50 50]
    plot_surface(x,y,z, color="red", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
end

function relais_vert(ax)
    # Face avant
    x = [250 250; 750 750]
    y = [0 0; 0 0]
    z = [-10 10; -10 10]
    plot_surface(x,y,z, color="lime", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    # Face droite
    x = [750 750; 750 750]
    y = [0 0; 600 600]
    z = [-10 10; -10 10]
    plot_surface(x,y,z, color="lime", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    # Toit
    x = [250 250; 750 750]
    y = [0 600; 0 600]
    z = [10 10; 10 10]
    plot_surface(x,y,z, color="lime", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
end

function relais_bleu(ax)
    # Face avant
    x = [250 250; 400 400]
    y = [0 0; 0 0]
    z = [10 30; 10 30]
    plot_surface(x,y,z, color="blue", edgecolor="black", alpha=0.5, shade=false, zorder=5, clip_on=false)
    # Face droite
    x = [400 400; 400 400]
    y = [0 0; 600 600]
    z = [10 30; 10 30]
    plot_surface(x,y,z, color="blue", edgecolor="black", alpha=0.5, shade=false, zorder=5, clip_on=false)
    # Toit
    x = [250 250; 400 400]
    y = [0 600; 0 600]
    z = [30 30; 30 30]
    plot_surface(x,y,z, color="blue", edgecolor="black", alpha=0.5, shade=false, zorder=5, clip_on=false)
end

function relais_jaune(ax)
    # Face avant
    x = [500 500; 750 750]
    y = [0 0; 0 0]
    z = [10 25; 10 25]
    plot_surface(x,y,z, color="gold", edgecolor="black", alpha=0.5, shade=false, zorder=5, clip_on=false)
    # Face droite
    x = [750 750; 750 750]
    y = [0 0; 400 400]
    z = [10 25; 10 25]
    plot_surface(x,y,z, color="gold", edgecolor="black", alpha=0.5, shade=false, zorder=5, clip_on=false)
    # Face gauche
    plot([500,500], [0,400], [10, 10], color="black", linestyle="--", zorder=10, linewidth=1)
    # Toit
    x = [500 500; 750 750]
    y = [0 400; 0 400]
    z = [25 25; 25 25]
    plot_surface(x,y,z, color="gold", edgecolor="black", alpha=0.5, shade=false, zorder=5, clip_on=false)
end

function relais_orange(ax)
    # Face avant
    x = [500 500; 750 750]
    y = [400 400; 400 400]
    z = [10 40; 10 40]
    plot_surface(x,y,z, color="orange", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    # Face droite
    x = [750 750; 750 750]
    y = [400 400; 600 600]
    z = [10 40; 10 40]
    plot_surface(x,y,z, color="orange", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    # Toit
    x = [500 500; 750 750]
    y = [400 600; 400 600]
    z = [40 40; 40 40]
    plot_surface(x,y,z, color="orange", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
end

function main()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    #fullscreen() 
    ax = fig.add_subplot(111, projection="3d") 
    ax.margins(0)
    ax.view_init(elev=13, azim=-80)
    ax.dist = 10
    fig.set_facecolor("#14213d")
    ax.set_facecolor("#14213d")
    axis("off")
    ax.grid(false)
    ax.set_zticks([0, 15, 20, 50, 85, 500])
    xlim(0, 1000)
    ylim(0, 1000)
    zlim(0, 50)
    tight_layout(pad=0)
    generation_etoiles(ax)
    suptitle(L"HAPS $h_1$",  y=0.93, bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=15)
    #text3D(x=400, y=0, z=18, s="Soute", zdir="x", color="white", size=12)
    #soute_fermee(ax)
    
    ax.text2D(0.33, 0.38, L"$r_1$", transform=ax.transAxes, color="white", fontsize=12, zorder=1000)
    ax.text2D(0.44, 0.2, L"$r_2$", transform=ax.transAxes, color="white", fontsize=12, zorder=1000)
    ax.text2D(0.52, 0.36, L"$r_3$", transform=ax.transAxes, color="white", fontsize=12, zorder=1000)
    ax.text2D(0.56, 0.51, L"$r_4$", transform=ax.transAxes, color="white", alpha=1, fontsize=12, zorder=1000)
    ax.text2D(0.50, 0.51, L"$r_5$", transform=ax.transAxes, color="white", alpha=0.4, fontsize=12, zorder=1000)
    soute_ouverte(ax)
    relais_rouge(ax)
    relais_bleu(ax)
    relais_vert(ax)
    relais_orange(ax)
    relais_jaune(ax)
end

main()



