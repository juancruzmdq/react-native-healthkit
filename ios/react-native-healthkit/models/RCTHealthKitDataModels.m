//
//  RCTHealthKitDataModels.m
//  react-native-healthkit
//
//  Created by Flávio Caetano on 15/11/18.
//

@import HealthKit;

#import "RCTHealthKitDataModels.h"
#import "RCTHealthKitTypes.h"

@implementation RCTHealthKitDataModels

+ (NSDictionary *)quantitiesDict {
    NSMutableDictionary *result = @{
             @"HKQuantityTypeIdentifierBodyMassIndex": HKQuantityTypeIdentifierBodyMassIndex,
             @"HKQuantityTypeIdentifierBodyFatPercentage": HKQuantityTypeIdentifierBodyFatPercentage,
             @"HKQuantityTypeIdentifierHeight": HKQuantityTypeIdentifierHeight,
             @"HKQuantityTypeIdentifierBodyMass": HKQuantityTypeIdentifierBodyMass,
             @"HKQuantityTypeIdentifierLeanBodyMass": HKQuantityTypeIdentifierLeanBodyMass,
             @"HKQuantityTypeIdentifierStepCount": HKQuantityTypeIdentifierStepCount,
             @"HKQuantityTypeIdentifierDistanceWalkingRunning": HKQuantityTypeIdentifierDistanceWalkingRunning,
             @"HKQuantityTypeIdentifierDistanceCycling": HKQuantityTypeIdentifierDistanceCycling,
             @"HKQuantityTypeIdentifierBasalEnergyBurned": HKQuantityTypeIdentifierBasalEnergyBurned,
             @"HKQuantityTypeIdentifierActiveEnergyBurned": HKQuantityTypeIdentifierActiveEnergyBurned,
             @"HKQuantityTypeIdentifierFlightsClimbed": HKQuantityTypeIdentifierFlightsClimbed,
             @"HKQuantityTypeIdentifierNikeFuel": HKQuantityTypeIdentifierNikeFuel,
             @"HKQuantityTypeIdentifierHeartRate": HKQuantityTypeIdentifierHeartRate,
             @"HKQuantityTypeIdentifierBodyTemperature": HKQuantityTypeIdentifierBodyTemperature,
             @"HKQuantityTypeIdentifierBasalBodyTemperature": HKQuantityTypeIdentifierBasalBodyTemperature,
             @"HKQuantityTypeIdentifierBloodPressureSystolic": HKQuantityTypeIdentifierBloodPressureSystolic,
             @"HKQuantityTypeIdentifierBloodPressureDiastolic": HKQuantityTypeIdentifierBloodPressureDiastolic,
             @"HKQuantityTypeIdentifierRespiratoryRate": HKQuantityTypeIdentifierRespiratoryRate,
             @"HKQuantityTypeIdentifierOxygenSaturation": HKQuantityTypeIdentifierOxygenSaturation,
             @"HKQuantityTypeIdentifierPeripheralPerfusionIndex": HKQuantityTypeIdentifierPeripheralPerfusionIndex,
             @"HKQuantityTypeIdentifierBloodGlucose": HKQuantityTypeIdentifierBloodGlucose,
             @"HKQuantityTypeIdentifierNumberOfTimesFallen": HKQuantityTypeIdentifierNumberOfTimesFallen,
             @"HKQuantityTypeIdentifierElectrodermalActivity": HKQuantityTypeIdentifierElectrodermalActivity,
             @"HKQuantityTypeIdentifierInhalerUsage": HKQuantityTypeIdentifierInhalerUsage,
             @"HKQuantityTypeIdentifierBloodAlcoholContent": HKQuantityTypeIdentifierBloodAlcoholContent,
             @"HKQuantityTypeIdentifierForcedVitalCapacity": HKQuantityTypeIdentifierForcedVitalCapacity,
             @"HKQuantityTypeIdentifierForcedExpiratoryVolume1": HKQuantityTypeIdentifierForcedExpiratoryVolume1,
             @"HKQuantityTypeIdentifierPeakExpiratoryFlowRate": HKQuantityTypeIdentifierPeakExpiratoryFlowRate,
             @"HKQuantityTypeIdentifierDietaryFatTotal": HKQuantityTypeIdentifierDietaryFatTotal,
             @"HKQuantityTypeIdentifierDietaryFatPolyunsaturated": HKQuantityTypeIdentifierDietaryFatPolyunsaturated,
             @"HKQuantityTypeIdentifierDietaryFatMonounsaturated": HKQuantityTypeIdentifierDietaryFatMonounsaturated,
             @"HKQuantityTypeIdentifierDietaryFatSaturated": HKQuantityTypeIdentifierDietaryFatSaturated,
             @"HKQuantityTypeIdentifierDietaryCholesterol": HKQuantityTypeIdentifierDietaryCholesterol,
             @"HKQuantityTypeIdentifierDietarySodium": HKQuantityTypeIdentifierDietarySodium,
             @"HKQuantityTypeIdentifierDietaryCarbohydrates": HKQuantityTypeIdentifierDietaryCarbohydrates,
             @"HKQuantityTypeIdentifierDietaryFiber": HKQuantityTypeIdentifierDietaryFiber,
             @"HKQuantityTypeIdentifierDietarySugar": HKQuantityTypeIdentifierDietarySugar,
             @"HKQuantityTypeIdentifierDietaryEnergyConsumed": HKQuantityTypeIdentifierDietaryEnergyConsumed,
             @"HKQuantityTypeIdentifierDietaryProtein": HKQuantityTypeIdentifierDietaryProtein,
             @"HKQuantityTypeIdentifierDietaryVitaminA": HKQuantityTypeIdentifierDietaryVitaminA,
             @"HKQuantityTypeIdentifierDietaryVitaminB6": HKQuantityTypeIdentifierDietaryVitaminB6,
             @"HKQuantityTypeIdentifierDietaryVitaminB12": HKQuantityTypeIdentifierDietaryVitaminB12,
             @"HKQuantityTypeIdentifierDietaryVitaminC": HKQuantityTypeIdentifierDietaryVitaminC,
             @"HKQuantityTypeIdentifierDietaryVitaminD": HKQuantityTypeIdentifierDietaryVitaminD,
             @"HKQuantityTypeIdentifierDietaryVitaminE": HKQuantityTypeIdentifierDietaryVitaminE,
             @"HKQuantityTypeIdentifierDietaryVitaminK": HKQuantityTypeIdentifierDietaryVitaminK,
             @"HKQuantityTypeIdentifierDietaryCalcium": HKQuantityTypeIdentifierDietaryCalcium,
             @"HKQuantityTypeIdentifierDietaryIron": HKQuantityTypeIdentifierDietaryIron,
             @"HKQuantityTypeIdentifierDietaryThiamin": HKQuantityTypeIdentifierDietaryThiamin,
             @"HKQuantityTypeIdentifierDietaryRiboflavin": HKQuantityTypeIdentifierDietaryRiboflavin,
             @"HKQuantityTypeIdentifierDietaryNiacin": HKQuantityTypeIdentifierDietaryNiacin,
             @"HKQuantityTypeIdentifierDietaryFolate": HKQuantityTypeIdentifierDietaryFolate,
             @"HKQuantityTypeIdentifierDietaryBiotin": HKQuantityTypeIdentifierDietaryBiotin,
             @"HKQuantityTypeIdentifierDietaryPantothenicAcid": HKQuantityTypeIdentifierDietaryPantothenicAcid,
             @"HKQuantityTypeIdentifierDietaryPhosphorus": HKQuantityTypeIdentifierDietaryPhosphorus,
             @"HKQuantityTypeIdentifierDietaryIodine": HKQuantityTypeIdentifierDietaryIodine,
             @"HKQuantityTypeIdentifierDietaryMagnesium": HKQuantityTypeIdentifierDietaryMagnesium,
             @"HKQuantityTypeIdentifierDietaryZinc": HKQuantityTypeIdentifierDietaryZinc,
             @"HKQuantityTypeIdentifierDietarySelenium": HKQuantityTypeIdentifierDietarySelenium,
             @"HKQuantityTypeIdentifierDietaryCopper": HKQuantityTypeIdentifierDietaryCopper,
             @"HKQuantityTypeIdentifierDietaryManganese": HKQuantityTypeIdentifierDietaryManganese,
             @"HKQuantityTypeIdentifierDietaryChromium": HKQuantityTypeIdentifierDietaryChromium,
             @"HKQuantityTypeIdentifierDietaryMolybdenum": HKQuantityTypeIdentifierDietaryMolybdenum,
             @"HKQuantityTypeIdentifierDietaryChloride": HKQuantityTypeIdentifierDietaryChloride,
             @"HKQuantityTypeIdentifierDietaryPotassium": HKQuantityTypeIdentifierDietaryPotassium,
             @"HKQuantityTypeIdentifierDietaryCaffeine": HKQuantityTypeIdentifierDietaryCaffeine,
             @"HKQuantityTypeIdentifierDietaryWater": HKQuantityTypeIdentifierDietaryWater,
             @"HKQuantityTypeIdentifierUVExposure": HKQuantityTypeIdentifierUVExposure,
             }.mutableCopy;

    if (@available(iOS 9.3, *)) {
        result[@"HKQuantityTypeIdentifierAppleExerciseTime"] = HKQuantityTypeIdentifierAppleExerciseTime;
    }

    if (@available(iOS 10, *)) {
        result[@"HKQuantityTypeIdentifierDistanceWheelchair"] = HKQuantityTypeIdentifierDistanceWheelchair;
        result[@"HKQuantityTypeIdentifierPushCount"] = HKQuantityTypeIdentifierPushCount;
        result[@"HKQuantityTypeIdentifierDistanceSwimming"] = HKQuantityTypeIdentifierDistanceSwimming;
        result[@"HKQuantityTypeIdentifierSwimmingStrokeCount"] = HKQuantityTypeIdentifierSwimmingStrokeCount;
    }

    if (@available(iOS 11, *)) {
        result[@"HKQuantityTypeIdentifierWaistCircumference"] = HKQuantityTypeIdentifierWaistCircumference;
        result[@"HKQuantityTypeIdentifierVO2Max"] = HKQuantityTypeIdentifierVO2Max;
        result[@"HKQuantityTypeIdentifierRestingHeartRate"] = HKQuantityTypeIdentifierRestingHeartRate;
        result[@"HKQuantityTypeIdentifierWalkingHeartRateAverage"] = HKQuantityTypeIdentifierWalkingHeartRateAverage;
        result[@"HKQuantityTypeIdentifierHeartRateVariabilitySDNN"] = HKQuantityTypeIdentifierHeartRateVariabilitySDNN;
        result[@"HKQuantityTypeIdentifierInsulinDelivery"] = HKQuantityTypeIdentifierInsulinDelivery;
    }

    if (@available(iOS 11.2, *)) {
        result[@"HKQuantityTypeIdentifierDistanceDownhillSnowSports"] = HKQuantityTypeIdentifierDistanceDownhillSnowSports;
    }

    return result;
}

