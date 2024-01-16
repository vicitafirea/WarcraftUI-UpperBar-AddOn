local barHeight = 50
MinimapCluster:ClearAllPoints()
MinimapCluster:SetPoint('TOPRIGHT', UIParent, 'TOPRIGHT', 0, 0 - barHeight)
BuffButton0:ClearAllPoints()
BuffButton0:SetPoint('TOPRIGHT', UIParent, 'TOPRIGHT', -205, -13 - barHeight)
--BuffFrame:SetPoint('TOPRIGHT', UIParent, 'TOPRIGHT', -205, -13 - barHeight)
TemporaryEnchantFrame:ClearAllPoints()
TemporaryEnchantFrame:SetPoint('TOPRIGHT', UIParent, 'TOPRIGHT', -175, -13 - barHeight)
TicketStatusFrame:ClearAllPoints()
TicketStatusFrame:SetPoint('TOPRIGHT', UIParent, 'TOPRIGHT', -180, 0 - barHeight)

local character = UnitName('player')
if type(WarcraftUI_UpperBar_Variables) ~= 'table' then
    WarcraftUI_UpperBar_Variables = {}
    WarcraftUI_UpperBar_Variables[character] = {}
end

local frame = CreateFrame('Frame', 'WarcraftUI_UpperBarFrame', UIParent)
frame:SetFrameStrata('BACKGROUND')
frame:SetPoint('TOP', UIParent, 'TOP')
frame:SetWidth(1)
frame:SetHeight(barHeight)
frame:Show()

local resourceBarLeft = frame:CreateTexture(nil, 'BACKGROUND')
resourceBarLeft:SetPoint('TOPLEFT', WarcraftUI_UpperBarFrame, 'TOPRIGHT', -1, 0)
resourceBarLeft:SetWidth(123)
resourceBarLeft:SetHeight(48)
resourceBarLeft:SetTexture('Interface\\AddOns\\WarcraftUI_UpperBar\\W3UI_Resources\\HumanUITile02')
resourceBarLeft:SetTexCoord(389 / 512, 1.0, 0.0, 48 / 512)
resourceBarLeft:Show()
    
local resourceBarMiddle = frame:CreateTexture(nil, 'BACKGROUND')
resourceBarMiddle:SetPoint('TOPLEFT', WarcraftUI_UpperBarFrame, 'TOPRIGHT', 122, 0)
resourceBarMiddle:SetWidth(512)
resourceBarMiddle:SetHeight(49)
resourceBarMiddle:SetTexture('Interface\\AddOns\\WarcraftUI_UpperBar\\W3UI_Resources\\HumanUITile03')
resourceBarMiddle:SetTexCoord(0.0, 1.0, 0.0, 49 / 512)
resourceBarMiddle:Show()
    
local resourceBarRight = frame:CreateTexture(nil, 'BACKGROUND')
resourceBarRight:SetPoint('TOPLEFT', WarcraftUI_UpperBarFrame, 'TOPRIGHT', 634, 0)
resourceBarRight:SetWidth(64)
resourceBarRight:SetHeight(49)
resourceBarRight:SetTexture('Interface\\AddOns\\WarcraftUI_UpperBar\\W3UI_Resources\\HumanUITile04')
resourceBarRight:SetTexCoord(0.0, 1.0, 0.0, 49 / 512)
resourceBarRight:Show()

local buttonBarRight = frame:CreateTexture(nil, 'BACKGROUND')
buttonBarRight:SetPoint('TOPRIGHT', WarcraftUI_UpperBarFrame, 'TOPLEFT', 0, 0)
buttonBarRight:SetWidth(186)
buttonBarRight:SetHeight(48)
buttonBarRight:SetTexture('Interface\\AddOns\\WarcraftUI_UpperBar\\W3UI_Resources\\HumanUITile02')
buttonBarRight:SetTexCoord(0.0, 186 / 512, 0.0, 48 / 512)
buttonBarRight:Show()
    
