//
//  LocationPageVC.swift
//  Bookjam
//
//  Created by 박민서 on 2023/08/28.
//

// MARK: - 메인 탭바에서 내 주변 누르면 나오는 위치 기반 검색 화면

import SwiftUI
import UIKit

import SnapKit
import Then

import CoreLocation
import MapKit
import FloatingPanel

// MARK: - 내 주변 탭의 메인 화면입니다
final class LocationPageVC: BaseBottomSheetController {

    // MARK: Variables
    /// 위치 관리 매니저
    private let locationManager = CLLocationManager()
    /// 지도 뷰
    private let mapView = MKMapView()
    /// 유저 위치
    private var userLocation: CLLocationCoordinate2D?
    /// 서점 목록
    private var bookStoreList: [GetPlaceResponseModel]? {
        didSet {
            self.dispatchBookStoreList()
        }
    }
    /// 지도 현재 지도 중심 위치 + 스케일
    private var mapCurrentLocation: MKCoordinateRegion?
    
    /// 화면 상단 서치바
    lazy var searchBar: UISearchBar = UISearchBar().then {
        $0.placeholder = "보고 싶은 장소를 입력해주세요."
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.searchBarStyle = .minimal

        $0.layer.borderColor = main02?.cgColor
        $0.layer.borderWidth = 1
        $0.setSearchFieldBackgroundImage(UIImage(), for: .normal)
    }
    
