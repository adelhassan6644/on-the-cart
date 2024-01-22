import UIKit
import Flutter
import GoogleMaps
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyA2xA7d84QkR0_0OPjdDRLfu--YbjJkSa8")
    GeneratedPluginRegistrant.register(with: self)
    AppCenter.start(withAppSecret: "6e0c0431-d34d-4217-9a6b-64836aba6f84", services:[
      Analytics.self,
      Crashes.self
    ])
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
