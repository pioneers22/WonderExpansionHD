--直接修改数值的直接放这里
--楼兰城造价提升为420锤，基础产降低为1粮1锤
update Buildings set Cost = 420 where BuildingType = 'BUILDING_LOULAN';
update Building_YieldChanges set YieldChange = 1 where BuildingType = 'BUILDING_LOULAN';
--名古屋城造价降低为1000锤，基础产提升为2宜居度8金，新增特效攻城单位+2移动力+5战斗力。
update Buildings set Cost = 1000 where BuildingType = 'BUILDING_PHANTA_NAGOYA_CASTLE';
update Building_YieldChanges set YieldChange = 8 where BuildingType = 'BUILDING_PHANTA_NAGOYA_CASTLE';
insert or replace into BuildingModifiers
	(BuildingType,									ModifierId)
select
	'BUILDING_PHANTA_NAGOYA_CASTLE',				'PHANTA_NAGOYA_CASTLE_ADD_ABILITY'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_NAGOYA_CASTLE');
insert or replace into Modifiers
	(ModifierId,									ModifierType)
values
	('PHANTA_NAGOYA_CASTLE_ADD_ABILITY',			'MODIFIER_PLAYER_UNITS_GRANT_ABILITY'),
	('PHANTA_NAGOYA_CASTLE_MOVEMENT',				'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT'),
	('PHANTA_NAGOYA_CASTLE_STRENGTH',				'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH');
insert or replace into ModifierArguments
	(ModifierId,									Name,				Value)
values
	('PHANTA_NAGOYA_CASTLE_ADD_ABILITY',			'AbilityType',		'ABILITY_PHANTA_NAGOYA_CASTLE'),
	('PHANTA_NAGOYA_CASTLE_MOVEMENT',				'Amount',			2),
	('PHANTA_NAGOYA_CASTLE_STRENGTH',				'Amount',			5);
insert or replace into ModifierStrings
	(ModifierId,									Context,			Text)
values
	('PHANTA_NAGOYA_CASTLE_STRENGTH',				'Preview',			'+{1_Amount} {LOC_PHANTA_NAGOYA_CASTLE_STRENGTH}');
insert or replace into Types
	(Type,											Kind)
values
	('ABILITY_PHANTA_NAGOYA_CASTLE',				'KIND_ABILITY');
insert or replace into UnitAbilities
	(UnitAbilityType,								Name,										Description,										Inactive)
values
	('ABILITY_PHANTA_NAGOYA_CASTLE',				NULL,										'LOC_ABILITY_PHANTA_NAGOYA_CASTLE_DESCRIPTION',		1);
insert or replace into UnitAbilityModifiers
	(UnitAbilityType,								ModifierId)
values
	('ABILITY_PHANTA_NAGOYA_CASTLE',				'PHANTA_NAGOYA_CASTLE_MOVEMENT'),
	('ABILITY_PHANTA_NAGOYA_CASTLE',				'PHANTA_NAGOYA_CASTLE_STRENGTH');
insert or replace into TypeTags
	(Type,											Tag)
values
	('ABILITY_PHANTA_NAGOYA_CASTLE',				'CLASS_SIEGE');
--黄金塔造价提升为1000锤，基础产提升为2提督点10金，盖伦帆船220锤5维护费
update Buildings set Cost = 1000 where BuildingType = 'BUILDING_TORRE_DEL_ORO';
update Building_YieldChanges set YieldChange = 10 where BuildingType = 'BUILDING_TORRE_DEL_ORO';
update Building_GreatPersonPoints set PointsPerTurn = 2 where BuildingType = 'BUILDING_TORRE_DEL_ORO';
update Units set Cost = 220, Maintenance = 5 where UnitType = 'UNIT_GALEON_TDO';
--阿姆利则金庙造价提升为1000锤
update Buildings set Cost = 1000 where BuildingType = 'BUILDING_HARIMANDIR_SAHIB';
--吉萨狮身人面像造价提升为260锤
update Buildings set Cost = 260 where BuildingType = 'BUILDING_PHANTA_GREAT_SPHINX';
--世界贸易中心造价提升为2000锤，基础产提升为20金，改为全球化解锁
update Buildings set Cost = 2000, PrereqTech = NULL, PrereqCivic = 'CIVIC_GLOBALIZATION' where BuildingType = 'BUILDING_PHANTA_WORLD_TRADE_CENTER';
update Building_YieldChanges set YieldChange = 20 where BuildingType = 'BUILDING_PHANTA_WORLD_TRADE_CENTER';
--亚马逊剧院造价降低为1360锤，基础产调整为6文4大艺4大音，汉化
update Buildings set Cost = 1360 where BuildingType = 'BUILDING_AMAZON_THEATRE';
update Building_YieldChanges set YieldChange = 6 where BuildingType = 'BUILDING_AMAZON_THEATRE';
update Building_GreatPersonPoints set PointsPerTurn = 4 where BuildingType = 'BUILDING_AMAZON_THEATRE';
insert or replace into Building_GreatPersonPoints
	(BuildingType,						GreatPersonClassType,			PointsPerTurn)
