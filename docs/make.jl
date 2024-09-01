using DigitalSlideArchive
using Documenter

DocMeta.setdocmeta!(DigitalSlideArchive, :DocTestSetup, :(using DigitalSlideArchive); recursive=true)

makedocs(;
    modules=[DigitalSlideArchive],
    authors="Kevin Bonham <kevin@bonham.ch> and contributors",
    sitename="DigitalSlideArchive.jl",
    format=Documenter.HTML(;
        canonical="https://kescobo.gitlab.io/DigitalSlideArchive.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
