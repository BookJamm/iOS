//
//  MyPageVC.swift
//  Bookjam
//
//  Created by 장준모 on 2023/07/26.
//

// MARK: - 메인 탭바에서 마이 누르면 나오는 마이 페이지 화면

import SwiftUI
import UIKit

import SnapKit
import Then


class MyPageVC: UIViewController {

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

struct MyPageVC_Preview: PreviewProvider {
    static var previews: some View {
        MyPageVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}
