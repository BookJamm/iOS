//
//  RxMapViewDataSourceProxy.swift
//  BookJam
//
//  Created by 박민서 on 12/10/23.
//


import RxSwift
import RxCocoa
import MapKit

public protocol RxMapViewDataSourceType {

    associatedtype Element

    /// 해당 mapView의 DataSource 이벤트를 observedEvent로
    ///
    /// - parameter mapView: Bound map view.
    /// - parameter observedEvent: Event
    ///
    func mapView(_ mapView: MKMapView, observedEvent: Event<[Element]>)
}


public class RxMapViewReactiveAnnotationDataSource<S: MKAnnotation>
    : RxMapViewDataSourceType {
    public typealias Element = S

    var currentAnnotations: [S] = []

    public func mapView(_ mapView: MKMapView, observedEvent: Event<[S]>) {
        Binder(self) { _, newAnnotations in
            DispatchQueue.main.async {
                let diff = Diff.calculateFrom(
                    previous: self.currentAnnotations,
                    next: newAnnotations)
                self.currentAnnotations = newAnnotations
                mapView.addAnnotations(diff.added)
                mapView.removeAnnotations(diff.removed)
            }
        }.on(observedEvent)
    }
}