local buttonBarLeft = frame:CreateTexture(nil, 'BACKGROUND')
buttonBarLeft:SetPoint('TOPRIGHT', WarcraftUI_UpperBarFrame, 'TOPLEFT', -186, 0) --185
buttonBarLeft:SetWidth(512)
buttonBarLeft:SetHeight(48)
buttonBarLeft:SetTexture('Interface\\AddOns\\WarcraftUI_UpperBar\\W3UI_Resources\\HumanUITile01')
buttonBarLeft:SetTexCoord(0.0, 1.0, 0.0, 48 / 512)
buttonBarLeft:Show()

local first = CreateFrame('Frame', 'WarcraftUI_ResourceBarFrameFirst', WarcraftUI_UpperBarFrame)
local firstIcon = first:CreateTexture('WarcraftUI_ResourceBarIconFirst', 'ARTWORK') --ResourceBarGoldIcon
local firstText = first:CreateFontString('WarcraftUI_ResourceBarTextFirst', 'OVERLAY', 'ResourceBarTextTemplate') --ResourceBarGoldText

local second = CreateFrame('Frame', 'WarcraftUI_ResourceBarFrameSecond', WarcraftUI_UpperBarFrame)
local secondIcon = second:CreateTexture('WarcraftUI_ResourceBarIconSecond', 'ARTWORK')
local secondText = second:CreateFontString('WarcraftUI_ResourceBarTextSecond', 'OVERLAY', 'ResourceBarTextTemplate')

local third = CreateFrame('Frame', 'WarcraftUI_ResourceBarFrameThird', WarcraftUI_UpperBarFrame)
local thirdIcon = third:CreateTexture('WarcraftUI_ResourceBarIconThird', 'ARTWORK')
local thirdText = third:CreateFontString('WarcraftUI_ResourceBarTextThird', 'OVERLAY', 'ResourceBarTextTemplate')

local fourth = CreateFrame('Frame', 'WarcraftUI_ResourceBarFrameFourth', WarcraftUI_UpperBarFrame)
local fourthIcon = fourth:CreateTexture('WarcraftUI_ResourceBarIconFourth', 'ARTWORK')
local fourthText = fourth:CreateFontString('WarcraftUI_ResourceBarTextFourth', 'OVERLAY', 'ResourceBarTextTemplate')

--first:SetScript('OnEnter', function() DEFAULT_CHAT_FRAME:AddMessage('debug: working OnEnter') end)
--first:SetScript('OnLeave', function() DEFAULT_CHAT_FRAME:AddMessage('debug: working OnLeave') end)

