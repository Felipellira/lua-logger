# Lua Logger

A very simple logger for my lua projects

## Example

```lua
require "Logger.lua"

local logger = Logger:new(Logger.loggerLevels.TRACE, "My Module")
logger:trace("A log example")
```