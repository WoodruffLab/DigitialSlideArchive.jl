
```@meta
CurrentModule = DigitalSlideArchive
```

# Getting started

Just about everything in this package is built around the [`DSAClient`](@ref),
which is a thin wrapper around the python-provided `girder_client.GirderClient`.
In order to interact with your DSA server, you will need

1. An API url. Typically, this is the url of your server followed by `/api/v1`,
   eg. `http://multiplex.pathology.emory.edu:8080/api/v1`
2. An API key. This is what allows you to authenticate with the server.
   See the [the authentication section](#getting-an-api-key) if you need an API key.

## Set-up

Once you have your URL and [api key](#getting-an-api-key),
set the environment variables `DSA_API_URL` and `DSA_API_KEY`.

The way to do this depends on your shell.
If you are a mac user, your default shell is probably `zsh`,
and you can set environment variables using `export`, eg

```zsh
export DSA_API_URL="http://multiplex.pathology.emory.edu:8080/api/v1"
export DSA_API_KEY="your-key-here"
```

This can be done in your shell before launching julia,
or these lines can be added to your `~/.zshrc` file.
Alternatively (and this is recommended),
use something like [`direnv`](https://direnv.net)
to set these variables when you are running code from within a particular directory.

!!! note
    You can instead pass the URL and key strings
    to the [`DSAClient()`](@ref) functions
    directly, but this is not recommended,
    since if this code gets shared, it could reveal your API key
    to other users, giving them full access to your server and data.

### Connecting to the DSA girder client

Don't worry if you don't know what `girder` is -
it's just the underlying code that makes it easy for the server
(where the DSA is running) and the client (your computer) to communicate.

To enable this communication, use the [`DSAClient()`](@ref) function.
If you have the environmental variables set,
you can simply call the function without arguments -
but be sure to assign it to a variable
```julia
import DigitalSlideArchive as DSA

client = DSAClient()
```

## Getting an API key

With an account on a DSA server,
click on your user name in the upper right hand corner,
and select "My Acount".
Switch to the "🔑 API Keys" tab,
and then click "Create new key"

![Make API key](assets/api_key.avif)

Give the key a name,
optionally restrict the permissions for the key,
and then click "➕ Create".
Click "show" in the newly created line,
and copy the alphanumeric text.

![Get API key](assets/api_key2.avif)

!!! warning
    This Key enables anyone to access the server and perform all actions that you can.
    DO NOT share this key or add it to any publicly accessible code.

```@index
```

```@autodocs
Modules = [DigitalSlideArchive]
```
