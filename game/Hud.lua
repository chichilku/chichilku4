CHud = Class{}

function CHud:init()
  base.dbg("initializing hud...")
end

function CHud:renderDebug(player)
  if (cfg.isDebug == false)
  then
    return
  end
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print("X: " .. player.x, 20, 20)
  love.graphics.print("Y: " .. player.y, 20, 40)
  love.graphics.print("DX: " .. player.dx, 20, 60)
  love.graphics.print("DY: " .. player.dy, 20, 80)
  love.graphics.print("scroll X: " .. render.scroll_x, 20, 100)
  love.graphics.print("scroll Y: " .. render.scroll_y, 20, 120)
end

function CHud:render(player)
  self:renderDebug(player)
  if TICKS % 50 == 0
  then
    -- base.dbg("player " .. player:toString())
  end
end

return CHud
