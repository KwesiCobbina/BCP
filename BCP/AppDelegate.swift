//
//  AppDelegate.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 02/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import Locksmith
import CoreData
import UserNotifications
import Firebase
import FirebaseMessaging
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		FirebaseApp.configure()
		if Locksmith.loadDataForUserAccount(userAccount: "userAccount") != nil {
			let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
			let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeTabViewController") as! UITabBarController
//			viewController.selectedIndex = 3 
			window!.rootViewController = viewController
			window!.makeKeyAndVisible()
			UINavigationBar.appearance().tintColor = UIColor.white
			UINavigationBar.appearance().barTintColor = UIColor.red
			UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
			if #available(iOS 10.0, *) {
				
				UNUserNotificationCenter.current().delegate = self
				let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
				UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { (_, _) in})
				
				
				
			} else {
				
				let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
				application.registerUserNotificationSettings(settings)
				
			}
			application.registerForRemoteNotifications()
			Messaging.messaging().delegate = self
			UNUserNotificationCenter.current().delegate = self
			
		}
		else {
            let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
                        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        window!.rootViewController = viewController
                        window!.makeKeyAndVisible()
		}
		IQKeyboardManager.shared.enable = true
		return true
	}
	
//	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//		<#code#>
//	}
	
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		let application = UIApplication.shared
		
		if(application.applicationState == .active){
			print("user tapped the notification bar when the app is in foreground")
			
		}
		
		if(application.applicationState == .inactive)
		{
			print("user tapped the notification bar when the app is in background")
		}
		
		let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let presentViewController = storyBoard.instantiateViewController(withIdentifier: "InterestsViewController") as! MyInterestsViewController
//		presentViewController.yourDict = userInfo //pass userInfo data to viewController
		//self.window?.rootViewController = presentViewController
		//self.window?.rootViewController!.present(presentViewController, animated: true, completion: nil)
		self.window?.rootViewController!.navigationController?.pushViewController(presentViewController, animated: true)


		
		
		completionHandler()
	}
	
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {

		let VC: HomeTabViewController = HomeTabViewController()
		let token = Messaging.messaging().fcmToken as AnyObject
		VC.postToken(Token: token as! String)

	}
	
	
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		//		#if DEVELOPMENT
		//Develop
		Messaging.messaging().setAPNSToken(deviceToken as Data, type: .sandbox)
		//		#else
		//Production
//		Messaging.messaging().setAPNSToken(deviceToken as Data, type: .prod)
		//		#endif
//		let token = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
//		print("APNs device token: \(token)")
	}

	
	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
		
		print(userInfo)
	}
	
	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
		
		// Print the error to console (you should alert the user that registration failed)
		
		print("APNs registration failed: \(error)")
	}
	
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
		let defaultValues = UserDefaults.standard
		//let private_individual = defaultValues.string(forKey: "userType")
//		if Locksmith.loadDataForUserAccount(userAccount: "userAccount") != nil {
		let BCP_userID = defaultValues.string(forKey: "userID")
		//let userId = "1"
		let count = "0";
		UIApplication.shared.applicationIconBadgeNumber = 0
		//		#if DEVELOPMENT
		//Develop
		if BCP_userID != nil {
//			let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/refresh_count.php")
			let url = URL(string: "\(AppConstants.sharedInstance.prodURL)refresh_count.php")
			//		#else
			//Production
			//let url = URL(string: "https://bcp.gov.gh/refresh_count.php")
			
			var request = URLRequest(url: url!)
			request.httpMethod = "POST"


			let params = "count=\(count)&userId=\(BCP_userID!)"
			request.httpBody = params.data(using: String.Encoding.utf8)
			let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
				guard let _ = data,
					error == nil else {
						print(error?.localizedDescription ?? "Response Error")
						return }
				do{
					let decoder = JSONDecoder()
					let res = try decoder.decode(ErrorData.self, from: data!)
					print(res.message!)

				} catch let parsingError {
					print("Error", parsingError)
				}
			}
			task.resume()
		}
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	//	self.saveContext()
	}
    
    
    /**
	
	lazy var persistentContainer: NSPersistentContainer = {
		/*
		The persistent container for the application. This implementation
		creates and returns a container, having loaded the store for the
		application to it. This property is optional since there are legitimate
		error conditions that could cause the creation of the store to fail.
		*/
		let container = NSPersistentContainer(name: "Ghana_Business_Consultation")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				
				/*
				Typical reasons for an error here include:
				* The parent directory does not exist, cannot be created, or disallows writing.
				* The persistent store is not accessible, due to permissions or data protection when the device is locked.
				* The device is out of space.
				* The store could not be migrated to the current model version.
				Check the error message to determine what the actual problem was.
				*/
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()

	
	
	func saveContext () {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
**/
	

}