select
	'BUILDING_AMAZON_THEATRE',			'GREAT_PERSON_CLASS_ARTIST',	4
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_AMAZON_THEATRE');
--所罗门圣殿造价提升为420锤，基础产增加3鸽，遗物槽减少到2个，移除创造遗物加1人口，改为神学解锁
update Buildings set Cost = 420, PrereqCivic = 'CIVIC_THEOLOGY' where BuildingType = 'BUILDING_TEMPLEOFSOLOMON';
update Building_GreatWorks set NumSlots = 2 where BuildingType = 'BUILDING_TEMPLEOFSOLOMON';
delete from ImprovementModifiers where ModifierId = 'MODFEAT_TEMPLEOFSOLOMON_DUMMY_GRANT_POPULATION';
insert or replace into Building_YieldChanges
	(BuildingType,						YieldType,				YieldChange)
select
	'BUILDING_TEMPLEOFSOLOMON',		'YIELD_FAITH',			3
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_TEMPLEOFSOLOMON');
--三星堆造价提升为260锤，基础产增加1瓶1鸽，遗物槽减少到1个
update Buildings set Cost = 260 where BuildingType = 'BUILDING_PHANTA_SANXINGDUI';
update Buildings set Cost = 260 where BuildingType = 'BUILDING_PHANTA_SANXINGDUI_1';
update Buildings set Cost = 260 where BuildingType = 'BUILDING_PHANTA_SANXINGDUI_2';
update Building_GreatWorks set NumSlots = 1 where BuildingType = 'BUILDING_PHANTA_SANXINGDUI';
update Building_GreatWorks set NumSlots = 1 where BuildingType = 'BUILDING_PHANTA_SANXINGDUI_1';
update Building_GreatWorks set NumSlots = 1 where BuildingType = 'BUILDING_PHANTA_SANXINGDUI_2';
insert or replace into Building_YieldChanges
	(BuildingType,						YieldType,				YieldChange)
select
	'BUILDING_PHANTA_SANXINGDUI',		'YIELD_FAITH',			1
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_SANXINGDUI')
union all select
	'BUILDING_PHANTA_SANXINGDUI',		'YIELD_SCIENCE',		1
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_SANXINGDUI')
union all select
	'BUILDING_PHANTA_SANXINGDUI_1',		'YIELD_FAITH',			1
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_SANXINGDUI_1')
union all select
	'BUILDING_PHANTA_SANXINGDUI_1',		'YIELD_SCIENCE',		1
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_SANXINGDUI_1')
union all select
	'BUILDING_PHANTA_SANXINGDUI_2',		'YIELD_FAITH',			1
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_SANXINGDUI_2')
union all select
	'BUILDING_PHANTA_SANXINGDUI_2',		'YIELD_SCIENCE',		1
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_SANXINGDUI_2');
--太阳/月亮金字塔造价提升为420锤，基础产调整为2鸽3大军，月亮金字塔数值提升至15HP
update Buildings set Cost = 420 where BuildingType = 'BUILDING_SUN_PYRAMID';
update Buildings set Cost = 420 where BuildingType = 'BUILDING_MOON_PYRAMID';
update Building_GreatPersonPoints set PointsPerTurn = 3 where BuildingType = 'BUILDING_SUN_PYRAMID';
update Building_GreatPersonPoints set PointsPerTurn = 3 where BuildingType = 'BUILDING_MOON_PYRAMID';
update ModifierArguments set Value = 15 where ModifierId = 'MODFEAT_MOON_PYRAMID_HEAL_MORE' and Name = 'Amount';
--滕王阁造价提升为750锤，改为科举解锁
update Buildings set Cost = 750, PrereqCivic = 'CIVIC_IMPERIAL_EXAMINATION_SYSTEM_HD' where BuildingType = 'BUILDING_PHANTA_PAVILION_PRINCE_TENG';
--帕特农神庙造价提升至420锤，基础产增加2文，移除通往城邦的每条贸易路线将为此处提供1名使者
update Buildings set Cost = 420 where BuildingType = 'BUILDING_PARTHENON';
delete from BuildingModifiers where ModifierId = 'MODFEAT_PARTHENON_TRADE_ROUTE_ENVOY';
insert or replace into Building_YieldChanges
	(BuildingType,						YieldType,				YieldChange)
