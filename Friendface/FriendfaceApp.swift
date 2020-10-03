//
//  FriendfaceApp.swift
//  Friendface
//
//  Created by Prathamesh Kowarkar on 28/09/20.
//

import CoreData
import SwiftUI

@main
struct FriendfaceApp: App {

    let container = FriendfacePersistentContainer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, container.viewContext)
        }
    }
}


class FriendfacePersistentContainer: NSPersistentContainer {

    convenience init() {
        self.init(name: "Friendface")
        loadPersistentStores { (storeDescription, error) in
            guard let error = error as NSError? else { return }
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

}
