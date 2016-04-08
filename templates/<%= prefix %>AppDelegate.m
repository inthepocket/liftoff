//
//  <%= prefix %>AppDelegate.m
//  <%= project_name %>
//
//  Created by <%= author %> on <%= Time.now.strftime("%-m/%-d/%y") %>
//  Copyright (c) <%= Time.now.strftime('%Y') %> <%= company %>. All rights reserved.
//

#import "<%= prefix %>AppDelegate.h"

#import "<%= prefix %>Appearance.h"

#import <CocoaLumberjack/CocoaLumberjack.h>
<% if enable_googleanalytics %>#import <GoogleAnalytics-iOS-SDK/GAI.h><% end %>
(((CRASHLYTICS_HEADER)))

#if DEBUG
    static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
    static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

@implementation <%= prefix %>AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] customizeAppearance];

    [self configureLogging];
<% if enable_push %>    [self configurePushNotifications:application];<% end %>
<% if enable_googleanalytics %>    [self configureGoogleAnalytics];<% end %>

    return YES;
}
<% if enable_push %>
#pragma mark - Push Notifications

- (void)configurePushNotifications:(UIApplication *)application {
    DDLogInfo(@"Configuring Push Notifications");

    [self registerForPushNotifications:application];
}

- (void)registerForPushNotifications:(UIApplication *)application {
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
      UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
      UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
      [application registerUserNotificationSettings:settings];
      [application registerForRemoteNotifications];
    } else {
      [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    DDLogDebug(@"Did register for remote notifications with deviceToken %@", deviceToken);

    // TODO:
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    DDLogError(@"Did fail to register for remote notifications with error %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
  // TODO:
}<% end %>
<% if enable_googleanalytics %>
#pragma mark - Google Analytics

- (void)configureGoogleAnalytics
{
    DDLogInfo(@"Configuring Google Analytics framework");

    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;

#if DEBUG
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
#endif
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:<#UA-XXXX-Y#>];
}
<% end %>
#pragma mark - Logging

- (void)configureLogging
{
    DDLogInfo(@"Configuring CocoaLumberjack framework");

    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
}

@end
