//
//  TagEntity+CoreDataClass.swift
//  Friendface
//
//  Created by Prathamesh Kowarkar on 29/09/20.
//
//

import Foundation
import CoreData

extension CodingUserInfoKey {

    static let managedObjectContext = Self(rawValue: "managedObjectContext")!

}

enum DecoderConfigurationError: Error {

    case missingManagedObjectContext

}

struct CodingKeys: CodingKey, ExpressibleByStringLiteral {

    var stringValue: String
    var intValue: Int?

    init(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = Int(stringValue)
    }

    init(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }

    init(stringLiteral value: String) {
        self.init(stringValue: value)
    }

}

@objc(TagEntity)
public class TagEntity: NSManagedObject, Decodable {

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)
        self.name = try decoder.singleValueContainer().decode(String.self)
    }

}
