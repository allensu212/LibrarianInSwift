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
    var booksDataArray = [Book]()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchBooks()
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
    
    //MARK: Networking
    
    func fetchBooks(){
        NetworkManager.sharedManager.fetchBook({
            (booksArray) in
            self.booksDataArray.removeAll(keepCapacity: true)
            self.booksDataArray = booksArray
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        })
    }
    
    func deleteBookAtIndexPath(indexPath: NSIndexPath){
        let selectedBook = booksDataArray[indexPath.row]
        NetworkManager.sharedManager.delete(selectedBook, completionBlock: {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.booksDataArray.removeAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            })
        })
    }
    
    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBookDetail" {
            let detailController = segue.destinationViewController as! BookDetailViewController
            let indexPath = tableView.indexPathForCell(sender as! BookTableViewCell)
            detailController.bookObject = booksDataArray[indexPath!.row]
        }
    }
}

extension MasterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksDataArray.count
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            deleteBookAtIndexPath(indexPath)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCellWithIdentifier("bookCell", forIndexPath: indexPath) as! BookTableViewCell
        
        let seletedBook = booksDataArray[indexPath.row]
        bookCell.configureCell(seletedBook)

        return bookCell
    }
    
}
