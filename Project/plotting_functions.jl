# FUNCTIONs NEEDED FOR PLOTTING

module plotting_functions

"""
Include the following lines in the main script:
---
include("./plotting_functions.jl")
using .plotting_functions
---

"""

# EXPORTED FUNCTIONS
export plot_fourier_spectrum, u_eps_plot, rho_plot, rho_history, post_plotting_real, post_plotting_sim, plot_data


# REQUIRED PACKAGES
using Plots
using CairoMakie
using PairPlots
using FFTW


# Function to plot the fourier spectrum of simulated data
function plot_fourier_spectrum(t::Union{Vector{Float64}, Vector{Int64}}, u::Vector{Float64})
  Fs = 1 / (t[2] - t[1])
  N = length(u)
  freqs = fftfreq(N, Fs)

  fourier_transform_sim = abs.(fft(u))

  frequencies = freqs[(freqs .> 0) .& (freqs .<= 0.5)]
  amplitudes = abs.(fourier_transform_sim[(freqs .> 0) .& (freqs .<= 0.5)])

  p = Plots.plot(frequencies, amplitudes, xlabel="Frequency (Hz)", ylabel="Magnitude", title="Magnitude Spectrum", legend=false)
  vline!(p, [1/11], line=:dash, color=:red, label=false)

  display(p)
  savefig(p, "fourier_spectrum.png")
end

function plot_data(t::Union{Vector{Float64}, Vector{Int64}}, u::Vector{Float64})
  p = Plots.plot(t, u, label = "B(t)", xlabel = "Time", ylabel = "Magnetic Field Strength", 
  title = "Simulated data", linewidth = 1)
  display(p)
  savefig(p, "simulated_data_plot.png")
end
  
# function for plotting u and epsilon behaviour in the sABC simulation
function u_eps_plot(eps_hist, u_hist)
  p1 = Plots.plot(vec(Matrix(eps_hist)), title="Epsilon History", xlabel="Iteration", legend=false, yscale=:log10)
  p2 = Plots.plot(vec(Matrix(u_hist)), title="U History", xlabel="Iteration", legend=false)

  combined_plot = Plots.plot(p1, p2, layout=(1, 2), size=(1000, 400))

  display(combined_plot)
  savefig(combined_plot, "u_eps_plot.png")
end

# function for plotting of rhos behaviour in the sABC simulation
function rho_plot(rho_hist; style::String = "together")
  if style == "divided"
    rho_plots = []

    for i in 1:20
      push!(rho_plots, Plots.plot(Matrix(rho_hist)[i, :], title="Rho History Stat $i", xlabel="Iteration", legend=false, yscale=:log10))
    end

    combined_plot = Plots.plot(rho_plots..., layout=(5, 4), size=(1200, 1800))

    display(combined_plot)
    savefig(combined_plot, "rho_divided.png")

  elseif style == "together"
    labels = ["rho$i" for i in 1:size(Matrix(rho_hist), 1)]

    all_rho_plot = Plots.plot(title="All Rho History", xlabel="Iteration", ylabel="Rho", legend=true, yscale=:log10)
    for i in 1:size(Matrix(rho_hist), 1)
      Plots.plot!(1:size(Matrix(rho_hist), 2), Matrix(rho_hist)[i, :], label=labels[i])
    end

    display(all_rho_plot)
    savefig(all_rho_plot, "rho_together.png")
  else
    throw(ErrorException("Invalid style: $style. The accepted styles are \"divided\" or \"together\""))
  end
end 

# Function for plotting the posterior as a corner plot
function post_plotting_real(post_par)
  p = pairplot(post_par)

  display(p)
  CairoMakie.save("posteriors.png", p)
end

function post_plotting_sim(posterior_params, true_vals)
  p = pairplot(
    posterior_params,
    PairPlots.Truth(
        (;
            N_value = true_vals[1],
            T_value = true_vals[2],
            tau_value = true_vals[3],
            sigma_value = true_vals[4],
            Bmax_value = true_vals[5]
        ),
        
        label="True Values"
    )
  )

  display(p)
  CairoMakie.save("posteriors.png", p)
end

# Function for plotting the rhos in a loglog scale
function rho_history(rho_hist)
  labels = ["rho$i" for i in 1:size(Matrix(rho_hist), 1)]
  
  all_rho_plot = Plots.plot(title = "All Rho History", xlabel = "Iteration", ylabel = "Rho", legend = true, yscale = :log10, xscale = :log10)
  
  for i in 1:size(Matrix(rho_hist), 1)
      Plots.plot!(1:size(Matrix(rho_hist), 2), Matrix(rho_hist)[i, :], label = labels[i])
  end
  
  display(all_rho_plot)
end


end