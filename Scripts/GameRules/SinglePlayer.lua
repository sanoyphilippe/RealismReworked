

SinglePlayer = {
	tempVec = {x=0,y=0,z=0},

	Client = {},
	Server = {},
	
	Properties = {			
		bSaved_by_game = 0,		
	},
	spawns = {},
}

usableEntityList = {}

if (not g_dmgMult) then g_dmgMult = 1.0; end
function SinglePlayer:OnReset(toGame)
end
function SinglePlayer:OnGameLoaded()
	System.LogAlways("Running q_perks right hereerere OnGameLoaded");
	QuestSystem.StartObjective('q_perks', 'perk_manSlayer');
	local questStatus = QuestSystem.IsQuestStarted('q_perks');
	local objectiveStatus = QuestSystem.IsObjectiveStarted('q_perks', 'perk_manSlayer');
	local objectiveStatus2 = QuestSystem.IsObjectiveCanceled('q_perks', 'perk_manSlayer');
	local objectiveStatus3 = QuestSystem.IsObjectiveCompleted('q_perks', 'perk_manSlayer');	
	System.LogAlways("questStatus: "..tostring(questStatus));
	System.LogAlways("objectiveStatus: "..tostring(objectiveStatus));
	System.LogAlways("objectiveStatusca: "..tostring(objectiveStatus2));
	System.LogAlways("objectiveStatusco: "..tostring(objectiveStatus3));
end
function SinglePlayer:OnGameplayStarted()
	System.LogAlways("Running q_perks right hereerere OnGameplayStarted");
	QuestSystem.StartObjective('q_perks', 'perk_manSlayer');
	local questStatus = QuestSystem.IsQuestStarted('q_perks');
	local objectiveStatus = QuestSystem.IsObjectiveStarted('q_perks', 'perk_manSlayer');
	local objectiveStatus2 = QuestSystem.IsObjectiveCanceled('q_perks', 'perk_manSlayer');
	local objectiveStatus3 = QuestSystem.IsObjectiveCompleted('q_perks', 'perk_manSlayer');	
	System.LogAlways("questStatus: "..tostring(questStatus));
	System.LogAlways("objectiveStatus: "..tostring(objectiveStatus));
	System.LogAlways("objectiveStatusca: "..tostring(objectiveStatus2));
	System.LogAlways("objectiveStatusco: "..tostring(objectiveStatus3));
end
function SinglePlayer:EquipActor(actor)
	
end
function SinglePlayer:OnShoot(shooter)
	if (shooter and shooter.OnShoot) then
		if (not shooter:OnShoot()) then
			return false;
		end
	end
	
	return true;
end
function SinglePlayer:IsUsable(obj)
	if(obj.GetActions) then
		local actions = obj:GetActions(g_localActor, true);
		if #actions > 0 then
			return 1;
		end
		
		return 0;
	end
	if (obj.IsUsable) then
		return obj:IsUsable(g_localActor);
	end

	return 0;
end
function SinglePlayer:AreUsable(source, entities)
	
	if (entities) then
		for i,entity in ipairs(entities) do
			usableEntityList[i] = entity:IsUsable(source);
		end
	end

	return usableEntityList;
end
function SinglePlayer:IsUsableMsgChanged(objId)
	local obj = System.GetEntity(objId);
	if (obj.IsUsableMsgChanged) then
		return obj:IsUsableMsgChanged();
	end
	
	return 0;
end
function SinglePlayer:OnNewUsable(srcId, objId, usableId)
end
function SinglePlayer:OnUsableMessage(obj)

	if obj.GetActions then
		g_localActor.player:AddLuaActions(obj:GetActions(g_localActor));
		return;
	end
	local msg = "";
	if obj.GetUsableMessage then
		msg = obj:GetUsableMessage(0)
	else
		local state = obj:GetState()
		if state ~= "" then
			state = obj[state]
			if state.GetUsableMessage then
				msg = state.GetUsableMessage(obj, 0)
			end
		end
	end
	local hintType = 0;
	if  obj.IsUsable then
		hintType = obj:IsUsable(g_localActor) - 1;
	end
	
	local hintEvent = "use";
	if obj.GetUsableEvent
	then
		hintEvent = obj:GetUsableEvent(0)
	end
				
	if (msg ~= "") then
		local actions = {};
		AddAction(actions, false, msg, hintEvent, hintType, true, obj.OnUsed)
		g_localActor.player:AddLuaActions(actions);		
	end
	local hintTypeHold = 0;
	if obj.IsUsableHold then
		hintTypeHold = obj:IsUsableHold(g_localActor) + 1 - 1;
	end
	
	local hintEventHold = "use";
	if obj.GetUsableEventHold
	then
		hintEventHold = obj:GetUsableEventHold(0)
	end
	
	if obj.IsUsableHold and obj.GetUsableHoldMessage and (hintTypeHold > 0) then
		msg = obj:GetUsableHoldMessage();
	
		local actions = {};
		AddAction(actions, false, msg, hintEventHold, hintTypeHold, true, nil)
		g_localActor.player:AddLuaActions(actions);		
	end
