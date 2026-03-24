# =========================
# Librería
# =========================
using Plots
gr()

# =========================
# Tipos
# =========================
abstract type Simulation end

struct PiSimulation <: Simulation
    n_points::Int
end

# =========================
# Simulación con puntos
# =========================
function run_with_points(sim::PiSimulation)
    inside_x = Float64[]
    inside_y = Float64[]

    outside_x = Float64[]
    outside_y = Float64[]

    for i in 1:sim.n_points
        x = rand()
        y = rand()

        if x*x + y*y <= 1
            push!(inside_x, x)
            push!(inside_y, y)
        else
            push!(outside_x, x)
            push!(outside_y, y)
        end
    end

    pi_est = 4 * length(inside_x) / sim.n_points

    return pi_est, inside_x, inside_y, outside_x, outside_y
end

# =========================
# Simulación rápida
# =========================
function run(sim::PiSimulation)
    inside = 0

    for i in 1:sim.n_points
        x = rand()
        y = rand()

        if x*x + y*y <= 1
            inside += 1
        end
    end

    return 4 * inside / sim.n_points
end

# =========================
# Error porcentual
# =========================
function porcentaje_error(estimado)
    return abs(Float64(pi) - estimado) / Float64(pi) * 100
end

# =========================
# Gráfica 1: puntos
# =========================
function plot_simulation(inside_x, inside_y, outside_x, outside_y)
    θ = range(0, stop=pi/2, length=200)
    circle_x = cos.(θ)
    circle_y = sin.(θ)

    p1 = scatter(outside_x, outside_y,
        label="Fuera",
        markersize=2)

    scatter!(p1, inside_x, inside_y,
        label="Dentro",
        markersize=2)

    plot!(p1, circle_x, circle_y,
        label="Círculo",
        linewidth=2)

    plot!(p1, [0,1,1,0,0], [0,0,1,1,0],
        label="Cuadrado",
        linewidth=2)

    xlabel!(p1, "x")
    ylabel!(p1, "y")
    title!(p1, "Monte Carlo π (puntos)")

    return p1
end

# =========================
# Gráfica 2: error vs puntos
# =========================
function plot_error_vs_points(points_list, errors)
    p2 = plot(points_list, errors,
        marker=:o,
        xlabel="Número de puntos",
        ylabel="Error (%)",
        title="Convergencia de Monte Carlo",
        label="Error",
        xscale=:log10)

    return p2
end

# =========================
# MAIN
# =========================
function main()
    println("Simulación Monte Carlo para π")

    # -------- Gráfica 1 --------
    n_visual = 5000
    sim_visual = PiSimulation(n_visual)

    est, ix, iy, ox, oy = run_with_points(sim_visual)
    error = porcentaje_error(est)

    println("\n--- Visualización ---")
    println("π estimado: ", est)
    println("π real: ", Float64(pi))
    println("Error %: ", error)

    p1 = plot_simulation(ix, iy, ox, oy)

    # -------- Gráfica 2 --------
    println("\n--- Convergencia ---")

    points_list = [100, 1000, 5000, 10000, 50000, 100000]
    errors = Float64[]

    for n in points_list
        sim = PiSimulation(n)
        est = run(sim)
        err = porcentaje_error(est)

        println("n = ", n, " → error = ", err, "%")
        push!(errors, err)
    end

    p2 = plot_error_vs_points(points_list, errors)

    # -------- MOSTRAR AMBAS --------
    plot(p1, p2, layout=(1,2))  # 🔥 clave: dos gráficas lado a lado
end

main()