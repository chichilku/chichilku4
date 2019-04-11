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

function CRender:relative(x, y, w ,h)
  center_x = love.graphics.getWidth() / 2
  center_y = love.graphics.getHeight() / 2

  -- love.graphics.rectangle("fill", (self.scroll_x + x) * world.TILE_SIZE, (self.scroll_y + y) * world.TILE_SIZE, w, h);
  -- love.graphics.rectangle("fill", self.scroll_x + x, self.scroll_y + y, w, h);
  love.graphics.rectangle("fill", (self.scroll_x + x) * world.TILE_SIZE + center_x, (self.scroll_y + y) * world.TILE_SIZE + center_y, w, h);
end

return CRender

