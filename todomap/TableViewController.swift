//
//  TableViewController.swift
//  todomap
//
//  Created by 森川彩音 on 2018/02/11.
//  Copyright © 2018年 森川彩音. All rights reserved.
//

import UIKit
import RealmSwift


class TableViewController: UITableViewController {
    
    var todoitem: Results<Item>!
    let realm = try! Realm()
    var cellnames: Results<Item>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellnames = realm.objects(Item.self)
    }
    
    
    // Do any additional setup after loading the view.
    
    
    func viewWillAppear(animated: Bool) {
        
        viewWillAppear(animated: animated)
        cellnames = realm.objects(Item.self)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
    }
    
    // Dispose of any resources that can be recreated.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cellnames.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = cellnames[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

            if editingStyle == UITableViewCellEditingStyle.delete {
                
                
                // これはRealmSwiftでデータを削除しているケース
                let deleteHistory = self.result!
                
                try! realm!.write {
                    realm!.delete(deleteHistory)
                }
                self.さtable.reloadData()
                
                
            }
        }
}

/*sd^
 
 
 
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
