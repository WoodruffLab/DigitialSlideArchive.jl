module DigitalSlideArchive

export DSAClient

using PythonCall
girder_client = pyimport("girder_client")

"""
    DSAClient

This is a thin wrapper around the `girder_client.GirderClient`
type provided by the `girder_client` python package.

The best way to create this is to use [the `DSA.client` function](@ref DigitalSlideArchive.client)
"""
struct DSAClient
    api_url
    client
end

function Base.getproperty(dsa_client::DSAClient, field::Symbol)
    if field == :api_url
        getfield(dsa_client, :field)
    else
        getproperty(dsa_client.client, field)
    end
end

Base.propertynames(dsa_client::DSAClient) = vcat([:api_url, :client], propertynames(dsa_client.client))


"""
    client(; url, key)

Create a girder client object that can be used
for interactiving with a DSA server.

A url for the API is required, but can be set
with the `DSA_API_URL` environmental variable.
If not set before starting julia,
this can be added using the `ENV` dictionary.
Eg.

```julia
using DigitalSlideArchive as DSA
gc = DSA.client(; url = "http://multiplex.pathology.emory.edu:8080/api/v1")

# OR:

ENV["DSA_API_URL"] = "http://multiplex.pathology.emory.edu:8080/api/v1"
gc = DSA.client()
```

If the `key` argument is provided (not recommended, see [`authenticate!`](@ref)),
or the `DSA_API_KEY` variable is set,
the client will automatically be authenticated.
"""
function client(; url = ENV["DSA_API_URL"], key=get(ENV, "DSA_API_KEY", nothing))
    gc = girder_client.GirderClient(; url)
    dsa_client = DSAClient(url, gc)
    !isnothing(key) && authenticate!(dsa_client; key)
    return dsa_client
end

# TODO: use Preferences.jl and/or set up user-input using TerminalMenus

"""
    authenticate!(client; key)

Authenticate the girder client using the provided API `key`.
By default, this will look for the enviroment variable `DSA_API_KEY`.
In principle, you can pass this in your code or add it to `ENV`
as described in [`DSA.client`](@ref DigitalSlideArchive.client), but this is not recommended,
since it's quite easy to accidentally commit that code.

!!! warn
    Anyone that has your API key may have full access to all
    data on your DSA server, including the ability to modify or delete it!
    Make sure to keep this plain-text key secure.


```julia
using DigitalSlideArchive as DSA
gc = DSA.client(; url = "http://multiplex.pathology.emory.edu:8080/api/v1")
DSA.authenticate!(gc)
```
"""
function authenticate!(dsa_client::DSAClient; key = ENV["DSA_API_KEY"])
    dsa_client.auth!(; apiKey=key )
    return dsa_client
end

# TODO: use Preferences.jl and/or set up user-input using TerminalMenus

"""
    get_folders(client)

"""

end
