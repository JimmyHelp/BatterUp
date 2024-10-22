# BatterUp

## How to Use:

1. To user BatterUp, first initialize it with this line of code:

```lua
local batterUp = require("BatterUp")
```

2. Then, add your animations to a table, this is code from the example avatar:

```lua
local anim = animations.model

local chained = {
	anim.chain1,
	anim.chain2,
	anim.chain3,
}
```

3. And finally, run the function to add the animations

```lua
batterUp:addChainedSwings(chained,"right","wooden_sword","attack",true,20)
```