+ (NSDictionary *)workoutsDict {
    NSMutableDictionary *result = @{
    @"RCTHealthKitWorkoutActivityArchery": @(HKWorkoutActivityTypeArchery),
    @"RCTHealthKitWorkoutActivityBowling": @(HKWorkoutActivityTypeBowling),
    @"RCTHealthKitWorkoutActivityFencing": @(HKWorkoutActivityTypeFencing),
    @"RCTHealthKitWorkoutActivityGymnastics": @(HKWorkoutActivityTypeGymnastics),
    @"RCTHealthKitWorkoutActivityTrackAndField": @(HKWorkoutActivityTypeTrackAndField),
    @"RCTHealthKitWorkoutActivityAmericanFootball": @(HKWorkoutActivityTypeAmericanFootball),
    @"RCTHealthKitWorkoutActivityAustralianFootball": @(HKWorkoutActivityTypeAustralianFootball),
    @"RCTHealthKitWorkoutActivityBaseball": @(HKWorkoutActivityTypeBaseball),
    @"RCTHealthKitWorkoutActivityBasketball": @(HKWorkoutActivityTypeBasketball),
    @"RCTHealthKitWorkoutActivityCricket": @(HKWorkoutActivityTypeCricket),
    @"RCTHealthKitWorkoutActivityHandball": @(HKWorkoutActivityTypeHandball),
    @"RCTHealthKitWorkoutActivityHockey": @(HKWorkoutActivityTypeHockey),
    @"RCTHealthKitWorkoutActivityLacrosse": @(HKWorkoutActivityTypeLacrosse),
    @"RCTHealthKitWorkoutActivityRugby": @(HKWorkoutActivityTypeRugby),
    @"RCTHealthKitWorkoutActivitySoccer": @(HKWorkoutActivityTypeSoccer),
    @"RCTHealthKitWorkoutActivitySoftball": @(HKWorkoutActivityTypeSoftball),
    @"RCTHealthKitWorkoutActivityVolleyball": @(HKWorkoutActivityTypeVolleyball),
    @"RCTHealthKitWorkoutActivityPreparationAndRecovery": @(HKWorkoutActivityTypePreparationAndRecovery),
    @"RCTHealthKitWorkoutActivityTypeWalking": @(HKWorkoutActivityTypeWalking),
    @"RCTHealthKitWorkoutActivityRunning": @(HKWorkoutActivityTypeRunning),
    @"RCTHealthKitWorkoutActivityCycling": @(HKWorkoutActivityTypeCycling),
    @"RCTHealthKitWorkoutActivityElliptical": @(HKWorkoutActivityTypeElliptical),
    @"RCTHealthKitWorkoutActivityFunctionalStrengthTraining": @(HKWorkoutActivityTypeFunctionalStrengthTraining),
    @"RCTHealthKitWorkoutActivityTraditionalStrengthTraining": @(HKWorkoutActivityTypeTraditionalStrengthTraining),
    @"RCTHealthKitWorkoutActivityCrossTraining": @(HKWorkoutActivityTypeCrossTraining),
    @"RCTHealthKitWorkoutActivityStairClimbing": @(HKWorkoutActivityTypeStairClimbing),
    @"RCTHealthKitWorkoutActivityDance": @(HKWorkoutActivityTypeDance),
    @"RCTHealthKitWorkoutActivityYoga": @(HKWorkoutActivityTypeYoga),
    @"RCTHealthKitWorkoutActivityMindAndBody": @(HKWorkoutActivityTypeMindAndBody),
    @"RCTHealthKitWorkoutActivityBadminton": @(HKWorkoutActivityTypeBadminton),
    @"RCTHealthKitWorkoutActivityRacquetball": @(HKWorkoutActivityTypeRacquetball),
    @"RCTHealthKitWorkoutActivitySquash": @(HKWorkoutActivityTypeSquash),
    @"RCTHealthKitWorkoutActivityTableTennis": @(HKWorkoutActivityTypeTableTennis),
    @"RCTHealthKitWorkoutActivityTennis": @(HKWorkoutActivityTypeTennis),
    @"RCTHealthKitWorkoutActivityClimbing": @(HKWorkoutActivityTypeClimbing),
    @"RCTHealthKitWorkoutActivityEquestrianSports": @(HKWorkoutActivityTypeEquestrianSports),
    @"RCTHealthKitWorkoutActivityFishing": @(HKWorkoutActivityTypeFishing),
    @"RCTHealthKitWorkoutActivityGolf": @(HKWorkoutActivityTypeGolf),
    @"RCTHealthKitWorkoutActivityHiking": @(HKWorkoutActivityTypeHiking),
    @"RCTHealthKitWorkoutActivityHunting": @(HKWorkoutActivityTypeHunting),
    @"RCTHealthKitWorkoutActivityPlay": @(HKWorkoutActivityTypePlay),
    @"RCTHealthKitWorkoutActivityCurling": @(HKWorkoutActivityTypeCurling),
    @"RCTHealthKitWorkoutActivitySnowSports": @(HKWorkoutActivityTypeSnowSports),
    @"RCTHealthKitWorkoutActivitySkatingSports": @(HKWorkoutActivityTypeSkatingSports),
    @"RCTHealthKitWorkoutActivityPaddleSports": @(HKWorkoutActivityTypePaddleSports),
    @"RCTHealthKitWorkoutActivityRowing": @(HKWorkoutActivityTypeRowing),
    @"RCTHealthKitWorkoutActivitySailing": @(HKWorkoutActivityTypeSailing),
    @"RCTHealthKitWorkoutActivitySurfingSports": @(HKWorkoutActivityTypeSurfingSports),
    @"RCTHealthKitWorkoutActivitySwimming": @(HKWorkoutActivityTypeSwimming),
    @"RCTHealthKitWorkoutActivityWaterFitness": @(HKWorkoutActivityTypeWaterFitness),
    @"RCTHealthKitWorkoutActivityWaterPolo": @(HKWorkoutActivityTypeWaterPolo),
    @"RCTHealthKitWorkoutActivityWaterSports": @(HKWorkoutActivityTypeWaterSports),
    @"RCTHealthKitWorkoutActivityBoxing": @(HKWorkoutActivityTypeBoxing),
    @"RCTHealthKitWorkoutActivityMartialArts": @(HKWorkoutActivityTypeMartialArts),
    @"RCTHealthKitWorkoutActivityWrestling": @(HKWorkoutActivityTypeWrestling),
    @"RCTHealthKitWorkoutActivityTypeOther": @(HKWorkoutActivityTypeOther),
    }.mutableCopy;

    if (@available(iOS 10, *)) {
        result[@"HKWorkoutActivityTypeFlexibility"] = @(HKWorkoutActivityTypeFlexibility);
        result[@"RCTHealthKitWorkoutActivityWheelchairWalkPace"] = @(HKWorkoutActivityTypeWheelchairWalkPace);
        result[@"RCTHealthKitWorkoutActivityWheelchairRunPace"] = @(HKWorkoutActivityTypeWheelchairRunPace);
        result[@"RCTHealthKitWorkoutActivityCoreTraining"] = @(HKWorkoutActivityTypeCoreTraining);
        result[@"RCTHealthKitWorkoutActivityHighIntensityIntervalTraining"] = @(HKWorkoutActivityTypeHighIntensityIntervalTraining);
        result[@"RCTHealthKitWorkoutActivityJumpRope"] = @(HKWorkoutActivityTypeJumpRope);
        result[@"RCTHealthKitWorkoutActivityStairs"] = @(HKWorkoutActivityTypeStairs);
        result[@"RCTHealthKitWorkoutActivityStepTraining"] = @(HKWorkoutActivityTypeStepTraining);
        result[@"RCTHealthKitWorkoutActivityBarre"] = @(HKWorkoutActivityTypeBarre);
        result[@"RCTHealthKitWorkoutActivityPilates"] = @(HKWorkoutActivityTypePilates);
        result[@"RCTHealthKitWorkoutActivityCrossCountrySkiing"] = @(HKWorkoutActivityTypeCrossCountrySkiing);
        result[@"RCTHealthKitWorkoutActivityDownhillSkiing"] = @(HKWorkoutActivityTypeDownhillSkiing);
        result[@"RCTHealthKitWorkoutActivitySnowboarding"] = @(HKWorkoutActivityTypeSnowboarding);
        result[@"RCTHealthKitWorkoutActivityKickboxing"] = @(HKWorkoutActivityTypeKickboxing);
    }

    if (@available(iOS 11, *)) {
        result[@"RCTHealthKitWorkoutActivityHandCycling"] = @(HKWorkoutActivityTypeHandCycling);
        result[@"RCTHealthKitWorkoutActivityMixedCardio"] = @(HKWorkoutActivityTypeMixedCardio);
        result[@"RCTHealthKitWorkoutActivityTaiChi"] = @(HKWorkoutActivityTypeTaiChi);
    }

    return result;
}

+ (NSDictionary *)permissionStatus {
    return @{
             @"RCTHealthKitAuthorizationStatusAuthorized": RCTHealthKitAuthorizationStatusAuthorized,
             @"RCTHealthKitAuthorizationStatusDenied": RCTHealthKitAuthorizationStatusDenied,
             @"RCTHealthKitAuthorizationStatusNotDetermined": RCTHealthKitAuthorizationStatusNotDetermined,
             };
}

+ (NSDictionary *)units {
    return @{
             @"RCTHealthKitUnitTypeKilo": RCTHealthKitUnitTypeKilo,
             @"RCTHealthKitUnitTypePounds": RCTHealthKitUnitTypePounds,
             @"RCTHealthKitUnitTypeCalories": RCTHealthKitUnitTypeCalories,
             };
}

+ (NSDictionary *)dataTypes {
    return @{
             @"RCTHealthKitTypeDateOfBirth": RCTHealthKitTypeDateOfBirth,
             @"RCTHealthKitTypeWorkout": RCTHealthKitTypeWorkout,
             };
}

@end
