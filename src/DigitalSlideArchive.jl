module DigitalSlideArchive

export DSAClient,
       DSAResponse,
       get_collection,
       list_folders,
       list_files,
       get_item,
       get_files,
       upload_file,
       create_folder

using PythonCall

const girder_client = Ref{Py}()

function __init__()
girder_client[] = pyimport("girder_client")
end


"""
    DSAClient(; url, key)

This is a thin wrapper around the `girder_client.GirderClient`
type provided by the `girder_client` python package
that can be used for interactiving with a DSA server.

A url for the API is required, but can be set
with the `DSA_API_URL` environmental variable.
If not set before starting julia,
this can be added using the `ENV` dictionary.
Eg.

```julia
using DigitalSlideArchive
client = DSAClient(; url = "http://multiplex.pathology.emory.edu:8080/api/v1")

# OR:

ENV["DSA_API_URL"] = "http://multiplex.pathology.emory.edu:8080/api/v1"
client = DSAClient()
```

If the `key` argument is provided (not recommended, see [`authenticate!`](@ref)),
or the `DSA_API_KEY` variable is set,
the client will automatically be authenticated.
"""
struct DSAClient
    api_url
    client

    function DSAClient(; url=ENV["DSA_API_URL"], key=get(ENV, "DSA_API_KEY", nothing))
        gc = girder_client[].GirderClient(; apiUrl = url)
        dsa_client = new(url, gc)
        !isnothing(key) && authenticate!(dsa_client; key)
        return dsa_client
    end
end


function Base.getproperty(dsa_client::DSAClient, field::Symbol)
    if field ∈ (:api_url, :client)
        getfield(dsa_client, field)
    else
        getproperty(dsa_client.client, field)
    end
end

Base.propertynames(dsa_client::DSAClient) = vcat([:api_url, :client], propertynames(dsa_client.client))

struct DSAResponse
    resp::Dict
end

function DSAResponse(resp::PythonCall.Core.Py)
    DSAResponse(pyconvert(Dict, resp))
end

Base.getindex(resp::DSAResponse, key) = resp.resp[key]
Base.get(resp::DSAResponse, key, default=nothing) = get(resp.resp, key, default)
function Base.show(io::IO, ::MIME"text/plain", resp::DSAResponse)
    println(io, "DSAResponse containing:")
    show(io, MIME"text/plain"(), resp.resp)
end

"""
    authenticate!(client::DSAClient; key)

Authenticate the girder client using the provided API `key`.
By default, this will look for the enviroment variable `DSA_API_KEY`.
In principle, you can pass this in your code or add it to `ENV`
as described in [`DSAClient`](@ref), but this is not recommended,
since it's quite easy to accidentally commit that code.

!!! warning
    Anyone that has your API key may have full access to all
    data on your DSA server, including the ability to modify or delete it!
    Make sure to keep this plain-text key secure.


```julia
client = DSAClient(; url = "http://multiplex.pathology.emory.edu:8080/api/v1")
DigitalSlideArchive.authenticate!(gc)
```

!!! note
    When creating a [`DSAClient`](@ref), if an API key is provided
    (either in the constructor or using the environmental variable)
    the authentication will happen automatically.
"""
function authenticate!(dsa_client::DSAClient; key = ENV["DSA_API_KEY"])
    dsa_client.authenticate(; apiKey=key )
    return dsa_client
end

# TODO: use Preferences.jl and/or set up user-input using TerminalMenus

get_collection(client::DSAClient, id) = DSAResponse(client.getCollection(id))
get_collection(client::DSAClient, resp::DSAResponse) = DSAResponse(client.getCollection(resp["_id"]))

function list_folders(client::DSAClient, resp::DSAResponse)
    dirs = client.listFolder(resp["_id"]; parentFolderType=resp["_modelType"])
    return [DSAResponse(dir) for dir in dirs]
end

function list_files(client::DSAClient, resp::DSAResponse)
    files = client.listItem(resp["_id"])
    return [DSAResponse(file) for file in files]
end

"""
    get_item(client, item)

Get item with specified `item` "_id".
"""
get_item(client::DSAClient, item) = DSAResponse(client.get("item/$item"))


"""
    get_files(client, item)

Get files stored in `item` "_id".
"""
function get_files(client::DSAClient, item)
    resp = client.get("item/$item/files")
    [DSAResponse(v) for v in pyconvert(Vector, resp)]
end


function create_folder(client::DSAClient, parent_resp::DSAResponse, name)
    DSAResponse(client.loadOrCreateFolder(name, parent_resp["_id"], parent_resp["_modelType"]))
end

function upload_file(client::DSAClient, folder_id, file_path)
    DSAResponse(client.uploadFileToFolder(folder_id, file_path))
end

end # module DigitalSlideArchive