select
	'BUILDING_PARTHENON',				'YIELD_CULTURE',		2
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PARTHENON');
--大阪城造价降低为1000锤，基础产调整为2宜居度8金
update Buildings set Cost = 1000 where BuildingType = 'BUILDING_PHANTA_OSAKA_CASTLE';
update Building_YieldChanges set YieldChange = 8 where BuildingType = 'BUILDING_PHANTA_OSAKA_CASTLE';
--东方明珠电视塔，基础产增加20金，改为全球化解锁
update Buildings set PrereqTech = NULL, PrereqCivic = 'CIVIC_GLOBALIZATION' where BuildingType = 'BUILDING_ORIENTAL_PEARL_TOWER';
insert or replace into Building_YieldChanges
	(BuildingType,						YieldType,				YieldChange)
select
	'BUILDING_ORIENTAL_PEARL_TOWER',	'YIELD_GOLD',			20
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_ORIENTAL_PEARL_TOWER');
--旧伦敦桥造价提升为750锤，基础产增加2锤6金，改为学徒解锁，新增所在城市的港口相邻加成提供生产力，商业相邻加成提供文化。
update Buildings set Cost = 750, PrereqTech = 'TECH_APPRENTICESHIP' where BuildingType = 'BUILDING_OLD_LONDON_BRIDGE';
insert or replace into Building_YieldChanges
	(BuildingType,						YieldType,				YieldChange)
select
	'BUILDING_OLD_LONDON_BRIDGE',		'YIELD_PRODUCTION',		2
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_OLD_LONDON_BRIDGE')
union all select
	'BUILDING_OLD_LONDON_BRIDGE',		'YIELD_GOLD',			6
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_OLD_LONDON_BRIDGE');
insert or replace into BuildingModifiers
	(BuildingType,						ModifierId)
select
	'BUILDING_OLD_LONDON_BRIDGE',		'MODFEAT_LONGONBRIDGE_HARBOR'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_OLD_LONDON_BRIDGE')
union all select
	'BUILDING_OLD_LONDON_BRIDGE',		'MODFEAT_LONGONBRIDGE_COMMERCIAL_HUB'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_OLD_LONDON_BRIDGE');
insert or replace into Modifiers
	(ModifierId,									ModifierType,															SubjectRequirementSetId)
values
	('MODFEAT_LONGONBRIDGE_HARBOR',					'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',								'DISTRICT_IS_DISTRICT_HARBOR_REQUIREMENTS'),
	('MODFEAT_LONGONBRIDGE_COMMERCIAL_HUB',			'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',								'DISTRICT_IS_DISTRICT_COMMERCIAL_HUB_REQUIREMENTS'),
	('MODFEAT_LONGONBRIDGE_HARBOR_MODIFIER',		'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS',		NULL),
	('MODFEAT_LONGONBRIDGE_COMMERCIAL_HUB_MODIFIER','MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS',		NULL);
insert or replace into ModifierArguments
	(ModifierId,									Name,				Value)
