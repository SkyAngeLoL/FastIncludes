Fast includes functions
-----------------
For client side:

```lua
includeCL("lua/myaddon/client_file.lua")
```

For shared sides:

```lua
includeSH("lua/myaddon/shared_file.lua")
```

For server side:

```lua
includeSV("lua/myaddon/server_file.lua")
```

Loading all files to the needed side:

```lua
includeCLFolder("lua/myaddon")
includeSHFolder("lua/myaddon")
includeSVFolder("lua/myaddon")
```

Loading all files from folder with tags `"cl_"` and `"sv_"`. Other files are considered shared:

```lua
includeRSFolder("lua/myaddon")
```
