//
//  UserEntity+CoreDataProperties.swift
//  Friendface
//
//  Created by Prathamesh Kowarkar on 30/09/20.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: Set<TagEntity>?
    @NSManaged public var friends: Set<FriendEntity>?

}

// MARK: Generated accessors for tags
extension UserEntity {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: TagEntity)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: TagEntity)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: Set<TagEntity>)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: Set<TagEntity>)

}

// MARK: Generated accessors for friends
extension UserEntity {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: FriendEntity)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: FriendEntity)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: Set<FriendEntity>)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: Set<FriendEntity>)

}

extension UserEntity : Identifiable {

}
