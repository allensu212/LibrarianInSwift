//
//  AddBookViewController.swift
//  LibrarianInSwift
//
//  Created by Wei-Lun Su on 2015/8/25.
//  Copyright (c) 2015年 allensu. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var categoriesTextField: UITextField!
    
    var userIsEditingTextField = false
    var userIsUpdatingBook = false
    
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
        }else {
            navigationItem.title = "Add Book"
        }
    }
    
    //MARK: IBAction
    
    @IBAction func submitNewBook() {
    }
    
    @IBAction func done(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