local character = UnitName('player')
local itemIDGroup = {}
local resourceBarUpdate = function(name, texture, resource, itemString)

    local resourceFrame = getglobal('WarcraftUI_ResourceBarFrame' .. name)
    local icon = getglobal('WarcraftUI_ResourceBarIcon' .. name)
    local text = getglobal('WarcraftUI_ResourceBarText' .. name)

    local y = -5
    local x
    if name == 'First' then x = 24
    elseif name == 'Second' then x = 198
    elseif name == 'Third' then x = 372
    else x = 546
    end

    resourceFrame:SetPoint('TOPLEFT', WarcraftUI_UpperBarFrame, 'TOPRIGHT', x, y)
    resourceFrame:SetWidth(145)
    resourceFrame:SetHeight(32)
    resourceFrame:Show()

    if texture then
        icon:SetTexture('Interface\\AddOns\\WarcraftUI_UpperBar\\W3UI_Resources\\Resource' .. texture)
        icon:SetWidth(32)
        icon:SetHeight(32)
        icon:SetPoint('LEFT', getglobal('WarcraftUI_ResourceBarFrame' .. name), 'LEFT')
        icon:Show()
    end

    if resource then
        if resource == 'money' then
            local getPlayerMoney = function(money)
                local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD)) --e9d741
                local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER) --a2adaf
                local copper = mod(money, COPPER_PER_SILVER) --ef9a41
                text:SetText(format('\124cffe9d741%d\124r, \124cffa2adaf%d\124r, \124cffef9a41%d\124r', gold, silver, copper))
            end
            getPlayerMoney(MoneyTypeInfo['PLAYER'].UpdateFunc())
    
            --could make an 'animation' when the player earns/loses money, coloring the money numbers all green/red for a couple of seconds
            --0.1, 1.0, 0.1
            --1.0, 0.1, 0.1
    
            resourceFrame:RegisterEvent('PLAYER_MONEY')
            resourceFrame:RegisterEvent('PLAYER_TRADE_MONEY')
            resourceFrame:RegisterEvent('TRADE_MONEY_CHANGED')
            resourceFrame:RegisterEvent('SEND_MAIL_MONEY_CHANGED')
            resourceFrame:RegisterEvent('SEND_MAIL_COD_CHANGED')
            resourceFrame:SetScript('OnEvent', function()
                getPlayerMoney(MoneyTypeInfo['PLAYER'].UpdateFunc())
            end)
    
        elseif resource == 'honor' then
            local _, honor = GetPVPThisWeekStats()                  --hk, contribution = GetPVPThisWeekStats()
            local _, _, weekHonor, standing = GetPVPLastWeekStats() --hk, dk, contribution, rank = GetPVPLastWeekStats()
            local faction
            if UnitFactionGroup('player') == 'Alliance' then
                faction = '0d265c'
            else faction = 'a11717'
            end
            secondResourceText:SetText(format('\124cff1aff1a%d\124r (\124cffffd100%d\124r, \124cff' .. faction .. '%d\124r)', honor, weekHonor, standing)) --1aff1a; ffd100
    
        elseif (resource == 'itemName' or resource == 'IDGroup' or resource == 'itemID') and itemString then
    
            if not WarcraftUI_UpperBar_Variables[character][itemString] then WarcraftUI_UpperBar_Variables[character][itemString] = {} end
    
            local totalItemCount = function(string, bagID)
                local itemNumber = 0
                local size = GetContainerNumSlots(bagID)
                if size > 0 then
                    for slotIndex = 1, size do
                        local itemLink = GetContainerItemLink(bagID, slotIndex)
                        local _, itemCount = GetContainerItemInfo(bagID, slotIndex) --local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bagID, slotIndex)
    
                        if resource == 'itemName' then
                            if itemLink and strfind(itemLink, '%[' .. string .. '%]') then
                                itemNumber = itemNumber + itemCount
                            end
                        else
                            if itemLink then
                                local link = strsub(itemLink, 18, strfind(itemLink, '%d:') - 1)
                                if resource == 'IDGroup' then
                                    for i = 1, getn(itemIDGroup), 1 do
                                        if strfind(link, itemIDGroup[string][i]) then
                                            itemNumber = itemNumber + itemCount
                                        end
                                    end
                                else
                                    if strfind(link, string) then
                                        itemNumber = itemNumber + itemCount
                                    end
                                end
                            end
                        end
                    end
                end
                return itemNumber
            end
    
            --BACKPACK 0 ; BAGS 1,2,3,4 ; KEYRING -2
            --BANK -1 ; BAGS 5,6,7,8,9,10
            local containerTypeBagIDsItemCount = function(bank)
                local count = 0
                if not bank then
                    for id = -2, 4, 1 do
                        if id ~= -1 then
                            count = count + totalItemCount(itemString, id)
                        end
                    end
                else
                    local count = 0
                    for id = -1, 10, 1 do
                        if id > 4 or id == -1 then
                            count = count + totalItemCount(itemString, id)
                        end
                    end
                end
                return count
            end
    
            WarcraftUI_UpperBar_Variables[character][itemString]['backpack'] = containerTypeBagIDsItemCount()
            if WarcraftUI_UpperBar_Variables[character][itemString]['bank'] then
                text:SetText(format('%d (%d)', WarcraftUI_UpperBar_Variables[character][itemString]['backpack'], WarcraftUI_UpperBar_Variables[character][item]['bank']))
            else
                text:SetText(format('%d', WarcraftUI_UpperBar_Variables[character][itemString]['backpack']))
            end
            
            resourceFrame:RegisterEvent('PLAYER_ENTERING_WORLD')
            resourceFrame:RegisterEvent('BAG_UPDATE')
            resourceFrame:RegisterEvent('BANKFRAME_OPENED')
            resourceFrame:RegisterEvent('PLAYERBANKSLOTS_CHANGED')
            resourceFrame:SetScript('OnEvent', function()
                if event == 'BAG_UPDATE' then
                    WarcraftUI_UpperBar_Variables[character][itemString]['backpack'] = containerTypeBagIDsItemCount()
    
                    if WarcraftUI_UpperBar_Variables[character][itemString]['bank'] then
                        text:SetText(format('%d (%d)', WarcraftUI_UpperBar_Variables[character][itemString]['backpack'], WarcraftUI_UpperBar_Variables[character][item]['bank']))
                    else
                        text:SetText(format('%d', WarcraftUI_UpperBar_Variables[character][itemString]['backpack']))
                    end
                    
                elseif event == 'BANKFRAME_OPENED' or event == 'PLAYERBANKSLOTS_CHANGED' then
                    WarcraftUI_UpperBar_Variables[character][itemString]['bank'] = containerTypeBagIDsItemCount(true)
                    
                    text:SetText(format('%d (%d)', WarcraftUI_UpperBar_Variables[character][itemString]['backpack'], WarcraftUI_UpperBar_Variables[character][item]['bank']))
                end
            end)
        end
        text:SetPoint('RIGHT', getglobal('WarcraftUI_ResourceBarFrame' .. name), 'RIGHT')

    else
        if itemString then
            text:SetText(itemString)
            text:SetTextColor(0.8, 0.8, 0.8)
            text:SetPoint('CENTER', getglobal('WarcraftUI_ResourceBarFrame' .. name), 'CENTER')
        end
    end
    text:Show()
