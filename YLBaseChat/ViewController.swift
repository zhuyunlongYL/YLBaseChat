//
//  ViewController.swift
//  YLBaseChat
//
//  Created by yl on 17/5/9.
//  Copyright © 2017年 yl. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var tableView = UITableView.init(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
    
    var dataArray = Array<UserInfo>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArray = dataArray + RealmManagers.shared.selectModel(UserInfo.self,predicate: nil)
        
        if dataArray.count == 0 {
            addData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
    }
    
    func addData() {
        
        let userInfo = UserInfo()
        userInfo.nickname = "龙五"
        
        RealmManagers.shared.addSynModel(userInfo)
        
        dataArray = dataArray + RealmManagers.shared.selectModel(UserInfo.self,predicate: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let userInfo = dataArray[indexPath.row]
        
        cell.textLabel?.text = userInfo.nickname
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let baseChatVC = BaseChatVC()
        
        let userInfo = dataArray[indexPath.row]
        
        baseChatVC.userInfo = userInfo
        
        self.navigationController?.pushViewController(baseChatVC, animated: true)
    }
}

