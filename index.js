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
  Constants: {
    writePermissionStatus: {
      authorized: 'AuthorizationStatusSharingAuthorized',
      denied: 'AuthorizationStatusSharingDenied',
      notDetermined: 'AuthorizationStatusSharingNotDetermined'
    }
  }
};
