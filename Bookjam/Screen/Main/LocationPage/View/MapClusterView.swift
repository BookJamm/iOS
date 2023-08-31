//
//  MapClusterView.swift
//  Bookjam
//
//  Created by 박민서 on 2023/08/31.
//

import Foundation
import MapKit
import UIKit
import SnapKit

final class LocationDataMapClusterView: MKAnnotationView {

    // MARK: Initialization
    private let countLabel = UILabel()
    static let identifier: String = "LocationDataMapClusterView"

    override var annotation: MKAnnotation? {
        didSet {
            if let annotation = annotation as? MKClusterAnnotation {
                countLabel.text = annotation.memberAnnotations.count < 100 ? "\(annotation.memberAnnotations.count)" : "99+"
            }
        }
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        displayPriority = .defaultHigh
        collisionMode = .circle

        frame = CGRect(x: 0, y: 0, width: 40, height: 40)
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
        backgroundColor = .clear
        
//        let view = UIImageView(image: UIImage(color: main03!, size: CGSize(width: 30, height: 30)).circularImage()!)
//        addSubview(view)
//        view.frame = bounds
        
        let circleImage = UIImage(systemName: "circle.circle.fill")
        let circleView = UIImageView(image: circleImage)
        circleView.tintColor = main03
        self.addSubview(circleView)
        circleView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        countLabel.textColor = .white
        countLabel.font = paragraph01
        circleView.addSubview(countLabel)
        countLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
}
