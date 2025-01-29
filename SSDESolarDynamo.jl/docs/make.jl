using SDDESolarDynamo
using Documenter

DocMeta.setdocmeta!(SDDESolarDynamo, :DocTestSetup, :(using SDDESolarDynamo); recursive=true)

makedocs(;
    modules=[SDDESolarDynamo],
    authors="Lorenzo Calandra Buonaura, Lucrezia Rossi and Andrea Turci",
    repo="https://github.com/Kallo27/LCP_B/tree/main/SSDESolarDynamo.jl/blob/{commit}{path}#{line}",
    sitename="SSDESolarDynamo.jl",
    checkdocs=:exports,
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Kallo27.github.io/SSDESolarDynamo.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "index.md",
        "usage.md",
        #"Example" => "example.md",
        #"API" => "api.md",
        #"Related packages" => "related.md"
    ],
)

deploydocs(;
    repo="github.com/Kallo27/LCP_B/tree/main/SSDESolarDynamo.jl",
    devbranch="main",
)