end
function SinglePlayer:OnLongHover(srcId, objId)
end
function SinglePlayer:EndLevel( params )
	if (not System.IsEditor()) then		  
		if (not params.nextlevel) then		  
			Game.PauseGame(true);
			Game.ShowMainMenu();
		end
		g_GameTokenPreviousLevel = GameToken.GetToken( "Game.Global.Previous_Level" );
	end
end
function SinglePlayer:CreateExplosion(shooterIdParam,weaponIdParam,damage,pos,dir,radius,angle,pressure,holesize,effect,effectScale, minRadius, minPhysRadius, physRadius, explosionType, soundRadius)
	if (not dir) then
		dir=g_Vectors.up;
	end
	
	if (not radius) then
		radius=5.5;
	end

	if (not minRadius) then
		minRadius=radius/2;
	end

	if (not physRadius) then
		physRadius=radius;
	end

	if (not minPhysRadius) then
		minPhysRadius=physRadius/2;
	end

	if (not angle) then
		angle=0;
	end
	
	if (not pressure) then
		pressure=200;
	end
	
	if (holesize==nil) then
    holesize = math.min(radius, 5.0);
	end
	
	if (radius == 0) then
		return;
	end
	
	local shooterId = NULL_ENTITY;
	if (shooterIdParam~=0 and shooterIdParam~=nil) then
		shooterId = shooterIdParam;
	end

	local weaponId = NULL_ENTITY;
	if (weaponIdParam~=0 and weaponIdParam~=nil) then
		weaponId = weaponIdParam;
	end
	
	self.game:ServerExplosion(shooterId, weaponId, damage, pos, dir, radius, angle, pressure, holesize, effect, effectScale, explosionType, minRadius, minPhysRadius, physRadius, soundRadius);
end
function SinglePlayer:CreateHit(targetId,shooterId,weaponId,dmg,radius,material,partId,type,pos,dir,normal)
	if (not radius) then
		radius=0;
	end
	
	local materialId=0;
	
	if (material) then
		materialId=self.game:GetHitMaterialId(material);
	end
	
	if (not partId) then
		partId=-1;
	end
	
	local typeId=0;
	if (type) then
		typeId=self.game:GetHitTypeId(type);
	else
		typeId=self.game:GetHitTypeId("normal");
	end
	
	self.game:ServerHit(targetId, shooterId, weaponId, dmg, radius, materialId, partId, typeId, pos, dir, normal);
end
function SinglePlayer:ClientViewShake(pos, distance, radiusMin, radiusMax, amount, duration, frequency, source, rnd)
	if (g_localActor and g_localActor.actor) then
		if (distance) then
			self:ViewShake(g_localActor, distance, radiusMin, radiusMax, amount, duration, frequency, source, rnd);
			return;
		end
		if (pos) then
			local delta = self.tempVec;
			CopyVector(delta,pos);
			FastDifferenceVectors(delta, delta, g_localActor:GetWorldPos());
			local dist = LengthVector(delta);
			self:ViewShake(g_localActor, dist, radiusMin, radiusMax, amount, duration, frequency, source, rnd);
			return;
		end
	end
end
function SinglePlayer:ViewShake(player, distance, radiusMin, radiusMax, amount, duration, frequency, source, rnd)
	local deltaDist = radiusMax - distance;
	rnd = rnd or 0.0;
	if (deltaDist > 0.0) then
		local r = math.min(1, deltaDist/(radiusMax-radiusMin));
		local amt = amount * r;
		local halfDur = duration * 0.5;
		player.actor:SetViewShake({x=2*g_Deg2Rad*amt, y=2*g_Deg2Rad*amt, z=2*g_Deg2Rad*amt}, {x=0.02*amt, y=0.02*amt, z=0.02*amt},halfDur + halfDur*r, 1/20, rnd);
	end
end
function SinglePlayer:OnSpawn()
end
function SinglePlayer.Server:OnInit()
	self.fallHit={};
	self.explosionHit={};
	self.collisionHit={};
end
function SinglePlayer.Client:OnInit()

end
function SinglePlayer.Server:OnClientConnect( channelId )
	local params =
	{
		name     = "Dude",
		class    = "Player",
		position = {x=0, y=0, z=0},
		rotation = {x=0, y=0, z=0},
		scale    = {x=1, y=1, z=1},
	};
	player = Actor.CreateActor(channelId, params);
	
	if (not player) then
	  Log("OnClientConnect: Failed to spawn the player!");
	  return;
	end
	
	local spawnId = self.game:GetFirstSpawnLocation(0);
	if (spawnId) then
		local spawn=System.GetEntity(spawnId);
		if (spawn) then
			player:SetWorldPos(spawn:GetWorldPos(g_Vectors.temp_v1));
			spawn:GetAngles(g_Vectors.temp_v1);
  	  g_Vectors.temp_v1.x = 0;
  	  g_Vectors.temp_v1.y = 0;
  	  player.actor:PlayerSetViewAngles(g_Vectors.temp_v1);
			spawn:Spawned(player);
			
			return;
		end
	end

	System.Log("$1warning: No spawn points; using default spawn location!")
