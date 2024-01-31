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
    func update(section: DetailSection, items: [DetailItem]) {
        var snapshot = snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        apply(snapshot)
    }
}
