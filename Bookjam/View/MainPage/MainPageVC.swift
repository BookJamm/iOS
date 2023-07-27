//
//  MainPageVC.swift
//  Bookjam
//
//  Created by 장준모 on 2023/07/26.
//

import UIKit

class MainPageVC: UIViewController {

    
    // MARK: Variables

    var bookJamLabel: UILabel = UILabel().then{
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = UIColor(hexCode: "EE7505")
        $0.text = "BOOKJAM"
    }
    
    var alarmButton: UIButton = UIButton().then{
        $0.setImage(UIImage(systemName: "bell.fill"), for: .normal)
    }
    
    var moreButton: UIButton = UIButton().then{
        $0.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
    }
    
    var searchBar: UISearchBar = UISearchBar().then{
        $0.placeholder = "상호명 또는 주소 검색"
    }
    
    var independentBookstoreButton: UIButton = UIButton().then{
        $0.setTitle("독립서점", for: .normal)
    }
    
    var bookPlayGroundButton: UIButton = UIButton().then{
        $0.setTitle("책 놀이터", for: .normal)
    }
    
    var libraryButton: UIButton = UIButton().then{
        $0.setTitle("도서관", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
