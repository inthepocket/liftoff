import UIKit
(((CRASHLYTICS_HEADER)))

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      (((CRASHLYTICS_APIKEY)))
      <% if enable_parse %>configureParse(application)<% end %>
      <% if enable_googleanalytics %>configureGoogleAnalytics()<% end %>

      // Override point for customization after application launch.
      return true
    }
    <% if enable_parse %>
    func configureParse(application: UIApplication) {
        Parse.setApplicationId(<#applicationId#>, clientKey: <#clientKey#>)

        registerForPushNotifications(application)
    }

    func registerForPushNotifications(application: UIApplication) {
        if application.respondsToSelector("registerUserNotificationSettings:") {
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert | .Badge | .Sound, categories: nil))
            application.registerForRemoteNotifications()
        } else {
            application.registerForRemoteNotificationTypes(.Alert | .Badge | .Sound)
        }
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        println("Did register for remote notifications with deviceToken \(deviceToken)")

        PFInstallation.currentInstallation().setDeviceTokenFromData(deviceToken)
    }

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        println("Did fail to register for remote notifications with error \(error.localizedDescription)")
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
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
