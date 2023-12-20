//
//  BaseViewController.swift
//  BookJam
//
//  Created by YOUJIM on 12/4/23.
//


// MARK: - ViewController 만들 때마다 템플릿으로 사용할 파일

import SwiftUI
import UIKit

import SnapKit
import Then


class BaseViewController: UIViewController {

    // MARK: Variables

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    

    // MARK: View
    
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            
        ].forEach { view.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        
    }
    
}

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        BaseViewController().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

