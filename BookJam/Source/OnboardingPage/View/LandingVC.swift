//
//  ViewController.swift
//  BookJam
//
//  Created by YOUJIM on 11/7/23.
//

import UIKit

import SnapKit
import Then

class LandingVC: UIViewController {
    
    // MARK: Variables
    
    let logoImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "BookjamLogo")
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: View
    
    private func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    private func setUpLayout() {
        
    }
    
    
    // MARK: Constraint
    
    private func setUpConstraint() {
        
    }

}

#Preview {
    LandingVC()
}

