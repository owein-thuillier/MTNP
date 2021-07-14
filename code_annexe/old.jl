#using PyCall
#a3 = pyimport("mpl_toolkits.mplot3d.art3d")

function generation_nuages(ax)
    x = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
    y = trunc.(Int, [79.83870967741936, 77.01612903225806, 71.9758064516129, 68.54838709677419, 65.9274193548387, 62.096774193548384, 57.258064516129025, 54.83870967741936, 54.435483870967744, 58.064516129032256, 63.10483870967742, 69.75806451612902, 73.79032258064515, 78.62903225806451, 80.64516129032258, 81.04838709677419])
    z = trunc.(Int, [57.14285714285716, 63.09523809523811, 62.55411255411257, 59.57792207792209, 61.20129870129872, 61.20129870129872, 59.57792207792209, 55.51948051948053, 47.94372294372296, 46.32034632034633, 44.96753246753248, 45.508658008658024, 45.508658008658024, 46.04978354978356, 47.94372294372296, 53.0844155844156])
    vtx = [[x[i], y[i], z[i]] for i in 1:length(x)]
    tri = a3.Poly3DCollection([vtx], zorder=15)
    tri.set_facecolor("white")
    ax.add_collection3d(tri)
end

###############"

using PyPlot

function demo()
    # Terrain (3-dimensions)
    fig = figure()
    ax = Axes3D(fig)
    xlim(0, 100)
    ylim(0, 100)
    zlim(0, 100)

    # HAPS (ballon-sonde)
    scatter3D(50, 50, 90, color="red", marker="o", s=110, label="HAPS")
    plot3D([50, 50], [50, 50], [0, 90], color="green", linestyle="--")

    # Communication type 1
    theta = range(0, 2 * pi, length=100)
    x = 50 .+ 20*cos.(theta)
    y = 50 .+ 20*sin.(theta)
    scatter3D(x, y, [0 for i in 1:length(x)], color="orange", marker=".", s=4, label=L"Port$\acute{e}$e $c_1$")

    # Communication type 2
    theta = range(0, 2 * pi, length=50)
    x = 50 .+ 10*cos.(theta)
    y = 50 .+ 10*sin.(theta)
    scatter3D(x, y, [0 for i in 1:length(x)], color="purple", marker=".", s=4, label=L"Port$\acute{e}$e $c_2$")

    # Unités terrestres (communication type 1)
    scatter3D(70, 70, 0, color="orange", marker="^", s = 30, label=L"Unit$\acute{e}$s terrestres $u_{1}$")
    scatter3D(60, 60, 0, color="orange", marker="^", s = 30)
    plot([60, 50], [60,50], [0,90], color="orange", linestyle="--",  linewidth=0.5)
    scatter3D(20, 40, 0, color="orange", marker="^", s = 30)
    
    

    # Unités terrestres (communication type 1)
    scatter3D(40, 20, 0, color="purple", marker="^", s = 30, label=L"Unit$\acute{e}$s terrestres $u_{2}$")
    scatter3D(55, 50, 0, color="purple", marker="^", s = 30)
    plot([55, 50], [50,50], [0,90], color="purple", linestyle="--",  linewidth=0.5)


    # Affichage
    suptitle("Nombre total de coupures : 3")
    title("État : 1 | Nombre de coupures : 3", y=0.9)
    legend(loc="best")
    show()
end

    x = []
    y = []
    z = []

function onclick(event, fig, ax)
    ax.plot(event.xdata, event.ydata, ls="", marker=".", color="black") 
    println(0, " ", event.xdata, " ", event.ydata)
    push!(x, 0)
    push!(y, event.xdata)
    push!(z, event.ydata)
    fig.canvas.draw()
end


function temp()
    fig = figure()
    ax = fig.add_subplot(111)
    xlim(0, 100)
    ylim(0, 100)
    fig.canvas.mpl_connect("button_press_event", event -> onclick(event, fig, ax))
    show()
    println(x)
    println(y)
    println(z)
end

function temp2()
    fig = figure()
    ax = Axes3D(fig)
    xlim(0, 100)
    ylim(0, 100)
    zlim(0, 100)
end



temp()

function pb()
    # Visualisation du scénario
    choix = choix_binaire("\n --> Souhaitez-vous visualiser le scénario (déplacement des unités terrestres) (o/n) ? ")
    if choix == "o"
        visualisation(instance)
    end
end


