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
  addWorkout: (workout) =>
    RNHealthKit.addWorkout(
      workout.startDate,
      workout.endDate,
      workout.calories,
      workout.metadata,
    ),
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
  getWeights: async (unit, startDate, endDate) => {
    if (!unit) {
      throw new Error('no unit provided');
    }

    return await RNHealthKit.getWeightsWithUnit(unit, startDate, endDate);
  },
  addWeight: async (weight, unit) => {
    if (!unit) {
      throw new Error('no unit provided');
    }

    return await RNHealthKit.addWeight(weight, unit);
  },
  getDefaultSource: async () => {
    return await RNHealthKit.getDefaultSource();
  },
  Constants: {
    writePermissionStatus: {
      authorized: RNHealthKit.RCTHealthKitAuthorizationStatusAuthorized,
      denied: RNHealthKit.RCTHealthKitAuthorizationStatusDenied,
      notDetermined: RNHealthKit.RCTHealthKitAuthorizationStatusNotDetermined
    },
    units: {
      kilo: RNHealthKit.RCTHealthKitUnitTypeKilo,
      pounds: RNHealthKit.RCTHealthKitUnitTypePounds,
    },
    dataTypes: {
      dateOfBirth: RNHealthKit.RCTHealthKitTypeDateOfBirth,
      weight: RNHealthKit.RCTHealthKitTypeWeight,
      workouts: RNHealthKit.RCTHealthKitTypeWorkout,
    },
    workoutActivityTypes: {
      americanFootball: RNHealthKit.RCTHealthKitWorkoutActivityAmericanFootball,
      archery: RNHealthKit.RCTHealthKitWorkoutActivityArchery,
      australianFootball: RNHealthKit.RCTHealthKitWorkoutActivityAustralianFootball,
      badminton: RNHealthKit.RCTHealthKitWorkoutActivityBadminton,
      barre: RNHealthKit.RCTHealthKitWorkoutActivityBarre,
      baseball: RNHealthKit.RCTHealthKitWorkoutActivityBaseball,
      basketball: RNHealthKit.RCTHealthKitWorkoutActivityBasketball,
      bowling: RNHealthKit.RCTHealthKitWorkoutActivityBowling,
      boxing: RNHealthKit.RCTHealthKitWorkoutActivityBoxing,
      climbing: RNHealthKit.RCTHealthKitWorkoutActivityClimbing,
      coreTraining: RNHealthKit.RCTHealthKitWorkoutActivityCoreTraining,
      cricket: RNHealthKit.RCTHealthKitWorkoutActivityCricket,
      crossCountrySkiing: RNHealthKit.RCTHealthKitWorkoutActivityCrossCountrySkiing,
      crossTraining: RNHealthKit.RCTHealthKitWorkoutActivityCrossTraining,
      curling: RNHealthKit.RCTHealthKitWorkoutActivityCurling,
      cycling: RNHealthKit.RCTHealthKitWorkoutActivityCycling,
      dance: RNHealthKit.RCTHealthKitWorkoutActivityDance,
      downhillSkiing: RNHealthKit.RCTHealthKitWorkoutActivityDownhillSkiing,
      elliptical: RNHealthKit.RCTHealthKitWorkoutActivityElliptical,
      equestrianSports: RNHealthKit.RCTHealthKitWorkoutActivityEquestrianSports,
      fencing: RNHealthKit.RCTHealthKitWorkoutActivityFencing,
      fishing: RNHealthKit.RCTHealthKitWorkoutActivityFishing,
      fitness: RNHealthKit.RCTHealthKitWorkoutActivityWaterFitness,
      flexibility: RNHealthKit.RCTHealthKitWorkoutActivityFlexibility,
      functionalStrengthTraining: RNHealthKit.RCTHealthKitWorkoutActivityFunctionalStrengthTraining,
      golf: RNHealthKit.RCTHealthKitWorkoutActivityGolf,
      gymnastics: RNHealthKit.RCTHealthKitWorkoutActivityGymnastics,
      handball: RNHealthKit.RCTHealthKitWorkoutActivityHandball,
      handCycling: RNHealthKit.RCTHealthKitWorkoutActivityHandCycling,
      highIntensityIntervalTraining: RNHealthKit.RCTHealthKitWorkoutActivityHighIntensityIntervalTraining,
      hiking: RNHealthKit.RCTHealthKitWorkoutActivityHiking,
      hockey: RNHealthKit.RCTHealthKitWorkoutActivityHockey,
      hunting: RNHealthKit.RCTHealthKitWorkoutActivityHunting,
      jumpRope: RNHealthKit.RCTHealthKitWorkoutActivityJumpRope,
      kickboxing: RNHealthKit.RCTHealthKitWorkoutActivityKickboxing,
      lacrosse: RNHealthKit.RCTHealthKitWorkoutActivityLacrosse,
      martialArts: RNHealthKit.RCTHealthKitWorkoutActivityMartialArts,
      mindAndBody: RNHealthKit.RCTHealthKitWorkoutActivityMindAndBody,
      mixedCardio: RNHealthKit.RCTHealthKitWorkoutActivityMixedCardio,
      other: RNHealthKit.RCTHealthKitWorkoutActivityTypeOther,
      paddleSports: RNHealthKit.RCTHealthKitWorkoutActivityPaddleSports,
      pilates: RNHealthKit.RCTHealthKitWorkoutActivityPilates,
      play: RNHealthKit.RCTHealthKitWorkoutActivityPlay,
      polo: RNHealthKit.RCTHealthKitWorkoutActivityWaterPolo,
      preparationAndRecovery: RNHealthKit.RCTHealthKitWorkoutActivityPreparationAndRecovery,
      racquetball: RNHealthKit.RCTHealthKitWorkoutActivityRacquetball,
      rowing: RNHealthKit.RCTHealthKitWorkoutActivityRowing,
      rugby: RNHealthKit.RCTHealthKitWorkoutActivityRugby,
      running: RNHealthKit.RCTHealthKitWorkoutActivityRunning,
      sailing: RNHealthKit.RCTHealthKitWorkoutActivitySailing,
      skatingSports: RNHealthKit.RCTHealthKitWorkoutActivitySkatingSports,
      snowboarding: RNHealthKit.RCTHealthKitWorkoutActivitySnowboarding,
      snowSports: RNHealthKit.RCTHealthKitWorkoutActivitySnowSports,
      soccer: RNHealthKit.RCTHealthKitWorkoutActivitySoccer,
      softball: RNHealthKit.RCTHealthKitWorkoutActivitySoftball,
      squash: RNHealthKit.RCTHealthKitWorkoutActivitySquash,
      stairClimbing: RNHealthKit.RCTHealthKitWorkoutActivityStairClimbing,
      stairs: RNHealthKit.RCTHealthKitWorkoutActivityStairs,
      stepTraining: RNHealthKit.RCTHealthKitWorkoutActivityStepTraining,
      strengthTraining: RNHealthKit.RCTHealthKitWorkoutActivityTraditionalStrengthTraining,
      surfingSports: RNHealthKit.RCTHealthKitWorkoutActivitySurfingSports,
      swimming: RNHealthKit.RCTHealthKitWorkoutActivitySwimming,
      tableTennis: RNHealthKit.RCTHealthKitWorkoutActivityTableTennis,
      taiChi: RNHealthKit.RCTHealthKitWorkoutActivityTaiChi,
      tennis: RNHealthKit.RCTHealthKitWorkoutActivityTennis,
      trackAndField: RNHealthKit.RCTHealthKitWorkoutActivityTrackAndField,
      typeWalking: RNHealthKit.RCTHealthKitWorkoutActivityTypeWalking,
      volleyball: RNHealthKit.RCTHealthKitWorkoutActivityVolleyball,
      waterSports: RNHealthKit.RCTHealthKitWorkoutActivityWaterSports,
      wheelchairRunPace: RNHealthKit.RCTHealthKitWorkoutActivityWheelchairRunPace,
      wheelchairWalkPace: RNHealthKit.RCTHealthKitWorkoutActivityWheelchairWalkPace,
      wrestling: RNHealthKit.RCTHealthKitWorkoutActivityWrestling,
      yoga: RNHealthKit.RCTHealthKitWorkoutActivityYoga,
    },
  },
};
