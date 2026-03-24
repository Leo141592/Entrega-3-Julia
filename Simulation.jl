# =========================
# Librería
# =========================
using Plots
gr()  # backend rápido

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
# Simulación rápida (sin guardar puntos)
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
# Gráfica de puntos
# =========================
function plot_simulation(inside_x, inside_y, outside_x, outside_y)
    θ = range(0, stop=pi/2, length=200)
    circle_x = cos.(θ)
    circle_y = sin.(θ)

    scatter(outside_x, outside_y,
        label="Fuera",
        markersize=2)

    scatter!(inside_x, inside_y,
        label="Dentro",
        markersize=2)

    plot!(circle_x, circle_y,
        label="Círculo",
        linewidth=2)

    plot!([0,1,1,0,0], [0,0,1,1,0],
        label="Cuadrado",
        linewidth=2)

    xlabel!("x")
    ylabel!("y")
    title!("Monte Carlo π (visualización)")
end

# =========================
# Gráfica puntos vs error
# =========================
function plot_error_vs_points(points_list, errors)
    plot(points_list, errors,
        marker=:o,
        xlabel="Número de puntos",
        ylabel="Error (%)",
        title="Convergencia de Monte Carlo",
        label="Error",
        xscale=:log10)  # 🔥 clave para ver bien la convergencia
end

# =========================
# MAIN
# =========================
function main()
    println("Simulación Monte Carlo para π")

    # =====================
    # 1. Visualización de puntos
    # =====================
    n_visual = 5000
    sim_visual = PiSimulation(n_visual)

    est, ix, iy, ox, oy = run_with_points(sim_visual)
    error = porcentaje_error(est)

    println("\n--- Visualización ---")
    println("Puntos: ", n_visual)
    println("π estimado: ", est)
    println("π real: ", Float64(pi))
    println("Error %: ", error)

    plot_simulation(ix, iy, ox, oy)

    # =====================
    # 2. Convergencia (puntos vs error)
    # =====================
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

    plot_error_vs_points(points_list, errors)
end

# =========================
# Ejecutar
# =========================
main()