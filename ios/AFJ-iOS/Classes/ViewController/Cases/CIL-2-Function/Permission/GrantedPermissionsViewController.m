//
//  GrantedPermissionsViewController.m
//  ISHPermissionKitSampleApp
//
//  Created by Felix Lamouroux on 10.06.16.
//  Copyright © 2016 iosphere GmbH. All rights reserved.
//

#import "GrantedPermissionsViewController.h"
#import "AppDelegate.h"
#import <ISHPermissionKit/ISHPermissionRequest+All.h>
#import "SamplePermissionViewController.h"

@import Accounts;
@import HealthKit;

NSString * const GrantedPermissionsViewControllerCell = @"cell";
NSInteger const RequestabalePermissionsSection = 1;

@interface GrantedPermissionsViewController ()
@property NSArray *permissionsNotRequestable;
@property NSArray *permissionsRequestable;
@end

@implementation GrantedPermissionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.400 green:0.800 blue:1.000 alpha:1.000]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:GrantedPermissionsViewControllerCell];
    [self reloadPermissionsUsingDataSource:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, self.bottomLayoutGuide.length, 0);
}

- (void)reloadPermissionsUsingDataSource:(id<ISHPermissionsViewControllerDataSource>)datasource {
    NSArray *allPermissions = [[self class] requiredPermissions];
    ISHPermissionsViewController *viewControllerForStateQueries = [ISHPermissionsViewController permissionsViewControllerWithCategories:allPermissions
                                                                                                                             dataSource:datasource];

    NSArray *requestablePermissions = [viewControllerForStateQueries permissionCategories] ?: @[];

    self.permissionsRequestable = [requestablePermissions sortedArrayUsingSelector:@selector(compare:)];
    NSMutableSet *permissionsNotRequestable = [NSMutableSet setWithArray:allPermissions];
    [permissionsNotRequestable minusSet:[NSSet setWithArray:requestablePermissions]];
    self.permissionsNotRequestable = [[permissionsNotRequestable allObjects] sortedArrayUsingSelector:@selector(compare:)];
    [self.tableView reloadData];
}

- (NSArray *)permissionsForSection:(NSInteger)section {
    if (section == RequestabalePermissionsSection) {
        return self.permissionsRequestable;
    }

    return self.permissionsNotRequestable;
}

- (NSNumber *)permissionAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *permissions = [self permissionsForSection:indexPath.section];

    if (indexPath.row >= permissions.count) {
        return nil;
    }

    return [permissions objectAtIndex:indexPath.row];
}

#pragma mark UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self permissionsForSection:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == RequestabalePermissionsSection) {
        return @"Requestable";
    }

    return @"Not requestable";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GrantedPermissionsViewControllerCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSNumber *permission = [self permissionAtIndexPath:indexPath];

    if (permission) {
        cell.textLabel.text = ISHStringFromPermissionCategory(permission.unsignedIntegerValue);
    } else {
        cell.textLabel.text = nil;
    }

    UIColor *color = (indexPath.section == RequestabalePermissionsSection) ? [UIColor darkTextColor] : [UIColor lightGrayColor];

    cell.textLabel.textColor = color;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self presentPermissionsIfNeeded];
}

#pragma mark -

+ (NSArray<NSNumber *> *)requiredPermissions {
    // The demo app requests all supported permissions. Those that
    // require special capabilities have been commented out since
    // they require additional configuration in Xcode.
    return @[
             @(ISHPermissionCategoryActivity),

             // requires Health capability & entitlements
             // @(ISHPermissionCategoryHealth),

             // If you want to request both, the order is important,
             // as Always implies WhenInUse, too
             @(ISHPermissionCategoryLocationWhenInUse),
             @(ISHPermissionCategoryLocationAlways),

             @(ISHPermissionCategoryMicrophone),
             @(ISHPermissionCategoryModernPhotoLibrary),
             @(ISHPermissionCategoryPhotoCamera),
             @(ISHPermissionCategoryNotificationLocal),

             // requires Push capability & entitlements to actually work
             @(ISHPermissionCategoryNotificationRemote),

             @(ISHPermissionCategorySocialFacebook),
             @(ISHPermissionCategorySocialTwitter),
             @(ISHPermissionCategorySocialSinaWeibo),
             // TODO: alert cannot be presented
             @(ISHPermissionCategorySocialTencentWeibo),

             @(ISHPermissionCategoryContacts),
             @(ISHPermissionCategoryEvents),
             @(ISHPermissionCategoryReminders),
             @(ISHPermissionCategoryMusicLibrary),

#ifdef NSFoundationVersionNumber_iOS_9_0
             // reqquires Siri capability & entitlements
             // @(ISHPermissionCategorySiri),

             @(ISHPermissionCategorySpeechRecognition),
             @(ISHPermissionCategoryUserNotification),
#endif
             ];
}

