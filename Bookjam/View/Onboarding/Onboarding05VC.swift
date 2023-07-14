//
//  Onboarding05VC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/14.
//

import SwiftUI
import UIKit

class Onboarding05VC: UIViewController {
    
    // MARK: Variables
    
    let backImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.backward")
        $0.tintColor = UIColor.black
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(backImageView)
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        backImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.06)
            $0.centerX.equalToSuperview().multipliedBy(0.15)
            $0.height.equalToSuperview().multipliedBy(0.035)
            $0.width.equalToSuperview().multipliedBy(0.04)
        }
        
    }

}

struct Onboarding05VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding05VC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}
