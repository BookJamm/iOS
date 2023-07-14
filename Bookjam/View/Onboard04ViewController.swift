//
//  Onboard04ViewController.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/14.
//

import SwiftUI
import UIKit

import Alamofire
import SnapKit
import Then


class Onboard04ViewController: UIViewController {
    
    // MARK: Variables
    
    let backButton = UIButton()
    let informationText = UITextView()
    let profileImageButton = UIButton()
    let nicknameTextField = UITextField()
    let confirmButton = UIButton()
    let decisionButton = UIButton()

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
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        
    }
    
}

struct Onboard04ViewController_Preview: PreviewProvider {
    static var previews: some View {
        Onboard04ViewController().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
