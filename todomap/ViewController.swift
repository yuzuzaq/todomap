import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate ,CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
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
        
        var pinByLongPress:MKPointAnnotation!

        
        //ロングタップを感知したときに呼び出されるメソッド
        func tapkanti(_ sender: UILongPressGestureRecognizer) {
            
            //ロングタップの最初の感知のみ受け取る
            if(sender.state != UIGestureRecognizerState.began){
                return
            }
            
            
            /*　ここから追加 */
            //インスタンス化
            pinByLongPress = MKPointAnnotation()
            
            //ロングタップから位置情報を取得
            let location:CGPoint = sender.location(in: mapView)
            
            //取得した位置情報をCLLocationCoordinate2D（座標）に変換
            let longPressedCoordinate:CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
            
            //ロングタップした位置の座標をピンに入力
            pinByLongPress.coordinate = longPressedCoordinate
            
            //ピンを追加する（立てる）
            mapView.addAnnotation(pinByLongPress)
            /* ここまで追加 */
            
            
        }
    }
    
        
        override func viewDidLoad() {
            super.viewDidLoad()

            
            
            //CLLocationManagerをインスタンス化
            myLocationManager = CLLocationManager()
            
            
            //位置情報使用許可のリクエストを表示
            myLocationManager.requestWhenInUseAuthorization()
            
            //ユーザーの位置を中心に
            mapView.setCenter(mapView.userLocation.coordinate, animated: true)
            
            // 表示タイプを航空写真と地図のハイブリッドに設定
            mapView.mapType = MKMapType.standard
            //        mapView.mapType = MKMapType.satellite
            //mapView.mapType = MKMapType.hybrid
            
            mapView.userTrackingMode = MKUserTrackingMode.follow
        
            func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
                
                mapView.delegate = self
            
                myLocationManager.delegate = self
                

            }
        }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}
