//
//  NetworkManager.swift
//  LibrarianInSwift
//
//  Created by Wei-Lun Su on 2015/8/24.
//  Copyright (c) 2015年 allensu. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    
    //MARK: Singleton
    class var sharedManager: NetworkManager {
        struct Singleton {
            static let instance = NetworkManager()
        }
        return Singleton.instance
    }
    
    //MARK: Fetch
    
    func fetchBook(completionBlock: [Book] ->Void){
        let url = NSURL(string: "\(ENDPOINT_URL)/books")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let request = NSURLRequest(URL: url!)
        
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                var booksArray = Array<Book>()
                let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSArray
                for jsonDict in jsonArray {
                    let book = Book(
                        bookTitle: jsonDict["title"] as! String,
                        author: jsonDict["author"] as! String,
                        publisher: jsonDict["publisher"] as! String,
                        categories: jsonDict["categories"] as! String,
                        url: jsonDict["url"] as! String,
                        lastCheckedOut: jsonDict["lastCheckedOut"] as! String,
                        lastCheckedOutBy: jsonDict["lastCheckedOutBy"] as! String)
                    booksArray.append(book)
                }
                completionBlock(booksArray)
            }
        })
        dataTask.resume()
    }
    
    //MARK: Delete
    
    func delete(book: Book, completionBlock: Void ->Void){
        let url = NSURL(string: "\(ENDPOINT_URL)" + "\(book.url!)")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "DELETE"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                completionBlock()
            }else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let alertView = UIAlertView(title: "Error", message: "Could Not Complete the Operation", delegate: nil, cancelButtonTitle: nil)
                    alertView.show()
                })
            }
        })
        
        dataTask.resume()
    }
    
    //MARK: Add
    
    //MARK: Update
    
}