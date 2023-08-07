//
//  ViewController.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/08.
//

// MARK: - ViewController 만들 때마다 템플릿으로 사용할 파일
// 아래 내용 복붙해서 사용

import SwiftUI
import UIKit

import SnapKit
import Then


class ViewController: UIViewController {

    // MARK: Variables

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
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        
    }
    
}

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}



