local playerObject = {};

function love.load(arg)
  love.graphics.setDefaultFilter("nearest","nearest");
  World = love.physics.newWorld(0, 0, false);

  testHitboxB = love.physics.newBody(World, 100 + 8, 300 + 8, "dynamic");
  testHitboxS = love.physics.newRectangleShape(16, 16);
  testHitboxF = love.physics.newFixture(testHitboxB, testHitboxS, 0);
  testhit = false;

  fist = require "fist";
  fist.loadFist(World);

  playerModel = love.graphics.newImage("assets/playermodels/model1.png");
  models = {};
  models.still = love.graphics.newQuad(0, 0, 16, 16, playerModel:getDimensions());
  models.left = love.graphics.newQuad(0, playerModel:getHeight() / 3, 16, 16, playerModel:getDimensions());
  models.right = love.graphics.newQuad(0, 2*(playerModel:getHeight() / 3), 16, 16, playerModel:getDimensions());
  player = {};
  player.sprite = playerModel;
  player.models = models;
  player.modStatus = 0;
  player.modTimer = 0
  player.modTLimit = 10;
  player.nextQuad = false;
  player.speed = 100;
  player.weaponType = 0;
  player.x = love.graphics.getWidth() / 2;
  player.y = love.graphics.getHeight() / 2;
  player.angle = 0;
  weaponHitbox = love.physics.newBody(World, -10, -10, "kinematic");
  weaponUsed = false;

  love.graphics.setBackgroundColor(255, 255, 255, 255);
  hit = false;
end

function love.update(dt)
  updatePlayer(dt);
  if(player.weaponType == 0) then
    fist.updateFist(dt,player.x,player.y,player.angle);
  elseif(player.weaponType == 1) then
    updatePrimary(dt);
  elseif(player.weaponType == 2) then
    updateSecondary(dt);
  end
end

function love.draw()
  love.graphics.setColor(0,0,0,255);
  love.graphics.print(player.x, 100, 100, 0,2,2);
  love.graphics.print(player.y, 200,100,0,2,2);
  if(testhit)then
    love.graphics.setColor(255,0,0,255);
  else
    love.graphics.setColor(0,0,0,255);
  end
  love.graphics.rectangle("fill", 100, 300, 16, 16);

  love.graphics.print(weaponHitbox:getX().."      "..weaponHitbox:getY(), 100, 200, 0, 2, 2);

  love.graphics.setColor(255,255,255,255);
  drawPlayer();

  if(player.weaponType == 0) then
    fist.drawFist();
  elseif(player.weaponType == 1) then
    drawPrimary();
  elseif(player.weaponType == 2) then
    drawSecondary();
  end
end

function updatePlayer(dt)

  weaponHitboxF, weaponUsed = fist.fistHit();

  distance, x1, y1, x2, y2 = love.physics.getDistance(weaponHitboxF, testHitboxF);

  if(distance == 0)then
    testhit = true;
  else
    testhit = false;
  end

  player.angle = (math.pi) - math.atan2((love.mouse.getX() - player.x),(love.mouse.getY() - player.y));

  if(player.modTimer >= player.modTLimit) then
    nextQuad = true;
    player.modTimer = 0;
  else
    nextQuad = false;
    player.modTimer = player.modTimer + 50*dt;
  end

  if (love.keyboard.isDown('w','a','s','d'))then
    if nextQuad then
      if player.modStatus == 2 then
        player.modStatus = 0;
      else
        player.modStatus = player.modStatus + 1;
      end
    end
    if(player.y >= 0) then
      if (love.keyboard.isDown('w')) then
        player.y = player.y - player.speed*dt;
      end
    end
    if(player.y <= love.graphics.getHeight()) then
      if (love.keyboard.isDown('s')) then
        player.y = player.y + player.speed*dt;
      end
    end
    if(player.x >= 0) then
      if (love.keyboard.isDown('a')) then
        player.x = player.x - player.speed*dt;
      end
    end
    if(player.x <= love.graphics.getWidth()) then
      if (love.keyboard.isDown('d')) then
        player.x = player.x + player.speed*dt;
      end
    end
  else
    player.modStatus = 0;
  end
end

function drawPlayer()
  if(player.modStatus == 0) then
    love.graphics.draw(player.sprite,player.models.still, player.x, player.y,player.angle, 4,4,8,8);
  elseif (player.modStatus == 1) then
    love.graphics.draw(player.sprite,player.models.left, player.x, player.y,player.angle, 4,4,8,8);
  elseif(player.modStatus == 2) then
    love.graphics.draw(player.sprite,player.models.right, player.x, player.y,player.angle, 4,4,8,8);
  end
end
