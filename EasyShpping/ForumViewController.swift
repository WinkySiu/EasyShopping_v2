//
//  NotificationViewController.swift
//  EasyShpping
//
//  Created by Winky_swl on 22/7/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit
import Firebase

class ForumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var imageArray = ["i2-1", "i2-2", "i2-3", "i2-4", "i2-5", "i2-6" ]
    
    @IBOutlet weak var chooseView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var hotButton: UIButton?
    var newButton: UIButton?
    var choose: UIView?
    
    var area = UIButton()
    var food = UIButton()
    var sport = UIButton()
    var life = UIButton()
    var fun = UIButton()
    var all = UIButton()
    var blackview  :UIView?
    var cates = "全部"
    var buttonview: UIView?
    
    var right_menu_button: UIBarButtonItem!
    var viewChangre = false
    
    var ref: DatabaseReference!
    var commentRef: DatabaseReference!
    
    var articlesList = [ArticleObject]()
    
    var sortChoice: Bool = true

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //Set tabBarItem image
        self.navigationController?.tabBarItem.selectedImage = UIImage(named: "MessageClicked")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        self.navigationController?.tabBarItem.image = UIImage(named: "Message")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        interfaceInit()
        getData()
    }
    
    func getData(){
        ref = Database.database().reference().child("Forum")
        //observing the data changes
        ref.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                //clearing the list
                self.articlesList.removeAll()
                
                //iterating through all the values
                for data in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let dataObject = data.value as? [String: AnyObject]
                    
                    let articlesTemp = ArticleObject()
                    
                    if self.cates == "全部" {
                        articlesTemp.id = data.key
                        articlesTemp.body  = dataObject?["body"] as? String
                        articlesTemp.category  = dataObject?["category"] as? String
                        articlesTemp.city  = dataObject?["city"] as? String
                        articlesTemp.like  = Int((dataObject?["like"] as? String)!)
                        articlesTemp.subArea  = dataObject?["subArea"] as? String
                        articlesTemp.time  = dataObject?["time"] as? String
                        articlesTemp.title  = dataObject?["title"] as? String
                        articlesTemp.userid = dataObject?["userid"] as? String
                        articlesTemp.userName = dataObject?["userName"] as? String

                        
                        self.commentRef = Database.database().reference().child("Forum").child(articlesTemp.id!).child("comments")
                        
                        self.commentRef.observe(DataEventType.value, with: { (commentSnapshot) in
                            articlesTemp.comments.removeAll()
                            
                            for commentData in commentSnapshot.children.allObjects as! [DataSnapshot] {
                                let commentObject = commentData.value as? [String: AnyObject]
                                let commentTemp = CommentObject()
                                commentTemp.id = commentData.key
                                commentTemp.body = commentObject?["body"] as? String
                                commentTemp.name = commentObject?["name"] as? String
                                
                                articlesTemp.comments.append(commentTemp)
                            }
                        })
                        self.articlesList.append(articlesTemp)
                    }
//                    else if self.cates == "地區" {
//                        
//                        if dataObject?["city"] as? String == ShareManager.sharedInstance.city {
//                            articlesTemp.id = data.key
//                            articlesTemp.body  = dataObject?["body"] as? String
//                            articlesTemp.category  = dataObject?["category"] as? String
//                            articlesTemp.city  = dataObject?["city"] as? String
//                            articlesTemp.like  = Int((dataObject?["like"] as? String)!)
//                            articlesTemp.subArea  = dataObject?["subArea"] as? String
//                            articlesTemp.time  = dataObject?["time"] as? String
//                            articlesTemp.title  = dataObject?["title"] as? String
//                            articlesTemp.userid = dataObject?["userid"] as? String
//                            articlesTemp.userName = dataObject?["userName"] as? String
//                            
//                            self.commentRef = Database.database().reference().child("articles").child(articlesTemp.id!).child("comments")
//                            
//                            self.commentRef.observe(DataEventType.value, with: { (commentSnapshot) in
//                                articlesTemp.comments.removeAll()
//                                
//                                for commentData in commentSnapshot.children.allObjects as! [DataSnapshot] {
//                                    let commentObject = commentData.value as? [String: AnyObject]
//                                    let commentTemp = CommentObject()
//                                    commentTemp.id = commentData.key
//                                    commentTemp.body = commentObject?["body"] as? String
//                                    commentTemp.name = commentObject?["name"] as? String
//                                    
//                                    articlesTemp.comments.append(commentTemp)
//                                }
//                            })
//                            self.articlesList.append(articlesTemp)
//                        }
//                    }
//                    else if self.cates == dataObject?["category"] as? String {
//                        
//                        articlesTemp.id = data.key
//                        articlesTemp.body  = dataObject?["body"] as? String
//                        articlesTemp.category  = dataObject?["category"] as? String
//                        articlesTemp.city  = dataObject?["city"] as? String
//                        articlesTemp.like  = Int((dataObject?["like"] as? String)!)
//                        articlesTemp.subArea  = dataObject?["subArea"] as? String
//                        articlesTemp.time  = dataObject?["time"] as? String
//                        articlesTemp.title  = dataObject?["title"] as? String
//                        articlesTemp.userid = dataObject?["userid"] as? String
//                        articlesTemp.userName = dataObject?["userName"] as? String
//                        
//                        self.commentRef = Database.database().reference().child("articles").child(articlesTemp.id!).child("comments")
//                        
//                        self.commentRef.observe(DataEventType.value, with: { (commentSnapshot) in
//                            articlesTemp.comments.removeAll()
//                            
//                            for commentData in commentSnapshot.children.allObjects as! [DataSnapshot] {
//                                let commentObject = commentData.value as? [String: AnyObject]
//                                let commentTemp = CommentObject()
//                                commentTemp.id = commentData.key
//                                commentTemp.body = commentObject?["body"] as? String
//                                commentTemp.name = commentObject?["name"] as? String
//                                
//                                articlesTemp.comments.append(commentTemp)
//                            }
//                        })
//                        self.articlesList.append(articlesTemp)
//                    }
                }
                self.tableView.reloadData()
            }
        })
    }

    
    func interfaceInit() {
        navigationBarInit()
        tableViewInit()
        setbuttongroup()
        chooseViewInit()
    }
    
    func tableViewInit() {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    func chooseViewInit() {
        let width = UIScreen.main.bounds.width
        choose = UIView(frame: CGRect(x: 0, y: 47.5, width: width / 2, height: 2.5))
        choose?.backgroundColor = UIColor(colorLiteralRed: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        chooseView.addSubview(choose!)
        
        let chooseWidth = choose?.bounds.width
        let x = (chooseWidth! - 100)/2
        
        hotButton = UIButton(frame: CGRect(x: x, y: 10, width: 100, height: 30))
        hotButton?.setTitle("熱門", for: .normal)
        hotButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        hotButton?.setTitleColor(ShareManager.sharedInstance.textColor, for: .normal)
        hotButton?.addTarget(self, action: #selector(hotOnClick), for: .touchUpInside)
        chooseView.addSubview(hotButton!)
        
        newButton = UIButton(frame: CGRect(x: x + chooseWidth!, y: 10, width: 100, height: 30))
        newButton?.setTitle("最新", for: .normal)
        newButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        newButton?.setTitleColor(ShareManager.sharedInstance.textColor, for: .normal)
        newButton?.addTarget(self, action: #selector(newOnClick), for: .touchUpInside)
        chooseView.addSubview(newButton!)
    }

    func newOnClick() {
        sortChoice = false
        UIView.animate(withDuration: 0.5) {
            let w = UIScreen.main.bounds.width
            self.choose?.frame.origin.x = w / 2
        }
        tableView.reloadData()
    }
    
    func hotOnClick() {
        sortChoice = true
        UIView.animate(withDuration: 0.5) {
            self.choose?.frame.origin.x = 0
        }
        tableView.reloadData()
    }
    
    func navigationBarInit() {
        navigationItem.title = "討論區"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 60/255, green: 196/255, blue: 211/255, alpha: 1)
        
        let left_menu_button = UIBarButtonItem(image: UIImage(named: "sort")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
                                               style: UIBarButtonItemStyle.plain ,
                                               target: self, action: #selector(addcategory))
        self.navigationItem.leftBarButtonItem  = left_menu_button
        
        right_menu_button = UIBarButtonItem(image: UIImage(named: "add")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
                                            style: UIBarButtonItemStyle.plain ,
                                            target: self, action: #selector(addArticle))
        
        self.navigationItem.rightBarButtonItem = right_menu_button
    }
    
    func addArticle() {
        let storyboard = UIStoryboard(name: "Forum", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "articleeditor") as! ArticleEditorViewController
        present(vc, animated: true, completion: nil)
    }
    
    func setbuttongroup(){
        let fullscreen = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        blackview = UIView(frame: fullscreen)
        blackview?.backgroundColor = UIColor(white: 0.15, alpha: 0.9)
        blackview?.alpha = 0
        
        buttonview = UIView(frame: fullscreen)
        buttonview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissblackview)))
        
        
        all = UIButton(frame: CGRect(x: (fullscreen.midX), y: 100, width: 100, height: 50))
        all.setTitle("全部", for: .normal)
        all.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        all.center.x = (fullscreen.midX)
        all.layer.cornerRadius = 5
        all.layer.borderWidth = 1
        all.layer.borderColor = UIColor.white.cgColor
        all.addTarget(self, action: #selector(buttontap(sender:)), for: .touchUpInside)
        
        
        
        area = UIButton(frame: CGRect(x: (fullscreen.midX), y: 180, width: 100, height: 50))
        area.setTitle("地區", for: .normal)
        area.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        area.center.x = (fullscreen.midX)
        area.layer.cornerRadius = 5
        area.layer.borderWidth = 0
        area.layer.borderColor = UIColor.white.cgColor
        area.addTarget(self, action: #selector(buttontap(sender:)), for: .touchUpInside)
        
        food = UIButton(frame: CGRect(x: (fullscreen.midX), y: 260, width: 100, height: 50))
        food.setTitle("商店", for: .normal)
        food.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        food.center.x = (fullscreen.midX)
        food.layer.cornerRadius = 5
        food.layer.borderWidth = 0
        food.layer.borderColor = UIColor.white.cgColor
        food.addTarget(self, action: #selector(buttontap(sender:)), for: .touchUpInside)
        
        
        self.sport = UIButton(frame: CGRect(x: (fullscreen.midX), y: 340, width: 100, height: 50))
        sport.setTitle("男裝", for: .normal)
        sport.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        sport.center.x = (fullscreen.midX)
        sport.layer.cornerRadius = 5
        sport.layer.borderWidth = 0
        sport.layer.borderColor = UIColor.white.cgColor
        sport.addTarget(self, action: #selector(buttontap(sender:)), for: .touchUpInside)
        
        
        self.life = UIButton(frame: CGRect(x: (fullscreen.midX), y: 420, width: 100, height: 50))
        life.setTitle("女裝", for: .normal)
        life.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        life.center.x = (fullscreen.midX)
        life.layer.cornerRadius = 5
        life.layer.borderWidth = 0
        life.layer.borderColor = UIColor.white.cgColor
        life.addTarget(self, action: #selector(buttontap(sender:)), for: .touchUpInside)
        
        
        self.fun = UIButton(frame: CGRect(x: (fullscreen.midX), y: 500, width: 100, height: 50))
        fun.setTitle("其他", for: .normal)
        fun.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        fun.center.x = (fullscreen.midX)
        fun.layer.cornerRadius = 5
        fun.layer.borderWidth = 0
        fun.layer.borderColor = UIColor.white.cgColor
        fun.addTarget(self, action: #selector(buttontap(sender:)), for: .touchUpInside)
        
        self.buttonview?.addSubview(all)
        self.buttonview?.addSubview(area)
        self.buttonview?.addSubview(food)
        self.buttonview?.addSubview(sport)
        self.buttonview?.addSubview(life)
//        self.buttonview?.addSubview(fun)
        
        
        //self.buttonview?.backgroundColor = UIColor.blue
        self.buttonview?.alpha = 0
        
        //self.buttonview?.layer.shouldRasterize = true
        
        self.view.addSubview(buttonview!)
        self.view.addSubview(blackview!)
    }
    
    func addcategory(){
        
        self.view.bringSubview(toFront: buttonview!)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.blackview?.alpha = 1
            self.buttonview?.alpha = 1
        })
        
    }
    
    func buttontap(sender: Any){
        
        let button =  sender as! UIButton
        all.layer.borderWidth = 0
        area.layer.borderWidth = 0
        food.layer.borderWidth = 0
        sport.layer.borderWidth = 0
        life.layer.borderWidth = 0
        fun.layer.borderWidth = 0
        button.layer.borderWidth = 1
        
        cates = button.titleLabel?.text as! String
        print(cates)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, animations: {
            self.blackview?.alpha = 0
            self.buttonview?.alpha = 0
        })
        
    }
    
    func dismissblackview(){
        UIView.animate(withDuration: 0.5, animations: {
            self.blackview?.alpha = 0
            self.buttonview?.alpha = 0
        })
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Forum", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier :"Box") as! BoxArticleViewController
        vc.artcle = articlesList[articlesList.count - indexPath.row - 1]
        
        
        //thread issue
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ForumTableViewCell
        var index: Int = indexPath.row
        
        if sortChoice == false {
            index = articlesList.count - indexPath.row - 1
        }
        
        cell.bgView.layer.masksToBounds = true
        cell.bgView.layer.cornerRadius = 5
        cell.profileImage.image = UIImage(named: imageArray[index % 6])
        cell.profileImage.layer.masksToBounds = true
        cell.profileImage.layer.cornerRadius = 25
        cell.title.text = articlesList[index].title
        cell.title.textColor = ShareManager.sharedInstance.textColor
        cell.username.text = articlesList[index].userName
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    

}
