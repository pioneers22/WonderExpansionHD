local iSantaMariaDelFiore = GameInfo.Buildings["BUILDING_SANTA_MARIA_DEL_FIORE"].Index;
local pGreatEngineer = GameInfo.Units["UNIT_GREAT_ENGINEER"].Index

function SantaMariaDelFiore_GreatEngineerEarned_New (playerID, unitID, iX, iY, locallyVisible, stateChange)
	local pPlayer = Players[playerID];
	local pUnit = pPlayer:GetUnits():FindID(unitID);
	for i, pCity in pPlayer:GetCities():Members() do
		if (pCity:GetBuildings():HasBuilding(iSantaMariaDelFiore)) then
			if pUnit:GetType() == pGreatEngineer then
				local iGreatArtist = GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_ARTIST"].Index;
				local timeline = Game.GetGreatPeople():GetTimeline();
				local cost = 0;
		  		for i, entry in ipairs(timeline) do
					if entry.Class == iGreatArtist then
						cost = entry.Cost;
					end
		  		end
		  		local nGPPGained = cost * 50 / 100;
		  		pPlayer:GetGreatPeoplePoints():ChangePointsTotal(iGreatArtist, nGPPGained);
		  		local sGPPNotifier = tostring(nGPPGained)..Locale.Lookup("LOC_NOTIFIER_GREATARTIST_SANTA_MARIA_DEL_FIORE_GPP");
		  		NotificationManager.SendNotification(playerID, "NOTIFICATION_RELIC_CREATED", sGPPNotifier);
			end
		end
	end
end
Events.UnitGreatPersonCreated.Add(SantaMariaDelFiore_GreatEngineerEarned_New)

