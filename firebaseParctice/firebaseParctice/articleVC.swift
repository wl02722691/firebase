//
//  articleVC.swift
//  firebaseParctice
//
//  Created by 張書涵 on 2018/9/3.
//  Copyright © 2018年 AliceChang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class articleVC: UIViewController, UITextViewDelegate {
    var friendname = ""
    var ref: DatabaseReference!
    
    var friendKey = "" {
        didSet {
            print("")
        }
        willSet{
            print("")
        }
    }
    var userKey = ""
    var segmentedSender:Int = 0
    var segmentedSenderName = ""
    @IBAction func pushArticleSegement(_ sender: UISegmentedControl) {
        segmentedSender = sender.selectedSegmentIndex
        print(segmentedSender)
        segmentedSenderName = sender.titleForSegment(at: segmentedSender)!
        print(sender.titleForSegment(at: segmentedSender)!)
        
    }
    @IBOutlet weak var pushArticleSegement: UISegmentedControl!
    
    @IBOutlet weak var pushTextView: UITextView!
    
    @IBOutlet weak var pushBtn: UIButton!
    
    
    @IBOutlet weak var titleText: UITextView!
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        pushTextView.text = ""
        titleText.text = ""
    }
    
    @IBAction func pushBtn(_ sender: Any) {

        let timeInterval = NSDate().timeIntervalSince1970
        print(timeInterval)
        
        let textcontent = pushTextView.text!
        print(textcontent)
        
        let titlecontent = titleText.text!
        
        
        ref = Database.database().reference()
        let key = ref.child("article").childByAutoId().key
        let post = ["article_content": "\(textcontent)",
            "article_id": "\(key)",
            "article_tag": "\(segmentedSenderName)",
            "article_title":"\(titlecontent)",
            "author": "\(email)",
            "created_time": "\(timeInterval)",
            "author_article_tag":"\(email)_\(segmentedSenderName)"
        ]

        let childUpdates = ["/article/\(key)": post]
        ref.updateChildValues(childUpdates)
        
        showAlertWith(title: "成功囉", message: "發出去囉水水！", style: .alert)
    }
    
    
    @IBOutlet weak var pullArticleSegement: UISegmentedControl!
    
    
    @IBAction func pullArticleSegement(_ sender: UISegmentedControl) {
        segmentedSender = sender.selectedSegmentIndex
        print(segmentedSender)
        segmentedSenderName = sender.titleForSegment(at: segmentedSender)!
        print(sender.titleForSegment(at: segmentedSender)!)
        
    }
    
    @IBAction func pullSegementBtn(_ sender: UIButton) {
        ref = Database.database().reference()
        print(segmentedSenderName)
        
        ref.child("article").queryOrdered(byChild: "article_tag").queryEqual(toValue:"\(segmentedSenderName)")
            .observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
              
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    
    
    @IBOutlet weak var pullAllBtn: UIButton!
    
    @IBAction func pullAllBtn(_ sender: UIButton) {
        ref = Database.database().reference()
        ref.child("article").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    

    
    @IBOutlet weak var friendText: UITextField!
    
    @IBAction func addFriendBtn(_ sender: UIButton) {
        friendname = friendText.text!
        print(friendname)

        //抓到key firend的key
        
        ref.child("user").queryOrdered(byChild: "email").queryEqual(toValue:"\(friendname)")
            .observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                 if let value = snapshot.value as? NSDictionary{
                self.friendKey = value.allKeys[0] as! String
                print(self.friendKey)
                
                    
                    //加自己的待確認
//                    let userpost = ["email": self.email,
//                                    "name": self.name,
//                                    "\(self.friendKey)": "sender"]
//                    let childUpdates = ["/user/\(self.userKey)": userpost]
//                    self.ref.updateChildValues(childUpdates)
                     self.ref.updateChildValues(["/user/\(self.userKey)/\(self.friendKey)": "sender"])
                    self.ref.updateChildValues(["/user/\(self.friendKey)/\(self.userKey)": "receiver"])
    
                
                }
                    
            }) { (error) in
                print(error.localizedDescription)
        }
//        ref.child("user").queryOrdered(byChild: "email").queryEqual(toValue: "\(friendname)").observeSingleEvent(of: .value, with: { (snapshot) in
//                print(snapshot)
//
////                if let value = snapshot.value as? NSDictionary{
////                    self.firendKey = value.allKeys[0] as! String
////                    print(self.firendKey)
////                }
//
//            }) { (error) in
//                print(error.localizedDescription)
//        }
//
//        print(self.firendKey)
        //自己的地方改成待確認
        
//        let userpost = ["email": email,
//                        "name": name,
//                        "\(firendKey)": "待確認"]
//        let childUpdates = ["/user/\(userKey)": userpost]
//        ref.updateChildValues(childUpdates)
//
//
//        //把對方改成true
//        let friendpost = ["\(userKey)": "true"]
//        let firendchildUpdates = ["/user/\(firendKey)": friendpost]
//        ref.updateChildValues(firendchildUpdates)
//        
////
//        ref = Database.database().reference()
//        firendKey = ref.child("firend").childByAutoId().key
//        let post = ["sendPerson": "\(email)",
//            "receivePerson": "\(friendname)",
//            "invite": "true",
//            "result":"false",
//            "firendKey":"\(firendKey)"
//        ]
//
//        let childUpdates = ["/friend/\(firendKey)": post]
//        ref.updateChildValues(childUpdates)
//
//        print(firendKey)
//
//
//
//
        
        
    }

    
    @IBOutlet weak var addFriendBtn: UIButton!
    
    @IBAction func friendSegument(_ sender: UISegmentedControl) {
        segmentedSender = sender.selectedSegmentIndex
        print(segmentedSender)
        segmentedSenderName = sender.titleForSegment(at: segmentedSender)!
        print(sender.titleForSegment(at: segmentedSender)!)
    }
    
    @IBAction func friendAllBtn(_ sender: UIButton) {
        ref = Database.database().reference()
        friendname = friendText.text!
        print(friendname)
        
        ref.child("article").queryOrdered(byChild: "author").queryStarting(atValue:"\(friendname)")
            .observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                
                if let value = snapshot.value as? NSDictionary{
                    let allKays = value.allKeys
                    print(allKays)
                }
                
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    
    
    @IBAction func friendApartBtn(_ sender: UIButton) {
        ref = Database.database().reference()
        print(segmentedSenderName)
        
        friendname = friendText.text!
        

        print("\(friendname)_\(segmentedSenderName)")
        
        //找
        ref.child("article").queryOrdered(byChild: "author_article_tag").queryEqual(toValue: "\(friendname)_\(segmentedSenderName)").observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
            
              
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    var name:String = ""
    var email:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.delegate = self
        pushTextView.delegate = self

        //監控
        ref = Database.database().reference()
        ref.child("user").child(userKey).observe(.childAdded) { (snapshot) in
            print(snapshot)
            self.friendKey = snapshot.key
            let status = snapshot.value as? String
            print(status)
            //
            print("______")
            print(self.friendKey)
            print(self.userKey)
            print("______")
            
            if status == "receiver"{
                self.friendAlert(title: "你要當我朋友嗎", message: "拜託啦")
            }
            
        }}
    
    
    func no(){
        //加自己的待確認
        ref = Database.database().reference()
        print("userKey:\(self.userKey),friendKey:\(self.friendKey)")
        self.ref.updateChildValues(["/user/\(self.userKey)/\(self.friendKey)": "not friend"])
        self.ref.updateChildValues(["/user/\(self.friendKey)/\(self.userKey)": "not friend"])
    }
    
    func yes(){
        ref = Database.database().reference()
        print("userKey:\(self.userKey),friendKey:\(self.friendKey)")
        self.ref.updateChildValues(["/user/\(self.userKey)/\(self.friendKey)": "friend"])
        self.ref.updateChildValues(["/user/\(self.friendKey)/\(self.userKey)": "friend"])
        
    }
    
    
    func friendAlert(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: style)
     
        let okAction = UIAlertAction(title: "好", style: .default) { (alert) in
            self.yes()
        }
        let noAction = UIAlertAction(title: "不要", style: .default) { (alert) in
            self.no()
        }
        
        self.present(alertController, animated: true, completion: nil)
        alertController.addAction(okAction)
        alertController.addAction(noAction)
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

