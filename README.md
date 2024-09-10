# DigitalSlideArchive

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://woodruff-lab.gitlab.io/DigitalSlideArchive.jl/dev)
[![Build Status](https://github.com/woodruff-lab/DigitalSlideArchive.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/woodruff-lab/DigitalSlideArchive.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Build Status](https://gitlab.com/woodruff-lab/DigitalSlideArchive.jl/badges/main/pipeline.svg)](https://gitlab.com/woodruff-lab/DigitalSlideArchive.jl/pipelines)
[![Coverage](https://gitlab.com/woodruff-lab/DigitalSlideArchive.jl/badges/main/coverage.svg)](https://gitlab.com/woodruff-lab/DigitalSlideArchive.jl/commits/main)
[![Coverage](https://codecov.io/gh/woodruff-lab/DigitalSlideArchive.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/woodruff-lab/DigitalSlideArchive.jl)

## Usage

### Getting an API key

With an account on a DSA server,
click on your user name in the upper right hand corner,
and select "My Acount".
Switch to the "🔑 API Keys" tab,
and then click "Create new key"

![Make API key](docs/src/assets/api_key.avif)

Give the key a name,
optionally restrict the permissions for the key,
and then click "➕ Create".
Click "show" in the newly created line,
and copy the alphanumeric text.

![Get API key](docs/src/assets/api_key2.avif)

!> [!WARNING]
> This Key enables anyone to access the server and perform all actions that you can.
> DO NOT share this key or add it to any publicly accessible code.