#pragma mark ISHPermissionsViewControllerDataSource

- (ISHPermissionRequestViewController *)permissionsViewController:(ISHPermissionsViewController *)vc requestViewControllerForCategory:(ISHPermissionCategory)category {
    return [SamplePermissionViewController new];
}

- (void)permissionsViewController:(ISHPermissionsViewController *)vc didConfigureRequest:(ISHPermissionRequest *)request {
    switch (request.permissionCategory) {
        case ISHPermissionCategoryHealth: {
            ISHPermissionRequestHealth *healthRequest = (ISHPermissionRequestHealth *)([request isKindOfClass:[ISHPermissionRequestHealth class]] ? request : nil);
            HKQuantityType *heartRate = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
            healthRequest.objectTypesRead = [NSSet setWithObjects:heartRate, nil];
            healthRequest.objectTypesWrite = [NSSet setWithObjects:heartRate, nil];
            break;
        }

        case ISHPermissionCategoryNotificationLocal: {
            // the demo app only requests permissions for badges
            UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
            ISHPermissionRequestNotificationsLocal *localNotesRequest = (ISHPermissionRequestNotificationsLocal *)([request isKindOfClass:[ISHPermissionRequestNotificationsLocal class]] ? request : nil);
            [localNotesRequest setNotificationSettings:setting];
            break;
        }

        case ISHPermissionCategorySocialFacebook:
        case ISHPermissionCategorySocialTencentWeibo: {
            ISHPermissionRequestAccount *accountRequest = (ISHPermissionRequestAccount *)([request isKindOfClass:[ISHPermissionRequestAccount class]] ? request : nil);

            NSDictionary *options;
            if ([accountRequest.accountTypeIdentifier isEqualToString:ACAccountTypeIdentifierFacebook]) {
                options = @{
                            ACFacebookAppIdKey: @"YOUR-API-KEY",
                            ACFacebookPermissionsKey: @[@"email", @"user_about_me"],
                            ACFacebookAudienceKey: ACFacebookAudienceFriends,
                            };
            } else if ([accountRequest.accountTypeIdentifier isEqualToString:ACAccountTypeIdentifierTencentWeibo]) {
                options = @{
                            ACTencentWeiboAppIdKey: @"YOUR-API-KEY",
                            };
            }

            [accountRequest setOptions:options];
            break;
        }

        default:
            break;
    }
}

- (void)presentPermissionsIfNeeded {
    NSArray *permissions = [[self class] requiredPermissions];
    ISHPermissionsViewController *permissionsVC = [ISHPermissionsViewController permissionsViewControllerWithCategories:permissions dataSource:self];
 
    __weak GrantedPermissionsViewController *rootVC = self;
    [permissionsVC setCompletionBlock:^{
        [rootVC reloadPermissionsUsingDataSource:self];
    }];
    
    __weak ISHPermissionsViewController *weakPermissionsVC = permissionsVC;
    [permissionsVC setErrorBlock:^(ISHPermissionCategory category, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:ISHStringFromPermissionCategory(category)
                                                                       message:error.localizedDescription
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Too bad" style:UIAlertActionStyleCancel handler:nil]];
        // if weakPermissionsVC still has a parent, present from there else present from root
        UIViewController *presentingVC = weakPermissionsVC.parentViewController ? weakPermissionsVC : rootVC;
        [presentingVC presentViewController:alert animated:YES completion:nil];
    }];

    if (permissionsVC) {
        [[[kAppDelegate window] rootViewController] presentViewController:permissionsVC animated:YES completion:nil];
    }
}

@end
