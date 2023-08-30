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
    
    // MARK: Initialization

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)

        canShowCallout = true
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    private func setupUI() {
        backgroundColor = .clear

        let view = UIImageView(image: UIImage(color: main03!, size: CGSize(width: 30, height: 30)).circularImage()!)
        addSubview(view)

        view.frame = bounds
    }
}
