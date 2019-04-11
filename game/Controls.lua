CControls = Class{}

function CControls:init(x, y)
  base.dbg("create controls class...")
  self.space_pressed = false
end

function CControls:tick(player, dt)
  if player == nil
  then
    return
  end
  if (love.keyboard.isDown("a"))
  then
    player.x = player.x - 10 * dt
  end
  if (love.keyboard.isDown("d"))
  then
    player.x = player.x + 10 * dt
  end
  -- if (love.keyboard.isDown(" "))
  if (self.space_pressed)
  then
    player:doJump()
    self.space_pressed = false
  end
end

return CControls

