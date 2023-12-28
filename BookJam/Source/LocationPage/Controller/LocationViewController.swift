//
//  LocationViewController.swift
//  BookJam
//
//  Created by 박민서 on 12/4/23.
//

// MARK: - 메인 탭바에서 내 주변 누르면 나오는 위치 기반 검색 화면
import UIKit
import SnapKit
import Then

import RxSwift
import RxCocoa

import CoreLocation
import MapKit

import FloatingPanel

final class LocationViewController: BaseBottomSheetController {
    // MARK: Variables
    
    /// Rx - DisposeBag
    private var disposeBag = DisposeBag()
    
    /// LocationViewController 뷰모델
    private var viewModel = LocationViewModel()
    
    /// 위치 관리 매니저
    private let locationManager = CLLocationManager()
    
    /// 지도 뷰
    private let mapView = MKMapView()
    
    /// 화명 상단 배경 뷰
    private var topBackgroundView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    /// 화면 상단 서치바 배경 뷰
    private var searchBarBackgroundView: UIView = UIView().then {
        $0.backgroundColor = .gray01
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    /// 화면 상단 서치바 아래 밑줄
    private var searchBarBackgroundViewLine: UIView = UIView().then {
        $0.backgroundColor = .gray01
    }
    
    /// 화면 상단 서치바
//    private lazy var searchBar: UISearchBar = UISearchBar().then {
//        $0.placeholder = "상호명 또는 주소 검색"
//        $0.searchBarStyle = .minimal
//
//        $0.searchTextField.backgroundColor = .gray01
//        $0.searchTextField.textColor = .gray06
//        $0.searchTextField.font = paragraph02
//
//        $0.setImage(UIImage.search, for: .search, state: .normal)
//        $0.setSearchFieldBackgroundImage(UIImage(), for: .normal)
//    }
    
    /// 화면 상단 서치바
    private lazy var searchBar: SearhBarButton = SearhBarButton(placeHolder: "상호명 또는 주소 검색").then {
        $0.contentHorizontalAlignment = .leading
    }
    
    /// 목록뷰 상단의 탐색 버튼입니다.
    private lazy var currentLocateBtn: UIButton = UIButton().then {
        
        var titleAttr = AttributedString.init("현재 위치로 탐색")
        titleAttr.font = paragraph04
        
        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.baseBackgroundColor = main03
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        $0.configuration?.cornerStyle = .large
        
        $0.layer.cornerRadius = 15
//        $0.clipsToBounds = true
        
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowRadius = 20
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpBinding()
        setUpLayout()
        setUpConstraint()
        setUpFloatingPanel()
        
    }
    
    
    // MARK: Configure View
    private func setUpView() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        // 현재 위치 설정
        locationManager.requestWhenInUseAuthorization()  // 권한 확인
        locationManager.startUpdatingLocation() // 위치 업데이트
        locationManager.desiredAccuracy = kCLLocationAccuracyBest   // 가장 높은 정확도의 위치 정보를 요청
        
        // 지도 초기화 설정
        mapView.showsUserLocation = true    // 유저 현재 위치 보이게
        mapView.mapType = MKMapType.standard    // 일반적인 지도 스타일
        mapView.setUserTrackingMode(.follow, animated: true)    // 지도가 사용자의 위치를 따라가는 모드로 전환
        
        // 지도 AnnotationView Register
        mapView.register(LocationAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)  // 지도에 어노테이션 커스텀 뷰 등록
        mapView.register(LocationDataMapClusterView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)   // 지도에 클러스터 커스텀뷰 등록
    }
    
    // MARK: Data Binding
    private func setUpBinding() {
        // MARK: Input
        let input = LocationViewModel.Input(refreshTrigger: currentLocateBtn.rx.tap.asObservable())
        
        // MARK: Output
        let output = viewModel.transform(input: input)
        
        // AnnotationList mapView에 바인딩
        output.bookStoreAnnotationList.asDriver(onErrorJustReturn: [])
            .drive(mapView.rx.annotations)
            .disposed(by: disposeBag)
        
        // LocationManager 위치 업데이트시 subscribe
        locationManager.rx.didUpdateLocation
            .subscribe(onNext: { locations in
                print(locations)
            })
            .disposed(by: disposeBag)
        
        // LocationManager 위치 업데이트시 subscribe
        locationManager.rx.didUpdateLocation
            .map{$0[0]}
            .bind(to: mapView.rx.center)
            .disposed(by: disposeBag)
        
        // mapView AnnotationView Source 불러올 때 인터셉트
        mapView.rx.handleViewForAnnotation { (mapView, annotation) in
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
        }
    }
    
