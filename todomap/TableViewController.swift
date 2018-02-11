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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            let; realm = try Realm()
            todoitem = Realm.objects(Item)
            tableView.reloadData()
        }catch{
            
        }
            
        }

        // Do any additional setup after loading the view.
    }

    func viewWillAppear(animated: Bool) {
    viewWillAppear(animated: animated)
    tableView.reloadData()
}

    func didReceiveMemoryWarning() {
    didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


func tableView(tableView: UITableView, cellForRowAtIndexPath indexpath: NSIndexPath)->UITableViewCell {
    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
    
    let object = [indexpath.row]
    
    cell.textLabel?.text = object.count
    return cell
}

// TableViewのCellの削除を行った際に、Realmに保存したデータを削除する
func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    
    if(editingStyle == UITableViewCellEditingStyle.delete) {
        do{
            let realm = try Realm()
            try realm.write {
                realm.delete (todoItem[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }catch{
        }
        tableView.reloadData()
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


