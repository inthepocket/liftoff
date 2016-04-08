//
//  AppDelegate.swift
//  <%= project_name %>
//
//  Created by <%= author %> on <%= Time.now.strftime("%-m/%-d/%y") %>
//  Copyright (c) <%= Time.now.strftime('%Y') %> <%= company %>. All rights reserved.
//

import UIKit
(((CRASHLYTICS_HEADER)))

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      (((CRASHLYTICS_APIKEY)))
      <% if enable_push %>configurePushNotifications(application)<% end %>
      <% if enable_googleanalytics %>configureGoogleAnalytics()<% end %>
      <% if enable_push %>
      // Handle launch options
      if let launchOptions = launchOptions,
          remoteNotification = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey] as? [NSObject : AnyObject] {
              self.application(application, didReceiveRemoteNotification: remoteNotification)
      }
      <% end %>
      return true
    }
    <% if enable_push %>
    // MARK: Push Notifications

    func configurePushNotifications(application: UIApplication) {
        registerForPushNotifications(application)
    }

    func registerForPushNotifications(application: UIApplication) {
        <% if deployment_target < 8 %>if #available(iOS 8.0, *) {
            let userNotificationTypes: UIUserNotificationType = [.Alert, .Badge, .Sound]
            let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
            let remoteNotificationTypes: UIRemoteNotificationType = [.Alert, .Badge, .Sound]
            application.registerForRemoteNotificationTypes(remoteNotificationTypes)
        }<% else %>let userNotificationTypes: UIUserNotificationType = [.Alert, .Badge, .Sound]
        let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()<% end %>
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("Did register for remote notifications with deviceToken \(deviceToken)")

        // TODO: Register deviceToken with push service
    }

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Did fail to register for remote notifications with error \(error.localizedDescription)")
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
      // TODO: Handle push notification
    }
    <% end %><% if enable_googleanalytics %>
    func configureGoogleAnalytics() {
	    // Optional: automatically send uncaught exceptions to Google Analytics.
	    GAI.sharedInstance().trackUncaughtExceptions = true

	    // Initialize tracker. Replace with your tracking ID.
	    GAI.sharedInstance().trackerWithTrackingId(<#UA-XXXX-Y#>)
    }
    <% end %>
}
