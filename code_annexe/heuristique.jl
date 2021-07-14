##### Heuristique #####

function temp()
    haps, liste_relais = heuristique(instance, Ebis, E1, E2)
    for (h, pos) in haps
        set_start_value(x[h,pos], 1)
    end

    for (pos, relais) in liste_relais 
        for r in relais
            set_start_value(y[r[1],pos], 1)
        end
    end
end

function heuristique(instance)
    # Solution optimale au problème relâché (HAPS pas considérés)
    modele = creation_modele_heuristique(instance, Ebis, E1, E2) 
    set_optimizer(modele, Gurobi.Optimizer)
    optimize!(modele)
    y = round.(Int, value.(modele[:y]))
    d = round.(Int, value.(modele[:d]))
    charge_pos = Tuple{Int, Float64, Float64, Int}[]
    liste_relais = Dict() # liste_relais[pos] : liste des relais placés à la position pos
    haps = Dict()
    for pos in Ebis
        if d[pos] == 1
            liste_relais_temp = Vector{Int}[]
            poids_pos = 0.0
            puissance_pos = 0.0
            for c in 1:instance.contexte.nC
                for r in instance.contexte.R[c]
                    position = instance.contexte.E[pos]
                    if y[r,pos] == 1
                        println(" - Relais $r (type $c) à la position ($(position.x), $(position.y)) ")
                        poids_pos += instance.contexte.w[r]
                        puissance_pos += instance.contexte.p[r]
                        push!(liste_relais_temp, [r,0])
                    end
                end
            end
            liste_relais[pos] = liste_relais_temp
            nb_unites_couvertes = nombre_unites_couvertes(instance, E1, pos, liste_relais)
            sort!(liste_relais[pos], by=last, rev=true)
            push!(charge_pos, (pos, poids_pos, puissance_pos, nb_unites_couvertes))
        end
    end 
    sort!(charge_pos, by=last, rev=true)

    # Réparation de la solution en introduisant les HAPS 
    haps_disponibles = [i for i in 1:instance.contexte.nH]
    for (pos, poids, puissance, nb_unites_couvertes) in charge_pos
        println(" - Position $pos : $poids, $puissance, $nb_unites_couvertes")
        meilleur_candidat = -1
        meilleure_ponderation = Inf32
        for h in haps_disponibles
            difference_poids = poids - instance.contexte.W[h]
            difference_puissance = puissance - instance.contexte.P[h]
            ponderation = (difference_poids + difference_puissance)/2
            if ponderation < meilleure_ponderation
                meilleur_candidat = h
                meilleure_ponderation = ponderation
            end
        end
        println("     --> HAPS : $meilleur_candidat ($(instance.contexte.W[meilleur_candidat]), $(instance.contexte.P[meilleur_candidat]))")
        filter!(x->x!=meilleur_candidat, haps_disponibles)
        poids_haps = instance.contexte.W[meilleur_candidat]
        puissance_haps = instance.contexte.P[meilleur_candidat]
        while poids > poids_haps || puissance > puissance_haps
            r = pop!(liste_relais[pos])[1]
            poids -= instance.contexte.w[r]
            puissance -= instance.contexte.p[r]
            println("      #$r")
        end
        println("    --> ($poids, $puissance)")
        haps[meilleur_candidat] = pos
    end
    return haps, liste_relais
end

function nombre_unites_couvertes(instance, E1, pos, liste_relais)
    nb_unites_couvertes = 0
    for u in 1:instance.contexte.nU
        for t in 1:instance.contexte.nT
            unite_couverte = false
            for r in liste_relais[pos]
                if pos in E1[u][r[1]][t]
                     unite_couverte = true
                     r[2] += 1
                end
            end
            if unite_couverte == true
                nb_unites_couvertes += 1
            end
        end
    end
    return nb_unites_couvertes
end

function creation_modele_heuristique(instance, Ebis, E1, E2) 
    modele = Model()

    # Données
    nT = instance.contexte.nT
    nH = instance.contexte.nH
    nE = instance.contexte.nE
    nC = instance.contexte.nC
    nU = instance.contexte.nU
    nB = instance.contexte.nB
    nR = instance.contexte.nR
    nRc = instance.contexte.nRc
    R = instance.contexte.R
    Cb = instance.contexte.Cb
    Cu = instance.contexte.Cu
    W = instance.contexte.W
    P = instance.contexte.P
    w = instance.contexte.w
    p =instance.contexte.p
 
    # Variables    
    @variables(modele, begin 
        y[1:nR, Ebis], Bin # ""
        z[1:nU, 1:nT], Bin
        d[Ebis], Bin
        end)

    # Contraintes

    @constraint(modele, c_1[r=1:nR], sum(y[r,pos] for pos in Ebis) <= 1) 

    @constraint(modele, c_2[r=1:nR, pos in Ebis], y[r, pos] <= d[pos])

    @constraint(modele, c_3, sum(d[pos] for pos in Ebis) <= nH)

    @constraint(modele, c_4[t=1:nT, u=1:nU], sum(y[r,pos] for c in Cu[u], r in R[c], pos in E1[u][r][t]) >= 1 - z[u,t])

    @constraint(modele, c_5[b=1:nB], sum(y[r,pos] for c in Cb[b], r in R[c], pos in E2[b][r]) >= 1) 

    @constraint(modele, c_R1[pos in Ebis, c=1:nC], sum(y[r,pos] for r in R[c]) <= 1) 

    # Fonction objectif
    @objective(modele, Min, sum(z[u,t] for u in 1:nU, t in 1:nT))

    return modele
end


