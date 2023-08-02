Config = {}
Config.Locale = 'en'

 -- You don't have to sum to sum the chances of all of the prices to 100. The totel will be decided based on the
 -- <chance of one price>/<total of all prices>. e.g. Price: 'Common' has a chance of '50' and the total of all chances is 100, so 50/100 (50%)
 -- chance of packing common. You may add as many prices as you want. Follow the preset logic.
 Config.Prices = {
  Nothing = {
    chance = 60,
    message = 'Harmillista, Et voittanut mitään',
    price = {
      price_money = 0,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Common = {
    chance = 20,
    message = 'Voitit uuden arvan!',
    price = {
      price_money = 0,
      item = {
        price_is_item = true,
        item_name = 'scratch_ticket',
        item_label = 'Arvan',
        item_amount = 1
      }
    }
  },
  Rare = {
    chance = 10,
    message = 'Voitit! $8.50!',
    price = {
      price_money = 8.50,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Epic = {
    chance = 4,
    message = 'Voitit! $45!',
    price = {
      price_money = 45,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Legendary = {
    chance = 1,
    message = 'Voitit $80!',
    price = {
      price_money = 80,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  }
}

Config.ScratchCooldownInSeconds = 10 -- Cooldown in SECONDS, when will player be able to scratch another ticket?
Config.ShowCooldownNotifications = true -- Show a notification to player with the remaining cooldown timer
Config.ShowUsedTicketNotification = true  -- Show a notification to player whenever a ticket is used
Config.ShowResultTicketNotification = true  -- Show a notification with message of price ticket. See Config.Prices.message
Config.ScratchAmount = 80    -- Percentage of the ticket that needs to be scrapped away for the price to be 'seen'