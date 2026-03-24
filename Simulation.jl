# =========================
# Tipos
# =========================
abstract type Simulation end

struct PiSimulation <: Simulation
    n_points::Int
end

# =========================
# Función que ejecuta la simulación
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
# Cálculo de error porcentual
# =========================
function porcentaje_error(estimado)
    real = pi
    return abs(real - estimado) / real * 100
end

# =========================
# Función principal
# =========================
function main()
    println("Simulación Monte Carlo para π")

    # puedes cambiar este valor
    n = 100000

    sim = PiSimulation(n)

    estimado = run(sim)
    error = porcentaje_error(estimado)

    println("\nResultados:")
    println("Puntos usados: ", n)
    println("π estimado: ", estimado)
    println("π real: ", pi)
    println("Error porcentual: ", error, " %")
end

# =========================
# Ejecutar
# =========================
main()