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


final class LocationPageVC: BaseBottomSheetController {

    // MARK: Variables
    /// 위치 관리 매니저
    private let locationManager = CLLocationManager()
    /// 지도 뷰
    private let mapView = MKMapView()
    /// 목록 뷰 팬 제스처
    private let panGesture = UIPanGestureRecognizer()
    
    private var listViewCurrentY:CGFloat = 200.0
    
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
    
    /// 화면 하단의 장소 목록 테이블 뷰입니다.
    lazy var locationListView = BookStoreListView().then {
        $0.titleLabel.text = "추천 장소"
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegate()
        setUpView()
        setUpLayout()
        setUpConstraint()
        setUpInteraction()
        setUpFloatingPanel()
    }
    
    func setUpFloatingPanel() {
        var BottomContent = BookStoreListViewController()
        var BottomSheetDelegateController = StoreListBottomSheetDelegateController(vc: BottomContent)
        setupBottomSheet(contentVC: BottomContent, floatingPanelDelegate: BottomSheetDelegateController)
        
        currentLocateBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.fpc.surfaceView.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
        }
        
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
        
        /// 테스트 데이터를 갖고 핀으로 map에 붙이기
//        locations.forEach { data in
//                    let pin = CustomAnnotation(isOnline: data.isOnline, coordinate: data.location)
//                    mapView.addAnnotation(pin)
//                }
        
        
        // locationListView의 테이블 뷰 register
        locationListView.locationTableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationTableViewCell")
    }
    
    
    // MARK: Layout
    func setUpLayout() {
        [
            mapView,
            locationListView,
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
        
//        // 목록 팝업 테이블 뷰
//        locationListView.snp.makeConstraints {
//            $0.horizontalEdges.equalToSuperview()
//            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(listViewCurrentY)
//            $0.height.equalToSuperview().multipliedBy(0.5)
//        }
        
        // 현재 위치 탐색 버튼
//        currentLocateBtn.snp.makeConstraints {
//            $0.bottom.equalTo(locationListView.snp.top).offset(-10)
//            $0.centerX.equalToSuperview()
//        }
    }
    
    // MARK: - Interaction
    func setUpInteraction() {
        panGesture.addTarget(self, action: #selector(handlePan))
        locationListView.addGestureRecognizer(self.panGesture) // 목록 뷰에 팬제스처 추가
        self.locationListView.locationTableView.isScrollEnabled = false // 처음엔 테이블 뷰 스크롤 안되게
    }
    
    /// 목록 뷰가 포함된 뷰의 팬제스처입니다.
    /// 스크롤을 올리면 목록뷰가 위로 이동하며, 끝까지 올린 경우 하단 탭바에 고정됩니다.
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
     
        guard let contentView = gestureRecognizer.view else { return }
        guard let tabBarMinY = self.tabBarController?.tabBar.frame.minY else { return }
        
        // 스크롤이 끝까지 되었는지 확인하는 조건
        let isFullyUpScrolled = self.locationListView.frame.maxY <= tabBarMinY
        let isFullyDownScrolled = self.locationListView.frame.minY + 200 > tabBarMinY
        
        // 팬제스처를 통한 변위 값
        let translation = gestureRecognizer.translation(in: contentView)
        
        
        
        
//        print(translation.y)
        
//        if gestureRecognizer.state == .changed {
//            // 목록 뷰에서 포인터가 어디에 위치하는지 표시 - 음수값도 지원된다.
//            let currentPoint_inContentView = gestureRecognizer.location(in: contentView)
//            let currentPoint_inEntireView = gestureRecognizer.location(in: self.view)
////            print(currentPoint_inEntireView.y)
//            print(currentPoint_inContentView.y)
//
//            listViewCurrentY = currentPoint_inEntireView.y + currentPoint_inContentView.y
//            print(listViewCurrentY)
//
//            self.locationListView.snp.updateConstraints{
////                $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-self.locationListView.bounds.height + translation.y)
//                $0.top.equalTo(self.view.snp.top).offset(listViewCurrentY)
//            }
//        }
        
        
//        // 다운 스크롤일 때
//        if translation.y > 0 {
//            // 끝까지 스크롤 했을 때
//            if isFullyDownScrolled {
//                // 하단 탭바에 목록 뷰 고정
//                locationListView.locationTableView.isScrollEnabled = false
//
//                self.locationListView.snp.updateConstraints{
//                    $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-self.locationListView.bounds.height + translation.y)
//                }
//            }
//            // 끝까지 스크롤 되지 않았을 때
//            else {
//                locationListView.locationTableView.isScrollEnabled = false
//                // 변위 값을 통해 offset 변경
//                self.locationListView.snp.updateConstraints{
//                    $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-self.locationListView.bounds.height + translation.y)
//                }
//            }
//        }
//        // 업 스크롤일 때
//        else {
//            // 끝까지 스크롤 했을 때
//            if isFullyUpScrolled {
//                // 하단 탭바에 목록 뷰 고정
//                self.locationListView.snp.updateConstraints {
//                    $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-self.locationListView.bounds.height)
//                }
////                gestureRecognizer.isEnabled = false
//                locationListView.locationTableView.isScrollEnabled = true
//
//            }
//            // 끝까지 스크롤 되지 않았을 때
//            else {
//                locationListView.locationTableView.isScrollEnabled = false
//                // 변위 값을 통해 offset 변경
//                self.locationListView.snp.updateConstraints{
//                    $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-200 + translation.y)
//                }
//            }
//        }
    }
            
}

// MARK: - LocationManagerDelgete 입니다. 위치를 갖고 오고, 이에 따른 추가 작업을 진행합니다.
extension LocationPageVC: CLLocationManagerDelegate {
    
    /// 위치가 업데이트 되었을 때 호출됩니다.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // location 가져오기 성공했을 때
        if let userLocation = locations.last?.coordinate {
            // region 설정 - 1km * 1km 반경으로 설정
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
        }
        // loacation 업데이트 종료 - 일단 안씁니다
//        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - MKMapViewDelegate 입니다. mapView에서 사용되는 annotation의 기본 내용을 설정합니다.
extension LocationPageVC: MKMapViewDelegate {
    // MARK: - 확정 사항이 아니므로, 더미 코드입니다.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 사용자 위치 표시는 따로 처리
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = .green
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
}

// MARK: - preview
struct LocationPageVC_Preview: PreviewProvider {
    static var previews: some View {
        // MARK: - UIViewControllerPreview를 사용하여 tabBarController의 index를 사용합니다
        UIViewControllerPreview {
            let tabBarController = TabBarController()
            tabBarController.selectedIndex = 1
            return tabBarController
        }
    }
}

// MARK: 테스트 데이터 모델
//struct Location {
//    let location: CLLocationCoordinate2D
//    let isOnline: Bool
//}
//
// MARK: 테스트 데이터
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
//             isOnline: true)
//
//]
