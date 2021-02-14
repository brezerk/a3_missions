// ACE Advanced Ballistics
// Увімкнути вплив вітру та температури на політ кулі
force force ace_advanced_ballistics_enabled = true;

// ACE Advanced Fatique
// Збільшити витривалість гравця на 50%
force force ace_advanced_fatigue_performanceFactor = 1.5;
force force ace_advanced_fatigue_recoveryFactor = 1.5;

// ACE Artillery
// Відключити балістичні калькулятори та включити вплив вітру на снаряд
force force ace_artillerytables_advancedCorrections = true;
force force ace_artillerytables_disableArtilleryComputer = true;
// Відключити далекомір та увімкнути опір повітря в ванільному мінометі
force force ace_mk6mortar_allowComputerRangefinder = false;
force force ace_mk6mortar_airResistanceEnabled = true;
force force ace_mk6mortar_useAmmoHandling = true;

// ACE Common
// Перевіряти усі адони і кікати у разі неспівпадіння
force force ace_common_checkPBOsAction = 2;
force force ace_common_checkPBOsCheckAll = true;

// ACE Cook off
// Увімкнути обробку зриву башти
force ace_cookoff_ammoCookoffDuration = 0.2;
force ace_cookoff_enable = true;
force ace_cookoff_enableAmmobox = true;
force ace_cookoff_enableAmmoCookoff = true;
force ace_cookoff_probabilityCoef = 0.2;

// ACE Explosives
force ace_explosives_explodeOnDefuse = true;
force ace_explosives_punishNonSpecialists = true;
force ace_explosives_requireSpecialist = false;

// ACE CSW
// Розширений монтаж стаціонарної зброї
force force ace_csw_defaultAssemblyMode = true;

// ACE Fragments
// Увімкнути симуляцію уламків та відбиття вибуху
force force ace_frag_reflectionsEnabled = true;
force force ace_frag_spallEnabled = true;

// ACE Googles
// Додати можливість протирати окуляри
force force ace_goggles_showClearGlasses = true;

// ACE Logistics
// Дозволити повний ремонт техніки біля ремонтних машин
force force ace_repair_fullRepairLocation = 3;
// Перезарядка техніки касетами
force force ace_rearm_level = 1;
force force ace_repair_engineerSetting_fullRepair = 2;
force force ace_repair_engineerSetting_repair = 1;


// ACE Map
// За замовченням маркер ставится в канал сторони 
force force ace_map_DefaultChannel = 1;
// Обмежити наближення мапи до побутових масштабів
//force force ace_map_mapLimitZoom = true;

// ACE Medicine
// Застосуання різних типів повязок до різних типів ран з розмотуванням
force force ace_medical_treatment_advancedBandages = 2;
// Аптечка лікує лише в госпіталях
force force ace_medical_treatment_locationPAK = 3;
// Зашивати можна лише в медеваках та госпіталях
force force ace_medical_treatment_locationSurgicalKit = 0;
// Дозволити переливання крові, зашивання і застосування аптечки медику на собі у відповідних установах
force force ace_medical_treatment_allowSelfPAK = 1;
force force ace_medical_treatment_allowSelfStitch = 0;
force force ace_medical_treatment_allowSelfIV = 1;
// Шанс успішної реанімації підігнано під кількість рухів в анімації персонажа
force force ace_medical_treatment_cprSuccessChance = 0.33;
// Лікування потребує вільні руки без зброї
force force ace_medical_treatment_holsterRequired = 1;
// Відключити 3Д інтерфейс для лікування
force force ace_medical_gui_enableActions = 1;
// Біль у вигляді розмиття
force force ace_medical_feedback_painEffectType = 2;
// Заборонити відключку у ботів, бо вони стають невмиручими
force force ace_medical_statemachine_AIUnconsciousness = false;
// Джерело фатального ушкодження - тільки важливі органи
force force ace_medical_fatalDamageSource = 0;
// Збільшити шанс отямитися
force force ace_medical_spontaneousWakeUpChance = 0.35;
force force ace_medical_spontaneousWakeUpEpinephrineBoost = 15;
// Сповільнити кровотечу
force force ace_medical_bleedingCoefficient = 0.8;
// Інші налаштування за замовченням, окрім параметрів кількості крові і сміття, які регулюються сервером
force force ace_medical_ai_enabledFor = 2;
force force ace_medical_AIDamageThreshold = 0.5;
force force ace_medical_feedback_bloodVolumeEffectType = 0;
force force ace_medical_fractureChance = 0.8;
force force ace_medical_fractures = 1;
force force ace_medical_gui_enableMedicalMenu = 1;
force force ace_medical_gui_enableSelfActions = true;
force force ace_medical_gui_maxDistance = 3;
force force ace_medical_gui_openAfterTreatment = true;
force force ace_medical_ivFlowRate = 1;
force force ace_medical_limping = 1;
force force ace_medical_painCoefficient = 1;
force force ace_medical_playerDamageThreshold = 1;
force force ace_medical_statemachine_cardiacArrestTime = 300;
force force ace_medical_statemachine_fatalInjuriesAI = 0;
force force ace_medical_statemachine_fatalInjuriesPlayer = 0;
force force ace_medical_treatment_advancedDiagnose = true;
force force ace_medical_treatment_advancedMedication = true;
force force ace_medical_treatment_allowSharedEquipment = 0;
force force ace_medical_treatment_clearTraumaAfterBandage = false;
force force ace_medical_treatment_consumePAK = 0;
force force ace_medical_treatment_consumeSurgicalKit = 0;
force force ace_medical_treatment_convertItems = 0;
force force ace_medical_treatment_locationEpinephrine = 0;
force force ace_medical_treatment_locationsBoostTraining = false;
force force ace_medical_treatment_medicEpinephrine = 0;
force force ace_medical_treatment_medicIV = 1;
force force ace_medical_treatment_medicPAK = 1;
force force ace_medical_treatment_medicSurgicalKit = 1;
force force ace_medical_treatment_timeCoefficientPAK = 1;

