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

class FavoriteViewController: UIViewController, MKMapViewDelegate ,CLLocationManagerDelegate, UITextFieldDelegate , UISearchBarDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var todoTextField: UITextField!
    @IBOutlet weak var testSearchBar: UISearchBar!
    

    
    var testManager:CLLocationManager = CLLocationManager()
    
    var savedata: UserDefaults = UserDefaults.standard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(todoTextField.isFirstResponder){
            todoTextField.resignFirstResponder()
        }
    }
    @IBAction func SaveMemo() {
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
    
    
    
    @IBAction func longPressMap(_ sender: UILongPressGestureRecognizer) {
        
        //ロングタップの最初の感知のみ受け取る
        if(sender.state != UIGestureRecognizerState.began){
            return
        }
        
        print("long tapped \(tapped)")
        tapped += 1
        
        let location:CGPoint = sender.location(in: mapView)
        
        let longPressedCoordinate:CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
        
        pinByLongPress = MKPointAnnotation()
        
        pinByLongPress.coordinate = longPressedCoordinate
        
        mapView.addAnnotation(pinByLongPress)
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let myPinIdentifier = "PinAnnotationIdentifier"
        
        let myPinview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: myPinIdentifier)
        
        myPinview.animatesDrop = true
        
        myPinview.annotation = annotation
        
        return myPinview
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        myLocationManager = CLLocationManager()
        
        
        //位置情報使用許可のリクエストを表示
        myLocationManager.requestWhenInUseAuthorization()
        
        //ユーザーの位置を中心に
        mapView.setCenter(mapView.userLocation.coordinate, animated: true)
        
        // 表示タイプを航空写真と地図のハイブリッドに設定
        mapView.mapType = MKMapType.standard
        //mapView.mapType = MKMapType.satellite
        //mapView.mapType = MKMapType.hybrid
        
        mapView.userTrackingMode = MKUserTrackingMode.follow
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
            
            mapView.delegate = self
            
            myLocationManager.delegate = self

            
            testSearchBar.delegate = self
            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
    //検索ボタン押下時の呼び出しメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //キーボードを閉じる。
        testSearchBar.resignFirstResponder()
        
        //検索条件を作成する。
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = testSearchBar.text
        
        //検索範囲はマップビューと同じにする。
        request.region = mapView.region
        
        //ローカル検索を実行する。
        let localSearch:MKLocalSearch = MKLocalSearch(request: request)
        localSearch.start(completionHandler: {(result, error) in
            
            for placemark in (result?.mapItems)! {
                if(error == nil) {
                    
                    //検索された場所にピンを刺す。
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(placemark.placemark.coordinate.latitude, placemark.placemark.coordinate.longitude)
                    annotation.title = placemark.placemark.name
                    annotation.subtitle = placemark.placemark.title
                    self.mapView.addAnnotation(annotation)
                    
                } else {
                    //エラー
                    print(error)
                }
            }
        })
    }
    
    
    
}
