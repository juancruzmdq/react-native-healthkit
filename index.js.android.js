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
  getWorkouts: async (startDate, endDate) =>
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
  getDefaultSource: async () => Promise.resolve(null),
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
