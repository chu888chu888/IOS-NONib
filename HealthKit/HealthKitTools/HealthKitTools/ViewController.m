//
//  ViewController.m
//  HealthKitTools
//
//  Created by 楚广明 on 16/1/7.
//  Copyright © 2016年 楚广明. All rights reserved.
//

#import "ViewController.h"
#import "HKHealthStore+AAPLExtensions.h"

// A mapping of logical sections of the table view to actual indexes.
typedef NS_ENUM(NSInteger, AAPLProfileViewControllerTableViewIndex) {
    AAPLProfileViewControllerTableViewIndexAge = 0,
    AAPLProfileViewControllerTableViewIndexHeight,
    AAPLProfileViewControllerTableViewIndexWeight
};
@interface ViewController ()
@property(nonatomic) NSString *ageUnitLabel;
@property(nonatomic) NSString *ageValueLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Set up an HKHealthStore, asking the user for read/write permissions. The profile view controller is the
    // first view controller that's shown to the user, so we'll ask for all of the desired HealthKit permissions now.
    // In your own app, you should consider requesting permissions the first time a user wants to interact with
    // HealthKit data.
    self.healthStore = [[HKHealthStore alloc] init];
    if ([HKHealthStore isHealthDataAvailable]) {
        NSLog(@"支持");
        
        NSSet *writeDataTypes = [self dataTypesToWrite];
        NSSet *readDataTypes = [self dataTypesToRead];
        
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the user interface based on the current user's health information.
                
                
                // Set the user's age unit (years).
                _ageUnitLabel = NSLocalizedString(@"Age (yrs)", nil);
                
                NSError *error;
                NSDate *dateOfBirth = [self.healthStore dateOfBirthWithError:&error];
                
                if (!dateOfBirth) {
                    NSLog(@"Either an error occured fetching the user's age information or none has been stored yet. In your app, try to handle this gracefully.");
                    
                    _ageValueLabel = NSLocalizedString(@"Not available", nil);
                }
                else {
                    // Compute the age of the user.
                    NSDate *now = [NSDate date];
                    
                    NSDateComponents *ageComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:dateOfBirth toDate:now options:NSCalendarWrapComponents];
                    
                    NSUInteger usersAge = [ageComponents year];
                    
                    _ageValueLabel = [NSNumberFormatter localizedStringFromNumber:@(usersAge) numberStyle:NSNumberFormatterNoStyle];
                }
                
                NSLog(@"%@ %@",_ageUnitLabel,_ageValueLabel);

            });
        }];
    }
}
#pragma mark - HealthKit Permissions

// Returns the types of data that Fit wishes to write to HealthKit.
- (NSSet *)dataTypesToWrite {
    HKQuantityType *dietaryCalorieEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
    HKQuantityType *activeEnergyBurnType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    
    return [NSSet setWithObjects:dietaryCalorieEnergyType, activeEnergyBurnType, heightType, weightType, nil];
}

// Returns the types of data that Fit wishes to read from HealthKit.
- (NSSet *)dataTypesToRead {
    HKQuantityType *dietaryCalorieEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
    HKQuantityType *activeEnergyBurnType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKCharacteristicType *birthdayType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    HKCharacteristicType *biologicalSexType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
    
    return [NSSet setWithObjects:dietaryCalorieEnergyType, activeEnergyBurnType, heightType, weightType, birthdayType, biologicalSexType, nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