    /// 목록뷰 상단의 탐색 버튼입니다.
    lazy var currentLocateBtn: UIButton = UIButton().then {
        
        var titleAttr = AttributedString.init("현재 위치로 탐색")
        titleAttr.font = paragraph04

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.baseBackgroundColor = main03
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        // Floating Panel의 위치 설정 관련 함수를 Notification 등록 - Floating Panel의 VC안에서 post
        NotificationCenter.default.addObserver(self, selector: #selector(moveState), name: NSNotification.Name("PanelMove") , object: nil)
        //  서점 디테일뷰 불러오기 요청시 호출되는 Noti - Floating Panel의 VC안에서 post
        NotificationCenter.default.addObserver(self, selector: #selector(presentVC), name: NSNotification.Name("presentVC") , object: nil)
        //  서점 필터 변경 요청시 호출되는 Noti - Floating Panel의 VC안에서 post
        NotificationCenter.default.addObserver(self, selector: #selector(changeFilter), name: NSNotification.Name("changeFilter") , object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegate()
        setUpView()
        setUpLayout()
        setUpConstraint()
        setUpFloatingPanel()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // 본 VC안의 모든 notification 종료
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: View
    func setUpView() {
        self.view.backgroundColor = .white
        
        // 현재 위치 설정
        locationManager.requestWhenInUseAuthorization()  // 권한 확인
        locationManager.startUpdatingLocation() // 위치 업데이트
        locationManager.desiredAccuracy = kCLLocationAccuracyBest   // 가장 높은 정확도의 위치 정보를 요청
        
        // 지도 초기화 설정
        mapView.showsUserLocation = true    // 유저 현재 위치 보이게
        mapView.mapType = MKMapType.standard    // 일반적인 지도 스타일
        mapView.setUserTrackingMode(.follow, animated: true)    // 지도가 사용자의 위치를 따라가는 모드로 전환
        mapView.register(LocationAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)  // 지도에 어노테이션 커스텀 뷰 등록
        mapView.register(LocationDataMapClusterView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)   // 지도에 클러스터 커스텀뷰 등록
        
        // MARK: - add Target
        self.currentLocateBtn.addTarget(self, action: #selector(searchOnCurrentLocation), for: .touchUpInside)
        self.searchBar.searchTextField.addTarget(self, action: #selector(moveToSearchPage), for: .touchDown)
        
        // MARK: - 테스트 데이터를 갖고 핀으로 map에 붙이기
//        test_locations.forEach { data in
//            let pin = MKPointAnnotation()
//            pin.coordinate = data.location
//            pin.title = "TEST"
//            mapView.addAnnotation(pin)
//        }
    }
    
    
    // MARK: Layout
    func setUpLayout() {
        [
            mapView,
            currentLocateBtn,
            searchBar // 상단 서치바는 가려지면 안됩니다.
        ].forEach { self.view.addSubview($0)}
    }
    
    // MARK: Delegate
    func setUpDelegate() {
        locationManager.delegate = self
        mapView.delegate = self
    }
    
    
    // MARK: Constraint
    func setUpConstraint() {
        // 상단 서치바
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        // 지도 뷰
        mapView.snp.makeConstraints {
            $0.top.equalTo(self.searchBar.snp.bottom).offset(20)
            $0.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Floating Panel에서 셀 선택했을 때 호출
    @objc func presentVC(_ sender: Notification) {
        if let placeID = sender.object as? Int {
            GETStoreDetail(selectedPlaceId: placeID)
        }
    }
    
    // MARK: - 현재 위치에서 탐색 눌렀을 때 호출
    @objc func searchOnCurrentLocation() {
        self.locationManager.startUpdatingLocation() // 위치 업데이트
    }
    
    // MARK: - 필터 변경했을 때 호출
    @objc func changeFilter(_ sender: Notification) {
        if let selected = sender.object as? filters {
            GETBookStoreList(sortBy: selected.rawValue, coord: self.userLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
        }
    }
    
    // MARK: - 검색 VC 전환
    @objc func moveToSearchPage() {
        let nextVC = SearchPageVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: - MapView에 Annotation 추가
    private func dispatchBookStoreList() {
        // TODO: 데모데이 끝나고 수정
        if self.mapView.annotations.count < 2 {
            self.bookStoreList?.forEach { model in
                
                if let lat = model.coords?.lat, let lon = model.coords?.lon {
                    let pin = MKPointAnnotation()
                    pin.coordinate = CLLocationCoordinate2D(latitude: Double(lat) ?? 0, longitude: Double(lon) ?? 0)
                    pin.title = model.name
                    pin.subtitle = LocationCategory(rawValue: model.category ?? 0)?.getName_InKorean()
                    self.mapView.addAnnotation(pin)
                }
        }
        
        
            
        }//: forEach
    }//: func
    
}

// MARK: - LocationManagerDelgete 입니다. 위치를 갖고 오고, 이에 따른 추가 작업을 진행합니다.
// MARK: - 본 VC에서는 처음 한번만 호출됩니다.
extension LocationPageVC: CLLocationManagerDelegate {
    
    // 위치가 업데이트 되었을 때 호출됩니다.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // location 가져오기 성공했을 때
        if let userLocation = locations.last?.coordinate {
            // region 설정 - 7km * 7km 반경으로 설정
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 7000, longitudinalMeters: 7000)
            mapView.setRegion(region, animated: false)
            self.userLocation = userLocation
            self.GETBookStoreList(coord: userLocation)
            // loacation 업데이트 종료
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - MKMapViewDelegate 입니다. mapView에서 사용되는 annotation의 기본 내용을 설정합니다.
extension LocationPageVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.mapCurrentLocation = mapView.region
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch annotation {
            
            // 사용자 위치 표시는 따로 처리
        case is MKUserLocation :
            return nil
            
            // 클러스터 뷰인경우
        case is MKClusterAnnotation :
            return LocationDataMapClusterView(annotation: annotation, reuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
            
            // 위치 annotation은 커스텀 이미지로
        default :
            return mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
        }
        
// MARK: - 마커로 annotation
//        if let markerAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "MarkerAnnotation") as? MKMarkerAnnotationView {
//            // 이미 생성된 마커 뷰 재사용
//            markerAnnotationView.annotation = annotation
//            return markerAnnotationView
//        } else {
//            // 새로운 마커 뷰 생성
//            let markerAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MarkerAnnotation")
//            markerAnnotationView.glyphImage = UIImage(systemName: "circle.circle.fill")  // 아이콘 설정
//            markerAnnotationView.markerTintColor = main03  // 색상 설정
//            markerAnnotationView.clusteringIdentifier = "bookStore"
//            return markerAnnotationView
//        }
        
// MARK: - 노란색 핀으로 annotation
//        let reuseIdentifier = "pin"
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
//
//        if annotationView == nil {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
//
//            // 핀 탭하면 상세 정보 팝업
//            annotationView?.canShowCallout = true
//            // 팝업 정보창 오른쪽 뷰 설정
////            let infoButton = UIButton(type: .infoLight)
////            annotationView?.rightCalloutAccessoryView = infoButton
//            annotationView?.pinTintColor = main03
//            annotationView?.clusteringIdentifier = "bookStore"
//        } else {
//            annotationView?.annotation = annotation
//        }
//
//        return annotationView
    }
    
}

// MARK: - Floating Panel
extension LocationPageVC {
    /// Floating Panel의 스크롤 상태를 이동시키는 함수입니다.
    /// 서점 목록 tableView에서 스크롤을 끝까지 올린경우, Notification을 호출하여 해당 함수를 호출합니다.
    @objc func moveState(_ sender: Notification) {
        switch self.fpc.state {
        case .half :
            self.fpc.move(to: .tip, animated: true)
        case .full :
            self.fpc.move(to: .half, animated: true)
        default :
           break
        }
    }
    
    // MARK: - Floating Panel - primary setting
    func setUpFloatingPanel() {
        let BottomContent = BookStoreListViewController()   // 바텀시트에 들어갈 서점 목록 VC
        let BottomSheetDelegateController = StoreListBottomSheetDelegateController(vc: BottomContent) // 서점목록VC 전용 바텀시트 DelegateController 등록
        setupBottomSheet(contentVC: BottomContent, floatingPanelDelegate: BottomSheetDelegateController) // 바텀시트 등록
        
        // 현재위치 버튼 위치는 바텀 시트 윗부분입니다. 해당 부분에서 설정해주어야 합니다.
        currentLocateBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.fpc.surfaceView.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
        }
    }

}

// MARK: - API
extension LocationPageVC {
    
    private func GETBookStoreList(category: Int = 0, sortBy: String = "distance", coord: CLLocationCoordinate2D) {

        let requestParam = getPlaceRequestModel(
            category: category,
            sortBy: sortBy,
            lat: Float(coord.latitude),
            lon: Float(coord.longitude))
        
        APIManager.shared.getData(
            urlEndpointString: Constant.getPlaces,
            responseDataType: APIModel<[GetPlaceResponseModel]>?.self,
            requestDataType: getPlaceRequestModel.self,
            parameter: requestParam,
            completionHandler: { [self]
                response in
                self.bookStoreList = response?.result
                // BookStoreListVC로 데이터 넘기기
                NotificationCenter.default.post(name: NSNotification.Name("handStoreList"), object: self.bookStoreList)
            })
    }
    
    private func GETStoreDetail(selectedPlaceId: Int) {
        APIManager.shared.getData(
            urlEndpointString: Constant.getPlaceId(placeId: selectedPlaceId),
            responseDataType: APIModel<PlaceIdResponseModel>?.self,
            requestDataType: PlaceIdRequestModel.self,
            parameter: nil,
            completionHandler: { [self]
                response in
                let detailPage = BookstoreDetailPageVC()
//                detailPage.navigationController?.navigationBar.isHidden = false
                detailPage.bookStoreDetail = response?.result ?? nil
                self.navigationController?.pushViewController(detailPage, animated: true)
            })
    }
}

// MARK: - preview
//struct LocationPageVC_Preview: PreviewProvider {
//    static var previews: some View {
//        // MARK: - UIViewControllerPreview를 사용하여 tabBarController의 index를 사용합니다
//        UIViewControllerPreview {
//            let tabBarController = TabBarController()
//            tabBarController.selectedIndex = 1
//            return tabBarController
//        }
//    }
//}

// MARK: 테스트 데이터 모델
//struct Location {
//    let location: CLLocationCoordinate2D
//    let isOnline: Bool
//}
//
//// MARK: 테스트 데이터
//let test_locations: [Location] = [
//    Location(location: CLLocationCoordinate2D(latitude: 37.54478472921202, longitude: 126.94673688998076),
//             isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.54439820083342, longitude: 126.948773984529),
//             isOnline: false),
//    Location(location: CLLocationCoordinate2D(latitude: 37.54504947320774, longitude: 126.9550424714841),
//             isOnline: false),
//    Location(location: CLLocationCoordinate2D(latitude: 37.54272316128486, longitude: 126.95069875049849),
//             isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.54580371975873, longitude: 126.9486824957686),
//             isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.54746336131146, longitude: 126.95301543492582),
//             isOnline: false),
//    Location(location: CLLocationCoordinate2D(latitude: 37.54187695023674, longitude: 126.95247580718593),
//             isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.540310515649004, longitude: 126.95583737028332),
//             isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.54111875425007, longitude: 126.94921751985316),
//             isOnline: false),
//    Location(location: CLLocationCoordinate2D(latitude: 37.53979090501977, longitude: 126.94666123767706),
//             isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.54845995224114, longitude: 126.94993678169008),
//             isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.494421166348764, longitude: 126.82028764389928), isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.488346902267495, longitude: 126.81579203804258), isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.49504914992981, longitude: 126.81993141424413), isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.4908971317027, longitude: 126.80895351558094), isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.49158859722595, longitude: 126.81273229448066), isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.49448832262324, longitude: 126.81572773122747), isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.49521139983187, longitude: 126.81864321432767), isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.49686821489078, longitude: 126.81099234551315), isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.49722714555698, longitude: 126.82161664736311), isOnline: true),
//    Location(location: CLLocationCoordinate2D(latitude: 37.48738974689891, longitude: 126.8222710328802), isOnline: true)
//
//]
