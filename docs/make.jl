using DigitalSlideArchive
using Documenter

DocMeta.setdocmeta!(DigitalSlideArchive, :DocTestSetup, :(using DigitalSlideArchive); recursive=true)

makedocs(;
    modules=[DigitalSlideArchive],
    authors="Kevin Bonham <kevin@bonham.ch> and contributors",
    sitename="DigitalSlideArchive.jl",
    repo = "https://gitlab.com/woodruff-lab/DigitalSlideArchive.jl",
    format=Documenter.HTML(;
        repolink = "https://gitlab.com/woodruff-lab/DigitalSlideArchive.jl",
        canonical="https://woodruff-lab.gitlab.io/DigitalSlideArchive.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Getting Started" => "getting_started.md"
    ],
)
