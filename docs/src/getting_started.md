
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
   See the next section if you need an API key.

### Getting an API key

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

!> [!WARNING]
> This Key enables anyone to access the server and perform all actions that you can.
> DO NOT share this key or add it to any publicly accessible code.


```@index
```

```@autodocs
Modules = [DigitalSlideArchive]
```
