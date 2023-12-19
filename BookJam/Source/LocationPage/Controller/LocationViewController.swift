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

final class LocationViewController: UIViewController {
    // MARK: Variables
    
    /// Rx - DisposeBag
    private var disposeBag = DisposeBag()
    
    /// LocationViewController 뷰모델
//    private var viewModel = LocationViewModel()

    /// 위치 관리 매니저
    private let locationManager = CLLocationManager()
    
    /// 지도 뷰
    private let mapView = MKMapView()
    
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    

    // MARK: Configure View
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    func setUpLayout() {
        [
            
        ].forEach { view.addSubview($0) }
    }
    
    
    // MARK: Constraint
    func setUpConstraint() {
        
    }
}
