//
//  AppDelegate.swift
//  DiffableDataSourceDemo
//
//  Created by Jeans Ruiz on 12/12/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(rootViewController: DemosViewController())
    window?.makeKeyAndVisible()

    return true
  }
}
