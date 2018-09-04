//
//  API.swift
//  firebaseParctice
//
//  Created by 張書涵 on 2018/9/3.
//  Copyright © 2018年 AliceChang. All rights reserved.
import Firebase
import FirebaseDatabase

struct GroceryItem {
    let key:String
    let article_id: String
    let article_title: String
    let article_content: String
    let article_tag:String
    let author:String
    let created_time: String
    let ref: DatabaseReference?

    init(key:String,id: String, title: String, content: String, tag: String, author:String, createdtime:String ){
        self.key = key
        self.article_id = id
        self.article_title = title
        self.article_content = content
        self.article_tag = tag
        self.author = author
        self.created_time = createdtime
        self.ref = nil
    
    }

    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        article_id = snapshotValue["article_id"] as! String
        article_title = snapshotValue["article_title"] as! String
        article_content = snapshotValue["article_content"] as! String
        article_tag = snapshotValue["article_content"] as! String
        author = snapshotValue["author"] as! String
        created_time = snapshotValue["created_time"] as! String
        ref = snapshot.ref
        
    }

    func toAnyObject() -> Any {
        return [
            "article_id": article_id,
            "article_content": article_content,
            "article_tag": article_tag,
            "author": author,
            "created_time": created_time,
            "key":key
            
        ]
    }

}
