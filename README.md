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

## Chained Swings

The `addChainedSwings` function has 6 arguments

1. The table containing the animations, it must have 2 or more animations in it
2. A string "left" or "right" which determines if the chains should only play when the left or right arm is swinging, by default this is nil and will play when either arm swings
3. A string for the item's Minecraft ID or it's name. Inserting an id/name will make it only play the animations when swinging with that weapon
4. A string to determine if the animation should play while attacking or mining. Options are "attack" or "mine", by default the animation will play during either circumstance
5. A boolean to determine if the animation's speed should match the vanilla animation's length, by default it won't change the animation speed
6. A number in ticks, determines how long it should wait before resetting the chain, by default it won't reset the chain

## Randomized Swings

The `addRandomSwings` function has 5 arguments

1. The table containing the animations, it must have 2 or more animations in it
2. A string "left" or "right" which determines if the chains should only play when the left or right arm is swinging, by default this is nil and will play when either arm swings
3. A string for the item's Minecraft ID or it's name. Inserting an id/name will make it only play the animations when swinging with that weapon
4. A string to determine if the animation should play while attacking or mining. Options are "attack" or "mine", by default the animation will play during either circumstance
5. A boolean to determine if the animation's speed should match the vanilla animation's length, by default it won't change the animation speed
