EventSystem = {}
function EventSystem.RandomSoulsForConfiguration( configuration, difficulty )
	local selected = {}
	for i=1,#configuration.spawnGroups do
		local cnt = math.random(configuration.spawnGroups[i].minCnt, configuration.spawnGroups[i].maxCnt)
        local chosen = {}
        if( difficulty == nil ) then
            chosen = Utils.ReservoirSample( cnt, EventSystem.classes[configuration.spawnGroups[i].class].souls )
        else
            chosen = EventSystem.WeightedRandomSouls( configuration.spawnGroups[i].class, cnt, difficulty )
        end
		for i=1,#chosen do
			table.insert(selected,chosen[i])
		end
	end
	table.arrayShiftZero(selected)
	return selected
end

function EventSystem.RandomSoulsForConfigurations( configurations, difficulty )

    local MAX_SPAWN_GROUPS = 1000

    local class2Num = {}
    local spawnGroup2Cnt = {}
    for iterC,c in pairs(configurations) do
        for iterS, spawnGroup in pairs(c.spawnGroups) do
            spawnGroup2Cnt[iterC*MAX_SPAWN_GROUPS+iterS] = math.random( spawnGroup.minCnt, spawnGroup.maxCnt )
            class2Num[spawnGroup.class] = (class2Num[spawnGroup.class] or 0) + spawnGroup2Cnt[iterC*MAX_SPAWN_GROUPS+iterS]
        end
        
    end
    
    local class2Soul = {}
    for class,cnt in pairs(class2Num) do
        if( difficulty == nil) then
            class2Soul[class] = Utils.ReservoirSample( cnt, EventSystem.classes[class].souls )
        else
            class2Soul[class] = EventSystem.WeightedRandomSouls( class, cnt, difficulty )
        end
    end
    local config2souls = {}
    for iterC,c in pairs(configurations) do
        config2souls[iterC] = {}
        for iterS, spawnGroup in pairs(c.spawnGroups) do
            for i=1,spawnGroup2Cnt[iterC*MAX_SPAWN_GROUPS+iterS] do
                table.insert( config2souls[ iterC ], table.remove(class2Soul[spawnGroup.class]) )
            end
        end
        table.arrayShiftZero(config2souls[iterC])
    end
    
    return config2souls
end
function EventSystem.WeightedRandomSouls( class, cnt, difficulty )
    
    local DIFFICULTY_MARGIN = 0.1
    local O = 0.08
    local S = 2.55
    
    local modifiedDiff = (difficulty + DIFFICULTY_MARGIN) * (1 - 2 * DIFFICULTY_MARGIN)
    local weights = {}
    local numSouls = #EventSystem.classes[class].souls
    for i = 1, numSouls do
        weights[i] = SkewedPseudoGauss( modifiedDiff, O, S,  (i/numSouls) )
    end
    return Utils.WeightedReservoirSample( cnt, EventSystem.classes[class].souls, weights )
end
function EventSystem.PickConfiguration( configurations, align, location )

    if not location then
        local checkAlign = function (element, alignment)
            return element.align == alignment;
        end
        
        return Utils.RollingSample( configurations, checkAlign, align )
    else
        local checkAlignAndLocation = function ( element, alignAndLocation )
            return element.align == alignAndLocation.alignment and element.location and element.location==alignAndLocation.location;
        end
        
        return Utils.RollingSample( configurations, checkAlignAndLocation, { alignment=align, location=location } )
    end
