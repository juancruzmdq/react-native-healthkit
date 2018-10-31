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

- (void)_getDefaultSource:(RCTPromiseResolveBlock)resolve
              reject:(RCTPromiseRejectBlock)reject;

#pragma mark - Weight

- (void)_getWeightsWithUnit:(HKUnit *)unit
                  startDate:(NSDate *)startDate
                    endDate:(NSDate *)endDate
                    resolve:(RCTPromiseResolveBlock)resolve
                     reject:(RCTPromiseRejectBlock)reject;

- (void)_addWeight:(float)weight
              unit:(HKUnit *)unit
           resolve:(RCTPromiseResolveBlock)resolve
            reject:(RCTPromiseRejectBlock)reject;

@end
