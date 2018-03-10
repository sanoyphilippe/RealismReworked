EventSystem.wandererConfig = {
    {
        name = "beggar_feet",
        soulList = {"41d931bc-bb84-ac67-721e-df7e6c73c2a2","96be6cea-01b4-4b1e-aa5f-920c61755563","cfc2a277-c0d1-4fb6-8451-d38ce6925834","9e13e11c-ac22-4976-a926-088d9b733d65","a8588487-3f4d-4475-982a-408c81bc38a2","87860ef0-84f6-4562-a545-e50a1a1213d4","b0847dd3-d8cc-4557-bf83-7cf48d469f2d","13d36615-3bd5-4a97-88b7-d054dd5f0487","3f87bd5d-21b5-4d0b-8217-6e17b658d54a","444d8ee7-fd97-4c41-8e82-9451cc9701ea"},
        idleActivity = enum_wandererIdleActivity.sit,
        cooldown = 3000,
        attentionMonolog = "event_wanderer_beggar_att",
        probability = 1,
    },
    {
        name = "riddlemaster",
        soulList = {"4ddf8e26-7a62-9baf-cfe8-a5d0899c18aa"},
        cooldown = 3000,
        idleActivity = enum_wandererIdleActivity.lean,
        attentionMonolog = "event_wanderer_riddler_att",
        condition = function ( location )
            return not QuestSystem.IsObjectiveCompleted('event_wanderer_persistent','riddlerDead');
        end,
        probability = 1,
    },
    {
        name = "poacherEnemy",
        locationRequired = "forest",
        cooldown = 2000,
        soulList = {"48cb4e5d-aa77-23bb-b629-99b0606b9c87","0c8b3619-6ce3-4bc3-b74d-eadb3f6e1588","d85f1595-e23e-42ee-9492-39914adbf4b8","e6d035e3-4ea1-4bd3-820c-65f4d4ec138a","0be9be9a-1826-4975-80fa-e6b934e97c32","d283d359-b6d9-43fa-9253-8153374c9560","c39dd6e8-229d-4865-a47b-bdd0202dba64","39c6fad7-82ab-466f-889e-32b6c49fe918","6738139e-b43a-4902-9dbb-99b21daf84ab","0647977c-cd52-4861-b495-65fa0bf6ec5b","e91e6ba0-e9df-4727-96c5-a3a2e6b3a988","4bfa139f-660e-9706-bf16-4996c40236b7","4fcc7572-a91a-4050-b5bc-e516f1ca0998","143170ac-05f4-44c1-8d3e-78765e9fa6c4","d4c15c9b-1c85-495b-a7fb-d3c2a3fdaeaf","610efc10-e63f-4083-8e93-b432d8f39225","ea643cc4-579f-407d-8d24-f50502173780","92c1fc9b-3e88-4bd7-9104-3f699d265435","2d6ebcfc-ab22-4ec9-a7b4-3ac6f9a64241","192d1e9f-f6b3-402c-8e66-384cdb0bfc70","9530b29d-fe9c-4048-8817-2a30e4435b1f","b50b3ac7-2c45-45b9-9f8d-36438271f2cc","4743d068-36d5-4549-9c30-e9fac985cead","5db52c3d-fa3d-4539-96e6-a05d42170cc6","eaae8899-11a5-493c-80bf-2919ba9337c7","b6ac146d-7bf1-424a-8305-9790f99d9ad9","707f67cf-fb7e-46b0-978d-45f5d1561ff7","9f13b9f9-1403-408d-9084-b50bf8dfe36f","1306d3de-5441-493c-9af3-21dcba833eb0","7b117f0c-21d3-4c39-88b3-7584289b3e16","47bcc32a-5b53-4c91-aa66-0b554fc79cd5"},
        approach = 15,
        attentionMonolog = "event_wanderer_poacher_enemy_att",
        corpseList={"48fff014-4837-82e0-82b1-69c9c4ba25a6","44f22a05-eb00-927f-8517-711e44c48692"},
        probability = 1.25,
        combatFromFader = false,
        keywords = {"poachersNest","poacherEnemy"},
    },
    {
        name = "poacherFriend",
        locationRequired = "forest",
        soulList = {"44ed3ec2-cd82-d6e4-9f27-9e944d9e73a0","1bd9944b-4903-47e5-84f3-efffdf0aae77","470311bd-bda8-4956-83bc-dcf569a7356b","2eb5157a-0890-4d85-849c-721e423c7834","2122e3f3-080d-45e7-a02b-d99a6e267262","5a0df7ee-245e-4a37-a358-9c174dd4295a","1999b65d-78f1-4c23-a894-3c07a09a9d1f","ccfe2dd3-a29c-4621-af62-93f2412e5a91","69d3d06d-10d3-4bfb-be16-efad9cf1ea37","ff9f0d60-9b77-4e7b-bd37-98760cc7eb2b","10b48645-3008-4927-b8f2-718b2e8ddcd2"},
        cooldown = 2100,
        attentionMonolog = "event_wanderer_poacher_friendly_att",
        corpseList = {"48fff014-4837-82e0-82b1-69c9c4ba25a6","44f22a05-eb00-927f-8517-711e44c48692"},
        probability = 1.1,
        combatFromFader = true,
        keywords = {"poachersNest","poacherFriend"},
    },
    {
        name = "huntsman",
        locationRequired = "forest",
        soulList = {"491eb68e-5598-b1d4-7a21-3f74fbda20ae","9beed354-38ef-4076-afe4-63c2feb4e45a","1469f042-7ce1-484f-b36c-4be2a5ffe711","0249aa52-f5ac-48ea-b707-0f50c0c76c56","49d6fe97-47e5-473e-a195-dfdaf48417df","a14e04f9-86d2-47bd-90cb-ba32bbd8cc73","89fae503-17b2-4c99-af65-705b99413986","ecb0e123-c0d8-4fd7-b6d3-597222eaa4a7","cd5e1e41-33d9-44a9-962a-ff718d683f72","2940f2ce-774b-42f9-addb-846dde88948d","778e969f-878a-4087-a72f-50cc609e0476","d59f3ef5-c737-424c-977d-ffa944435156","3e6be16a-1231-40be-bf31-908e1e954dcd","71cc199d-4ff9-4522-853a-c948a9650866","124d0874-9e24-44be-aebc-14adbd6a3845","e928695a-64fc-44b9-bac1-f18d367f1d52"},
        cooldown = 1800,
        approach = 20,
        forceDialog = "event_wanderer_huntsman_fc",
        probability = 1.35,
        combatFromFader = true,
        keywords = {"poachersNest","huntsman"},
    },
    {
        name="duel",
        cooldown = 2400,
        soulList = {"45da943b-837b-eddc-4ec8-50af81ea29a3"},
        probability = 1.25,
        attentionMonolog = "event_wanderer_duelist_att",
        farewellMonolog = "event_wanderer_duelist_bye",
        combatFromFader = true,
        keywords = {"duel","duelist"},
    },
    {
        name="duel",
        cooldown = 2400,
        soulList = {"431dd698-37c0-a087-0839-a6736f8495a8"},
        probability = 1.25,
        attentionMonolog = "event_wanderer_knighterrant_att",
        farewellMonolog = "event_wanderer_knighterrant_bye",
        combatFromFader = true,
        keywords = {"duel","duelKnight"},
    },
    {
        name="duel",
        cooldown = 2400,
        soulList = {"4fcb793f-2815-3eeb-f323-35d635f05992","45e28f3c-761a-94a9-1c61-00a312ef44b5","478f364b-0e46-a3c1-1384-39823f062993","4c898ff4-977d-cb3a-5d38-5e467f58d796","aefafd7b-587c-428b-8236-a681a5eecad5","495efc80-fe2c-4c65-9054-311bf0611428","fb438972-cc5c-4a12-aff6-d243a597aff2","1ff85f8a-5c06-4328-b67c-261d659084eb"},
        probability = 1.25,
        attentionMonolog = "event_wanderer_mercenary_att",
        farewellMonolog = "event_wanderer_mercenary_bye",
        combatFromFader = true,
        keywords = {"duel","duelMercenary"},
    },
    {
        name="opportunity",
        cooldown = 1800,
        soulList = {"4445628d-55bd-2545-7409-520cc4c1b4b9","34df37e6-8507-4cb5-a197-0991ecbf49f9","4cbc8c27-03d6-4aae-b8ca-5ca8edd2b260","3123906f-c9eb-4acf-bc90-6bc2b84a829b","fbb263f9-0d75-4bc6-b5c9-d6099d086573","a615bdaa-0207-482b-85a8-c270d0d5587a"},
        idleActivity = enum_wandererIdleActivity.sit,
        probability = 1.15,
        attentionMonolog = "event_wanderer_opportunity_att",
        condition = function ( location )
            return not not EventSystem.PickItemFromList( EventSystem.wandererTraderList )
        end,
    },
        {
        name="treasure",
        cooldown = 2400,
        soulList = {"46111205-5191-fa6e-90f9-ac93582d24b2","49e75ac1-36e4-4866-0207-1f483f5e9ba8","4481e39e-d2f5-e19c-d544-ad5c544d8bb5","0c88319c-d9b6-4e1b-8039-fcd90cd6d0f6","b97d6e4f-0327-44bd-bbe8-4907602a0931","d09337a5-9763-4d82-8c6e-4b69c415ec4b"},
        idleActivity = enum_wandererIdleActivity.sit,
        probability = 1.05,
        attentionMonolog = "event_wanderer_opportunity_att",
        condition = function ( location )
            return not not EventSystem.PickItemFromList( EventSystem.wandererTreasureMapList )
        end,
        keywords = {"treasureMap"}
    },
    {
        name="help",
        cooldown = 2400,
        soulList = {"4e470ac7-0775-27bf-3647-f0c701d7eca2","5448eefc-c0d6-4269-9029-11f48326c6f6","cf30d3f2-d173-4b3b-93d3-d41a845fdec5","99fc696e-a0c8-4082-8966-702181311392","bed970a6-0c77-4897-94bf-f362f9e912d1"},
        idleActivity = enum_wandererIdleActivity.sit,
        probability = 1.2,
        attentionMonolog = "event_wanderer_help_att",
        keywords = {"help"},
    },
    {
        name="whichWay",
        cooldown = 1800,
        locationRequired = "sam",
        soulList = {"43b96dfe-6260-ff6c-58cb-aae353e62da9"},
        probability = 1.25,
        attentionMonolog = "event_wanderer_whichWay_att",
    },
    {
        name="whichWay",
        cooldown = 1800,
        locationRequired = "tal",
        soulList = {"4c6353a3-fb23-60f2-1bcf-2175c81048a4"},
        probability = 1.25,
        attentionMonolog = "event_wanderer_whichWay_att",
    },
    {
        name="whichWay",
        cooldown = 1800,
        locationRequired = "neu",
        soulList = {"45d7f6b6-123d-1bb1-c293-539244bfa3bd"},
        probability = 1.25,
        attentionMonolog = "event_wanderer_whichWay_att",
    },
    {
        name="whichWay",
        cooldown = 1800,
        locationRequired = "aus",
        soulList = {"4b86afd8-0b04-07b7-7318-48d613c4b2b5"},
        probability = 1.25,
        attentionMonolog = "event_wanderer_whichWay_att",
    },
    {
        name="whichWay",
        cooldown = 1800,
        locationRequired = "ska",
        soulList = {"4a242797-2add-350b-e416-658909237f8d"},
        probability = 1.25,
        attentionMonolog = "event_wanderer_whichWay_att",
    },
}

