//
//  BookDetailViewController.swift
//  LibrarianInSwift
//
//  Created by Wei-Lun Su on 2015/8/24.
//  Copyright (c) 2015年 allensu. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookInfoTextView: UITextView!
    @IBOutlet weak var checkOutButton: UIButton!
    
    var bookObject: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(bookObject)
        configureSubViews()
    }
    
    //MARK: UISetup
    
    func updateUI(book: Book){
        bookTitleLabel.text = book.bookTitle;
        authorLabel.text = book.author;
        bookTitleLabel.font = UIFont(name: FONT_MAIN, size: 16)
        authorLabel.font = UIFont(name: FONT_MAIN, size: 14)
        configureTextView(bookObject)
    }
    
    func configureSubViews(){
        containerView.layer.cornerRadius = 2.0
        containerView.layer.shadowColor = UIColor.darkGrayColor().CGColor
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowOffset = CGSizeMake(0.1, 0.3)
        containerView.layer.shadowRadius = 2.0
        
        checkOutButton.layer.cornerRadius = checkOutButton.frame.size.width / 2
        checkOutButton.layer.shadowColor = UIColor.darkGrayColor().CGColor
        checkOutButton.layer.shadowOpacity = 0.7
        checkOutButton.layer.shadowOffset = CGSizeMake(0.5, 0.5)
        checkOutButton.layer.shadowRadius = 4.0
    }
    
    func configureTextView(book: Book){
        let dateString = book.lastCheckedOut;
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd  HH':'mm':'ss"
        let date = dateFormatter.dateFromString(dateString!)
        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
        let formattedString = dateFormatter.stringFromDate(date!)
        
        let publisherString = book.publisher;
        let formattedPublisherString = bookObject.publisher ?? "Default"
        
        let categoriesString = book.categories;
        let formattedCategoriesString = bookObject.categories ?? "Default"
        
        bookInfoTextView.text = "Publisher: \(formattedPublisherString)\nTags: \(formattedCategoriesString)\n\nLast Checked Out:\n\(book.lastCheckedOutBy!) @ \(formattedString)"
        
        bookInfoTextView.font = UIFont(name: FONT_MAIN, size: 12)
        bookInfoTextView.textColor = UIColor.darkGrayColor()
        bookInfoTextView.textAlignment = NSTextAlignment.Right
    }
    
    //MARK: IBAction
    
    func showShareSheet(){
        let shareController = UIActivityViewController(activityItems: ["This Book is Awesome!!"], applicationActivities: nil)
        presentViewController(shareController, animated: true, completion: nil)
    }
    
}