    // MARK: Layout
    private func setUpLayout() {
        [
            searchBarBackgroundView,
            searchBarBackgroundViewLine,
            searchBar
        ].forEach { topBackgroundView.addSubview($0)}
        
        
        [
            mapView,
            currentLocateBtn,
            topBackgroundView
        ].forEach { self.view.addSubview($0)}
    }
    
    
    // MARK: Constraint
    private func setUpConstraint() {
        // 상단 서치바
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(0)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        // 화면 상단 배경 뷰
        topBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(searchBar).offset(10)
            $0.horizontalEdges.equalToSuperview()
        }
        
        // 서치바 배경 뷰
        searchBarBackgroundView.snp.makeConstraints {
            $0.center.equalTo(searchBar)
            $0.height.equalTo(searchBar)
            $0.width.equalTo(searchBar).multipliedBy(1)
        }
        
        // 서치바 배경뷰 아래 밑줄선
        searchBarBackgroundViewLine.snp.makeConstraints {
            $0.bottom.equalTo(topBackgroundView)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        // 지도 뷰
        mapView.snp.makeConstraints {
            $0.top.equalTo(self.searchBarBackgroundView.snp.bottom)
            $0.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Floating Panel - primary setting
extension LocationViewController: UITableViewDelegate {
    
    func setUpFloatingPanel() {
        
        // MARK: Floating Panel Base Setting
        let BottomContent = BookStoreListViewController()   // 바텀시트에 들어갈 서점 목록 VC
        let BottomSheetDelegateController = StoreListBottomSheetDelegateController(vc: BottomContent) // 서점목록VC 전용 바텀시트 DelegateController 등록
        setupBottomSheet(contentVC: BottomContent, floatingPanelDelegate: BottomSheetDelegateController) // 바텀시트 등록
        BottomContent.locationTableView.delegate = self // 해당 tableView의 셀 선택 이벤트를 가져오려면 해당 delegate를 가져와야합니다.
        
        // MARK: Floating Panel related Layout
        // 현재위치 버튼 위치는 바텀 시트 윗부분입니다. 해당 부분에서 설정해주어야 합니다.
        currentLocateBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.fpc.surfaceView.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
        }
        // Floating Panel 보다 상단 바가 더 앞으로 오게 재설정
        self.view.bringSubviewToFront(topBackgroundView)
        
        // MARK: Floating Panel Rx Binding
        // bookStoreList Floating Panel 안의 테이블뷰에 바인딩
        viewModel.bookStoreList.bind(to: BottomContent.locationTableView.rx.items(
            cellIdentifier: BookStoreTableViewCell.cellID,
            cellType: BookStoreTableViewCell.self)) {
                (row, element, cell) in
                cell.cellModel = element
            }.disposed(by: disposeBag)
        
        // locationTableView의 셀 누르는 이벤트 subscribe
        BottomContent.locationTableView.rx.modelSelected(Place.self)
            .subscribe(onNext: { place in
                print(place)
            }).disposed(by: disposeBag)
        
        // filterButton의 tap 이벤트 subscribe
        Observable.merge(
            BottomContent.filterButton_rating.rx.tap.map { filters.rating },
            BottomContent.filterButton_review.rx.tap.map { filters.review },
            BottomContent.filterButton_distance.rx.tap.map { filters.distance }
        )
        .bind(to: viewModel.selectedFilterIndex)
        .disposed(by: disposeBag)
        
        // filter 값 state 변경 subscribe
        viewModel.selectedFilterIndex
            .map { index -> (isRating: Bool, isReview: Bool, isDistance: Bool) in
                switch index {
                case .rating: return (true,false,false)
                case .review: return (false,true,false)
                case .distance: return (false,false,true)
                }
            }
            .bind { isRating, isReview, isDistance in
                BottomContent.filterButton_rating.isOn = isRating
                BottomContent.filterButton_review.isOn = isReview
                BottomContent.filterButton_distance.isOn = isDistance
            }
            .disposed(by: disposeBag)
    }
}

@available(iOS 17, *)
#Preview {
    LocationViewController()
}
