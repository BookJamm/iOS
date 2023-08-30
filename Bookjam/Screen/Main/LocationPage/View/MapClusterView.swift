//
//  MapClusterView.swift
//  Bookjam
//
//  Created by 박민서 on 2023/08/31.
//

import Foundation
import MapKit
import UIKit

final class LocationDataMapClusterView: MKAnnotationView {

    // MARK: Initialization
    private let countLabel = UILabel()
    static let identifier: String = "LocationDataMapClusterView"

    override var annotation: MKAnnotation? {
        didSet {
//             guard let annotation = annotation as? MKClusterAnnotation else {
//                assertionFailure("Using LocationDataMapClusterView with wrong annotation type")
//                return
//            } -> 얘 때문에 안되느거임

//            countLabel.text = annotation.memberAnnotations.count < 100 ? "\(annotation.memberAnnotations.count)" : "99+"
        }
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        displayPriority = .defaultHigh
        collisionMode = .circle

        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)

       
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup
    private func setupUI() {
//        ...
        backgroundColor = .gray
    }
}