end
function SinglePlayer.Server:OnClientEnteredGame( channelId, player, loadingSaveGame )
end
function SinglePlayer:GetDamageAbsorption(actor, hit)
	return 0
end
function SinglePlayer:CanHitIgnoreInvulnerable(hit, target)

	if (self:IsStealthHealthHit(hit.type)) then
		return true;
	elseif (hit.type == "silentMelee") then
		return true;
	end

end
function SinglePlayer:ProcessActorDamage(hit)
	local target=hit.target;
	local shooter=hit.shooter;
	local shooterId = hit.shooterId or NULL_ENTITY;
	local weapon=hit.weapon;
	local health = target.actor:GetHealth();
	
	if (target.IsInvulnerable and target:IsInvulnerable() and not self:CanHitIgnoreInvulnerable(hit,target))then
		return (health <= 0);
	end;
	
	local isMultiplayer = self.game:IsMultiplayer();
	local totalDamage = g_dmgMult * hit.damage;
	
	local splayer = shooter and shooter.actor and shooter.actor:IsPlayer();
	local tplayer = target and target.actor and target.actor:IsPlayer();
		
	if (not isMultiplayer) then
		
		local sai=(not splayer) and shooter and shooter.actor;
		local tai=(not tplayer) and target and target.actor;
		
		local dmgMult = 1.0;
		if (tplayer) then
			dmgMult = g_dmgMult;
		end
		
		if (shooter and shooter.actor and tai) then
			AI.SetAlarmed(target.id);
		end
		
		if(AI) then	
			if (sai and not tai) then
				totalDamage = AI.ProcessBalancedDamage(shooterId, target.id, dmgMult*hit.damage, hit.type);
				totalDamage = totalDamage*(1-self:GetDamageAbsorption(target, hit));
			elseif (sai and tai) then
				totalDamage = AI.ProcessBalancedDamage(shooterId, target.id, dmgMult*hit.damage, hit.type);
				totalDamage = totalDamage*(1-self:GetDamageAbsorption(target, hit));
			else
				totalDamage = dmgMult*hit.damage*(1-self:GetDamageAbsorption(target, hit));
			end
		else
			totalDamage = dmgMult*hit.damage*(1-self:GetDamageAbsorption(target, hit));
		end
	end

	if (tplayer and (hit.damage > 0) and (hit.type == "collision")) then
		if (hit.velocity and hit.velocity > 0.5) then
			totalDamage = 0;
		end
	end
	local newhealth = math.floor(health - totalDamage);
	local useMercyTime = not isMultiplayer and (hit.type ~= "fall") and (hit.type ~= "punish") and (hit.type ~= "vehicleDestruction");
	if (tplayer and useMercyTime) then
		local threshold=target.actor:GetLowHealthThreshold();
		if (health>threshold and newhealth<=0) then
		end
	end
	if (hit.type ~= "event") then
		if (target.GetForcedMinHealthThreshold) then
			local forcedMinHealth = target:GetForcedMinHealthThreshold()
			if (newhealth < forcedMinHealth) then
				newhealth = forcedMinHealth
			end
		end
	end
	
	health = newhealth;
	if((not isMultiplayer) and (target.id == g_localActorId) and (health <= 0)) then
		self.game:DemiGodDeath();

		local isGod = target.actor:IsGod();
		if (isGod and isGod > 0) then
			target.actor:SetHealth(0);
			health = target.Properties.Damage.health;
		end
	end
	
	target.actor:SetHealth(health);	
	health = target.actor:GetHealth();
	
	if (not isMultiplayer) then
		target:WallBloodSplat(hit, health <= 0);
	end
	
	local weaponId = (weapon and weapon.id) or NULL_ENTITY;
	local projectileId = hit.projectileId or NULL_ENTITY;
	target.actor:DamageInfo(shooterId, target.id, weaponId, projectileId, totalDamage, hit.typeId, hit.dir);
	if (not isMultiplayer and AI) then
		if(hit.material_type) then
			AI.DebugReportHitDamage(target.id, shooterId, totalDamage, hit.material_type);
		else
			AI.DebugReportHitDamage(target.id, shooterId, totalDamage, "");
		end
	end

	return (health <= 0);
end
function SinglePlayer.Server:OnStartLevel()
	CryAction.SendGameplayEvent(NULL_ENTITY, eGE_GameStarted);
	if (g_GameTokenPreviousLevel) then
		GameToken.SetToken( "Game.Global.Previous_Level", g_GameTokenPreviousLevel );
		g_GameTokenPreviousLevel = nil;
	end
end
function SinglePlayer.Client:OnStartLevel()

end
function SinglePlayer.Client:OnHit(hit)
	local trg = hit.target;
	if (trg and trg.Client and trg.Client.OnHit) then
		trg.Client.OnHit(trg, hit);
	end
end
function SinglePlayer:PrecacheLevel()
end
function SinglePlayer:IsStealthHealthHit(hitType)
	return (hitType == "stealthKill") or (hitType == "stealthKill_Maximum");
end
