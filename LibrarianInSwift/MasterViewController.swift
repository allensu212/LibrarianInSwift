//
//  ViewController.swift
//  LibrarianInSwift
//
//  Created by Wei-Lun Su on 2015/8/24.
//  Copyright (c) 2015年 allensu. All rights reserved.
//

import UIKit
import QuartzCore

class MasterViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBookButton: UIButton!
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: UIUpdate
    
    func configureUI(){
        self.navigationItem.rightBarButtonItem = editButtonItem();
        
        addBookButton.layer.cornerRadius = self.addBookButton.frame.size.width / 2
        addBookButton.layer.shadowColor = UIColor.darkGrayColor().CGColor
        addBookButton.layer.shadowOpacity = 0.7
        addBookButton.layer.shadowOffset = CGSizeMake(0.5, 0.5)
        addBookButton.layer.shadowRadius = 4.0
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            tableView.setEditing(true, animated: true)
        }else {
            tableView.setEditing(false, animated: true)
        }
    }
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
