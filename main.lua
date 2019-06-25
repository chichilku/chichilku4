-- globals
Class = require "other/class"
base = require "base/base"

-- locals
local CConfig = require "base/Config"
local CRender = require "engine/Render"
local CHud = require "game/Hud"
local CWorld = require "game/World"
local CControls = require "game/Controls"
local CTile = require "game/entities/Tile"
local CEntity = require "game/entities/Entity"

cfg = CConfig()
render = CRender(0,0)
CURRENT_ENTITY_ID = 0
T_OBJS = {}

GRAVITY_MAX_VEL = 4
GRAVITY_VEL = 1
TICKS = 0

function addEntitie(entity)
  base.dbg("inserting entitiy " .. entity:toString())
  -- T_OBJS[#T_ENTITIES+1]=entity -- cool dynamic way
  T_OBJS[CURRENT_ENTITY_ID]=entity -- making sure table index is same as entitiy id
  CURRENT_ENTITY_ID = CURRENT_ENTITY_ID + 1
end

function love.load()
  love.window.setMode(800, 600, {resizable=true, vsync=false, minwidth=400, minheight=300})
  controls = CControls()
  hud = CHud()
  world = CWorld(10,10)
  addEntitie(CEntity(4,4)) -- player
  addEntitie(CEntity(5,4)) -- random falling thing
  addEntitie(CTile(2,2))
  addEntitie(CTile(3,3))
  r = 0
end

function love.draw()
  player = T_OBJS[0]
  render.scroll_x = -player.x
  render.scroll_y = -player.y
  render:relative(-10, 11, 30 * world.TILE_SIZE, 1 * world.TILE_SIZE)
  render:renderObjs()
  hud:render(player)
  if (TICKS % 10 == 0)
  then
    r = r + 1
  end
  if (r > 360)
  then
    r = 0
  end
  base.dbg("r=" .. r)
  render:poly(200, 200, 100, 100, r)
end

function love.update(dt)
  TICKS = TICKS + 1
  player = T_OBJS[0]
  controls:tick(player, dt)
  for k, v in pairs(T_OBJS)
  do
    v:onTick(dt)
    player:collide(v)
  end
  T_OBJS[0] = player
end

function love.keypressed( key, isrepeat )
  if (key == " ")
  then
    controls.space_pressed = true
  elseif (love.keyboard.isDown("q"))
  then
    love.event.quit()
  elseif (love.keyboard.isDown("o"))
  then
    cfg.isDebug = not cfg.isDebug
  elseif (love.keyboard.isDown("f"))
  then
    cfg.isFullscreen = not cfg.isFullscreen
    love.window.setMode(800, 600, {fullscreen=cfg.isFullscreen})
  end
end
