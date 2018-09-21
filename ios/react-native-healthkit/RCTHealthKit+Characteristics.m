#import "RCTHealthKit+Characteristics.h"
#import "RCTHealthKit+Utils.h"
#import <React/RCTConvert.h>

@implementation RCTHealthKit (Characteristics)

- (void)_getDateOfBirth:(RCTPromiseResolveBlock)resolve
              rejecter:(RCTPromiseRejectBlock)reject {
  NSError *error;
  NSDateComponents *dateOfBirthComponents = [self._healthStore dateOfBirthComponentsWithError:&error];

  if (error) {
    [self _rejectWithType:RCTHealthKitErrorTypePermisionDenied error:error rejecter:reject];
    return;
  }

  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDate *dateOfBirth = [calendar dateFromComponents:dateOfBirthComponents];
  resolve(@([dateOfBirth timeIntervalSince1970]));
}

- (void)_addWorkout:(NSDate*)startDate
            endDate:(NSDate*)endDate
            calories:(float)calories
            metadata:(NSDictionary*)metadata
            resolve:(RCTPromiseResolveBlock)resolve
            reject:(RCTPromiseRejectBlock)reject{
    HKUnit *caloriesUnit = [HKUnit calorieUnit];
    HKQuantity *caloriesQuantity = [HKQuantity quantityWithUnit:caloriesUnit doubleValue:calories];


    HKWorkout *workout = [HKWorkout workoutWithActivityType:HKWorkoutActivityTypeOther startDate:startDate endDate:endDate duration:0 totalEnergyBurned:caloriesQuantity totalDistance:nil device:nil metadata:metadata];

    [self._healthStore saveObject:workout withCompletion:^(BOOL success, NSError * _Nullable error) {
        if(!success) {
            reject(@"RCTHealthKit_save_workout_fail", @"An error occurred while saving the workout", error);
        }
        resolve(nil);
    }];
}

- (NSDictionary*)convertHKSample:(HKSample*)sample {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    if([sample startDate]){
        dictionary[@"startDate"] = [[sample startDate] description];
    }
    if([sample endDate]) {
        dictionary[@"endDate"] = [[sample endDate] description];
    }
    if([((HKWorkout *)sample) totalEnergyBurned]) {
        double calories =  [[((HKWorkout *)sample) totalEnergyBurned] doubleValueForUnit:[HKUnit calorieUnit]];
        if(calories) {
            dictionary[@"calories"] = [NSNumber numberWithFloat:calories];
        }
    }
    if([sample metadata]) {
        dictionary[@"metadata"] = [sample metadata];
    }
    return dictionary;
}

- (void)_getWorkouts:(RCTPromiseResolveBlock)resolve
                reject:(RCTPromiseRejectBlock)reject {
    HKQuery *query = [HKQuery predicateForObjectsFromSource:[HKSource defaultSource]];
    HKSampleType *sampleType = [HKSampleType workoutType];
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:query limit:0 sortDescriptors:nil resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        if(error) {
            reject(@"RCTHealthKit_read_workouts_fail", @"An error occured while reading workouts", error);
        } else {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for(id object in results) {
                [array addObject:[self convertHKSample:object]];
            }
            resolve(array);
        }
    }];

    [[self _healthStore] executeQuery:sampleQuery];
}

- (void)_getWorkoutsByMetadata:(NSString*)key
                        value:(NSString*)value
                        resolve:(RCTPromiseResolveBlock)resolve
                        reject:(RCTPromiseRejectBlock)reject {
    HKQuery *sourceQuery = [HKQuery predicateForObjectsFromSource:[HKSource defaultSource]];
    HKQuery *metadataQuery = [HKQuery predicateForObjectsWithMetadataKey:key operatorType:NSEqualToPredicateOperatorType value:value];
    HKQuery *query = [NSCompoundPredicate andPredicateWithSubpredicates:@[sourceQuery, metadataQuery]];
    HKSampleType *sampleType = [HKSampleType workoutType];
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:query limit:0 sortDescriptors:nil resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        if(error) {
            reject(@"RCTHealthKit_read_workouts_fail", @"An error occured while reading workouts", error);
        } else {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for(id object in results) {
                [array addObject:[self convertHKSample:object]];
            }
            resolve(array);
        }
    }];

    [[self _healthStore] executeQuery:sampleQuery];
}

@end
