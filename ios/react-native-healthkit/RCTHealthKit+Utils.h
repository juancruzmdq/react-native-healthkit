#import "RCTHealthKit.h"

@interface RCTHealthKit (Utils)

- (HKHealthStore *)_initializeHealthStore;
- (BOOL)_isAuthorizedForType:(NSString *)type;
- (void)_rejectWithType:(RCTHealthKitErrorType)type rejecter:(RCTPromiseRejectBlock)reject;
- (void)_rejectWithType:(RCTHealthKitErrorType)type
                 error: (NSError *)error
              rejecter:(RCTPromiseRejectBlock)reject;

@end
