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
import RealmSwift


class ViewController: UIViewController, MKMapViewDelegate ,CLLocationManagerDelegate, UITextFieldDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    let annotation = MKPointAnnotation()
    
    var myLocationManager:CLLocationManager = CLLocationManager()
    
    var location = CGPoint()
    var mapPoint = CLLocationCoordinate2D()
    
    
    @IBOutlet var todoTextField: UITextField!

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  
        if(todoTextField.isFirstResponder){
            todoTextField.resignFirstResponder()
        }
    }


        @IBAction func cancel() {
    
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLocationManager = CLLocationManager()
        
        
        //位置情報使用許可のリクエストを表示
        myLocationManager.requestWhenInUseAuthorization()
        
        //ユーザーの位置を中心に
        //mapView.setCenter(mapView.userLocation.coordinate, animated: true)
        

        mapView.mapType = MKMapType.standard
        //mapView.mapType = MKMapType.satellite
        //mapView.mapType = MKMapType.hybrid
        
        mapView.userTrackingMode = MKUserTrackingMode.follow
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
            
            mapView.delegate = self
            
            myLocationManager.delegate = self
            
        }
        

        var pinByLongPress:MKPointAnnotation!
        
        func viewDidLoad() {
            
            
            super.viewDidLoad()
            
            //CLLocationManagerをインスタンス化
            myLocationManager = CLLocationManager()
            
            
            //位置情報使用許可のリクエストを表示
            myLocationManager.requestWhenInUseAuthorization()
            
            
        }

        
    }
    
    
    //マップビュー長押し時の呼び出しメソッド
    @IBAction func pressMap(sender: UILongPressGestureRecognizer) {
        
        let center = CLLocationCoordinate2DMake(35.0, 140.0)
        
        //表示範囲
        let span = MKCoordinateSpanMake(1.0, 1.0)
        
        //中心座標と表示範囲をマップに登録する。
        let region = MKCoordinateRegionMake(center, span)
        mapView.setRegion(region, animated:true)
        
        //ピンを作成してマップビューに登録する。
        annotation.coordinate = CLLocationCoordinate2DMake(35.0, 140.0)
        annotation.title = "ピン"
        annotation.subtitle = "\(annotation.coordinate.latitude), \(annotation.coordinate.longitude)"
        mapView.addAnnotation(annotation)
        
        //デリゲート先に自分を設定する。
        mapView.delegate = self
        
        if (sender.state == UIGestureRecognizerState.ended){
            
            location = sender.location(in: mapView)
            mapPoint = mapView.convert(location, toCoordinateFrom: mapView)

            //ピンの座標とサブタイトルを更新する。
            annotation.coordinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
            annotation.subtitle = "\(annotation.coordinate.latitude), \(annotation.coordinate.longitude)"
        }
        
        var tapLocation: CGPoint = CGPoint()
        
        func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            // タッチイベントを取得する
            let touch = touches.first
            // タップした座標を取得する
            tapLocation = touch!.location(in: self.view)

        }
    }
    
    
    
    //アノテーションビューを返すメソッド
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let testView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        //吹き出しを表示可能にする。
        testView.canShowCallout = true
        
        return testView
    }
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        let newTodo = Item()
        
        // textFieldに入力したデータをnewTodoのtitleに代入
        newTodo.name = todoTextField.text!
        
        // 上記で代入したテキストデータを永続化
        do{
            let realm = try Realm()
            try realm.write({ () -> Void in
                realm.add(newTodo)
                print("ToDo Saved")
            })
        }catch{
            print("Save is Faild")
        }
        self.dismiss(animated: true, completion: nil) 
    }
}
            
