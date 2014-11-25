//
//  <%= prefix %>AppDelegate.m
//  <%= project_name %>
//
//  Created by <%= author %> on <%= Time.now.strftime("%-m/%-d/%y") %>
//  Copyright (c) <%= Time.now.strftime('%Y') %> <%= company %>. All rights reserved.
//

#import "<%= prefix %>AppDelegate.h"

<% if enable_parse %>#import <Parse/Parse.h><% end %>

<% if enable_googleanalytics %>#import <GoogleAnalytics-iOS-SDK/GAI.h><% end %>
(((CRASHLYTICS_HEADER)))

@implementation <%= prefix %>AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    (((CRASHLYTICS_APIKEY)))
<% if enable_parse %>    [self registerForPushNotifications:application];<% end %>
<% if enable_googleanalytics %>    [self registerGoogleAnalytics];<% end %>

    return YES;
}
<% if enable_parse %>
#pragma mark - Push Notifications

- (void)registerForPushNotifications:(UIApplication *)application
{
  // Parse (push notifications)

  [Parse setApplicationId:<#applicationId#> clientKey:<#clientKey#>];

  if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
  } else {
    [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
  }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"Did register for remote notifications with deviceToken %@", deviceToken);

    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Did fail to register for remote notifications with error %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
}<% end %>
<% if enable_googleanalytics %>
#pragma mark - Google Analytics

- (void)registerGoogleAnalytics
{
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;

#if DEBUG
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
#endif
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:<#UA-XXXX-Y#>];
}
<% end %>
@end
