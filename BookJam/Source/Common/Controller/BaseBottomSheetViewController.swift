//
//  BaseBottomSheetViewController.swift
//  BookJam
//
//  Created by 박민서 on 12/8/23.
//

import Foundation
import UIKit
import FloatingPanel

/// Floating Panel을 사용하기 위한 기본 BaseController입니다.
/// 해당 Controller를 상속한 ViewController는 기본 세팅만으로 화면에 Floating panel을 사용할 수 있습니다.
class BaseBottomSheetController: BaseViewController {
    // MARK: - Floating Panel
    var fpc = FloatingPanelController()
    
    // MARK: - 내용물이 되는 ViewController 세팅
    private weak var contentVC: UIViewController? {
        didSet {
            guard let contentVC = contentVC else { return }
            prepareBottomSheet(contentVC: contentVC)
        }
    }

    // MARK: - 갖고온 Floating Panel 안 VC의 delegate를 본 fpc에 위임합니다
    private var floatingPanelDelegate: FloatingPanelControllerDelegate? {
        didSet {
            fpc.delegate = floatingPanelDelegate
        }
    }
    
    // MARK: - contentVC를 Floating Panel의 VC로 지정합니다.
    // MARK: - Floating Panel 안 VC의 delegate를 갖고옵니다
    func setupBottomSheet(contentVC: UIViewController?, floatingPanelDelegate: FloatingPanelControllerDelegate) {
        self.floatingPanelDelegate = floatingPanelDelegate
        prepareBottomSheet(contentVC: contentVC)
    }

    // MARK: - Floating Panel의 기본 설정 + 화면추가를 해줍니다.
    private func prepareBottomSheet(contentVC: UIViewController?) {
        fpc.surfaceView.appearance.cornerRadius = 15
        fpc.contentMode = .fitToBounds
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
    }
}
