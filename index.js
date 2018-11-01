import { NativeModules, PushNotificationIOS, Platform } from 'react-native';

const { RNHealthKit } = NativeModules;

const isIOS = Platform.OS === 'ios';

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
  requestPermissions: (params) => {
    if (!isIOS) {
      return Promise.resolve();
    }
    return RNHealthKit.requestPermissions(params);
  },
  getWritePermissionStatus: (permission) => {
    if (!isIOS) {
      return Promise.resolve(false);
    }
    return RNHealthKit.getWritePermissionStatus(permission);
  },
  isAvailable: isIOS ? RNHealthKit.isAvailable : false,
  getDateOfBirth: async () => {
    if (!isIOS) {
      return Promise.resolve();
    }
    const dateOfBirth = await RNHealthKit.getDateOfBirth();
    return new Date(dateOfBirth);
  },
  addWorkout: (workout) => {
    if (!isIOS) {
      return Promise.resolve();
    }
    return RNHealthKit.addWorkout(
      workout.startDate,
      workout.endDate,
      workout.calories,
      workout.metadata,
    );
  },
  getWorkouts: async () => {
    if (!isIOS) {
      return Promise.resolve([]);
    }
    const workouts = await RNHealthKit.getWorkouts();
    return workouts.map(convertWorkoutDates);
  },
  getWorkoutsByMetadata: async (
    key,
    value,
  ) => {
    if (!isIOS) {
      return Promise.resolve([]);
    }
    const workouts = await RNHealthKit.getWorkoutsByMetadata(key, value);
    return workouts.map(convertWorkoutDates);
  },
  getWeights: async (unit, startDate, endDate) => {
    if (!isIOS) {
      return Promise.resolve([]);
    }

    if (!unit) {
      throw new Error('no unit provided');
    }

    console.log({ RNHealthKit });
    return await RNHealthKit.getWeightsWithUnit(unit, startDate, endDate);
  },
  addWeight: async (weight, unit) => {
    if (!isIOS) {
      return Promise.resolve();
    }

    if (!unit) {
      throw new Error('no unit provided');
    }

    return await RNHealthKit.addWeight(weight, unit);
  },
  Constants: {
    ...(isIOS ? {
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
      }
    } : {
      writePermissionStatus: {
        authorized: '',
        denied: '',
        notDetermined: ''
      },
      units: {
        kilo: '',
        pounds: '',
      },
      dataTypes: {
        dateOfBirth: '',
        weight: '',
        workouts: '',
      }
    })
  }
};
