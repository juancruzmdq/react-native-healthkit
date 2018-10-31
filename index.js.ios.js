import { NativeModules, PushNotificationIOS, Platform } from 'react-native';

const { RNHealthKit } = NativeModules;

const convertWorkoutDates = (input) => ({
  calories: input.calories,
  endDate: new Date(input.endDate),
  metadata: input.metadata,
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
  getWorkouts: async () => {
    const workouts = await RNHealthKit.getWorkouts();
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
  },
};
