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

  fistHitAngle = 0;
  fistHitboxB = love.physics.newBody(World, fistX, fistY, "kinematic");
  fistHitboxS = love.physics.newRectangleShape(16 * 4, 16 * 4);
  fistHitboxF = love.physics.newFixture(fistHitboxB, fistHitboxS, 0);

  testX = 0;
  testY = 0;
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

  love.graphics.rectangle("fill", testX, testY, 16 * 2, 16 * 2);
  --love.graphics.rectangle("fill", (fistX - (18 * math.cos(fistAngle))), testY, 16 * 2, 16 * 2);
end

function updateFist(dt,playerX,playerY, angle)

fistX = playerX;
fistY = playerY;
fistAngle = angle;
fistHitAngle = fistAngle;
testX = fistX + ( (18*math.sin(fistHitAngle)) - (9*math.cos((math.pi / 2) - fistHitAngle)) );
testY = fistY - ( (18*math.cos(fistHitAngle)) + (9*math.sin((math.pi / 2) - fistHitAngle)) );

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
