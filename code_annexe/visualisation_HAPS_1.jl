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
    x = [0 0; 1000 1000]
    y = [0 0; 0 0]
    z = [0 40; 0 40]
    plot_surface(x,y,z, color="grey", edgecolor="white", alpha=1, shade=false, zorder=-5, clip_on=false)
    # Face droite
    x = [1000 1000; 1000 1000]
    y = [0 0; 1000 1000]
    z = [0 40; 0 40]
    plot_surface(x,y,z, color="grey", edgecolor="white", alpha=1, shade=false, zorder=-5, clip_on=false)
    # Toit
    x = [0 0; 1000 1000]
    y = [0 1000; 0 1000]
    z = [40 40; 40 40]
    plot_surface(x,y,z, color="grey", edgecolor="white", alpha=1, shade=false, zorder=-5, clip_on=false)
end

function soute_ouverte(ax)
    # Face avant
    ax.plot([0,1000], [0,0], [0,0], color="white", linewidth=1, zorder=100)
    ax.plot([0,1000], [0,0], [40,40], color="white", linewidth=1, zorder=100)
    ax.plot([0,0], [0,0], [0,40], color="white", linewidth=1, zorder=100)
    ax.plot([1000,1000], [0,0], [0,40], color="white", linewidth=1, zorder=100)
    # Face derrière
    ax.plot([0,1000], [1000,1000], [0,0], color="white", linewidth=1, linestyle="--")
    ax.plot([0,1000], [1000,1000], [40,40], color="white", linewidth=1, zorder=100)
    ax.plot([0,0], [1000,1000], [0,40], color="white", linewidth=1, linestyle="--")
    ax.plot([1000,1000], [1000,1000], [0,40], color="white", linewidth=1, zorder=100)
    # Face droite
    ax.plot([1000,1000], [0,1000], [0,0], color="white", linewidth=1, zorder=100)
    ax.plot([1000,1000], [0,1000], [40,40], color="white", linewidth=1, zorder=100)
    # Face gauche
    ax.plot([0,0], [0,1000], [0,0], color="white", linewidth=1, linestyle="--")
    ax.plot([0,0], [0,1000], [40,40], color="white", linewidth=1, zorder=100)
end


function relais_orange(ax)
    # Face avant
    x = [0 0; 1000 1000]
    y = [700 700; 700 700]
    z = [0 10; 0 10]
    plot_surface(x,y,z, color="mediumspringgreen", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    # Face droite
    x = [1000 1000; 1000 1000]
    y = [700 700; 1000 1000]
    z = [0 10; 0 10]
    plot_surface(x,y,z, color="mediumspringgreen", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    # Toit
    x = [0 0; 1000 1000]
    y = [700 1000; 700 1000]
    z = [10 10; 10 10]
    plot_surface(x,y,z, color="mediumspringgreen", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
end

function relais_violet(ax)
    # Face avant
    x = [0 0; 300 300]
    y = [0 0; 0 0]
    z = [0 10; 0 10]
    plot_surface(x,y,z, color="fuchsia", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    # Face droite
    x = [300 300; 300 300]
    y = [0 0; 700 700]
    z = [0 10; 0 10]
    plot_surface(x,y,z, color="fuchsia", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    # Toit
    x = [0 0; 300 300]
    y = [0 700; 0 700]
    z = [10 10; 10 10]
    plot_surface(x,y,z, color="fuchsia", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    
    #plot([0,0], [0,1000], [0,0], color="black", linestyle="--", linewidth=1)
end

function relais_rose(ax)
    # Face avant
    x = [0 0; 300 300]
    y = [0 0; 0 0]
    z = [10 25; 10 25]
    plot_surface(x,y,z, color="pink", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    # Face droite
    x = [300 300; 300 300]
    y = [0 0; 1000 1000]
    z = [10 25; 10 25]
    plot_surface(x,y,z, color="pink", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    # Toit
    x = [0 0; 300 300]
    y = [0 1000; 0 1000]
    z = [25 25; 25 25]
    plot_surface(x,y,z, color="pink", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)

    #plot([0,0], [1000,1000], [10,25], color="black", linestyle="--", linewidth=1)
end

function relais_cyan(ax)
    # Face avant
    x = [700 700; 1000 1000]
    y = [0 0; 0 0]
    z = [0 30; 0 30]
    plot_surface(x,y,z, color="cyan", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    # Face droite
    x = [1000 1000; 1000 1000]
    y = [0 0; 300 300]
    z = [0 30; 0 30]
    plot_surface(x,y,z, color="cyan", edgecolor="black", alpha=0.5, shade=false, zorder=-5, clip_on=false)
    # Toit
    x = [700 700; 1000 1000]
    y = [0 300; 0 300]
    z = [30 30; 30 30]
    plot_surface(x,y,z, color="cyan", edgecolor="black", alpha=0.5, shade=false, zorder=-10, clip_on=false)
    # Pointillés
    plot([700, 700], [0, 300], [0, 0], color="black", linestyle="--", zorder=-10, clip_on=false, linewidth=1)
    plot([700, 1000], [300, 300], [0, 0], color="black", linestyle="--", zorder=-10, clip_on=false, linewidth=1)
    plot([700, 700], [300, 300], [0, 30], color="black", linestyle="--", zorder=-10, clip_on=false, linewidth=1)
end


function main()
    ion()
    using3D()
    fig = figure("Outil de visualisation") # figsize=(16,9), tight_layout=true
    #fullscreen() 
    ax = fig.add_subplot(111, projection="3d") 
    ax.margins(0)
    ax.view_init(elev=15, azim=-63)
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
    suptitle(L"HAPS $h_2$",  y=0.88, bbox=Dict("facecolor"=>"whitesmoke", "boxstyle"=>"round,pad=0.5", "alpha"=>0.8), fontsize=15)
    #text3D(x=400, y=0, z=18, s="Soute", zdir="x", color="white", size=12)
    #soute_fermee(ax)
    
    ax.text2D(0.15, 0.38, L"$r_6$", transform=ax.transAxes, color="white", fontsize=12, zorder=1000)
    ax.text2D(0.15, 0.27, L"$r_7$", transform=ax.transAxes, color="white", fontsize=12, zorder=1000)
    ax.text2D(0.56, 0.31, L"$r_8$", transform=ax.transAxes, color="white", fontsize=12, zorder=1000)
    ax.text2D(0.56, 0.35, L"$r_9$", transform=ax.transAxes, color="white", alpha=0.4, fontsize=12, zorder=1000)
    soute_ouverte(ax)
    relais_orange(ax)
    relais_violet(ax)
    relais_rose(ax)
    relais_cyan(ax)
end

main()



