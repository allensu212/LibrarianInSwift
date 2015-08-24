//
//  ViewController.swift
//  LibrarianInSwift
//
//  Created by Wei-Lun Su on 2015/8/24.
//  Copyright (c) 2015年 allensu. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
}

extension MasterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCellWithIdentifier("bookCell", forIndexPath: indexPath) as! BookTableViewCell
        
        //TODO: Configure cell with book object
        let book = Book(bookTitle: "iOS Programming 2", author: "Ray Wenderlich", publisher: "", categories: "", url: "", lastCheckedOut: "", lastCheckedOutBy: "")
        bookCell.configureCell(book)

        return bookCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}
