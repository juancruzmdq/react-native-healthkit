#import "RCTHealthKit+Utils.h"

@implementation RCTHealthKit (Utils)

- (HKHealthStore *)_initializeHealthStore {
    if(![self _healthStore]) {
        self._healthStore = [HKHealthStore new];
    }
    return [self _healthStore];
}

- (BOOL)_isAuthorizedForType:(NSString *)type {
    HKObjectType *hkType = [RCTHealthKitTypes _getWriteType:type];
    if (!hkType) {
        return false;
    }

    return [self._healthStore authorizationStatusForType:hkType] ==
    HKAuthorizationStatusSharingAuthorized;
}

- (void)_rejectWithType:(RCTHealthKitErrorType)type rejecter:(RCTPromiseRejectBlock)reject {
    reject(
           [RCTHealthKitError _rejectKeyWithType:type],
           [RCTHealthKitError _rejectMessageWithType:type],
           [RCTHealthKitError _rejectErrorWithType:type]
           );
}

- (void)_rejectWithType:(RCTHealthKitErrorType)type
                  error: (NSError *)error
               rejecter:(RCTPromiseRejectBlock)reject {
    reject(
           [RCTHealthKitError _rejectKeyWithType:type],
           [RCTHealthKitError _rejectMessageWithType:type],
           error
           );
}

@end
