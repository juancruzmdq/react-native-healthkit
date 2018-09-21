#import "RCTHealthKit.h"

@interface RCTHealthKit (Characteristics)

- (void)_getDateOfBirth:(RCTPromiseResolveBlock)resolve
              rejecter:(RCTPromiseRejectBlock)reject;

- (void)_addWorkout:(NSDate*)startDate
            endDate:(NSDate*)endDate
           calories:(float)calories
           metadata:(NSDictionary*)metadata
            resolve:(RCTPromiseResolveBlock)resolve
             reject:(RCTPromiseRejectBlock)reject;

- (void)_getWorkouts:(RCTPromiseResolveBlock)resolve
              reject:(RCTPromiseRejectBlock)reject;

- (void)_getWorkoutsByMetadata:(NSString*)key
                         value:(NSString*)value
                       resolve:(RCTPromiseResolveBlock)resolve
                        reject:(RCTPromiseRejectBlock)reject;

@end