// ACE Nightvision
// Зменшити зерно ПНБ в 2 рази
force force ace_nightvision_noiseScaling = 0.2;
// Прибрати розмиття єкрану при прицілюванні
force force ace_nightvision_aimDownSightsBlur = 0;
force ace_nightvision_disableNVGsWithSights = false;
force force ace_nightvision_fogScaling = 0.1;
force force ace_nightvision_effectScaling = 0.2;

// ACE Pointing
// Включити показування пальцем
force force ace_finger_enabled = true;

// ACE Respawn
// Відроджувати з інвентарем що був на час смерті
force force ace_respawn_savePreDeathGear = false;

// ACE Weather
force force ace_weather_updateInterval = 300;

// ACE Uncategorized
// Для спуску потрібно мати канат в інвентарі
force force ace_fastroping_requireRopeItems = true;
// Зменшити точність навігатора і деталізацію мапи
//force force ace_microdagr_mapDataAvailable = 1;
//force force ace_microdagr_waypointPrecision = 2;

// ACEX Rations
//force force acex_field_rations_enabled = true;

// GRAD Trenches
// Сповільнити копання окопів пропорційно в 3 рази
force force grad_trenches_functions_bigEnvelopeDigTime = 120;
force force grad_trenches_functions_giantEnvelopeDigTime = 270;
force force grad_trenches_functions_LongEnvelopeDigTime = 300;
force force grad_trenches_functions_shortEnvelopeDigTime = 60;
force force grad_trenches_functions_smallEnvelopeDigTime = 90;
force force grad_trenches_functions_vehicleEnvelopeDigTime = 360;
// Компенсувати витрати стаміни у звязку із збільшенням часу копання 
force force grad_trenches_functions_buildFatigueFactor = 0.33;

// STUI Settings
// Прибрати шестикутні позначки на гравцях
force force STGI_Settings_Enabled = false;
// Прибрати імена гравців з компасу
force force STHud_Settings_HUDMode = 1;
// Прибрати ванільний список підлеглих
force force STHud_Settings_SquadBar = true;

// Labels
force ace_nametags_showPlayerRanks = true;
force ace_nametags_playerNamesViewDistance = 5;
force ace_nametags_showCursorTagForVehicles = false;
force ace_nametags_showPlayerNames = 1;
force ace_nametags_showPlayerRanks = true;
force ace_nametags_showVehicleCrewInfo = true;

// Хапати усіх
force force ace_captives_allowHandcuffOwnSide = true;
force force ace_captives_allowSurrender = false;
force force ace_captives_requireSurrender = 0;
force force ace_captives_requireSurrenderAi = true;

// ACE MAP
force force ace_markers_moveRestriction = 0;

//TFAR
force force TFAR_Teamspeak_Channel_Name = "MCCTaskForceRadio";
force force tf_radio_channel_name = "MCCTaskForceRadio";
froce force tf_west_radio_code = "DSH&G^G";
froce force tf_east_radio_code = "DSH&G^G";
froce force tf_guer_radio_code = "DSH&G^G";

// GRAD окопы
force force grad_trenches_functions_allowTrenchDecay = true;
force force grad_trenches_functions_bigEnvelopeDigTime = 25;
force force grad_trenches_functions_decayTime = 900;
force force grad_trenches_functions_giantEnvelopeDigTime = 40;
force force grad_trenches_functions_LongEnvelopeDigTime = 60;
force force grad_trenches_functions_shortEnvelopeDigTime = 10;
force force grad_trenches_functions_smallEnvelopeDigTime = 15;
force force grad_trenches_functions_timeoutToDecay = 600;
force force grad_trenches_functions_vehicleEnvelopeDigTime = 90;
