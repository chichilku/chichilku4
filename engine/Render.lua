CRender = Class{}

function CRender:init(x, y)
  base.dbg("init render with scroll x=" .. x .. " y=" .. y)
  self.scroll_x = x
  self.scroll_y = y
end

function CRender:renderObjs()
  for k, v in pairs(T_OBJS)
  do
    v:render()
  end
end

-- pixel2unit:
function CRender:p2u(pixel)
  return pixel / world.TILE_SIZE
end

-- unit2pixel:
function CRender:u2p(pixel)
  return pixel * world.TILE_SIZE
end

function CRender:getScrollX(x)
  center_x = love.graphics.getWidth() / 2
  return (self.scroll_x + x) * world.TILE_SIZE + center_x
end

function CRender:getScrollY(y)
  center_y = love.graphics.getHeight() / 2
  return (self.scroll_y + y) * world.TILE_SIZE + center_y
end

function CRender:relative(x, y, w ,h)
  -- love.graphics.rectangle("fill", (self.scroll_x + x) * world.TILE_SIZE, (self.scroll_y + y) * world.TILE_SIZE, w, h);
  -- love.graphics.rectangle("fill", self.scroll_x + x, self.scroll_y + y, w, h);
  love.graphics.rectangle("fill", self:getScrollX(x), self:getScrollY(y), self:u2p(w), self:u2p(h));
  -- base.dbg("rect X=" .. self:getScrollX(x) .. " Y=" .. self:getScrollY(y) .. " size=" .. w .. "x" .. h)
end

function CRender:relativeTxt(text, x, y)
  love.graphics.print(text, self:getScrollX(x), self:getScrollY(y))
end

function CRender:hitbox(x, y, w, h)
  love.graphics.setColor(100, 200, 100, 220)
  -- sizes
  ds = self:p2u(10)
  ls = self:p2u(3)
  x_raw = x
  y_raw = y
  -- dots
  x = x_raw - (ds / 2)
  y = y_raw - (ds / 2)
  render:relative(x, y, ds, ds)         render:relative(x + w, y, ds, ds)
  render:relative(x, y + h, ds, ds)     render:relative(x + w, y + h, ds, ds)
  -- lines
  x = x_raw - (ls / 2)
  y = y_raw - (ls / 2)
  --  |                                             |
  --  |                                             |
  --  |                                             |
  --  |                                             |
  render:relative(x, y, ls, h)    render:relative(x + w, y, ls, h)
  --
  -- -----------------------------------------------
  --
  --
  --
  render:relative(x, y, w, ls)
  --
  --
  --
  -- -----------------------------------------------
  --
  render:relative(x, y + h, w, ls)
  love.graphics.setColor(1, 1, 1, 255)
end

return CRender
