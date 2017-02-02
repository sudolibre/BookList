//
//  Book+CoreDataProperties.swift
//  BookList
//
//  Created by Jonathon Day on 2/1/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book");
    }

    @NSManaged public var author: String?
    @NSManaged public var image_url: NSURL?
    @NSManaged public var title: String?

}
