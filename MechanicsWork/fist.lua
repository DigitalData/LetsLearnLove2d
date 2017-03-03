local fistObject = {};

function loadFist(World)
  fistSprite = love.graphics.newImage("assets/playermodels/swingModel.png");
  fistAnim = {};
  fistAnim.frameOne = love.graphics.newQuad(0, 0, 16, 16, fistSprite:getDimensions());
  fistAnim.frameTwo = love.graphics.newQuad(0, 16, 16, 16, fistSprite:getDimensions());
  fistAnim.frameThree = love.graphics.newQuad(0, 32, 16, 16, fistSprite:getDimensions());

  animationTimer = 0;
  animationTimerMax = 5;
  animationFrame = -1;

  canUseTimer = 0;
  canUseTimerMax = 20;
  canUse = true;
  inUse = false;
  used = false;

  fistX = 0;
  fistY = 0;
  fistAngle = 0

  fistHitboxB = love.physics.newBody(World, fistX + fistSprite:getWidth() / 2, fistY + fistSprite:getHeight() / 2, "kinematic");
  fistHitboxS = love.physics.newRectangleShape(16 * 4, 16 * 4);
  fistHitboxF = love.physics.newFixture(fistHitboxB, fistHitboxS, 0);
end

function drawFist()
  love.graphics.setColor(0, 0,0,255);
  love.graphics.print("Fists", love.graphics.getWidth() - 100, 100, 0, 2, 2);
  love.graphics.print(fistAngle, love.graphics.getWidth() - 100, 150, 0, 2, 2);

  love.graphics.setColor(255, 255,255,255);
  if(animationFrame == -1)then
  elseif(animationFrame == 0)then
    love.graphics.draw(fistSprite, fistAnim.frameOne, fistX, fistY, fistAngle, 4,4,9,18);
  elseif(animationFrame == 1)then
    love.graphics.draw(fistSprite, fistAnim.frameTwo, fistX, fistY, fistAngle, 4,4,9,18);
  elseif(animationFrame == 2)then
    love.graphics.draw(fistSprite, fistAnim.frameThree, fistX, fistY, fistAngle, 4,4,9,18);
  end
  love.graphics.setColor(0, 200, 200, 255);

  if(fistAngle >= 0 and fistAngle < math.pi)then
  love.graphics.rectangle("fill", (fistX + (18 * math.cos(fistAngle))), (fistY + (18 * math.sin(fistAngle))), 16 * 2, 16 * 2);
  love.graphics.rectangle("fill", (fistX - (18 * math.cos(fistAngle))), (fistY - (18 * math.sin(fistAngle))), 16 * 2, 16 * 2);
elseif(fistAngle >= math.pi / 2 and fistAngle < math.pi)then
  minus = math.pi / 2;
  love.graphics.rectangle("fill", (fistX + (18 * math.cos(fistAngle-minus))), (fistY + (18 * math.sin(fistAngle-minus))), 16 * 2, 16 * 2);
  love.graphics.rectangle("fill", (fistX - (18 * math.cos(fistAngle-minus))), (fistY - (18 * math.sin(fistAngle-minus))), 16 * 2, 16 * 2);
elseif(fistAngle >= math.pi and fistAngle < 3 * math.pi / 2)then
  minus = math.pi;
  love.graphics.rectangle("fill", (fistX + (18 * math.cos(fistAngle-minus))), (fistY + (18 * math.sin(fistAngle-minus))), 16 * 2, 16 * 2);
  love.graphics.rectangle("fill", (fistX - (18 * math.cos(fistAngle-minus))), (fistY - (18 * math.sin(fistAngle-minus))), 16 * 2, 16 * 2);
elseif(fistAngle >= 3 * math.pi/2)then
  minus = 3*math.pi / 2;
  love.graphics.rectangle("fill", (fistX + (18 * math.cos(fistAngle-minus))), (fistY + (18 * math.sin(fistAngle-minus))), 16 * 2, 16 * 2);
  love.graphics.rectangle("fill", (fistX - (18 * math.cos(fistAngle-minus))), (fistY - (18 * math.sin(fistAngle-minus))), 16 * 2, 16 * 2);
  end
end

function updateFist(dt,playerX,playerY, angle)

fistX = playerX;
fistY = playerY;
fistAngle = angle;

  if(not canUse)then
    if(canUseTimer >= canUseTimerMax)then
      canUse = true;
    else
      canUseTimer = canUseTimer + 30*dt;
    end
  end

  if(canUse)then

    if(love.keyboard.isDown("space"))then
      testY = 200;
      used = true;
    end

    if(used)then
      punch(dt);
    end
  end
end

function punch(dt)

  if(animationTimer >= animationTimerMax)then
    animationTimer = 0;
    animationFrame = animationFrame + 1;
  else
    animationTimer = animationTimer + 400*dt
  end

  if(animationFrame > 2)then
    used = false;
    canUse = false;
    canUseTimer = 0;
    animationFrame = -1;
  end
end

function fistHit()
  fistHitboxB:setX(fistX + (18 * math.sin(fistAngle)));
  fistHitboxB:setY(fistY + (18 * math.cos(fistAngle)));
  fistHitboxB:setAngle(fistAngle);
  return fistHitboxF, used;
end

fistObject.loadFist = loadFist;
fistObject.drawFist = drawFist;
fistObject.updateFist = updateFist;
fistObject.fistHit = fistHit;

return fistObject;
