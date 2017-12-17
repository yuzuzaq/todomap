//
//  NewPlaceViewController.swift
//  todomap
//
//  Created by 森川彩音 on 2017/12/17.
//  Copyright © 2017年 森川彩音. All rights reserved.
//



import UIKit
import MapKit

class NewPlaceViewController: UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var testSearchBar: UISearchBar!
    @IBOutlet weak var testMapView: MKMapView!
    
    var testManager:CLLocationManager = CLLocationManager()
    
    //最初からあるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //中心座標
        let center = CLLocationCoordinate2DMake(35.690553, 139.699579)
        
        //表示範囲
        let span = MKCoordinateSpanMake(0.001, 0.001)
        
        //中心座標と表示範囲をマップに登録する。
        let region = MKCoordinateRegionMake(center, span)
        testMapView.setRegion(region, animated:true)
        
        //デリゲート先を自分に設定する。
        testSearchBar.delegate = self
    }
    
    
    
    //検索ボタン押下時の呼び出しメソッド
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        //キーボードを閉じる。
        testSearchBar.resignFirstResponder()
        
        //検索条件を作成する。
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = testSearchBar.text
        
        //検索範囲はマップビューと同じにする。
        request.region = testMapView.region
        
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
                    self.testMapView.addAnnotation(annotation)
                    
                } else {
                    //エラー
                    print(error)
                }
            }
        })
    }
}
