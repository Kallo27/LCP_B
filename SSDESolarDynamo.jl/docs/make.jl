# Add the src directory to the LOAD_PATH
push!(LOAD_PATH, "./src")

# Include the SDDESolarDynamo.jl file from the src directory
include("../src/SDDESolarDynamo.jl")

# Use the module
using .SDDESolarDynamo
using Documenter

#DocMeta.setdocmeta!(SDDESolarDynamo, :DocTestSetup, :(using SDDESolarDynamo); recursive=true)

makedocs(;
    modules=[SDDESolarDynamo],
    authors="Lorenzo Calandra Buonaura, Lucrezia Rossi, Andrea Turci",
    repo="https://github.com/Kallo27/LCP_B",  # Keep this as a string
    sitename="SSDESolarDynamo.jl",
    checkdocs=:exports,
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Kallo27.github.io/SSDESolarDynamo.jl",
        edit_link="main",
        assets=String[],
        inventory_version="0.1.0",
        repolink="https://github.com/Kallo27/LCP_B"  # Set repolink explicitly
    ),
    pages=[
        "index.md",
        #"usage.md",
        #"Example" => "example.md",
        #"API" => "api.md",
        #"Related packages" => "related.md"
    ],
)

deploydocs(;
    repo="github.com/Kallo27/LCP_B/tree/main/SSDESolarDynamo.jl",
    devbranch="main",
)