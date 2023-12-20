//
//  BookStoreBottomSheetViewController.swift
//  BookJam
//
//  Created by 박민서 on 12/8/23.
//

import Foundation
import UIKit
import FloatingPanel


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
//    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
//        switch fpc.state {
//        case .tip:
////            contentVC?.updateView(viewType: .tip)
//            // 여기에 메뉴 arrowDirection 넣어주기
//            self.contentVC?.locationTableView.isScrollEnabled = false
//
//        case .half:
////            contentVC?.updateView(viewType: .half)
//            // 여기에 테이븗 뷰 스크롤 제한 해제해주기
////            self.contentVC?.enableTableViewScroll()
//            self.contentVC?.locationTableView.isScrollEnabled = false
//        case .full:
////            contentVC?.updateView(viewType: .full)
//            self.contentVC?.enableTableViewScroll()
//        default:
//            return
//        }
//    }
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
