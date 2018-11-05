export default {
  openAppleHealth: () => {},
  requestPermissions: (params) =>
    Promise.resolve(),
  getWritePermissionStatus: (permission) =>
    Promise.resolve(false),
  isAvailable: false,
  getDateOfBirth: async () =>
    Promise.resolve(),
  addWorkout: (workout) =>
    Promise.resolve(),
  getWorkouts: async () =>
    Promise.resolve([]),
  getWorkoutsByMetadata: async (
    key,
    value,
  ) =>
    Promise.resolve([]),
  getWeights: async (unit, startDate, endDate) =>
    Promise.resolve([]),
  addWeight: async (weight, unit) =>
    Promise.resolve(),
  Constants: {
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
    },
  },
};
