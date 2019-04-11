-- https://github.com/vrld/hump/blob/master/class.lua
Class = require "../../other/class"
base = require "../../base/base"

CEntity = Class{}

function CEntity:init(x, y)
  base.dbg("create new entity at x=" .. x .. " y=" .. y)
  self.x = x
  self.y = y
  self.last_x = x;
  self.last_y = y;
  self.dy = 0
  self.dx = 0
  self.jumps = 0
  self.w = 60 -- width
  self.h = 60 -- height
  self.id = CURRENT_ENTITY_ID
end

function CEntity:render()
  -- debug render last position
  -- love.graphics.setColor( 255, 255, 2, 255 )
  -- love.graphics.rectangle("fill", self.last_x * world.TILE_SIZE, self.last_y * world.TILE_SIZE, self.w, self.h);
  love.graphics.setColor( 255, 255, 255, 255 )
  -- love.graphics.rectangle("fill", self.x * world.TILE_SIZE, self.y * world.TILE_SIZE, self.w, self.h);
  render:relative(self.x, self.y, self.w, self.h);
end

function CEntity:doJump()
  if (self.jumps > 0)
  then
    self.dy = -0.2
    self.jumps = self.jumps - 1
    base.dbg("player[" .. self.id .. "] jumped! jumps=" .. self.jumps .. " dy=" .. self.dy)
  end
end

function CEntity:toString()
  return "[<CEntity> id=" .. self.id .. " x=" .. self.x .. " y=" .. self.y .. "]"
end

function CEntity:onTick(dt)
  self:gravity(dt)

  self.last_x = self.x -- keep this end of tick
  self.last_y = self.y -- keep this end of tick
end

function CEntity:gravity(dt)
  if (self.dy < GRAVITY_MAX_VEL)
  then
    self.dy = self.dy + GRAVITY_VEL * dt
  end
  self.y = self.y + self.dy
  if (self.y > 10) -- collide with floor
  then
    self.y = self.y - self.dy
    self.jumps = 2
  end
end

return CEntity

