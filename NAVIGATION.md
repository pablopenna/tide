# Navigation

I struggled to get Navigation2D working properly as the navigation agent was getting stuck on corners or trying to go straight through walls.

I managed to solve it by adjusting the different parameters.


## NavigationRegion2D
The most important parameters are the cell size and the agents radius
* Cell Size: The smaller it is, the more accurate the pathfinding but also the more expensive to calculate it is. If you change it, it is better to use the same value under Project > Project settings > Navigation 2D > Default cell size. If not, you might get some errors on the console.

The default value is 1. Increase it if you find pathfinding in your game is computationally too expensive.

The sweetspot seems to be between 1/2 and 1/4 your tile size. In my game it is 16px, so 4 or 8 is nice.

* Agents Radius: This is critical. This parameter indicates how much margin the navigation polygon will use for obstacles or walls. If it is too high, the navigation agents will try to go through obstacles/walls. If too little, it will be easy for agents to get stuck.

The default value is 10, which at least in my case did not work properly. Agents got stuck in turns and tried to go straight through walls. After tunning it to match the sweetspot, navigation works much better.

The sweetspot seems to be slightly under half of the tile size. In my case the tile size is 16px, so 7px of radius seems to be value to use.
 
## NavigationAgent2D
Most relevant parameters in my case were:
* Path desired distance: distance threshold before a path point is considered to be reached. I think this varies a lot depending on how you want the agent to behave, but I guess a good value is between tile size to half tile size.

* Target desired distance: distance threshold to the target position before the agent considers it reached. Similar to the previous one, it depends on how you want the agent to behave but I think any value under tile size should be fine.

## CharacterBody2D
In this case, the game is setup as a 2D game with cenital view, thus the CharacterBody2Ds have the mode set to floating.The min slide angle is better at 0º so that it does not get stuck in corners.


Source: https://www.youtube.com/watch?v=31bVq2z6mME
