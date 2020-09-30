//
//  UserEntity+CoreDataClass.swift
//  Friendface
//
//  Created by Prathamesh Kowarkar on 29/09/20.
//
//

import Foundation
import CoreData

@objc(UserEntity)
public class UserEntity: NSManagedObject, Decodable {

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext]
            as? NSManagedObjectContext
        else { throw DecoderConfigurationError.missingManagedObjectContext }
        self.init(context: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: "id")
        self.name = try container.decode(String.self, forKey: "name")
        self.isActive = try container.decode(Bool.self, forKey: "isActive")
        self.age = try container.decode(Int16.self, forKey: "age")
        self.company = try container.decode(String.self, forKey: "company")
        self.email = try container.decode(String.self, forKey: "email")
        self.address = try container.decode(String.self, forKey: "address")
        self.about = try container.decode(String.self, forKey: "about")
        self.registered = try container.decode(Date.self, forKey: "registered")

        self.tags = try container.decode(Set<TagEntity>.self, forKey: "tags")
        self.tags?.forEach { $0.users?.insert(self) }
//        print(tags)
//        tags.forEach { print($0.users.contains(self)) }
//        print(tags?.map { $0.users?.count })

        self.friends = try container.decode(Set<FriendEntity>.self, forKey: "friends")
        self.friends?.forEach { $0.users?.insert(self) }
//        print(friends)
//        friends.forEach { print($0.user == self) }
//        print(friends.map { $0.user })

//        try decodeTags(with: decoder)
//        try decodeFriends(with: decoder)
        try context.save()
    }

    func decodeTags(with decoder: Decoder) throws {
        let tags = try decoder
            .container(keyedBy: CodingKeys.self)
            .decode([String].self, forKey: "tags")
        if tags.isEmpty { return }

        guard let context = decoder.userInfo[.managedObjectContext]
                as? NSManagedObjectContext
        else { throw DecoderConfigurationError.missingManagedObjectContext }

        let fetchReq: NSFetchRequest<TagEntity> = TagEntity.fetchRequest()
        let tagEntities = try fetchReq.execute()
        tags.map { tag -> TagEntity in
            if let tagEntity = tagEntities.first(where: { tag == $0.name }) {
                return tagEntity
            }
            let tagEntity = TagEntity(context: context)
            tagEntity.name = tag
            return tagEntity
        }.forEach {
            $0.addToUsers(self)
            self.addToTags($0)
        }
//        for tag in tags {
//            let tagEntity: TagEntity
//            if let entity = tagEntities.first(where: { tag == $0.name }) {
//                tagEntity = entity
//            } else {
//                tagEntity = .init(context: context)
//                tagEntity.name = tag
//            }
//            tagEntity.addToUsers(self)
//            self.tags.insert(tagEntity)
//        }
    }

    func decodeFriends(with decoder: Decoder) throws {

        struct Friend: Decodable {
            let id: UUID
            let name: String
        }

        let friends = try decoder
            .container(keyedBy: CodingKeys.self)
            .decode([Friend].self, forKey: "tags")
        if friends.isEmpty { return }

        guard let context = decoder.userInfo[.managedObjectContext]
                as? NSManagedObjectContext
        else { throw DecoderConfigurationError.missingManagedObjectContext }


        let fetchReq: NSFetchRequest<FriendEntity> = FriendEntity.fetchRequest()
        let friendEntities = try fetchReq.execute()
        friends.map { friend -> FriendEntity in
            if let friendEntity = friendEntities.first(where: { friend.id == $0.id }) {
                return friendEntity
            }
            let friendEntity = FriendEntity(context: context)
            friendEntity.id = friend.id
            friendEntity.name = friend.name
            return friendEntity
        }.forEach {
            $0.users?.insert(self)
            self.addToFriends($0)
        }
    }

}