function EventSystem.FillAiVariable(varToFill,data)
    for i,default in pairs(varToFill) do
         varToFill[i] = data[i] or default
    end 
end

function EventSystem.CalcWandererWeight( cfg, location, variation )
    local lastSpawn = Variables.GetGlobal( "event_wanderer_" .. cfg.name .. "_lastSpawn" )
    if( ( not cfg.condition or cfg.condition(location) ) and string.match(location or "",cfg.locationRequired or "") and ( not variation or( cfg.keywords and table.contains(cfg.keywords,variation) ) ) ) then
        if( cfg.cooldown ) then
            return math.min( 1, ( (Calendar.GetGameTime()+5000) - lastSpawn) / cfg.cooldown ) * ( cfg.probability or 1 )
        else 
            return 1 * ( cfg.probability or 1 )
        end
    else
        return 0
    end
end

function EventSystem.PickWandererVariation( location, variation )
    weights = {}

    for i=1,#EventSystem.wandererConfig do
        weights[i] = EventSystem.CalcWandererWeight( EventSystem.wandererConfig[i], location, variation )
    end
    local event
    if( EventSystem.fixedRandomElements and EventSystem.fixedRandomElements['wanderer_variation'] ) then
        event = EventSystem.wandererConfig[ EventSystem.fixedRandomElements['wanderer_variation'] ]
    else
        event = Utils.WeightedSample( EventSystem.wandererConfig, weights )
    end
    if( event ) then
        event.soul = event.soulList[ math.random(1,#event.soulList) ]
        if( event.corpseList ) then
            event.corpse = event.corpseList[ math.random(1,#event.corpseList) ]
        end
        Variables.SetGlobal( "event_wanderer_" .. event.name .. "_lastSpawn", (Calendar.GetGameTime()+5000) )
        return event
    else
        return {}
    end
end
function EventSystem.PickItemFromList( list )

    local function checkGVar( item, varname )
        return Variables.GetGlobal( varname..(item.guid) ) == 0
    end

    local item =  Utils.RollingSample( list.items, checkGVar, list.gvarName )
    return item and item.guid or nil

end
function EventSystem.RemoveItemFromList( list, guid )
    Variables.SetGlobal( list.gvarName..guid, 1 )
end

function EventSystem.PickAndRemoveItemFromList( list )
    local item = EventSystem.PickItemFromList( list )
    if( item ~= nil ) then
        EventSystem.RemoveItemFromList(list,item)
    end
    return item
end


EventSystem.wandererTraderList = CryAction.LoadXML( 'libs/LuaXML/itemListDefinition.xml', 'libs/LuaXML/eventTraderItemList.xml' )
EventSystem.wandererTreasureMapList = CryAction.LoadXML( 'libs/LuaXML/itemListDefinition.xml', 'libs/LuaXML/treasureMapList.xml' )

