#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <HealthKit/HealthKit.h>
#import "RCTHealthKitTypes.h"
#import "RCTHealthKitError.h"

@interface RCTHealthKit : NSObject <RCTBridgeModule>

@property (nonatomic) HKHealthStore *_healthStore;

- (BOOL)_isAvailable;

@end
