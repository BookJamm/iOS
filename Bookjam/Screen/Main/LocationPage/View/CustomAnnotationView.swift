//
//  CustomAnnotationView.swift
//  Bookjam
//
//  Created by 박민서 on 2023/08/31.
//

import Foundation
import MapKit
import UIKit

final class LocationAnnotationView: MKAnnotationView {

    static let identifier: String = "LocationAnnotationView"
    private let customImage = UIImageView()
    
    // MARK: Initialization

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        clusteringIdentifier = LocationDataMapClusterView.identifier
//        canShowCallout = true
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            clusteringIdentifier = LocationDataMapClusterView.identifier
        }
    }

    // MARK: Setup

    private func setupUI() {
        backgroundColor = .clear
        customImage.image = UIImage(named: "locationPin")//?.withRenderingMode(.alwaysTemplate)
        customImage.tintColor = main03
        self.addSubview(customImage)
        customImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