values
	('MODFEAT_LONGONBRIDGE_HARBOR',					'ModifierId',		'MODFEAT_LONGONBRIDGE_HARBOR_MODIFIER'),
	('MODFEAT_LONGONBRIDGE_COMMERCIAL_HUB',			'ModifierId',		'MODFEAT_LONGONBRIDGE_COMMERCIAL_HUB_MODIFIER'),
	('MODFEAT_LONGONBRIDGE_HARBOR_MODIFIER',		'YieldTypeToGrant',	'YIELD_PRODUCTION'),
	('MODFEAT_LONGONBRIDGE_HARBOR_MODIFIER',		'YieldTypeToMirror','YIELD_GOLD'),
	('MODFEAT_LONGONBRIDGE_COMMERCIAL_HUB_MODIFIER','YieldTypeToGrant',	'YIELD_CULTURE'),
	('MODFEAT_LONGONBRIDGE_COMMERCIAL_HUB_MODIFIER','YieldTypeToMirror','YIELD_GOLD');
--西贡圣母大教堂造价提升为1360锤，建成时赠予一次等同于每回合文化值4倍的信仰值加成。
update Buildings set Cost = 1360 where BuildingType = 'BUILDING_PHANTA_NOTRE_DAME_SAIGON';
update ModifierArguments set Value = 4 where ModifierId = 'MODFEAT_PHANTA_NOTRE_DAME_SAIGON_GRANT_FAITH' and Name = 'Multiplier';
--斯瓦尔巴群岛全球种子库价降低为1800锤，基础产提升为+8琴8瓶+5大工+5大科+300%国家公园业绩
update Buildings set Cost = 1800 where BuildingType = 'BUILDING_SVALBARD';
update ModifierArguments set Value = 300 where ModifierId = 'MODIFIER_SVALBARD_NATIONAL_PARKS';
insert or replace into Building_YieldChanges
	(BuildingType,						YieldType,				YieldChange)
select
	'BUILDING_SVALBARD',				'YIELD_SCIENCE',		8
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_SVALBARD');
insert or replace into Building_GreatPersonPoints
	(BuildingType,						GreatPersonClassType,			PointsPerTurn)
select
	'BUILDING_SVALBARD',				'GREAT_PERSON_CLASS_SCIENTIST',	5
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_SVALBARD');
--铜雀台造价提升为420锤，基础产提升2文2大作，改为文学传统解锁，移除免费获得一个大作家，移除1个巨作槽位（任一类型）
update Buildings set Cost = 420, PrereqCivic = 'CIVIC_LITERARY_TRADITION_HD' where BuildingType = 'BUILDING_PHANTA_BRONZE_BIRD_TERRACE';
delete from Building_GreatWorks where BuildingType = 'BUILDING_PHANTA_BRONZE_BIRD_TERRACE' and GreatWorkSlotType = 'GREATWORKSLOT_PALACE';
delete from BuildingModifiers where ModifierId = 'MODFEAT_PHANTA_BRONZE_BIRD_TERRACE_GRANT_WRITER';
insert or replace into Building_YieldChanges
	(BuildingType,								YieldType,				YieldChange)
select
	'BUILDING_PHANTA_BRONZE_BIRD_TERRACE',		'YIELD_CULTURE',		2
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_BRONZE_BIRD_TERRACE');
insert or replace into Building_GreatPersonPoints
	(BuildingType,								GreatPersonClassType,			PointsPerTurn)
select
	'BUILDING_PHANTA_BRONZE_BIRD_TERRACE',		'GREAT_PERSON_CLASS_ARTIST',	2
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_BRONZE_BIRD_TERRACE');
--布哈拉造价提升为420锤，基础产提升+3金币+1科技+2大商人点数
update Buildings set Cost = 420 where BuildingType = 'BUILDING_SILK_ROAD';
update Building_GreatPersonPoints set PointsPerTurn = 2 where BuildingType = 'BUILDING_SILK_ROAD';
insert or replace into Building_YieldChanges
	(BuildingType,								YieldType,				YieldChange)
