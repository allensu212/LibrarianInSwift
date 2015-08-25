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
    }
    
    func updateUI(book: Book){
        bookTitleLabel.text = book.bookTitle;
        authorLabel.text = book.author;
        bookTitleLabel.font = UIFont(name: FONT_MAIN, size: 16)
        authorLabel.font = UIFont(name: FONT_MAIN, size: 14)
        //[self configureTextViewUIFromBook:book];
    }
}
