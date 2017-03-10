local player = {};

function loadPlayer()
  fist = require "fist";
  fist.loadFist(World);

  playerModel = love.graphics.newImage("assets/playermodels/modeltest.png");
  models = {};
  models.still = love.graphics.newQuad(0, 0, 32, 32, playerModel:getDimensions());
  models.left = love.graphics.newQuad(0, playerModel:getHeight() / 3, 32, 32, playerModel:getDimensions());
  models.right = love.graphics.newQuad(0, 2*(playerModel:getHeight() / 3), 32, 32, playerModel:getDimensions());
  player = {};
  player.sprite = playerModel;
  player.models = models;
  player.modStatus = 0;
  player.modTimer = 0
  player.modTLimit = 10;
  player.nextQuad = false;
  player.speed = 200;
  player.weaponType = 0;
  player.x = love.graphics.getWidth() / 2;
  player.y = love.graphics.getHeight() / 2;
  player.angle = 0;
  player.hitboxB = love.physics.newBody(World, player.x, player.y, "dynamic");
  player.hitboxS = love.physics.newRectangleShape(16*3, 16*3);
  player.hitboxF = love.physics.newFixture(player.hitboxB, player.hitboxS, 0);
  calcAngle = 0;
  weaponHitbox = love.physics.newBody(World, -10, -10, "kinematic");
  weaponUsed = false;

end

function updatePlayer(dt)

  player.hitboxB:setX(player.x);
  player.hitboxB:setY(player.y);
  player.hitboxB:setAngle(player.angle);

  weaponHitboxF, weaponUsed = fist.fistHit();

  calcAngle = math.atan2((love.mouse.getX() - player.x),(love.mouse.getY() - player.y));
  player.angle = math.pi - calcAngle;

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

  love.graphics.setColor(0,0,0,255);
  love.graphics.print(player.x, 100, 100, 0,0.5,0.5);
  love.graphics.print(player.y, 200,100,0,0.5,0.5);
  love.graphics.setColor(255,255,255,255);
  if not weaponUsed then
    if(player.modStatus == 0) then
      love.graphics.draw(player.sprite,player.models.still, player.x, player.y,player.angle, 3,3,16,16);
    elseif (player.modStatus == 1) then
      love.graphics.draw(player.sprite,player.models.left, player.x, player.y,player.angle,3,3,16,16);
    elseif(player.modStatus == 2) then
      love.graphics.draw(player.sprite,player.models.right, player.x, player.y,player.angle,3,3,16,16);
    end
  end
end

function switchWeapon()
end

function getStats()
  pStats = {};
  pStats.x = player.x;
  pStats.y = player.y
  pStats.hitboxF = player.hitboxF;
  pStats.weaponType = player.weaponType;
  pStats.weaponUsed = weaponUsed;
  pStats.weaponHitboxF = weaponHitboxF;
  pStats.angle = player.angle;
  return pStats;
end

player.loadPlayer = loadPlayer;
player.updatePlayer = updatePlayer;
player.drawPlayer = drawPlayer;
player.getStats = getStats;

return player;