select
	'BUILDING_SILK_ROAD',						'YIELD_SCIENCE',		1
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_SILK_ROAD');
--伏见稻荷大社造价提升为750锤，UI鸟居基础产提升至+2文化值。+1魅力。每相邻1座鸟居+2信仰值。若相邻奇观或自然奇观+3文化值。若位于或相邻森林+2文化值。
update Buildings set Cost = 750 where BuildingType = 'BUILDING_PHANTA_FUSHIMI_INARI_TAISHA';
update Improvement_YieldChanges set YieldChange = 2 where ImprovementType = 'IMPROVEMENT_PHANTA_TORII_GATE' and YieldType = 'YIELD_CULTURE';
update ModifierArguments set Value = 3 where ModifierId = 'MODFEAT_IMPROVEMENT_PHANTA_TORII_GATE_CULTURE_FROM_ADJACENT_WONDER' and Name = 'Amount';
update ModifierArguments set Value = 2 where ModifierId = 'MODFEAT_IMPROVEMENT_PHANTA_TORII_GATE_CULTURE_FROM_WOODS' and Name = 'Amount';
--基督救世主大教堂造价降低为1000锤，改为伦理学解锁
update Buildings set Cost = 1000, PrereqCivic = 'CIVIC_ETHICS_HD' where BuildingType = 'BUILDING_CATHEDRAL_CHRIST_SAVIOUR';
--岩石圆顶清真寺造价提升为750锤 适配宗教扩展
update Buildings set Cost = 750 where BuildingType = 'BUILDING_DOME_OF_THE_ROCK';
insert or ignore into BuildingModifiers
	(BuildingType,					ModifierId)
select
	'BUILDING_DOME_OF_THE_ROCK',	'MODFEAT_DOME_OF_THE_ROCK_GRANT_STRENGTH_' || BuildingType
from Buildings where EnabledByReligion = 1;
insert or ignore into Modifiers
	(ModifierId,												ModifierType,								RunOnce,	Permanent,	NewOnly,	OwnerRequirementSetId,								SubjectRequirementSetId)
select
	'MODFEAT_DOME_OF_THE_ROCK_GRANT_STRENGTH_' || BuildingType,	'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER',	0,			0,			0,			'REQSET_DOME_OF_THE_ROCK_HAS_' || BuildingType,		'REQSET_DOME_OF_THE_ROCK_HEAVY_CAVALRY_RELIGIOUS'			
from Buildings where EnabledByReligion = 1;
insert or ignore into ModifierArguments
	(ModifierId,												Name,			Value)
select
	'MODFEAT_DOME_OF_THE_ROCK_GRANT_STRENGTH_' || BuildingType,	'ModifierId',	'MODFEAT_DOME_OF_THE_ROCK_STRENGTH'
from Buildings where EnabledByReligion = 1;
insert or ignore into RequirementSets
	(RequirementSetId,								RequirementSetType)
select
	'REQSET_DOME_OF_THE_ROCK_HAS_' || BuildingType,	'REQUIREMENTSET_TEST_ALL'
from Buildings where EnabledByReligion = 1;
insert or ignore into RequirementSetRequirements
	(RequirementSetId,								RequirementId)
select
	'REQSET_DOME_OF_THE_ROCK_HAS_' || BuildingType,	'REQ_DOME_OF_THE_ROCK_HAS_WORSHIP_BUILDING_' || BuildingType
from Buildings where EnabledByReligion = 1;
insert or ignore into Requirements
	(RequirementId,													RequirementType)
select
	'REQ_DOME_OF_THE_ROCK_HAS_WORSHIP_BUILDING_' || BuildingType,	'REQUIREMENT_PLAYER_HAS_BUILDING'
from Buildings where EnabledByReligion = 1;
insert or ignore into RequirementArguments
	(RequirementId,													Name,			Value)
select
	'REQ_DOME_OF_THE_ROCK_HAS_WORSHIP_BUILDING_' || BuildingType,	'BuildingType',	BuildingType
from Buildings where EnabledByReligion = 1;
--圣母百花大教堂造价提升为1000锤，基础产+2琴+2鸽，移除获得大工程师时免费获得1个大艺术家。新增获得大工程师时获得下一位大艺术家50%点数。
update Buildings set Cost = 1000 where BuildingType = 'BUILDING_SANTA_MARIA_DEL_FIORE';
insert or replace into Building_YieldChanges
	(BuildingType,						YieldType,				YieldChange)
