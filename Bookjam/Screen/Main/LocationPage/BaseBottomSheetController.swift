//
//  BaseBottomSheetController.swift
//  Bookjam
//
//  Created by 박민서 on 2023/08/30.
//

import Foundation
import UIKit
import FloatingPanel

class BaseBottomSheetController: UIViewController {
    var fpc = FloatingPanelController()



    private weak var contentVC: UIViewController? {
        didSet {
            guard let contentVC = contentVC else { return }

            prepareBottomSheet(contentVC: contentVC)
        }
    }


    //We can access the delegate property of the “FloatingPanelController” through the “fpc” object we have created. Thanks to this delegate, we can use FloatingPanel’s methods such as “didMove()” and “shouldBegin()”.
    private var floatingPanelDelegate: FloatingPanelControllerDelegate? {
        didSet {
            fpc.delegate = floatingPanelDelegate
        }
    }

    func setupBottomSheet(contentVC: UIViewController?, floatingPanelDelegate: FloatingPanelControllerDelegate) {
        self.floatingPanelDelegate = floatingPanelDelegate
        prepareBottomSheet(contentVC: contentVC)
    }


    //We set the corner radius of the bottom sheet and set the content mode as “.fitToBounds”. This content mode is used to scale the content to fit the bounds of the root view by changing the bottom sheet position. In this way, our “Start Diagnosing” button is visible and clickable even in different types.
//    Here we use the “set()” method taking the “contentVC” parameter and “addPanel()” method to add the “fpc” to panel.
    private func prepareBottomSheet(contentVC: UIViewController?) {
        fpc.surfaceView.appearance.cornerRadius = 15
        fpc.contentMode = .fitToBounds
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
    }
}

final class StoreListBottomSheetDelegateController: FloatingPanelControllerDelegate {
    weak var contentVC: BookStoreListViewController?

    init(vc: BookStoreListViewController) {
        self.contentVC = vc
    }

    func floatingPanel(_ fpc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
           return FloatingPanelStocksLayout()
    }
    
    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        if fpc.isAttracting == false {
            let loc = fpc.surfaceLocation
            let minY = fpc.surfaceLocation(for: .full).y
            let maxY = fpc.surfaceLocation(for: .tip).y 
            fpc.surfaceLocation = CGPoint(x: loc.x, y: min(max(loc.y, minY), maxY))
        }
    }
    
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

class FloatingPanelStocksLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half

    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 160, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.45, edge: .bottom, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 52, edge: .bottom, referenceGuide: .safeArea)
    ]
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        switch state {
        default:
            return 0
        }
    }
}
