#import "RCTHealthKitError.h"
#import <React/RCTUtils.h>


static NSString * const healthKitErrorDomain = @"com.rcthealthkit.error";

@implementation RCTHealthKitError

+ (NSError *)_rejectErrorWithType:(RCTHealthKitErrorType)type {
    return [NSError errorWithDomain:healthKitErrorDomain
                               code:[self errorCodeWithType:type]
                           userInfo:[self localizedRejectErrorMessageWithType:type]];
}

+ (NSDictionary *)localizedRejectErrorMessageWithType:(RCTHealthKitErrorType)type {
  return @{
           NSLocalizedDescriptionKey: NSLocalizedString([self _rejectMessageWithType:type], nil)
           };
}

+ (NSString *)_rejectKeyWithType:(RCTHealthKitErrorType)type {
  switch (type) {
    case RCTHealthKitErrorTypeNotAvailable:
      return @"HEALTH_KIT_NOT_AVAILABLE";
    case RCTHealthKitErrorTypeNoTypesProvided:
      return @"NO_TYPES_PROVIDED";
    case RCTHealthKitErrorTypeInitializationFailed:
      return @"INITIALIZATION_FAILED";
    case RCTHealthKitErrorTypePermisionDenied:
      return @"PERMISION_DENIED";
  }
}

+ (NSString *)_rejectMessageWithType:(RCTHealthKitErrorType)type {
  switch (type) {
    case RCTHealthKitErrorTypeNotAvailable:
      return @"HealthKit is not available";
    case RCTHealthKitErrorTypeNoTypesProvided:
      return @"No HealthKit types were provided";
    case RCTHealthKitErrorTypeInitializationFailed:
      return @"Health Kit failed to initialize";
    case RCTHealthKitErrorTypePermisionDenied:
      return @"The app does not have permision to access the type required";
  }
}

+ (NSInteger)errorCodeWithType:(RCTHealthKitErrorType)type {
  switch (type) {
    case RCTHealthKitErrorTypeNotAvailable:
      return 9901;
    case RCTHealthKitErrorTypeNoTypesProvided:
      return 9902;
    case RCTHealthKitErrorTypeInitializationFailed:
      return 9903;
    case RCTHealthKitErrorTypePermisionDenied:
      return 9904;
  }
}

@end
