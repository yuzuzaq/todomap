//
//  ViewController.swift
//  todomap
//
//  Created by 森川彩音 on 2017/11/05.
//  Copyright © 2017年 森川彩音. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate ,CLLocationManagerDelegate, UITextFieldDelegate {

    @IBOutlet var todoTextField: UITextField!
    
    var savedata: UserDefaults = UserDefaults.standard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  
        if(todoTextField.isFirstResponder){
            todoTextField.resignFirstResponder()
        }
    }
    @IBAction func saveMemo() {
        savedata.set(todoTextField.text , forKey: "title")
        
    }

    

        @IBAction func cancel() {
    
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        todoTextField.text = textField.text
        return true
    }


    var myLocationManager:CLLocationManager!
    
    //タップされた回数
    var tapped = 1
    
    var pinByLongPress:MKPointAnnotation!
    
    
 }
