import { NativeModules, PushNotificationIOS, Platform } from 'react-native';

const { RNHealthKit } = NativeModules;

const convertWorkoutDates = (input) => ({
  ...input,
  endDate: new Date(input.endDate),
  startDate: new Date(input.startDate),
});

export default {
  openAppleHealth: () => {
    RNHealthKit.openAppleHealth();
  },
  requestPermissions: (params) =>
    RNHealthKit.requestPermissions(params),
  getWritePermissionStatus: (permission) =>
    RNHealthKit.getWritePermissionStatus(permission),
  isAvailable: RNHealthKit.isAvailable,
  getDateOfBirth: async () => {
    const dateOfBirth = await RNHealthKit.getDateOfBirth();
    return new Date(dateOfBirth);
  },
  addWorkout: ({ activityType, startDate, endDate, calories, distance, metadata }) =>
    RNHealthKit.addWorkout(activityType, startDate, endDate, calories, distance || -1, metadata),
  getWorkouts: async (startDate = null, endDate = null) => {
    const workouts = await RNHealthKit.getWorkouts(startDate, endDate);
    return workouts.map(convertWorkoutDates);
  },
  getWorkoutsByMetadata: async (
    key,
    value,
  ) => {
    const workouts = await RNHealthKit.getWorkoutsByMetadata(key, value);
    return workouts.map(convertWorkoutDates);
  },
  deleteWorkoutsByMetadata: (key, value) =>
    RNHealthKit.deleteWorkoutsByMetadata(key, value),
  editWorkoutByMetadata: async (key, value, { activityType, startDate, endDate, calories, distance, metadata }) => {
    await RNHealthKit.deleteWorkoutsByMetadata(key, value);
    await RNHealthKit.addWorkout(activityType, startDate, endDate, calories, distance || -1, metadata);
  },
  getWeights: async (unit, startDate, endDate) => {
    if (!unit) {
      throw new Error('no unit provided');
    }

    return await RNHealthKit.getWeightsWithUnit(unit, startDate, endDate);
  },
  addWeight: async (weight, unit, date = null) => {
    if (!unit) {
      throw new Error('no unit provided');
    }

    return await RNHealthKit.addWeight(weight, unit, date);
  },
  getDefaultSource: async () => {
    return await RNHealthKit.getDefaultSource();
  },
  getQuantity: async (quantity, unit, startDate, endDate) => {
    if (!unit) {
      throw new Error('no unit provided');
    }

    return await RNHealthKit.getQuantity(quantity, unit, startDate, endDate);
  },
  Constants: {
    writePermissionStatus: {
      authorized: RNHealthKit.permissionStatus.RCTHealthKitAuthorizationStatusAuthorized,
      denied: RNHealthKit.permissionStatus.RCTHealthKitAuthorizationStatusDenied,
      notDetermined: RNHealthKit.permissionStatus.RCTHealthKitAuthorizationStatusNotDetermined,
    },
    units: {
      calories: RNHealthKit.units.RCTHealthKitUnitTypeCalories,
      kilo: RNHealthKit.units.RCTHealthKitUnitTypeKilo,
      pounds: RNHealthKit.units.RCTHealthKitUnitTypePounds,
    },
    dataTypes: {
      dateOfBirth: RNHealthKit.dataTypes.RCTHealthKitTypeDateOfBirth,
      workouts: RNHealthKit.dataTypes.RCTHealthKitTypeWorkout,
    },
    quantities: {
      bodyMassIndex: RNHealthKit.quantities.HKQuantityTypeIdentifierBodyMassIndex,
      bodyFatPercentage: RNHealthKit.quantities.HKQuantityTypeIdentifierBodyFatPercentage,
      height: RNHealthKit.quantities.HKQuantityTypeIdentifierHeight,
      bodyMass: RNHealthKit.quantities.HKQuantityTypeIdentifierBodyMass,
      leanBodyMass: RNHealthKit.quantities.HKQuantityTypeIdentifierLeanBodyMass,
      waistCircumference: RNHealthKit.quantities.HKQuantityTypeIdentifierWaistCircumference,
      stepCount: RNHealthKit.quantities.HKQuantityTypeIdentifierStepCount,
      distanceWalkingRunning: RNHealthKit.quantities.HKQuantityTypeIdentifierDistanceWalkingRunning,
      distanceCycling: RNHealthKit.quantities.HKQuantityTypeIdentifierDistanceCycling,
      distanceWheelchair: RNHealthKit.quantities.HKQuantityTypeIdentifierDistanceWheelchair,
      basalEnergyBurned: RNHealthKit.quantities.HKQuantityTypeIdentifierBasalEnergyBurned,
      activeEnergyBurned: RNHealthKit.quantities.HKQuantityTypeIdentifierActiveEnergyBurned,
      flightsClimbed: RNHealthKit.quantities.HKQuantityTypeIdentifierFlightsClimbed,
      nikeFuel: RNHealthKit.quantities.HKQuantityTypeIdentifierNikeFuel,
      appleExerciseTime: RNHealthKit.quantities.HKQuantityTypeIdentifierAppleExerciseTime,
      pushCount: RNHealthKit.quantities.HKQuantityTypeIdentifierPushCount,
      distanceSwimming: RNHealthKit.quantities.HKQuantityTypeIdentifierDistanceSwimming,
      swimmingStrokeCount: RNHealthKit.quantities.HKQuantityTypeIdentifierSwimmingStrokeCount,
      VO2Max: RNHealthKit.quantities.HKQuantityTypeIdentifierVO2Max,
      distanceDownhillSnowSports: RNHealthKit.quantities.HKQuantityTypeIdentifierDistanceDownhillSnowSports,
      heartRate: RNHealthKit.quantities.HKQuantityTypeIdentifierHeartRate,
      bodyTemperature: RNHealthKit.quantities.HKQuantityTypeIdentifierBodyTemperature,
      basalBodyTemperature: RNHealthKit.quantities.HKQuantityTypeIdentifierBasalBodyTemperature,
      bloodPressureSystolic: RNHealthKit.quantities.HKQuantityTypeIdentifierBloodPressureSystolic,
      bloodPressureDiastolic: RNHealthKit.quantities.HKQuantityTypeIdentifierBloodPressureDiastolic,
      respiratoryRate: RNHealthKit.quantities.HKQuantityTypeIdentifierRespiratoryRate,
      restingHeartRate: RNHealthKit.quantities.HKQuantityTypeIdentifierRestingHeartRate,
      walkingHeartRateAverage: RNHealthKit.quantities.HKQuantityTypeIdentifierWalkingHeartRateAverage,
      heartRateVariabilitySDNN: RNHealthKit.quantities.HKQuantityTypeIdentifierHeartRateVariabilitySDNN,
      oxygenSaturation: RNHealthKit.quantities.HKQuantityTypeIdentifierOxygenSaturation,
      peripheralPerfusionIndex: RNHealthKit.quantities.HKQuantityTypeIdentifierPeripheralPerfusionIndex,
      bloodGlucose: RNHealthKit.quantities.HKQuantityTypeIdentifierBloodGlucose,
      numberOfTimesFallen: RNHealthKit.quantities.HKQuantityTypeIdentifierNumberOfTimesFallen,
      electrodermalActivity: RNHealthKit.quantities.HKQuantityTypeIdentifierElectrodermalActivity,
      inhalerUsage: RNHealthKit.quantities.HKQuantityTypeIdentifierInhalerUsage,
      insulinDelivery: RNHealthKit.quantities.HKQuantityTypeIdentifierInsulinDelivery,
      bloodAlcoholContent: RNHealthKit.quantities.HKQuantityTypeIdentifierBloodAlcoholContent,
      forcedVitalCapacity: RNHealthKit.quantities.HKQuantityTypeIdentifierForcedVitalCapacity,
      forcedExpiratoryVolume1: RNHealthKit.quantities.HKQuantityTypeIdentifierForcedExpiratoryVolume1,
      peakExpiratoryFlowRate: RNHealthKit.quantities.HKQuantityTypeIdentifierPeakExpiratoryFlowRate,
      dietaryFatTotal: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryFatTotal,
      dietaryFatPolyunsaturated: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryFatPolyunsaturated,
      dietaryFatMonounsaturated: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryFatMonounsaturated,
      dietaryFatSaturated: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryFatSaturated,
      dietaryCholesterol: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryCholesterol,
      dietarySodium: RNHealthKit.quantities.HKQuantityTypeIdentifierDietarySodium,
      dietaryCarbohydrates: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryCarbohydrates,
      dietaryFiber: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryFiber,
      dietarySugar: RNHealthKit.quantities.HKQuantityTypeIdentifierDietarySugar,
      dietaryEnergyConsumed: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryEnergyConsumed,
      dietaryProtein: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryProtein,
      dietaryVitaminA: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryVitaminA,
      dietaryVitaminB6: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryVitaminB6,
      dietaryVitaminB12: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryVitaminB12,
      dietaryVitaminC: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryVitaminC,
      dietaryVitaminD: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryVitaminD,
      dietaryVitaminE: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryVitaminE,
      dietaryVitaminK: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryVitaminK,
      dietaryCalcium: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryCalcium,
      dietaryIron: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryIron,
      dietaryThiamin: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryThiamin,
      dietaryRiboflavin: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryRiboflavin,
      dietaryNiacin: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryNiacin,
      dietaryFolate: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryFolate,
      dietaryBiotin: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryBiotin,
      dietaryPantothenicAcid: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryPantothenicAcid,
      dietaryPhosphorus: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryPhosphorus,
      dietaryIodine: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryIodine,
      dietaryMagnesium: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryMagnesium,
      dietaryZinc: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryZinc,
      dietarySelenium: RNHealthKit.quantities.HKQuantityTypeIdentifierDietarySelenium,
      dietaryCopper: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryCopper,
      dietaryManganese: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryManganese,
      dietaryChromium: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryChromium,
      dietaryMolybdenum: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryMolybdenum,
      dietaryChloride: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryChloride,
      dietaryPotassium: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryPotassium,
      dietaryCaffeine: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryCaffeine,
      dietaryWater: RNHealthKit.quantities.HKQuantityTypeIdentifierDietaryWater,
      UVExposure: RNHealthKit.quantities.HKQuantityTypeIdentifierUVExposure,
    },
    workoutActivityTypes: {
      americanFootball: RNHealthKit.workouts.RCTHealthKitWorkoutActivityAmericanFootball,
      archery: RNHealthKit.workouts.RCTHealthKitWorkoutActivityArchery,
      australianFootball: RNHealthKit.workouts.RCTHealthKitWorkoutActivityAustralianFootball,
      badminton: RNHealthKit.workouts.RCTHealthKitWorkoutActivityBadminton,
      barre: RNHealthKit.workouts.RCTHealthKitWorkoutActivityBarre,
      baseball: RNHealthKit.workouts.RCTHealthKitWorkoutActivityBaseball,
      basketball: RNHealthKit.workouts.RCTHealthKitWorkoutActivityBasketball,
      bowling: RNHealthKit.workouts.RCTHealthKitWorkoutActivityBowling,
      boxing: RNHealthKit.workouts.RCTHealthKitWorkoutActivityBoxing,
      climbing: RNHealthKit.workouts.RCTHealthKitWorkoutActivityClimbing,
      coreTraining: RNHealthKit.workouts.RCTHealthKitWorkoutActivityCoreTraining,
      cricket: RNHealthKit.workouts.RCTHealthKitWorkoutActivityCricket,
      crossCountrySkiing: RNHealthKit.workouts.RCTHealthKitWorkoutActivityCrossCountrySkiing,
      crossTraining: RNHealthKit.workouts.RCTHealthKitWorkoutActivityCrossTraining,
      curling: RNHealthKit.workouts.RCTHealthKitWorkoutActivityCurling,
      cycling: RNHealthKit.workouts.RCTHealthKitWorkoutActivityCycling,
      dance: RNHealthKit.workouts.RCTHealthKitWorkoutActivityDance,
      downhillSkiing: RNHealthKit.workouts.RCTHealthKitWorkoutActivityDownhillSkiing,
      elliptical: RNHealthKit.workouts.RCTHealthKitWorkoutActivityElliptical,
      equestrianSports: RNHealthKit.workouts.RCTHealthKitWorkoutActivityEquestrianSports,
      fencing: RNHealthKit.workouts.RCTHealthKitWorkoutActivityFencing,
      fishing: RNHealthKit.workouts.RCTHealthKitWorkoutActivityFishing,
      fitness: RNHealthKit.workouts.RCTHealthKitWorkoutActivityWaterFitness,
      flexibility: RNHealthKit.workouts.RCTHealthKitWorkoutActivityFlexibility,
      functionalStrengthTraining: RNHealthKit.workouts.RCTHealthKitWorkoutActivityFunctionalStrengthTraining,
      golf: RNHealthKit.workouts.RCTHealthKitWorkoutActivityGolf,
      gymnastics: RNHealthKit.workouts.RCTHealthKitWorkoutActivityGymnastics,
      handball: RNHealthKit.workouts.RCTHealthKitWorkoutActivityHandball,
      handCycling: RNHealthKit.workouts.RCTHealthKitWorkoutActivityHandCycling,
      highIntensityIntervalTraining: RNHealthKit.workouts.RCTHealthKitWorkoutActivityHighIntensityIntervalTraining,
      hiking: RNHealthKit.workouts.RCTHealthKitWorkoutActivityHiking,
      hockey: RNHealthKit.workouts.RCTHealthKitWorkoutActivityHockey,
      hunting: RNHealthKit.workouts.RCTHealthKitWorkoutActivityHunting,
      jumpRope: RNHealthKit.workouts.RCTHealthKitWorkoutActivityJumpRope,
      kickboxing: RNHealthKit.workouts.RCTHealthKitWorkoutActivityKickboxing,
      lacrosse: RNHealthKit.workouts.RCTHealthKitWorkoutActivityLacrosse,
      martialArts: RNHealthKit.workouts.RCTHealthKitWorkoutActivityMartialArts,
      mindAndBody: RNHealthKit.workouts.RCTHealthKitWorkoutActivityMindAndBody,
      mixedCardio: RNHealthKit.workouts.RCTHealthKitWorkoutActivityMixedCardio,
      other: RNHealthKit.workouts.RCTHealthKitWorkoutActivityTypeOther,
      paddleSports: RNHealthKit.workouts.RCTHealthKitWorkoutActivityPaddleSports,
      pilates: RNHealthKit.workouts.RCTHealthKitWorkoutActivityPilates,
      play: RNHealthKit.workouts.RCTHealthKitWorkoutActivityPlay,
      polo: RNHealthKit.workouts.RCTHealthKitWorkoutActivityWaterPolo,
      preparationAndRecovery: RNHealthKit.workouts.RCTHealthKitWorkoutActivityPreparationAndRecovery,
      racquetball: RNHealthKit.workouts.RCTHealthKitWorkoutActivityRacquetball,
      rowing: RNHealthKit.workouts.RCTHealthKitWorkoutActivityRowing,
      rugby: RNHealthKit.workouts.RCTHealthKitWorkoutActivityRugby,
      running: RNHealthKit.workouts.RCTHealthKitWorkoutActivityRunning,
      sailing: RNHealthKit.workouts.RCTHealthKitWorkoutActivitySailing,
      skatingSports: RNHealthKit.workouts.RCTHealthKitWorkoutActivitySkatingSports,
      snowboarding: RNHealthKit.workouts.RCTHealthKitWorkoutActivitySnowboarding,
      snowSports: RNHealthKit.workouts.RCTHealthKitWorkoutActivitySnowSports,
      soccer: RNHealthKit.workouts.RCTHealthKitWorkoutActivitySoccer,
      softball: RNHealthKit.workouts.RCTHealthKitWorkoutActivitySoftball,
      squash: RNHealthKit.workouts.RCTHealthKitWorkoutActivitySquash,
      stairClimbing: RNHealthKit.workouts.RCTHealthKitWorkoutActivityStairClimbing,
      stairs: RNHealthKit.workouts.RCTHealthKitWorkoutActivityStairs,
      stepTraining: RNHealthKit.workouts.RCTHealthKitWorkoutActivityStepTraining,
      strengthTraining: RNHealthKit.workouts.RCTHealthKitWorkoutActivityTraditionalStrengthTraining,
      surfingSports: RNHealthKit.workouts.RCTHealthKitWorkoutActivitySurfingSports,
      swimming: RNHealthKit.workouts.RCTHealthKitWorkoutActivitySwimming,
      tableTennis: RNHealthKit.workouts.RCTHealthKitWorkoutActivityTableTennis,
      taiChi: RNHealthKit.workouts.RCTHealthKitWorkoutActivityTaiChi,
      tennis: RNHealthKit.workouts.RCTHealthKitWorkoutActivityTennis,
      trackAndField: RNHealthKit.workouts.RCTHealthKitWorkoutActivityTrackAndField,
      typeWalking: RNHealthKit.workouts.RCTHealthKitWorkoutActivityTypeWalking,
      volleyball: RNHealthKit.workouts.RCTHealthKitWorkoutActivityVolleyball,
      waterSports: RNHealthKit.workouts.RCTHealthKitWorkoutActivityWaterSports,
      wheelchairRunPace: RNHealthKit.workouts.RCTHealthKitWorkoutActivityWheelchairRunPace,
      wheelchairWalkPace: RNHealthKit.workouts.RCTHealthKitWorkoutActivityWheelchairWalkPace,
      wrestling: RNHealthKit.workouts.RCTHealthKitWorkoutActivityWrestling,
      yoga: RNHealthKit.workouts.RCTHealthKitWorkoutActivityYoga,
    },
  },
};