end
function EventSystem.PickAlignments( pickVictims )
	
	local checkGroup = function ( element, victimWarfare )
		return element.defender == victimWarfare.attacker
	end
	
	local firstPick = EventSystem.ambushConfig.classWarfare[math.random(1,#EventSystem.ambushConfig.classWarfare)]
	
	if(pickVictims ~= true) then
		return firstPick
	else
		local secondPick = Utils.RollingSample( EventSystem.ambushConfig.classWarfare, checkGroup, firstPick )
		local attempts = 5
		while attempts > 0 and secondPick == nil do
			firstPick = EventSystem.ambushConfig.classWarfare[math.random(1,#EventSystem.ambushConfig.classWarfare)]
			secondPick = Utils.RollingSample( EventSystem.ambushConfig.classWarfare, checkGroup, firstPick )
			attempts = attempts - 1
		end
		
		if(secondPick==nil) then
			return firstPick
		else
			return { attacker = secondPick.attacker, defender = firstPick.attacker, victim = firstPick.defender }
		end
		
	end
	
end

function EventSystem._ExtractProbabilities( probTable, dependency )
	local weights = {}
	for i=1,#probTable do
		if dependency == nil or probTable[i].dependentValue == dependency then
			weights[i] = probTable[i].probability
		else
			weights[i] = 0
		end 
	end
	return weights
end

function EventSystem._ExtractLabels(probTable)
	local labels = {}
	for i=1,#probTable do
		labels[i] = probTable[i].outValue
	end
	return labels
end

function EventSystem.PickRandomElements( elements )
	
	local picked = {}
	local dependency = nil
	for i=1,#elements do
		if( EventSystem.fixedRandomElements ~= nil and EventSystem.fixedRandomElements[elements[i].name] ~= nil) then
			picked[elements[i].name] = EventSystem.fixedRandomElements[elements[i].name]
		else
			if elements[i].dependency ~= nil then
				 dependency = picked[elements[i].dependency]
			else
				dependency = nil
			end
			picked[ elements[i].name ] = Utils.WeightedSample( EventSystem._ExtractLabels(elements[i].probTable), EventSystem._ExtractProbabilities(elements[i].probTable,dependency) )
		end
	end
	return picked
end

function EventSystem.Initialize(self)

  local classes = CryAction.LoadXML("libs/LuaXML/soulPoolDefinitions.xml","libs/LuaXML/soulPool.xml").pools;
  local usedSouls = {}
  self.classes = {}
  for i=1,#classes do
	self.classes[ classes[i].name ] = classes[i];
	classes[i].souls = {}
  end

  local numCols = Database.GetTableInfo("soul").ColumnCount
  local colDictionary = {}
  for c=0,numCols-1 do
    colDictionary[Database.GetColumnInfo("soul",c).Name] = c
  end
  local guids = Database.GetTableColumnData("soul",colDictionary["soul_id"]);
  local names = Database.GetTableColumnData("soul",colDictionary["soul_name"]);
  
  local soul2nameNumber = {}
  for s=1,#guids do
	soul2nameNumber[ guids[s] ] = tonumber(string.match( names[s], '[0-9]+' )) or 0
    for name,class in pairs(EventSystem.classes) do
      if( class.filter and class.filter~="" and string.match( names[s], class.filter ) ) then
        table.insert(class.souls, guids[s])
      end
    end
  end
  for id,class in pairs(EventSystem.classes) do
	table.sort( class.souls, function (a,b) return soul2nameNumber[a] < soul2nameNumber[b] end )
  end
  
  EventSystem.ambushConfig = CryAction.LoadXML("libs/LuaXML/ambushNPCDefinitions.xml","libs/LuaXML/ambushNPCConfigurations.xml");
  EventSystem.roadsideConfig = CryAction.LoadXML("libs/LuaXML/roadsideCorpseDefinitions.xml","libs/LuaXML/roadsideCorpseConfigurations.xml");
  EventSystem.ambushPlrConfig = CryAction.LoadXML("libs/LuaXML/ambushPLRDefinitions.xml","libs/LuaXML/ambushPLRConfigurations.xml");

end
function EventSystem:IsPlayerMounted()
	return ((player.human:IsMounted()  and 1) or 0);
end

function EventSystem:GenericEventEvade()
	player.soul:AddBuff('e4b76425-4bc5-492a-9d5f-3575b4fab1be');
	player.soul:AddBuff('c37ab134-a443-433f-92a9-51ff6f08999c');
	Variables.SetGlobal('genericEvadeDisableTimer',Calendar.GetGameTime() + 5 );
	XGenAIModule.SendMessageToEntity( player.this.id, "player:preventCombat", "5s" );
end

function EventSystem.FixRandomElementForTest( element, value )
	if( EventSystem.fixedRandomElements == nil ) then
		EventSystem.fixedRandomElements = {}
	end
	EventSystem.fixedRandomElements[element] = value
end

function EventSystem.ResetFixedElements()
	EventSystem.fixedRandomElements = nil
    EventSystem.fixedSeed = nil
end

function EventSystem.SetDump( doDump )
    EventSystem.doDumpElements = doDump
end

function EventSystem.Dump( tbl )
    if( EventSystem.doDumpElements ) then
        Dump( tbl )
    end
end

function EventSystem.FixRandomSeed( newSeed )
    EventSystem.fixedSeed = newSeed;
end

function EventSystem.RandomSeed()
    if( EventSystem.fixedSeed ) then
        math.randomseed(EventSystem.fixedSeed)
    end
end

EventSystem:Initialize();