select
	'BUILDING_SANTA_MARIA_DEL_FIORE',	'YIELD_CULTURE',		2
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_SANTA_MARIA_DEL_FIORE')
union all select
	'BUILDING_SANTA_MARIA_DEL_FIORE',	'YIELD_FAITH',			2
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_SANTA_MARIA_DEL_FIORE');
delete from Modifiers where ModifierId = 'MODFEAT_SANTA_MARIA_DEL_FIORE_GREAT_ARTIST_ENGINEER';
/*雷峰塔造价提升为750锤，基础产+2文化+2信仰，改为金属铸造解锁，移除购买使徒时获得一个免费的建造者。
帝国中所有在湖泊和魅力值为“惊艳”的单元格改良+2食物+1信仰值+1文化，城市中有奇观时额外+1信仰+1文化。*/
update Buildings set Cost = 750, PrereqTech = 'TECH_METAL_CASTING' where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA';
delete from BuildingModifiers where ModifierId = 'MODFEAT_PHANTA_LEIFENG_PAGODA_GRANT_BUILDER_ATTACH';
insert or replace into Building_YieldChanges
	(BuildingType,						YieldType,				YieldChange)
select
	'BUILDING_PHANTA_LEIFENG_PAGODA',	'YIELD_CULTURE',		2
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA')
union all select
	'BUILDING_PHANTA_LEIFENG_PAGODA',	'YIELD_FAITH',			2
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA');
insert or replace into BuildingModifiers
	(BuildingType, ModifierId)
select
	'BUILDING_PHANTA_LEIFENG_PAGODA', 'MODFEAT_PHANTA_LEIFENG_PAGODA_CULTURE'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA')
union all select
	'BUILDING_PHANTA_LEIFENG_PAGODA', 'MODFEAT_PHANTA_LEIFENG_PAGODA_CULTURE_EXTRA'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA')
union all select
	'BUILDING_PHANTA_LEIFENG_PAGODA', 'MODFEAT_PHANTA_LEIFENG_PAGODA_FAITH_EXTRA'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA');
insert or replace into Modifiers
	(ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId)
select
	'MODFEAT_PHANTA_LEIFENG_PAGODA_CULTURE', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'REQSET_PHANTA_LEIFENG_PAGODA_PLOTS'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA')
union all select
	'MODFEAT_PHANTA_LEIFENG_PAGODA_CULTURE_EXTRA', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 0, 0, 0, NULL, 'CITY_HAS_WONDER_REQUIREMENTS'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA')
union all select
	'MODFEAT_PHANTA_LEIFENG_PAGODA_FAITH_EXTRA', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 0, 0, 0, NULL, 'CITY_HAS_WONDER_REQUIREMENTS'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA')
union all select
	'MODFEAT_PHANTA_LEIFENG_PAGODA_CULTURE_EXTRA_MODIFIER', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'REQSET_PHANTA_LEIFENG_PAGODA_PLOTS'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA')
union all select
	'MODFEAT_PHANTA_LEIFENG_PAGODA_FAITH_EXTRA_MODIFIER', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'REQSET_PHANTA_LEIFENG_PAGODA_PLOTS'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA');
insert or replace into ModifierArguments
	(ModifierId, Name, Value)
select 
	'MODFEAT_PHANTA_LEIFENG_PAGODA_CULTURE', 'Amount', 1
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA')
union all select
	'MODFEAT_PHANTA_LEIFENG_PAGODA_CULTURE', 'YieldType', 'YIELD_CULTURE'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA')
union all select
	'MODFEAT_PHANTA_LEIFENG_PAGODA_CULTURE_EXTRA', 'ModifierId', 'MODFEAT_PHANTA_LEIFENG_PAGODA_CULTURE_EXTRA_MODIFIER'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA')
union all select
	'MODFEAT_PHANTA_LEIFENG_PAGODA_FAITH_EXTRA', 'ModifierId', 'MODFEAT_PHANTA_LEIFENG_PAGODA_FAITH_EXTRA_MODIFIER'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA')
union all select
	'MODFEAT_PHANTA_LEIFENG_PAGODA_CULTURE_EXTRA_MODIFIER', 'Amount', 1
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA')
union all select
	'MODFEAT_PHANTA_LEIFENG_PAGODA_CULTURE_EXTRA_MODIFIER', 'YieldType', 'YIELD_CULTURE'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA')
union all select
	'MODFEAT_PHANTA_LEIFENG_PAGODA_FAITH_EXTRA_MODIFIER', 'Amount', 1
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA')
union all select
	'MODFEAT_PHANTA_LEIFENG_PAGODA_FAITH_EXTRA_MODIFIER', 'YieldType', 'YIELD_FAITH'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PHANTA_LEIFENG_PAGODA');
