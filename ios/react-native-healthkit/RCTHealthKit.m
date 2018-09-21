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
            resolve(@(true));
            break;
        default:
            resolve(@(false));
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

RCT_EXPORT_METHOD(getWorkouts:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject){
    [self _initializeHealthStore];
    [self _getWorkouts:resolve reject:reject];
}

RCT_EXPORT_METHOD(getWorkoutsByMetadata:(NSString*)key
                  value:(NSString*)value
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject){
    [self _initializeHealthStore];
    [self _getWorkoutsByMetadata:key value:value resolve:resolve reject:reject];
}

- (NSDictionary *)constantsToExport {
  return @{
           @"isAvailable": @([self _isAvailable]),
           @"RCTHealthKitTypesKey": RCTHealthKitTypesKey,
           @"RCTHealthKitTypeOperationReadKey": RCTHealthKitTypeOperationReadKey,
           @"RCTHealthKitTypeOperationWriteKey": RCTHealthKitTypeOperationWriteKey,
           @"RCTHealthKitTypeDateOfBirth": RCTHealthKitTypeDateOfBirth,
           };
}

+ (BOOL)requiresMainQueueSetup {
    return NO;
}

@end
