-- Setting the randomness seed
math.randomseed(os.time())

-- TODO: Include helpers file
-- require("helpers.lua")

-- Let the program stops temporarily to create basic animation
function sleep (a)
  local sec = tonumber(os.clock() + a);
  while (os.clock() < sec) do
  end
end

-- Function to copy Tables (keeping a table of a new deck)
function table.clone(org)
  return {table.unpack(org)}
end

-- Clears the Terminal screen (When redrawing the play area)
function clear()
  os.execute("clear")
end

-- Initializing the Player class for user and dealer
Player = {}
Player.__index = Player

function Player:new (o)
     o = o or {}   -- create object if user does not provide one
     setmetatable(o, self)
     self.__index = self
     self.name = ""
     self.choice = 0
     self.total = 0
     self.money = 0
     return o
end

function Player:set_name(name)
  self.name = name
end

function Player:hit(deck)
   table.insert(self.hand, draw(deck))
end

function Player:win(amount)
  self.money = self.money + amount
end

-- Draws a random card from the deck "drawFrom" and removes the
-- card each time to make sure it is not drawn twice.
-- Returns the drawn card value as output
function draw(deck)
    local n = #deck
    local pos = math.random(n)
    local cardDrew = deck[pos]
    table.remove(deck, pos)
    return cardDrew
end

-- Draws/Updates the play area on the table
function redrawTable()
  clear()

  io.write("You: ")
  for i = 1, #user.hand do
    io.write(user.hand[i] .. " ")
  end
  io.write("(" .. user:count_hand() .. ")")

  io.write("\nDealer: ")
  for i = 1, #dealer.hand do
    io.write(dealer.hand[i] .. " ")
  end
  io.write("(" .. dealer:count_hand() .. ")")
  io.write("\n")
end

-- Calculates the hand total after every hit
function Player:count_hand()
    local total = 0
    local softHand = false
    local softHandCount = 0

    for i = 1, #self.hand do
      local value = self.hand[i]

      if value == 'J' or value == 'Q' or value == 'K' then
        value = 10
      elseif value == 'A' then
        value = 11
        softHand = true
        softHandCount = softHandCount + 1
      end
      -- TODO: Still need to check for soft Aces

      total = total + value
    end

    if total > 21 and softHand == true then
      total = total - (softHandCount * 10)
    end

    return total
end

-- Evaluates the player's and dealer's cards, Returns a numeric value and a winner
function compare()

-- TODO: compares the two hands

end

-- main loop of the game
function game ()
  while true do

    -- bet()

    newDeal()

    playerTurn()

    -- dealerTurn()

    -- evaluate()

    -- pay()

  end
end

-- Deals the first two cards to dealer and player
-- TODO: Check for Blackjack and insurance
function newDeal()
-- Clears the screen and instantiate a new deck to draw from

  drawFrom = table.clone(newDeck)

  for i = 1, 2 do
    user:hit(drawFrom)
  end
  dealer:hit(drawFrom)

  redrawTable()


-- Start of the Player's turn
function playerTurn()
  while true do
    io.write([[What will you do?
      (1) Hit
      (2) Stay
      (3) Split
      (4) Double
      (5) Quit]] .. "\n")

      repeat
        io.write("Command: ")
        user.choice = io.read()
      until tonumber(user.choice) > 0 and tonumber(user.choice) <= 5

      if user.choice == "1" then
        user:hit(drawFrom)
        redrawTable()

      elseif user.choice == "2" then
        -- TODO: Stay()
        os.exit()
      elseif user.choice == "3" then
        -- TODO: Split()
        os.exit()
      elseif user.choice == "4" then
        -- TODO: Double()
        os.exit()
      elseif user.choice == "5" then
        os.exit()
      end
    end
  end
end



-- Stores the player's credit score
-- TODO: store in external file for persistence
c = 1000
borrow = 0

newDeck = {"A", 2, 3, 4, 5, 6, 7, 8, 9 , 10, "J", "Q", "K",
 "A", 2, 3, 4, 5, 6, 7, 8, 9 , 10, "J", "Q", "K",
 "A", 2, 3, 4, 5, 6, 7, 8, 9 , 10, "J", "Q", "K",
 "A", 2, 3, 4, 5, 6, 7, 8, 9 , 10, "J", "Q", "K"}

user = Player:new({hand = {}})
dealer = Player:new({hand = {}})

user.name = "Player"
dealer.name = "Dealer"

-- Start of main program, and displays main menu
clear()

io.write("\n" .. [[Welcome to Blackjack]] .. "\n")

sleep(1)

io.write("\n" .. [[By TuxMan20]] .. "\n\n")

sleep(1)

io.write("Current credit: " .. c .. "\n\n")

sleep(1)

io.write("\n" .. [[Please choose an option:
(1) New Game
(2) Add Credits
(3) Quit]] .. "\n\n")

repeat
  io.write("Command: ")
  user.choice = io.read()
until tonumber(user.choice) > 0 and tonumber(user.choice) <= 3

if user.choice == "1" then
  game()


elseif user.choice == "2" then
  -- TODO: addCredit()
  io.write("Choice 2\n")
elseif user.choice == "3" then
  os.exit()
end