--泰坦尼克号造价提升为1360锤，6单元格内非您拥有的每个城市为你+5%金币，+3影响力和+2外交支持。
update Units set Cost = 1360 where UnitType = 'UNIT_JD_TITANIC';
update ModifierArguments set Value = 5 where ModifierId = 'MODIFIER_ABILITY_JD_TITANIC2_ATTACH' and Name = 'Amount';
update ModifierArguments set Value = 3 where ModifierId = 'MODIFIER_ABILITY_JD_TITANIC4_ATTACH' and Name = 'Amount';
--白星航运公司造价提升为1360锤，增加基础产3锤6金
update Buildings set Cost = 1360 where BuildingType = 'BUILDING_JD_WHITESTARLINE';
insert or replace into Building_YieldChanges
	(BuildingType,						YieldType,				YieldChange)
select
	'BUILDING_JD_WHITESTARLINE',		'YIELD_PRODUCTION',		3
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JD_WHITESTARLINE')
union all select
	'BUILDING_JD_WHITESTARLINE',		'YIELD_GOLD',			6
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JD_WHITESTARLINE');
--新仓富士浅间神社造价提升为750锤，增加基础产2琴2鸽，新增此城市所有单元格+1魅力，拥有国家公园的城市+5%信仰5%文化20%旅游业绩。修复相邻问题
update Buildings set Cost = 750 where BuildingType = 'BUILDING_ARAKURA_SENGEN';
insert or replace into Building_YieldChanges
	(BuildingType,						YieldType,				YieldChange)
select
	'BUILDING_ARAKURA_SENGEN',			'YIELD_CULTURE',		2
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_ARAKURA_SENGEN')
union all select
	'BUILDING_ARAKURA_SENGEN',			'YIELD_FAITH',			2
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_ARAKURA_SENGEN');
insert or replace into BuildingModifiers
	(BuildingType,						ModifierId)
select
	'BUILDING_ARAKURA_SENGEN',			'ARAKURA_SENGEN_ADDAPPEAL'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_ARAKURA_SENGEN')
union all select
	'BUILDING_ARAKURA_SENGEN',			'ARAKURA_SENGEN_ADDFAITH'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_ARAKURA_SENGEN')
union all select
	'BUILDING_ARAKURA_SENGEN',			'ARAKURA_SENGEN_ADDCULTURE'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_ARAKURA_SENGEN')
union all select 
	'BUILDING_ARAKURA_SENGEN',			'ARAKURA_SENGEN_ADDTOURISM'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_ARAKURA_SENGEN');
insert or replace into Modifiers
	(ModifierId,							ModifierType,											SubjectRequirementSetId)
values
	('ARAKURA_SENGEN_ADDAPPEAL',			'MODIFIER_SINGLE_CITY_ADJUST_CITY_APPEAL',				NULL),
	('ARAKURA_SENGEN_ADDFAITH',				'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',	'CITY_HAS_NATIONAL_PARK_REQUREMENTS'),
	('ARAKURA_SENGEN_ADDCULTURE',			'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',	'CITY_HAS_NATIONAL_PARK_REQUREMENTS'),
	('ARAKURA_SENGEN_ADDTOURISM',			'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',				'CITY_HAS_NATIONAL_PARK_REQUREMENTS'),
	('ARAKURA_SENGEN_ADDTOURISM_MODIFIER',	'MODIFIER_SINGLE_CITY_ADJUST_TOURISM_LATE_ERAS',		NULL);
insert or replace into ModifierArguments
	(ModifierId,							Name,			Value)
values
	('ARAKURA_SENGEN_ADDAPPEAL',			'Amount',		1),
	('ARAKURA_SENGEN_ADDFAITH',				'YieldType',	'YIELD_FAITH'),
	('ARAKURA_SENGEN_ADDFAITH',				'Amount',		5),
	('ARAKURA_SENGEN_ADDCULTURE',			'YieldType',	'YIELD_CULTURE'),
	('ARAKURA_SENGEN_ADDCULTURE',			'Amount',		5),
	('ARAKURA_SENGEN_ADDTOURISM',			'ModifierId',	'ARAKURA_SENGEN_ADDTOURISM_MODIFIER'),
	('ARAKURA_SENGEN_ADDTOURISM_MODIFIER',	'MinimumEra',	'ERA_ANCIENT'),
	('ARAKURA_SENGEN_ADDTOURISM_MODIFIER',	'Modifier',		20);
