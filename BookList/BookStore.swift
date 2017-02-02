//
//  BookStore.swift
//  BookList
//
//  Created by Jonathon Day on 2/1/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation
import CoreData

class BookStore {
    var books: [Book] = []
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BookList")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error setting up core data \(error)")
            }
        }
        return container
    }()
    
    func fetchBooks(completion: @escaping () -> ()) {
        CalmMountainAPI.getBookList(context: persistentContainer.viewContext) { (result) in
            switch result {
            case .success(let array):
                for dict in array {
                    var book: Book!
                    let context = self.persistentContainer.viewContext
                    context.performAndWait {
                        book = Book(context: context)
                        book.title = dict["title"] as? String
                        if let author = dict["author"] as? String {
                            book.author = author
                        }
                        if let imageURL = dict["image_url"] as? String {
                            book.image_url = NSURL(string: imageURL)
                        }
                    }
                    self.books.append(book)
                }
                completion()
            case .networkError(let response):
                fatalError(response.debugDescription)
            case .systemError(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}
