import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications
import Firebase
import FirebaseMessaging
import FirebaseCore
import flutter_background_service_ios

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
     FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
           GeneratedPluginRegistrant.register(with: registry)
    }

    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }
    GMSServices.provideAPIKey("*************")
    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "com.jploft.binbeardrivers"
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
