#import "RCTHealthKit.h"
#import "RCTHealthKit+Utils.h"
#import "RCTHealthKit+Characteristics.h"

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

RCT_EXPORT_METHOD(addWorkout:(NSDate*)startDate
                  endDate:(NSDate*)endDate
                  calories:(float)calories
                  metadata:(NSDictionary*)metadata
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    [self _initializeHealthStore];
    [self _addWorkout:startDate endDate:endDate calories:calories metadata:metadata resolve:resolve reject:reject];
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

- (HKUnit *)convertUnit:(NSString *)unit {
    if ([unit isEqualToString:RCTHealthKitUnitTypeKilo]) {
        return [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
    } else if ([unit isEqualToString:RCTHealthKitUnitTypePounds]) {
        return [HKUnit poundUnit];
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
           @"RCTHealthKitTypeDateOfBirth": RCTHealthKitTypeDateOfBirth,
           @"RCTHealthKitTypeWeight": RCTHealthKitTypeWeight,
           @"RCTHealthKitTypeWorkout": RCTHealthKitTypeWorkout,
           @"RCTHealthKitAuthorizationStatusAuthorized": RCTHealthKitAuthorizationStatusAuthorized,
           @"RCTHealthKitAuthorizationStatusDenied": RCTHealthKitAuthorizationStatusDenied,
           @"RCTHealthKitAuthorizationStatusNotDetermined": RCTHealthKitAuthorizationStatusNotDetermined,
           @"RCTHealthKitUnitTypeKilo": RCTHealthKitUnitTypeKilo,
           @"RCTHealthKitUnitTypePounds": RCTHealthKitUnitTypePounds,
           @"RCTHealthKitWorkoutActivityArchery": [NSNumber numberWithInteger:HKWorkoutActivityTypeArchery],
           @"RCTHealthKitWorkoutActivityBowling": [NSNumber numberWithInteger:HKWorkoutActivityTypeBowling],
           @"RCTHealthKitWorkoutActivityFencing": [NSNumber numberWithInteger:HKWorkoutActivityTypeFencing],
           @"RCTHealthKitWorkoutActivityGymnastics": [NSNumber numberWithInteger:HKWorkoutActivityTypeGymnastics],
           @"RCTHealthKitWorkoutActivityTrackAndField": [NSNumber numberWithInteger:HKWorkoutActivityTypeTrackAndField],
           @"RCTHealthKitWorkoutActivityAmericanFootball": [NSNumber numberWithInteger:HKWorkoutActivityTypeAmericanFootball],
           @"RCTHealthKitWorkoutActivityAustralianFootball": [NSNumber numberWithInteger:HKWorkoutActivityTypeAustralianFootball],
           @"RCTHealthKitWorkoutActivityBaseball": [NSNumber numberWithInteger:HKWorkoutActivityTypeBaseball],
           @"RCTHealthKitWorkoutActivityBasketball": [NSNumber numberWithInteger:HKWorkoutActivityTypeBasketball],
           @"RCTHealthKitWorkoutActivityCricket": [NSNumber numberWithInteger:HKWorkoutActivityTypeCricket],
           @"RCTHealthKitWorkoutActivityHandball": [NSNumber numberWithInteger:HKWorkoutActivityTypeHandball],
           @"RCTHealthKitWorkoutActivityHockey": [NSNumber numberWithInteger:HKWorkoutActivityTypeHockey],
           @"RCTHealthKitWorkoutActivityLacrosse": [NSNumber numberWithInteger:HKWorkoutActivityTypeLacrosse],
           @"RCTHealthKitWorkoutActivityRugby": [NSNumber numberWithInteger:HKWorkoutActivityTypeRugby],
           @"RCTHealthKitWorkoutActivitySoccer": [NSNumber numberWithInteger:HKWorkoutActivityTypeSoccer],
           @"RCTHealthKitWorkoutActivitySoftball": [NSNumber numberWithInteger:HKWorkoutActivityTypeSoftball],
           @"RCTHealthKitWorkoutActivityVolleyball": [NSNumber numberWithInteger:HKWorkoutActivityTypeVolleyball],
           @"RCTHealthKitWorkoutActivityPreparationAndRecovery": [NSNumber numberWithInteger:HKWorkoutActivityTypePreparationAndRecovery],
           @"RCTHealthKitWorkoutActivityFlexibility": [NSNumber numberWithInteger:HKWorkoutActivityTypeFlexibility],
           @"RCTHealthKitWorkoutActivityTypeWalking": [NSNumber numberWithInteger:HKWorkoutActivityTypeWalking],
           @"RCTHealthKitWorkoutActivityRunning": [NSNumber numberWithInteger:HKWorkoutActivityTypeRunning],
           @"RCTHealthKitWorkoutActivityWheelchairWalkPace": [NSNumber numberWithInteger:HKWorkoutActivityTypeWheelchairWalkPace],
           @"RCTHealthKitWorkoutActivityWheelchairRunPace": [NSNumber numberWithInteger:HKWorkoutActivityTypeWheelchairRunPace],
           @"RCTHealthKitWorkoutActivityCycling": [NSNumber numberWithInteger:HKWorkoutActivityTypeCycling],
           @"RCTHealthKitWorkoutActivityHandCycling": [NSNumber numberWithInteger:HKWorkoutActivityTypeHandCycling],
           @"RCTHealthKitWorkoutActivityCoreTraining": [NSNumber numberWithInteger:HKWorkoutActivityTypeCoreTraining],
           @"RCTHealthKitWorkoutActivityElliptical": [NSNumber numberWithInteger:HKWorkoutActivityTypeElliptical],
           @"RCTHealthKitWorkoutActivityFunctionalStrengthTraining": [NSNumber numberWithInteger:HKWorkoutActivityTypeFunctionalStrengthTraining],
           @"RCTHealthKitWorkoutActivityTraditionalStrengthTraining": [NSNumber numberWithInteger:HKWorkoutActivityTypeTraditionalStrengthTraining],
           @"RCTHealthKitWorkoutActivityCrossTraining": [NSNumber numberWithInteger:HKWorkoutActivityTypeCrossTraining],
           @"RCTHealthKitWorkoutActivityMixedCardio": [NSNumber numberWithInteger:HKWorkoutActivityTypeMixedCardio],
           @"RCTHealthKitWorkoutActivityHighIntensityIntervalTraining": [NSNumber numberWithInteger:HKWorkoutActivityTypeHighIntensityIntervalTraining],
           @"RCTHealthKitWorkoutActivityJumpRope": [NSNumber numberWithInteger:HKWorkoutActivityTypeJumpRope],
           @"RCTHealthKitWorkoutActivityStairClimbing": [NSNumber numberWithInteger:HKWorkoutActivityTypeStairClimbing],
           @"RCTHealthKitWorkoutActivityStairs": [NSNumber numberWithInteger:HKWorkoutActivityTypeStairs],
           @"RCTHealthKitWorkoutActivityStepTraining": [NSNumber numberWithInteger:HKWorkoutActivityTypeStepTraining],
           @"RCTHealthKitWorkoutActivityBarre": [NSNumber numberWithInteger:HKWorkoutActivityTypeBarre],
           @"RCTHealthKitWorkoutActivityDance": [NSNumber numberWithInteger:HKWorkoutActivityTypeDance],
           @"RCTHealthKitWorkoutActivityYoga": [NSNumber numberWithInteger:HKWorkoutActivityTypeYoga],
           @"RCTHealthKitWorkoutActivityMindAndBody": [NSNumber numberWithInteger:HKWorkoutActivityTypeMindAndBody],
           @"RCTHealthKitWorkoutActivityPilates": [NSNumber numberWithInteger:HKWorkoutActivityTypePilates],
           @"RCTHealthKitWorkoutActivityBadminton": [NSNumber numberWithInteger:HKWorkoutActivityTypeBadminton],
           @"RCTHealthKitWorkoutActivityRacquetball": [NSNumber numberWithInteger:HKWorkoutActivityTypeRacquetball],
           @"RCTHealthKitWorkoutActivitySquash": [NSNumber numberWithInteger:HKWorkoutActivityTypeSquash],
           @"RCTHealthKitWorkoutActivityTableTennis": [NSNumber numberWithInteger:HKWorkoutActivityTypeTableTennis],
           @"RCTHealthKitWorkoutActivityTennis": [NSNumber numberWithInteger:HKWorkoutActivityTypeTennis],
           @"RCTHealthKitWorkoutActivityClimbing": [NSNumber numberWithInteger:HKWorkoutActivityTypeClimbing],
           @"RCTHealthKitWorkoutActivityEquestrianSports": [NSNumber numberWithInteger:HKWorkoutActivityTypeEquestrianSports],
           @"RCTHealthKitWorkoutActivityFishing": [NSNumber numberWithInteger:HKWorkoutActivityTypeFishing],
           @"RCTHealthKitWorkoutActivityGolf": [NSNumber numberWithInteger:HKWorkoutActivityTypeGolf],
           @"RCTHealthKitWorkoutActivityHiking": [NSNumber numberWithInteger:HKWorkoutActivityTypeHiking],
           @"RCTHealthKitWorkoutActivityHunting": [NSNumber numberWithInteger:HKWorkoutActivityTypeHunting],
           @"RCTHealthKitWorkoutActivityPlay": [NSNumber numberWithInteger:HKWorkoutActivityTypePlay],
           @"RCTHealthKitWorkoutActivityCrossCountrySkiing": [NSNumber numberWithInteger:HKWorkoutActivityTypeCrossCountrySkiing],
           @"RCTHealthKitWorkoutActivityCurling": [NSNumber numberWithInteger:HKWorkoutActivityTypeCurling],
           @"RCTHealthKitWorkoutActivityDownhillSkiing": [NSNumber numberWithInteger:HKWorkoutActivityTypeDownhillSkiing],
           @"RCTHealthKitWorkoutActivitySnowSports": [NSNumber numberWithInteger:HKWorkoutActivityTypeSnowSports],
           @"RCTHealthKitWorkoutActivitySnowboarding": [NSNumber numberWithInteger:HKWorkoutActivityTypeSnowboarding],
           @"RCTHealthKitWorkoutActivitySkatingSports": [NSNumber numberWithInteger:HKWorkoutActivityTypeSkatingSports],
           @"RCTHealthKitWorkoutActivityPaddleSports": [NSNumber numberWithInteger:HKWorkoutActivityTypePaddleSports],
           @"RCTHealthKitWorkoutActivityRowing": [NSNumber numberWithInteger:HKWorkoutActivityTypeRowing],
           @"RCTHealthKitWorkoutActivitySailing": [NSNumber numberWithInteger:HKWorkoutActivityTypeSailing],
           @"RCTHealthKitWorkoutActivitySurfingSports": [NSNumber numberWithInteger:HKWorkoutActivityTypeSurfingSports],
           @"RCTHealthKitWorkoutActivitySwimming": [NSNumber numberWithInteger:HKWorkoutActivityTypeSwimming],
           @"RCTHealthKitWorkoutActivityWaterFitness": [NSNumber numberWithInteger:HKWorkoutActivityTypeWaterFitness],
           @"RCTHealthKitWorkoutActivityWaterPolo": [NSNumber numberWithInteger:HKWorkoutActivityTypeWaterPolo],
           @"RCTHealthKitWorkoutActivityWaterSports": [NSNumber numberWithInteger:HKWorkoutActivityTypeWaterSports],
           @"RCTHealthKitWorkoutActivityBoxing": [NSNumber numberWithInteger:HKWorkoutActivityTypeBoxing],
           @"RCTHealthKitWorkoutActivityKickboxing": [NSNumber numberWithInteger:HKWorkoutActivityTypeKickboxing],
           @"RCTHealthKitWorkoutActivityMartialArts": [NSNumber numberWithInteger:HKWorkoutActivityTypeMartialArts],
           @"RCTHealthKitWorkoutActivityTaiChi": [NSNumber numberWithInteger:HKWorkoutActivityTypeTaiChi],
           @"RCTHealthKitWorkoutActivityWrestling": [NSNumber numberWithInteger:HKWorkoutActivityTypeWrestling],
           @"RCTHealthKitWorkoutActivityTypeOther": [NSNumber numberWithInteger:HKWorkoutActivityTypeOther],
           };
}

+ (BOOL)requiresMainQueueSetup {
    return NO;
}

@end
