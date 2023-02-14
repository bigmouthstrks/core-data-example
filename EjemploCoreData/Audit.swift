//
//  Audit.swift
//  EjemploCoreData
//
//  Created by Benjamin Cáceres on 29-11-21.
//

import CoreData
import Foundation

typealias EncodableObject = Encodable & NSManagedObject

// MARK: - Audit
@objc(Audit)
class Audit: EncodableObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Audit> {
        return NSFetchRequest<Audit>(entityName: "Audit")
    }
    
    @NSManaged var localId: String?
    @NSManaged var auditType: String?
    @NSManaged var platform: String?
    @NSManaged var application: String?
    
    @NSManaged var source: Source?
    @NSManaged var transaction: Transaction?
    @NSManaged var location: Location?
    @NSManaged var extraData: ExtraData?
    
    convenience init(context: NSManagedObjectContext) {
        self.init(entity: Audit.entity(), insertInto: context)
    }
}

// MARK: - Source
@objc(Source)
class Source: EncodableObject {
    @NSManaged var trustId: String?
    @NSManaged var appName: String?
    @NSManaged var bundleId: String?
    @NSManaged var connectionType: String?
    @NSManaged var connectionName: String?
    @NSManaged var appVersion: String?
    @NSManaged var deviceName: String?
    @NSManaged var osVersion: String?
    @NSManaged var os: String?
    
    convenience init(context: NSManagedObjectContext) {
        self.init(entity: Source.entity(), insertInto: context)
    }
}

// MARK: - Transaction
@objc(Transaction)
class Transaction: EncodableObject {
    @NSManaged var type: String?
    @NSManaged var result: String?
    @NSManaged var method: String?
    @NSManaged var operation: String?
    @NSManaged var timestamp: Int16
    
    convenience init(context: NSManagedObjectContext) {
        self.init(entity: Transaction.entity(), insertInto: context)
    }
}

// MARK: - Location
@objc(Location)
class Location: EncodableObject {
    @NSManaged var latitude: String?
    @NSManaged var longitude: String?
    
    convenience init(context: NSManagedObjectContext) {
        self.init(entity: Location.entity(), insertInto: context)
    }
}

// MARK: - ExtraData
@objc(ExtraData)
class ExtraData: EncodableObject {
    @NSManaged var identity: Identity?
    
    convenience init(context: NSManagedObjectContext) {
        self.init(entity: ExtraData.entity(), insertInto: context)
    }
}

// MARK: - Identity
@objc(Identity)
class Identity: EncodableObject {
    @NSManaged var dni: String?
    @NSManaged var email: String?
    @NSManaged var lastName: String?
    @NSManaged var firstName: String?
    @NSManaged var phone: String?
    
    convenience init(context: NSManagedObjectContext) {
        self.init(entity: Identity.entity(), insertInto: context)
    }
}
