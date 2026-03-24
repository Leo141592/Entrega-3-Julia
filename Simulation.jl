# =========================
# Tipos
# =========================
abstract type Simulation end

struct PiSimulation <: Simulation
    n_points::Int
end

# =========================
# Función principal
# =========================
function run(sim::PiSimulation)
    inside = 0

    for i in 1:sim.n_points
        x = rand()
        y = rand()

        if x^2 + y^2 <= 1
            inside += 1
        end
    end

    pi_estimate = 4 * inside / sim.n_points
    return pi_estimate
end

# =========================
# Repetir simulación
# =========================
function repeat_simulation(sim::Simulation, times::Int)
    results = Float64[]

    for i in 1:times
        push!(results, run(sim))
    end

    return results
end

# =========================
# Estadísticas
# =========================
function stats(results)
    mean = sum(results) / length(results)
    min_val = minimum(results)
    max_val = maximum(results)

    println("Promedio: ", mean)
    println("Mínimo: ", min_val)
    println("Máximo: ", max_val)
end

# =========================
# Versión funcional
# =========================
function repeat_functional(sim::Simulation, times::Int)
    return map(i -> run(sim), 1:times)
end

# =========================
# MAIN
# =========================
function main()
    println("Simulación Monte Carlo para π")
    
    println("¿Cuántos puntos por simulación?")
    n = parse(Int, readline())

    println("¿Cuántas repeticiones?")
    t = parse(Int, readline())

    sim = PiSimulation(n)

    # Ejecutar simulaciones
    results = repeat_simulation(sim, t)

    # Mostrar resultados
    stats(results)
end

main()