//
//  AppDelegate.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 31/10/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//configurando a navigationbar
          UINavigationBar.appearance().isTranslucent = false
       
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .meuRoxo()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        let backbutton = UIBarButtonItem.appearance()
        backbutton.tintColor = .white
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        print("Tamanho: \(UIScreen.main.bounds)")
        
        let api = API()
        
        let controller = UINavigationController(rootViewController: ViewController(api: api))
        controller.navigationBar.standardAppearance = appearance;
        controller.navigationBar.scrollEdgeAppearance = controller.navigationBar.standardAppearance
    
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
        
        return true
    
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        DataBaseController.saveContext()
    }
    
}
