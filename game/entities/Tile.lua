-- https://github.com/vrld/hump/blob/master/class.lua
Class = require "../../other/class"
base = require "../../base/base"

CTile = Class{}

function CTile:init(x, y)
  base.dbg("create new tile at x=" .. x .. " y=" .. y)
  self.x = x
  self.y = y
  self.id = CURRENT_ENTITY_ID
end

function CTile:render()
  -- love.graphics.rectangle("fill", self.x * world.TILE_SIZE, self.y * world.TILE_SIZE, world.TILE_SIZE, world.TILE_SIZE);
  render:relative(self.x, self.y, world.TILE_SIZE, world.TILE_SIZE);
end

function CTile:toString()
  return "[<CTile> id=" .. self.id .. " x=" .. self.x .. " y=" .. self.y .. "]"
end

function CTile:onTick(dt)
  -- called every tick for every tile
end

return CTile






