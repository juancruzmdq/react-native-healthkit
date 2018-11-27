#import "RCTHealthKit.h"
#import "RCTHealthKit+Utils.h"
#import "RCTHealthKit+Characteristics.h"
#import "RCTHealthKitDataModels.h"

@implementation RCTHealthKit

RCT_EXPORT_MODULE(RNHealthKit);

- (BOOL)_isAvailable {
  return [HKHealthStore isHealthDataAvailable];
}

RCT_EXPORT_METHOD(openAppleHealth) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"x-apple-health://"]];
}

RCT_EXPORT_METHOD(requestPermissions:(NSDictionary *)params
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  [self _initializeHealthStore];
  NSSet *hkReadTypes = nil;
  NSSet *hkWriteTypes = nil;

  if (![HKHealthStore isHealthDataAvailable]) {
    [self _rejectWithType:RCTHealthKitErrorTypeNotAvailable rejecter:reject];
    return;
  }

  NSDictionary *types = [params objectForKey:RCTHealthKitTypesKey];
  if (types) {
    NSArray* readTypes = [types objectForKey:RCTHealthKitTypeOperationReadKey];
    hkReadTypes = [RCTHealthKitTypes _getReadHKTypes:readTypes];
    NSArray* writeTypes = [types objectForKey:RCTHealthKitTypeOperationWriteKey];
    hkWriteTypes = [RCTHealthKitTypes _getWriteHKTypes:writeTypes];
  } else {
    [self _rejectWithType:RCTHealthKitErrorTypeNoTypesProvided rejecter:reject];
    return;
  }

  if (!hkReadTypes) {
    [self _rejectWithType:RCTHealthKitErrorTypeNoTypesProvided rejecter:reject];
    return;
  }

  [self._healthStore requestAuthorizationToShareTypes:hkWriteTypes
                                            readTypes:hkReadTypes
                                           completion:^(BOOL success, NSError *error) {
    if (error) {
      [self _rejectWithType:RCTHealthKitErrorTypeNotAvailable error:error rejecter:reject];
      return;
    } else {
      resolve(@(true));
    }
  }];
}

RCT_EXPORT_METHOD(getWritePermissionStatus:(NSString *)permissionName
                  resolve:(RCTPromiseResolveBlock) resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    [self _initializeHealthStore];
    RCTHealthKitTypes *type = [RCTHealthKitTypes _getWriteType:permissionName];
    if(!type) {
        resolve(@(false));
        return;
    }
    switch ([[self _healthStore] authorizationStatusForType:type]) {
        case HKAuthorizationStatusSharingAuthorized:
            resolve(RCTHealthKitAuthorizationStatusAuthorized);
            break;
        case HKAuthorizationStatusNotDetermined:
            resolve(RCTHealthKitAuthorizationStatusNotDetermined);
            break;
        case HKAuthorizationStatusSharingDenied:
            resolve(RCTHealthKitAuthorizationStatusDenied);
            break;
    };
}

RCT_EXPORT_METHOD(getDateOfBirth:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  [self _initializeHealthStore];
  [self _getDateOfBirth:resolve rejecter:reject];
}

#pragma mark - Workouts

RCT_EXPORT_METHOD(addWorkout:(NSDate*)startDate
                  endDate:(NSDate*)endDate
                  calories:(float)calories
          distanceInMeters:(float)distance
                  metadata:(NSDictionary*)metadata
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    [self _initializeHealthStore];
    [self _addWorkout:startDate 
              endDate:endDate
             calories:calories
     distanceInMeters:distance
             metadata:metadata
              resolve:resolve
               reject:reject];
}

RCT_EXPORT_METHOD(getWorkouts:(NSDate*)startDate
                  endDate:(NSDate*)endDate
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    [self _initializeHealthStore];
    [self _getWorkoutsWithStartDate:startDate endDate:endDate resolve:resolve reject:reject];
}

RCT_EXPORT_METHOD(getWorkoutsByMetadata:(NSString*)key
                  value:(NSString*)value
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject){
    [self _initializeHealthStore];
    [self _getWorkoutsByMetadata:key value:value resolve:resolve reject:reject];
}

RCT_EXPORT_METHOD(deleteWorkoutsByMetadata:(NSString*)key
                    value:(NSString*)value
                    resolve:(RCTPromiseResolveBlock)resolve
                    reject:(RCTPromiseRejectBlock)reject){
    [self _initializeHealthStore];
    [self _deleteWorkoutsByMetadata:key value:value resolve:resolve reject:reject];
}

#pragma mark - Weight

RCT_EXPORT_METHOD(getWeightsWithUnit:(NSString *)unit
                  startDate:(NSDate *)startDate
                  endDate:(NSDate *)endDate
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject){
    [self _initializeHealthStore];
    [self _getWeightsWithUnit:[self convertUnit:unit]
                    startDate:startDate
                      endDate:endDate
                      resolve:resolve
                       reject:reject];
}

RCT_EXPORT_METHOD(addWeight:(float)weight
                  unit:(NSString *)unit
                  date:(NSDate *)date
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject){
    [self _initializeHealthStore];
    [self _addWeight:weight
                unit:[self convertUnit:unit]
                date:date
             resolve:resolve reject:reject];
}

#pragma mark - Generic Quantity

RCT_EXPORT_METHOD(getQuantity:(NSString *)quantityIdentifier
                  unit:(NSString *)unit
                  startDate:(NSDate *)startDate
                  endDate:(NSDate *)endDate
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject){
    [self _getQuantity:quantityIdentifier
                  unit:[self convertUnit:unit]
             startDate:startDate
               endDate:endDate
               resolve:resolve
                reject:reject];
}

- (HKUnit *)convertUnit:(NSString *)unit {
    if ([unit isEqualToString:RCTHealthKitUnitTypeKilo]) {
        return [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
    } else if ([unit isEqualToString:RCTHealthKitUnitTypePounds]) {
        return [HKUnit poundUnit];
    } else if ([unit isEqualToString:RCTHealthKitUnitTypeCalories]) {
        if (@available(iOS 11, *)) {
            return HKUnit.smallCalorieUnit;
        } else {
            return HKUnit.calorieUnit;
        }
    }

    return nil;
}

RCT_EXPORT_METHOD(getDefaultSource:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject){
    [self _initializeHealthStore];
    [self _getDefaultSource:resolve reject:reject];
}

- (NSDictionary *)constantsToExport {
  return @{
           @"isAvailable": @([self _isAvailable]),
           @"RCTHealthKitTypesKey": RCTHealthKitTypesKey,
           @"RCTHealthKitTypeOperationReadKey": RCTHealthKitTypeOperationReadKey,
           @"RCTHealthKitTypeOperationWriteKey": RCTHealthKitTypeOperationWriteKey,
           @"dataTypes": RCTHealthKitDataModels.dataTypes,
           @"units": RCTHealthKitDataModels.units,
           @"permissionStatus": RCTHealthKitDataModels.permissionStatus,
           @"quantities": RCTHealthKitDataModels.quantitiesDict,
           @"workouts": RCTHealthKitDataModels.workoutsDict,
           };
}

+ (BOOL)requiresMainQueueSetup {
    return NO;
}

@end
