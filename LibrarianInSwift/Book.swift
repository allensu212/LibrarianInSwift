//
//  Book.swift
//  LibrarianInSwift
//
//  Created by Wei-Lun Su on 2015/8/24.
//  Copyright (c) 2015年 allensu. All rights reserved.
//

import Foundation

class Book {
    var bookTitle: String?
    var author: String?
    var publisher: String?
    var categories: String?
    var url: String?
    var lastCheckedOut: String?
    var lastCheckedOutBy: String?
    
    init(bookTitle: String, author: String, publisher: String, categories: String, url: String, lastCheckedOut: String, lastCheckedOutBy: String){
        self.bookTitle = bookTitle
        self.author = author
        self.categories = categories
        self.url = url
        self.lastCheckedOut = lastCheckedOut
        self.lastCheckedOutBy = lastCheckedOutBy
    }
}