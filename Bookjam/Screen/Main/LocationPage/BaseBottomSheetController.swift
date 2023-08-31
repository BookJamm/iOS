//
//  BaseBottomSheetController.swift
//  Bookjam
//
//  Created by 박민서 on 2023/08/30.
//

import Foundation
import UIKit
import FloatingPanel

/// Floating Panel을 사용하기 위한 기본 BaseController입니다.
/// 해당 Controller를 상속한 ViewController는 기본 세팅만으로 화면에 Floating panel을 사용할 수 있습니다.
class BaseBottomSheetController: UIViewController {
    // MARK: - Floating Panel
    var fpc = FloatingPanelController()
    
    // MARK: - 내용물이 되는 ViewController
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


    //We set the corner radius of the bottom sheet and set the content mode as “.fitToBounds”. This content mode is used to scale the content to fit the bounds of the root view by changing the bottom sheet position. In this way, our “Start Diagnosing” button is visible and clickable even in different types.
//    Here we use the “set()” method taking the “contentVC” parameter and “addPanel()” method to add the “fpc” to panel.
    // MARK: - Floating Panel의 기본 설정을 해줍니다.
    private func prepareBottomSheet(contentVC: UIViewController?) {
        fpc.surfaceView.appearance.cornerRadius = 15
        fpc.contentMode = .fitToBounds
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
    }
}

/// LocationPageVC에서 사용하는 Floating Panel 전용 DelgateController입니다.
final class StoreListBottomSheetDelegateController: FloatingPanelControllerDelegate {
    weak var contentVC: BookStoreListViewController?

    init(vc: BookStoreListViewController) {
        self.contentVC = vc
    }

    func floatingPanel(_ fpc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
           return FloatingPanelStocksLayout()
    }
    
    // MARK: - Floating panel 최고 / 최저 위치 설정
    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        if fpc.isAttracting == false {
            let loc = fpc.surfaceLocation
            let minY = fpc.surfaceLocation(for: .full).y
            let maxY = fpc.surfaceLocation(for: .tip).y 
            fpc.surfaceLocation = CGPoint(x: loc.x, y: min(max(loc.y, minY), maxY))
        }
    }
    
    // MARK: - Floating Panel 크기 상태에 따른 코드 진행
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        switch fpc.state {
        case .tip:
//            contentVC?.updateView(viewType: .tip)
            // 여기에 메뉴 arrowDirection 넣어주기
            self.contentVC?.locationTableView.isScrollEnabled = false
            
        case .half:
//            contentVC?.updateView(viewType: .half)
            // 여기에 테이븗 뷰 스크롤 제한 해제해주기
//            self.contentVC?.enableTableViewScroll()
            self.contentVC?.locationTableView.isScrollEnabled = false
        case .full:
//            contentVC?.updateView(viewType: .full)
            self.contentVC?.enableTableViewScroll()
        default:
            return
        }
    }
}

/// Floating Panel에서 참조하는 Panel의 layout입니다.
/// 위치 설정과, 외형 변경등을 담당합니다.
class FloatingPanelStocksLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half

    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 160, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.3, edge: .bottom, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 52, edge: .bottom, referenceGuide: .safeArea)
    ]
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        switch state {
        default:
            return 0
        }
    }
}
