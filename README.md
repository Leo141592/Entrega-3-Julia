````markdown
# Simulación de π con el método de Monte Carlo (Julia)

## Descripción

Este proyecto implementa una simulación del método de Monte Carlo para estimar el valor de π.

La idea es generar puntos aleatorios dentro de un cuadrado y verificar cuáles caen dentro de un círculo inscrito. A medida que se agregan más puntos, la estimación se vuelve cada vez más cercana al valor real de π.

El programa permite visualizar:

- Los puntos generados dentro y fuera del círculo  
- El cuadrado y el círculo  
- Cómo cambia el error conforme se usan más puntos  

La simulación es acumulativa, es decir, los puntos se van agregando progresivamente en lugar de generarse desde cero cada vez.

---

## Librerías utilizadas

El proyecto utiliza las siguientes librerías de Julia:

- `Plots` → para la visualización de gráficos  
- `PlutoUI` → para interacción (slider) dentro de Pluto  
- `Random` → generación de números aleatorios (incluida en Julia base)

---

## Requisitos

- Julia 1.8 o superior (recomendado 1.10+)
- Pluto.jl

---

## Instalación de dependencias

Abrir Julia y ejecutar:

```julia
using Pkg
Pkg.add("Pluto")
Pkg.add("Plots")
Pkg.add("PlutoUI")
````

---

## Cómo ejecutar el proyecto

1. Iniciar Pluto:

```julia
using Pluto
Pluto.run()
```

2. En el navegador que se abre:

   * Seleccionar **"Open a notebook"**
   * Abrir el archivo `.jl` del proyecto

3. Usar el slider para variar el número de puntos de la simulación.

---

## Autor

Leonel Hernández

```
```
