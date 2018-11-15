#import "RCTHealthKitTypes.h"
#import <HealthKit/HealthKit.h>

NSString * RCTHealthKitTypesKey = @"types";
NSString * RCTHealthKitTypeOperationReadKey = @"read";
NSString * RCTHealthKitTypeOperationWriteKey = @"write";

NSString * RCTHealthKitTypeDateOfBirth = @"DateOfBirth";
NSString * RCTHealthKitTypeWorkout = @"Workouts";

NSString * RCTHealthKitAuthorizationStatusAuthorized = @"AuthorizationStatusSharingAuthorized";
NSString * RCTHealthKitAuthorizationStatusDenied = @"AuthorizationStatusSharingDenied";
NSString * RCTHealthKitAuthorizationStatusNotDetermined = @"AuthorizationStatusSharingNotDetermined";

NSString * RCTHealthKitUnitTypeKilo = @"Kilo";
NSString * RCTHealthKitUnitTypePounds = @"Pounds";
NSString * RCTHealthKitUnitTypeCalories = @"Calories";

@implementation RCTHealthKitTypes

+ (NSDictionary *)_writeTypes {
    return @{
             RCTHealthKitTypeWorkout : [HKObjectType workoutType],
             };
}

+ (NSDictionary *)_readTypes {
    return @{
             RCTHealthKitTypeDateOfBirth : [HKObjectType
                                            characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth],
             RCTHealthKitTypeWorkout : [HKObjectType workoutType],
             };
}

+ (NSSet *)_getReadHKTypes:(NSArray *)types; {
    NSMutableSet *hkTypes = [NSMutableSet new];

    for (NSString *type in types) {
        HKObjectType *hkType = [self _getWriteType:type];
        if (hkType) {
            [hkTypes addObject:hkType];
        }
    }

    return hkTypes;
}

+ (HKObjectType *)_getWriteType:(NSString *)type {
    HKObjectType *result = self._readTypes[type];
    return result ?: [HKObjectType quantityTypeForIdentifier:type];
}

+ (NSSet *)_getWriteHKTypes:(NSArray *)types; {
    NSMutableSet *hkTypes = [NSMutableSet new];
    if(types) {
        for(NSString *type in types) {
            HKObjectType *hkType = [self _getWriteType:type];
            if(hkType) {
                [hkTypes addObject:hkType];
            }
        }
    }
    return hkTypes;
}

@end
