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
  self.w = render:p2u(60) -- width
  self.h = render:p2u(60) -- height
  self.id = CURRENT_ENTITY_ID
end

function CEntity:render()
  love.graphics.setColor(255, 255, 255, 255)
  render:relative(self.x, self.y, self.w, self.h)
  if (cfg.isDebug)
  then
    -- ids
    render:relativeTxt("E=" .. self.id, self.x + (self.w * 0.01) / 2, self.y - (self.h * 0.01))
    -- hitbox
    render:hitbox(self.x, self.y, self.w, self.h)
  end
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

function CEntity:collideXY(pos1, size1, pos2, size2)
  if (pos1 + size1 > pos2)
  then
    if (pos1 < pos2 + size2)
    then
      return true
    end
  end
  return false
end

function CEntity:collideX(other)
  sx = self.x
  sw = self.w
  ox = other.x
  ow = other.w
  return self:collideXY(sx, sw, ox, ow)
end

function CEntity:collideY(other)
  sy = self.y
  sh = self.h
  oy = other.y
  oh = other.h
  return self:collideXY(sy, sh, oy, oh)
end

function CEntity:collide(other)
  if other.id == self.id
  then
    return
  end
  if self:collideX(other) and self:collideY(other)
  then
    -- base.dbg("colliding with other=" .. other:toString())
    -- calculate centers
    scx = self.last_x + (self.w / 2)
    ocx = other.last_x + (other.w / 2)
    scy = self.last_y + (self.h / 2)
    ocy = other.last_y + (other.h / 2)
    if scx < ocx
    then
      self.dx = 0
      self.x = other.x - self.w
      base.dbg("collide with right side")
    elseif scx > ocx
    then
      self.dx = 0
      self.x = other.x + other.w
      base.dbg("collide with left side")
    elseif scy > ocy
    then
      self.dy = 0
      self.y = other.y + other.h
      base.dbg("collide with left side")
    elseif scy > ocy
    then
      self.dy = 0
      self.y = other.y + other.h
      base.dbg("collide with left side")
    end
  end
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
    self.y = 10
    self.jumps = 2
  end
end

return CEntity
