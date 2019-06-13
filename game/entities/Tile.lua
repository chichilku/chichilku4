-- https://github.com/vrld/hump/blob/master/class.lua
Class = require "../../other/class"
base = require "../../base/base"

CTile = Class{}

function CTile:init(x, y)
  base.dbg("create new tile at x=" .. x .. " y=" .. y)
  self.x = x
  self.y = y
  self.last_x = x -- doesn't change but used for collison
  self.last_y = y -- doesn't change but used for collison
  self.w = render:p2u(world.TILE_SIZE)
  self.h = render:p2u(world.TILE_SIZE)
  self.id = CURRENT_ENTITY_ID
end

function CTile:render()
  render:relative(self.x, self.y, self.w, self.h);
end

function CTile:toString()
  return "[<CTile> id=" .. self.id .. " x=" .. self.x .. " y=" .. self.y .. "]"
end

function CTile:onTick(dt)
  -- called every tick for every tile
end

return CTile






