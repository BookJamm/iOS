//
//  RxMKMapViewDelegateProxy.swift
//  BookJam
//
//  Created by 박민서 on 12/9/23.
//

import RxSwift
import RxCocoa
import MapKit

extension MKMapView: HasDelegate {
    public typealias Delegate = MKMapViewDelegate
}

// Annotation 설정하는 Closuer명 정의 -> 얘를 통해 Annotation 정보 전달
public typealias RxMKHandleViewForAnnotaion = (MKMapView, MKAnnotation) -> (MKAnnotationView?)

class RxMKMapViewDelegateProxy: DelegateProxy<MKMapView, MKMapViewDelegate>, DelegateProxyType, MKMapViewDelegate {
    // 여기에서 MKMapViewDelegate를 상속했으니, 해당 블럭안에서 Delegate 메소드 작성 가능
    
    weak private(set) var mapView: MKMapView?
    
    init(mapView: MKMapView) {
        self.mapView = mapView
        super.init(parentObject: mapView, delegateProxy: RxMKMapViewDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register {
            RxMKMapViewDelegateProxy(mapView: $0)
        }
    }
    
    // Annotaion 정보 반환할 Closure 선언
    var handleViewForAnnotation: RxMKHandleViewForAnnotaion? = nil
    
//    @objc(mapView:viewForAnnotation:)
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? { // Delegate 메소드 작성
        return handleViewForAnnotation?(mapView, annotation)
    }
}


// center는 Binder로 선언되어있고 전달된 CLLocation에 포함된 좌표를 지도 중앙에 표시하도록 구현.
extension Reactive where Base: MKMapView {
    
    public var center: Binder<CLLocation> {
        return Binder(self.base) { mapView, location in
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 300, longitudinalMeters: 300) // 너무 크면 지도 해쉬 렌더링 에러 뜸 -> 문제는 안될지도
            self.base.setRegion(region, animated: true)
        }
    }
    
    var delegate: RxMKMapViewDelegateProxy { //DelegateProxy<MKMapView, MKMapViewDelegate> 이었는데, 어차피 RxMKMapViewDelegateProxy는 이를 모두 충족시킴
        return RxMKMapViewDelegateProxy.proxy(for: base)
    }
    
    var regionDidChangeAnimated: Observable<[MKCoordinateRegion]> {
        return delegate.methodInvoked(#selector(MKMapViewDelegate.mapView(_:regionDidChangeAnimated:)))
            .map {  params in
                return params[1] as! [MKCoordinateRegion]
            }
    }
    
    func handleViewForAnnotation(_ closure: RxMKHandleViewForAnnotaion?) {
        delegate.handleViewForAnnotation = closure // 클로저로 받아서 delgate로 전달하는 방식
    }
    
}
