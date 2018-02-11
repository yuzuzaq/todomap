


//  ListViewController.swift
//  todomap
//
//  Created by 森川彩音 on 2017/11/19.
//  Copyright © 2017年 森川彩音. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController {
    
    var todoItem: Results<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
    func modoru() {
        
        self.dismiss(animated: true, completion: nil)
    }


    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
}
