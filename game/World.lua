CWorld = Class{}

function CWorld:createWorld()
  base.dbg("creating world...")
  for y=5,self.y do
    for x=0,self.x do
      self.WORLD[y*self.x + x] = math.random(0,1)
    end
  end
  self.WORLD[122] = 1
end

function CWorld:init(x, y)
  base.dbg("create world with size x=" .. x .. " y=" .. y)
  self.x = x
  self.y = y
  self.WORLD = {}
  self.TILE_SIZE = 60
  self:createWorld()
end

function CWorld:setXY(x,y, value)
  index = y*self.x+x
  self.WORLD[index] = value
  return index
end

function CWorld:getTileXY(x,y)
  return self.WORLD[y*self.x+x]
end

function CWorld:getIndexXY(x,y)
  return y*self.x+x
end

function CWorld:getXY(index)
  y = math.floor(index / self.x)
  x = index - y * self.x
  return x, y
end

return CWorld

