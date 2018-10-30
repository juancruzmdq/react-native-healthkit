#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

FOUNDATION_EXPORT NSString * RCTHealthKitTypesKey;
FOUNDATION_EXPORT NSString * RCTHealthKitTypeOperationReadKey;
FOUNDATION_EXPORT NSString * RCTHealthKitTypeOperationWriteKey;

FOUNDATION_EXPORT NSString * RCTHealthKitTypeDateOfBirth;
FOUNDATION_EXPORT NSString * RCTHealthKitTypeWorkout;
FOUNDATION_EXPORT NSString * RCTHealthKitTypeWeight;

FOUNDATION_EXPORT NSString * RCTHealthKitAuthorizationStatusAuthorized;
FOUNDATION_EXPORT NSString * RCTHealthKitAuthorizationStatusDenied;
FOUNDATION_EXPORT NSString * RCTHealthKitAuthorizationStatusNotDetermined;

FOUNDATION_EXPORT NSString * RCTHealthKitUnitTypeKilo;
FOUNDATION_EXPORT NSString * RCTHealthKitUnitTypePounds;

@interface RCTHealthKitTypes : NSObject

@property (class, readonly) NSDictionary *_readTypes;

+ (NSSet *)_getReadHKTypes:(NSArray *)types;
+ (NSSet *)_getWriteHKTypes:(NSArray *)types;
+ (HKObjectType *)_getWriteType:(NSString *)type;

@end
