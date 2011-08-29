-- Module to generate and draw the background

background = {}
background.cameraScale = 0.3
background.xTiles = math.ceil(width / tileSize)
background.yTiles = math.ceil(height / tileSize) + 1
background.width = background.xTiles * tileSize
background.height = background.yTiles * tileSize
background.base = love.graphics.newSpriteBatch(tiles, background.xTiles * background.yTiles)

for x = 0, background.xTiles - 1 do
  for y = 0, background.yTiles - 1 do
    background.base:addq(quads[26], x * tileSize, y * tileSize, 0, 2)
  end
end

local function newBuffer()
  local batch = love.graphics.newSpriteBatch(tiles, background.xTiles * background.yTiles)
  local camY = camera.y * background.cameraScale
  background.buffer2 = background.buffer
  background.buffer = {
    image = batch,
    y = camY - background.height - (camY - (background.lastCameraY or camY)) - 15
  }
  
  for i = 1, math.random(2, 10) do
    local length = math.random(1, 5)
    local type = math.random(22, 25)
    
    if math.random(0, 1) == 0 then
      local xPos = math.random(0, background.xTiles - 1 - length)
      local y = math.random(0, background.yTiles - 1) * tileSize
      
      for x = xPos, xPos + length do
        batch:addq(quads[type], x * tileSize, y, 0, 2)
      end
    else
      local x = math.random(0, background.xTiles - 1) * tileSize
      local yPos = math.random(0, background.yTiles - 1 - length)
      
      for y = yPos, yPos + length do
        batch:addq(quads[type], x, y * tileSize, 0, 2)
      end
    end
  end
end

function background.reset()
  background.buffer = nil
  newBuffer()
  background.buffer.y = camera.y - 15
  newBuffer()
  background.buffer.y = camera.y - background.height - 15
end

function background.update(dt)
  if background.buffer.y >= camera.y * background.cameraScale - 15 then newBuffer() end
  background.lastCameraY = camera.y * background.cameraScale
end

function background.draw()
  if background.buffer then
    love.graphics.draw(background.base, 0, background.buffer.y)
    love.graphics.draw(background.buffer.image, 0, background.buffer.y)
  end
  
  if background.buffer2 then
    love.graphics.draw(background.base, 0, background.buffer2.y)
    love.graphics.draw(background.buffer2.image, 0, background.buffer2.y)
  end
end
