#import "RCTHealthKit.h"

@interface RCTHealthKit (Characteristics)

- (void)_getDateOfBirth:(RCTPromiseResolveBlock)resolve
              rejecter:(RCTPromiseRejectBlock)reject;

- (void)_getDefaultSource:(RCTPromiseResolveBlock)resolve
                   reject:(RCTPromiseRejectBlock)reject;

#pragma mark - Workouts

- (void)_addWorkout:(NSDate*)startDate
            endDate:(NSDate*)endDate
           calories:(float)calories
           metadata:(NSDictionary*)metadata
            resolve:(RCTPromiseResolveBlock)resolve
             reject:(RCTPromiseRejectBlock)reject;

- (void)_getWorkoutsWithStartDate:(NSDate*)startDate
              endDate:(NSDate*)endDate
              resolve:(RCTPromiseResolveBlock)resolve
              reject:(RCTPromiseRejectBlock)reject;

- (void)_getWorkoutsByMetadata:(NSString*)key
                         value:(NSString*)value
                       resolve:(RCTPromiseResolveBlock)resolve
                        reject:(RCTPromiseRejectBlock)reject;

- (void)_deleteWorkoutsByMetadata:(NSString*)key
                            value:(NSString*)value
                          resolve:(RCTPromiseResolveBlock)resolve
                           reject:(RCTPromiseRejectBlock)reject;

#pragma mark - Weight

- (void)_getWeightsWithUnit:(HKUnit *)unit
                  startDate:(NSDate *)startDate
                    endDate:(NSDate *)endDate
                    resolve:(RCTPromiseResolveBlock)resolve
                     reject:(RCTPromiseRejectBlock)reject;

- (void)_addWeight:(float)weight
              unit:(HKUnit *)unit
              date:(NSDate *)date
           resolve:(RCTPromiseResolveBlock)resolve
            reject:(RCTPromiseRejectBlock)reject;

#pragma mark - Generic Quantity

- (void)_getQuantity:(NSString *)quantityIdentifier
                unit:(NSString *)unit
           startDate:(NSDate *)startDate
             endDate:(NSDate *)endDate
             resolve:(RCTPromiseResolveBlock)resolve
              reject:(RCTPromiseRejectBlock)reject;

@end