end


frame:RegisterEvent('PLAYER_ENTERING_WORLD')
frame:SetScript('OnEvent', function()
    frame:UnregisterEvent('PLAYER_ENTERING_WORLD')

    if TimeOfDayIndicatorFrame then
        resourceBarLeft:ClearAllPoints()
        resourceBarLeft:SetPoint('TOPLEFT', WarcraftUI_UpperBarFrame, 'TOPRIGHT', 0, 0)
        frame:SetWidth(198)
        --frame:SetPoint('TOPLEFT', UIParent, 'TOP', -102, 0)
        local centerBar = frame:CreateTexture(nil, 'BACKGROUND')
        --centerBar:SetPoint('TOPLEFT', WarcraftUI_UpperBarFrame, 'TOPLEFT')
        centerBar:SetWidth(198)
        centerBar:SetHeight(barHeight)
        centerBar:SetAllPoints(WarcraftUI_UpperBarFrame)
        centerBar:SetTexture('Interface\\AddOns\\WarcraftUI_UpperBar\\W3UI_Resources\\HumanUITile02')
        centerBar:SetTexCoord(190 / 512, 388 / 512, 0.0, 50 / 512)
        centerBar:Show()
    end

    if not WarcraftUI_UpperBar_Variables[character] then
        WarcraftUI_UpperBar_Variables[character] = {}
    end
    resourceBarUpdate('First', 'Gold', 'money')
    resourceBarUpdate('Second', 'Lumber', 'IDGroup', 'wood')
    resourceBarUpdate('Third', 'Supply', 'IDGroup', 'food')
    resourceBarUpdate('Fourth', nil, nil, 'No Upkeep')
end)

itemIDGroup['wood'] = {4470, 11291} --Simple Wood, Star Wood

itemIDGroup['ore'] = {2770, 11370, 18562, 2776, 2772, 3858, 2775, 10620, 2771, 7911}
--Copper Ore, Dark Iron Ore, Elementium Ore, Gold Ore, Iron Ore, Mithril Ore, Silver Ore, Thorium Ore, Tin Ore, Truesilver Ore

itemIDGroup['leather'] = {15416, 7286, 15415, 12607, 15423, 17012}
--Items harvested by Skinning.
--Black Dragonscale, Black Whelp Scale, Blue Dragonscale, Brilliant Chromatic Scale, Chimera Leather, Core Leather


itemIDGroup['herb'] = {8153}
--Items gathered by Herbalism.


itemIDGroup['fish'] = {6458}
--Items caught by Fishing, not related to a quest, usually consumables.

itemIDGroup['alcohol'] = {21151}
--Consumables that get you tipsy/drunk.