update Buildings set Description = 'LOC_BUILDING_ARAKURA_SENGEN_DESCRIPTION_PRESERVE', AdjacentDistrict = 'DISTRICT_PRESERVE' where	BuildingType = 'BUILDING_ARAKURA_SENGEN' and exists (select DistrictType from Districts where DistrictType = 'DISTRICT_PRESERVE');
/*塞萨洛尼基白塔重做
750锤
单位在所处单元格上下船时无额外移动力消耗。沿海城市获得相当于城市防御力15%科技和文化。（全国）允许修建海岸防御墙改良设施。
+2文化+2生产力
+2万能槽
海岸防御墙
+3文化，提供相当于所在单元格魅力的生产力。研究“飞行”科技后获得相当于生产力100%的旅游业绩。为单位提供驻防加成，单位在该单元格上下船无额外移动力消耗，也无视该单元格地形地貌对移动力的惩罚。必须修建在海岸上

update Buildings set Cost = 750 where BuildingType = 'BUILDING_MC_LEFKOS_PYRGOS';
update Building_GreatWorks set GreatWorkSlotType = 'GREATWORKSLOT_PALACE' where BuildingType = 'BUILDING_MC_LEFKOS_PYRGOS';
insert or replace into Building_YieldChanges
	(BuildingType,						YieldType,				YieldChange)
select
	'BUILDING_MC_LEFKOS_PYRGOS',		'YIELD_PRODUCTION',		2
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_MC_LEFKOS_PYRGOS');
*/
--塔克基思拉宫(最后一个了)造价提升为750锤，新增，允许用信仰购买考古学家。考古学家和考古博物馆-50%购买花费。+200%文物业绩。
update Buildings set Cost = 750 where BuildingType = 'BUILDING_TAQ_KASRA';
insert or replace into BuildingModifiers
	(BuildingType,								ModifierId)
select
	'BUILDING_TAQ_KASRA',						'TAQ_KASRA_ARCHAEOLOGIST_PURCHASE'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_TAQ_KASRA')
union all select
	'BUILDING_TAQ_KASRA',						'TAQ_KASRA_ARCHAEOLOGIST_DISCOUNT'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_TAQ_KASRA')
union all select
	'BUILDING_TAQ_KASRA',						'TAQ_KASRA_MUSEUM_ARTIFACT_DISCOUNT'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_TAQ_KASRA')
union all select
	'BUILDING_TAQ_KASRA',						'TAQ_KASRA_ARTIFACTS_TOURISM'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_TAQ_KASRA');
insert or replace into Modifiers
	(ModifierId,								ModifierType)
values
	('TAQ_KASRA_ARCHAEOLOGIST_PURCHASE',		'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE'),
	('TAQ_KASRA_ARCHAEOLOGIST_DISCOUNT',		'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_PURCHASE_COST'),
	('TAQ_KASRA_MUSEUM_ARTIFACT_DISCOUNT',		'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PURCHASE_COST'),
	('TAQ_KASRA_ARTIFACTS_TOURISM',				'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM');
insert or replace into ModifierArguments
	(ModifierId,								Name,					Value)
values
	('TAQ_KASRA_ARCHAEOLOGIST_PURCHASE',		'Tag',					'CLASS_ARCHAEOLOGIST'),
	('TAQ_KASRA_ARCHAEOLOGIST_DISCOUNT',		'Amount',				50),
	('TAQ_KASRA_ARCHAEOLOGIST_DISCOUNT',		'UnitType',				'UNIT_ARCHAEOLOGIST'),
	('TAQ_KASRA_MUSEUM_ARTIFACT_DISCOUNT',		'Amount',				50),
	('TAQ_KASRA_MUSEUM_ARTIFACT_DISCOUNT',		'BuildingType',			'BUILDING_MUSEUM_ARTIFACT'),
	('TAQ_KASRA_ARTIFACTS_TOURISM',				'GreatWorkObjectType',	'GREATWORKOBJECT_ARTIFACT'),
	('TAQ_KASRA_ARTIFACTS_TOURISM',				'ScalingFactor',		300);
--test

