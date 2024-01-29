//
//  MainDetailDataSource.swift
//  BookJam
//
//  Created by 장준모 on 1/30/24.
//

import Foundation
import UIKit

final class MainDetailDataSource: UITableViewDiffableDataSource<DetailSection, DetailItem> {
    
    // 편집모드 > 셀 이동 처리
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        <#code#>
//    }
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        <#code#>
//    }
}

extension MainDetailDataSource {
    func update(items: [DetailItem]) {
        var snapshot = snapshot()
        snapshot.deleteAllItems()
//        snapshot.appendSections([0])
        snapshot.appendItems(items)
        apply(snapshot)
    }
}