itemIDGroup['food'] = {19301, 8932, 20062, 20063, 20064, 13935, 4457, 16166, 2888, 18635, 3726, 13810, 3220, 13546, 20516, 5525, 6290, 4593, 21031, 11584, 20390, 7807, 17344, 20389, 12213, 2679, 7808, 5526, 16971, 8683,
1113, 22895, 5349, 1487, 1114, 8075, 8076, 2682, 13927, 2684, 2683, 12224, 5479, 3664, 3662, 19306, 4599, 3665, 414, 13888, 19223, 2070, 21030, 19225, 8953, 17119, 20222, 20223, 20224, 4607,
5478, 21023, 8948, 2687, 422, 17198, 13724, 20031, 21537, 13930, 5476, 3927, 5066, 5845, 4604, 4541, 23160, 6807, 6038, 17197, 5527, 4539, 3666, 724, 17407, 21215, 1401, 9681, 13928, 11444,
19995, 19696, 19996, 19994, 2287, 961, 16168, 20074, 12215, 6888, 20225, 20226, 20227, 17406, 8950, 3727, 13929, 13851, 12212, 5472, 13893, 5480, 12209, 7097, 13933, 6316, 20388, 7806, 4592, 13934,
8364, 11415, 4542, 12218, 4602, 18632, 4544, 3663, 3770, 12214, 13931, 6458, 19305, 13932, 21033, 5095, 4608, 6291, 6308, 13754, 21153, 6317, 6289, 8365, 13759, 6361, 13758, 6362, 21071, 6303, 8959, 4603, 13756, 13760, 13889, 19224, 4605, 1082, 5057, 12210,
2681, 5474, 8952, 4594, 18255, 18254, 21217, 1326, 5473, 1017, 3448, 4536, 6299, 787, 4656, 6890, 20452, 21072, 4538, 4601, 3729, 11109, 19304, 12216, 2680, 12211, 17408, 17222, 8957, 4606,
6887, 16170, 1707, 5477, 21552, 18633, 2685, 3728, 4537, 18045, 7228, 23211, 4540, 117, 16766, 16167, 19060, 19062, 19061, 733, 3771, 16169, 11950, 22324, 13755, 21254, 21235}
--Alterac Manna Biscuit, Alterac Swiss, Arathi Basin Enriched Ration, Arathi Basin Field Ration, Arathi Basin Iron Ration, Baked Salmon, Barbecued Buzzard Wing, Bean Soup, Beer Basted Boar Ribs, Bellara's Nutterbar
--Big Bear Steak, Blessed Sunfruit, Blood Sausage, Bloodbelly Fish, Bobbing Apple, Boiled Clams, Brilliant Smallfish, Bristle Whisker Catfish, Cabbage Kimchi, Cactus Apple Surprise
--Candy Bar(Halloween), Candy Bar(Easter), Candy Cane, Candy Corn, Carrion Surprise, Charred Wolf Meat, Chocolate Square, Clam Chowder, Clamlette Surprise, Clara's Fresh Apple
--Conjured Bread, Conjured Cinnamon Roll, Conjured Muffin, Conjured Pumpernickel, Conjured Rye, Conjured Sourdough, Conjured Sweet Roll, Cooked Crab Claw, Cooked Glossy Mightfish, Coyote Steak
--Crab Cake, Crispy Bat Wing, Crispy Lizard Tail, Crocolisk Gumbo, Crocolisk Steak, Crunchy Frog, Cured Ham Steak, Curiously Tasty Omelet, Dalaran Sharp, Darkclaw Lobster
--Darkmoon Dog, Darnassian Bleu, Darnassus Kimchi Pie, Deep Fried Candybar, Deep Fried Plantains, Deeprun Rat Kabob, Defiler's Enriched Ration, Defiler's Field Ration, Defiler's Iron Ration, Delicious Cave Mold
--Dig Rat Stew, Dirge's Kickin' Chimaerok Chops, Dried King Bolete, Dry Pork Ribs, Dwarven Mild, Egg Nog, Enriched Manna Biscuit, Essence Mango, Festival Dumplings, Filet of Redgill
--Fillet of Frenzy, Fine Aged Cheddar, Fissure Plant, Flank of Meat, Forest Mushroom Cap, Freshly Baked Bread, Friendship Bread, Frog Leg Stew, Giant Clam Scorcho, Gingerbread Cookie
--Goblin Deviled Clams, Goldenbark Apple, Gooey Spider Cake, Goretusk Liver Pie, Graccu's Homemade Meat Pie, Graccu's Mince Meat Fruitcake, Green Tea Leaf, Grilled King Crawler Legs, Grilled Squid, Grim Guzzler Boar
--Harvest Boar, Harvest Bread, Harvest Fish, Harvest Fruit, Haunch of Meat, Healing Herb, Heaven Peach, Heavy Crocolisk Stew, Heavy Kodo Stew, Herb Baked Egg
--Highlander's Enriched Ration, Highlander's Field Ration, Highlander's Iron Ration, Holiday Cheesewheel, Homemade Cherry Pie, Hot Lion Chops, Hot Smoked Bass, Hot Wolf Ribs, Jungle Stew, Kaldorei Spider Kabob
--Large Raw Mightfish, Lean Venison, Lean Wolf Steak, Leg Meat, Lobster Stew, Loch Frenzy Delight, Lollipop(Halloween), Lollipop(Easter), Longjaw Mud Snapper, Mightfish Steak
--Mithril Head Trout, Mixed Berries, Moist Cornbread, Monster Omelet, Moon Harvest Pumpkin, Moonbrook Riot Taffy, Mulgore Spice Bread, Murloc Fin Soup, Mutton Chop, Mystery Stew
--Nightfin Soup, Oil Covered Fish, Pickled Kodo Foot, Poached Sunscale Salmon, Radish Kimchi, Rainbow Fin Albacore, Raw Black Truffle, Raw Brilliant Smallfish, Raw Bristle Whisker Catfish, Raw Glossy Mightfish
--Raw Greater Sagefish, Raw Loch Frenzy, Raw Longjaw Mud Snapper, Raw Mithril Head Trout, Raw Nightfin Snapper, Raw Rainbow Fin Albacore, Raw Redgill, Raw Rockscale Cod, Raw Sagefish, Raw Slitherskin Mackerel
--Raw Spinefin Halibut, Raw Spotted Yellowtail, Raw Summer Bass, Raw Sunscale Salmon, Raw Whitescale Salmon, Red Hot Wings, Red-speckled Mushroom, Redridge Goulash, Ripe Watermelon, Roast Raptor
--Roasted Boar Meat, Roasted Kodo Meat, Roasted Quail, Rockscale Cod, Runn Tum Tuber, Runn Tum Tuber Surprise, Sagefish Delight, Sauteed Sunfish, Scorpid Surprise, Seasoned Wolf Kabob
--Senggin Root, Shiny Red Apple, Sickly Looking Fish, Slitherskin Mackerel, Small Pumpkin, Smoked Bear Meat, Smoked Desert Dumplings, Smoked Sagefish, Snapvine Watermelon, Soft Banana Bread
--Soothing Turtle Bisque, Special Chicken Feed, Spiced Beef Jerky, Spiced Chili Crab, Spiced Wolf Meat, Spiced Wolf Ribs, Spicy Beefstick, Spider Sausage, Spinefin Halibut, Spongy Morel
--Spotted Yellowtail, Steamed Mandu, Stormwind Brie, Strider Stew, Striped Yellowtail, Styleen's Sour Suckerpop, Succulent Pork Ribs, Tasty Lion Steak, Tel'Abim Banana, Tender Wolf Steak
--Tigule's Strawberry Ice Cream, Toasted Smorc, Tough Hunk of Bread, Tough Jerky, Undermine Clam Chowder, Versicolor Treat, Warsong Gulch Enriched Ration, Warsong Gulch Field Ration, Warsong Gulch Iron Ration, Westfall Stew
--Wild Hog Shank, Wild Ricecake, Windblossom Berries, Winter Kimchi, Winter Squid, Winter Veil Cookie, Winter Veil Roast

--'Bottled Spirits'1119 ; 'Bad Egg Nog'17199 ; 'Dragonbreath Chili'12217 ; 'Refreshing Red Apple'23172 ; 'Shinsollo'16171 ; 'Tasty Summer Treat'23175 ; 'Un'Goro Etherfruit'12763 ; 'Underwater Mushroom Cap'8543 ; 'Winter Veil Candy'21240 ; 'Winter Veil Loaf'21236

itemIDGroup['drink'] = {2319}
--Consumables that restore mana.

--rep items?

--Item Types:
--Weapon
--Container
--Consumable
--Trade Goods
--Projectile
--Quiver
--Recipe
--Reagent
--Miscellaneous