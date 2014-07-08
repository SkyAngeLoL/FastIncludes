Fast Includes
============

Fast includes functions


```lua
includeCL("lua/myaddon/client_file.lua")
```
for client side

```lua
includeSH("lua/myaddon/shared_file.lua")
```
for shared sides

```lua
includeSV("lua/myaddon/server_file.lua")
```
for server side

```lua
includeCLFolder("lua/myaddon")
includeSHFolder("lua/myaddon")
includeSVFolder("lua/myaddon")
```
Loading all files to the needed side




```lua
includeRSFolder("lua/myaddon")
```
Loading all files from folder with tags `"cl_"` and `"sv_"`. Other files are considered shared
