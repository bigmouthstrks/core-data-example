//
//  ViewController.swift
//  EjemploCoreData
//
//  Created by Benjamin Cáceres on 29-11-21.
//

import UIKit
import CoreData

// MARK: - UIViewController
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cd = CoreDataManager.shared
        let context = cd.persistentContainer.viewContext
        
        if context == nil {
            print("NULO")
        } else {
            print("NO NULO")
        }
    }
}

// MARK: - ViewController
extension ViewController {
    func getAudits() {
        let coreData = CoreDataManager.shared
        let result = coreData.getAudits()
        
        print(result[4].extraData)
    }
    
    func storeAudit() {
        let coreData = CoreDataManager.shared
        
        let audit = Audit(context: coreData.getContext())
        audit.localId = "WEAITA NOMAS"
        
        coreData.store(audit: audit)
    }
}

// MARK: - CoreDataManager
final class CoreDataManager {
    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Audit")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
}

// MARK: - CoreDataManager
extension CoreDataManager {
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getAudits() -> [Audit] {
        let context = persistentContainer.viewContext
        let request = Audit.fetchRequest()
        var results: [Audit] = []
        
        do {
            results = try context.fetch(request)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return results
    }
    
    func store(audit: Audit) {
        let context = persistentContainer.viewContext
        
        do {
            context.insert(audit)
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func store<T: NSManagedObject>(object: T) {
        let entityName = "\(type(of: object))"
        
        let context = persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return }
        
        let objectToStore = Audit(entity: entity, insertInto: context)
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

// MARK: - String
extension String {
    static var localId: String { return "localId" }
    static var auditType: String { return "auditType" }
    static var platform: String { return "platform" }
    static var application: String { return "application" }
    
    static var source: String { return "source" }
    static var transaction: String { return "transaction" }
    static var location: String { return "location" }
    static var extraData: String { return "extraData" }
}
