//
//  RCTHealthKitDataModels.h
//  react-native-healthkit
//
//  Created by Flávio Caetano on 15/11/18.
//

@import Foundation;

@interface RCTHealthKitDataModels : NSObject

+ (NSDictionary *)quantitiesDict;

+ (NSDictionary *)workoutsDict;

+ (NSDictionary *)permissionStatus;

+ (NSDictionary *)units;

+ (NSDictionary *)dataTypes;

@end
