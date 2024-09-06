module DigitalSlideArchive

export girder_client,
  gc_auth

using CondaPkg
using PythonCall

girder_client = pyimport("girder_client")
gc_auth(; apiUrl=ENV["DSA_API_URL"]) = girder_client.GirderClient(; apiUrl)



end
