#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RCTHealthKitErrorType) {
  RCTHealthKitErrorTypeNotAvailable,
  RCTHealthKitErrorTypeNoTypesProvided,
  RCTHealthKitErrorTypeInitializationFailed,
  RCTHealthKitErrorTypePermisionDenied
};

@interface RCTHealthKitError : NSObject

+ (NSError *)_rejectErrorWithType:(RCTHealthKitErrorType)type;
+ (NSString *)_rejectKeyWithType:(RCTHealthKitErrorType)type;
+ (NSString *)_rejectMessageWithType:(RCTHealthKitErrorType)type;


@end
