//
//  ChoiceDateBottomSheetVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/11.
//

// MARK: - 날짜 선택 화면에서 장소 방문 날짜 선택 버튼을 눌렀을 때 올라오는 달력 바텀시트

import SwiftUI
import UIKit

import FloatingPanel
import SnapKit
import Then


class ChoiceDateBottomSheetVC: FloatingPanelController {

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

struct ChoiceDateBottomSheetVC_Preview: PreviewProvider {
    static var previews: some View {
        ChoiceDateBottomSheetVC().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}
