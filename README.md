# 开心农场

这是一个参考web2.0开心网上偷菜游戏的全链游戏。

## 相关概念介绍

- 植物介绍:

1. 不同的植物，初始值均为 50 。
2. 植物 会根据当前地块的 风雨雪阳光，做出回馈，成长的快与慢，由植物种类定义。
3. 当植物达到 收获值(目前均为 100）的时候，玩家可以完成收获。
4. 收割的时候，植物对应的积分会返还相应的玩家。(不同用户的植物均可以互相收获，只是积分会返回给植物的所有者)

- 地块介绍:

1. 玩家购买地块，目前消耗50积分。
2. 地块用于种植植物，一个地块做多种植10个植物。
3. 玩家可以把植物种植在其他玩家的地块。收获的时候，需要转移 5积分给地块所有者

- 技能介绍:

1. 玩家可以对地块施加技能。该技能会作用在地块内的所有植物。 
2. 技能分为 : 雨 雪 风 阳光 四种。 释放技能会消耗对应的积分，消耗数值在游戏初始化的时候完成。
3. 不同类型的植物会对不同的技能，做出回馈,表现为 score 的变化。
4. 当 植物的积分达到100 的时候，可以完成植物的收获，收获后，完成积分返还。

## 游戏流程

0. 部署游戏，使用 [initPlants.ts](./scripts/initPlants.ts) 完成种植植物类型初始化
1. 注册游戏，获得初始积分 800
2. 使用积分购买地块，初始定价 50 积分一个地块
3. 种植植物
4. 施加技能
5. 收获植物
