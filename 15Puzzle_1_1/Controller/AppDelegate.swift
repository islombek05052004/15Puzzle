//
//  AppDelegate.swift
//  15Puzzle_1_1
//
//  Created by Abdurazzoqov Islombek on 02/06/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RecordsDB")
        container.loadPersistentStores { storeDesc, error in
            if let error = error {
                fatalError("error \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let introPage = IntroPage()
        let nav = UINavigationController(rootViewController: introPage)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
    
    func savecontext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch  {
                let nserror = error as NSError
                fatalError("error saving \(nserror.localizedDescription)")
            }
        }
    }
    
}

