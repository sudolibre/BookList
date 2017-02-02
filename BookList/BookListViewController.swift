//
//  ViewController.swift
//  BookList
//
//  Created by Jonathon Day on 2/1/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {
    
    var dataSource: BookListDataSource!
    
    var tableView: UITableView {
        return view as! UITableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.updateBooks(tableView: tableView)
    }
}

class BookListDataSource: NSObject, UITableViewDataSource {
    private let bookStore: BookStore
    private let reuseID = "bookCell"
    
    func updateBooks(tableView: UITableView) {
        bookStore.fetchBooks { 
            tableView.reloadData()
        }
    }
    
    internal var books: [Book] {
        return bookStore.books
    }
    
    //MARK: Tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID)!
        let book = books[indexPath.row]
        
        cell.textLabel?.text = book.title!
        if let author = book.author {
        cell.detailTextLabel?.text = author
        } else {
            cell.detailTextLabel?.text = ""
        }
        
        cell.imageView?.image = UII
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    init(bookStore: BookStore) {
        self.bookStore = bookStore
    }
}

