//
//  ViewController.swift
//  firebaseParctice
//
//  Created by 張書涵 on 2018/9/3.
//  Copyright © 2018年 AliceChang. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class loginVC: UIViewController {

    var name:String = ""
    var email:String = ""
    var userKey:String = ""
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    
    @IBAction func doneBtn(_ sender: Any) {
        UserDefaults.standard.set("\(email)", forKey: "email")
        
        if emailText.text?.count == 0 || nameText.text?.count == 0{
            showAlertWith(title: "不能空白啦", message: "白痴")
        }
        
        
        email = emailText.text!
        name = nameText.text!
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        userKey = ref.child("user").childByAutoId().key
        let userpost = ["email": email,
                        "name": name]
        let childUpdates = ["/user/\(userKey)": userpost]
        ref.updateChildValues(childUpdates)
        
        performSegue(withIdentifier: "articleVC", sender: sender)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        let key = ref.child("article").childByAutoId().key
//        let post = ["article_content": "QAQ",
//                    "article_id": "\(key)",
//            "article_tag": "就可",
//            "author": "Alice",
//            "created_time": "31232131"]
//        let childUpdates = ["/article/\(key)": post]
//        ref.updateChildValues(childUpdates)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "articleVC"{
            if let articleVC = segue.destination as? articleVC{
                articleVC.email = email
                articleVC.name = name
                articleVC.userKey = userKey
            }
        }
    }
    
    func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        self.present(alertController, animated: true, completion: nil)
        alertController.addAction(okAction)
    }
    
}






//寫資料進article
//        let key = ref.child("article").childByAutoId().key
//        let post = ["article_content": "??????",
//                    "article_id": "\(key)",
//                    "article_tag": "表特",
//                    "author": "Annie",
//                    "created_time": "31232131"]
//        let childUpdates = ["/article/\(key)": post]
//        ref.updateChildValues(childUpdates)
//
//寫資料進user
//        let key = ref.child("user").childByAutoId().key
//        let userpost = ["email": "Ling@gmail.com",
//                        "name": "Ling",
//                        "userID":"\(key)",
//                        "friend":"-LLTRUArHuVSjxkeCL3j"]
//        let childUpdates = ["/user/\(key)": userpost]
//        ref.updateChildValues(childUpdates)

//load article 資料
//        ref.child("article").observeSingleEvent(of: .value, with: { (snapshot) in
//            let article = snapshot.value as? NSDictionary
//            print(article)
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//

//    let article = ref.child("article")

//    article.setValue()
//.setValue(groceryItem.toAnyObject())

//
//        ref.child("article").observeSingleEvent(of: .value) { (sanpshot) in
//
//        }

//找article中的author的keyAnnie
//        ref.child("article").queryOrdered(byChild: "author").queryStarting(atValue:"Alice")
//            .observeSingleEvent(of: .value, with: { (snapshot) in
//                let value = snapshot.value
//                print(value)
//
//
//            }) { (error) in
//                print(error.localizedDescription)
//        }
//    }
//}
//        let postsByMostPopular = ref.child("article").child("-LLTJEnqrR_S8arM7J5t").child("author").observe(.value) { (snapshot) in
//            print(snapshot)
//
//
// let data = snapshot
//
//          let value = snapshot.value as? NSDictionary
//          print(value?.allKeys(for: "article_content"))


//             for child in snapshot.children {
//               if let title = child.val
//                    child.value["title"] as? String {
//                    print(title)
//                }
//    }
//        }}
//
//
