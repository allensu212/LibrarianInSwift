//
//  AddBookViewController.swift
//  LibrarianInSwift
//
//  Created by Wei-Lun Su on 2015/8/25.
//  Copyright (c) 2015年 allensu. All rights reserved.
//

import UIKit

enum NewBookInfoType: Int {
    case INFO_BOOK_TITLE = 0
    case INFO_BOOK_AUTHOR
    case INFO_BOOK_PUBLISHER
    case INFO_BOOK_CATEGORIES
}

class AddBookViewController: UIViewController {
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var categoriesTextField: UITextField!
    
    var userIsEditingTextField = false
    var userIsUpdatingBook = false
    var currentBook = Book(bookTitle: "", author: "", publisher: "", categories: "", url: "", lastCheckedOut: "", lastCheckedOutBy: "")
    
    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        configureNav()
    }
    
    //MARK: UISetup
    
    func updateUI(){
        
        for textField in self.view.subviews
        {
            textField.layer.shadowColor = UIColor.darkGrayColor().CGColor
            textField.layer.shadowOpacity = 0.7
            textField.layer.shadowOffset = CGSizeMake(0.1, 0.3)
            textField.layer.shadowRadius = 1.0
        }
        actionButton.layer.cornerRadius = actionButton.frame.size.width / 2;
    }
    
    func configureNav(){
        if (userIsUpdatingBook == true) {
            navigationItem.title = "Edit Book"
            fillOutTextFields(currentBook)
        }else {
            navigationItem.title = "Add Book"
        }
    }
    
    func fillOutTextFields(book: Book){
        
        let formattedPublisherString = book.publisher ?? "Default"
        let formattedCategoriesString = book.categories ?? "Default"
        bookTitleTextField.text = book.bookTitle;
        authorTextField.text = book.author;
        publisherTextField.text = formattedPublisherString;
        categoriesTextField.text = formattedCategoriesString;
    }
    
    //MARL: Networking
    
    func addBook(){
        NetworkManager.sharedManager.add(currentBook, completionBlock: {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.userIsEditingTextField = false
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        })
    }
    
    
    //MARK: IBAction
    
    @IBAction func submitNewBook() {
        addBook()
    }
    
    @IBAction func done(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension AddBookViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(textField: UITextField) {
        let trimmedString = textField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let infoType = textField.tag
        
        switch (infoType) {
        case 0:
            currentBook.bookTitle = trimmedString;
            break;
        case 1:
            currentBook.author = trimmedString;
            break;
        case 2:
            currentBook.publisher = trimmedString;
            break;
        case 3:
            currentBook.categories = trimmedString;
            break;
        default:
            break;
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let infoType = textField.tag;
        
        switch (infoType) {
        case 0:
            self.currentBook.bookTitle = textField.text;
            break;
        case 1:
            self.currentBook.author = textField.text;
            break;
        case 2:
            self.currentBook.publisher = textField.text;
            break;
        case 3:
            self.currentBook.categories = textField.text;
            break;
        default:
            break;
        }
        userIsEditingTextField = true;
        
        return true
    }
}
