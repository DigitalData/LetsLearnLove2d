local game = {};

function loadGame()
  love.graphics.setDefaultFilter("nearest","nearest");
  World = love.physics.newWorld(0, 0, false);

  testHitboxB = love.physics.newBody(World, 100 + 8, 300 + 8, "dynamic");
  testHitboxS = love.physics.newRectangleShape(16, 16);
  testHitboxF = love.physics.newFixture(testHitboxB, testHitboxS, 0);
  testhit = false;

  player = require("player");
  player.loadPlayer();
  playerStats = {};
end

function updateGame(dt)
  updatePlayer(dt);
  playerStats = player.getStats();

distance = love.physics.getDistance(playerStats.weaponHitboxF, testHitboxF);

if(weaponUsed)then
  if(distance == 0)then
    testhit = true;
  else
    testhit = false;
  end
else
  testhit = false;
end

  if(playerStats.weaponType == 0) then
    fist.updateFist(dt,playerStats.x,playerStats.y,playerStats.angle);
  elseif(playerStats.weaponType == 1) then
    updatePrimary(dt);
  elseif(playerStats.weaponType == 2) then
    updateSecondary(dt);
  end
end

function drawGame()
  love.graphics.setBackgroundColor(255,255,255,255);
  if(testhit)then
    love.graphics.setColor(255,0,0,255);
  else
    love.graphics.setColor(0,0,0,255);
  end
  love.graphics.rectangle("fill", 100, 300, 16, 16);

  love.graphics.print(weaponHitbox:getX().."      "..weaponHitbox:getY(), 100, 200, 0, 0.5,0.5);

  love.graphics.setColor(255,255,255,255);
  drawPlayer();

  if(playerStats.weaponType == 0) then
    fist.drawFist();
  elseif(playerStats.weaponType == 1) then
    drawPrimary();
  elseif(playerStats.weaponType == 2) then
    drawSecondary();
  end
end

game.loadGame = loadGame;
game.updateGame = updateGame;
game.drawGame = drawGame;

return game;
