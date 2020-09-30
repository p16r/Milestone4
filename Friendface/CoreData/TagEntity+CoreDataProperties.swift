//
//  TagEntity+CoreDataProperties.swift
//  Friendface
//
//  Created by Prathamesh Kowarkar on 30/09/20.
//
//

import Foundation
import CoreData


extension TagEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TagEntity> {
        return NSFetchRequest<TagEntity>(entityName: "TagEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var users: Set<UserEntity>?

}

// MARK: Generated accessors for users
extension TagEntity {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: UserEntity)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: UserEntity)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: Set<UserEntity>)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: Set<UserEntity>)

}

extension TagEntity : Identifiable {

}
