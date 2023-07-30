//
//  MainPageVC.swift
//  Bookjam
//
//  Created by 장준모 on 2023/07/26.
//

import SwiftUI
import UIKit

class MainPageVC: UIViewController {

    
    // MARK: Variables

    var bookJamLabel: UILabel = UILabel().then{
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = UIColor(hexCode: "EE7505")
        $0.text = "BOOKJAM"
    }
    
    var alarmButton: UIButton = UIButton().then{
        $0.setImage(UIImage(systemName: "bell"), for: .normal)
        $0.tintColor = .black
    }
    
    var moreButton: UIButton = UIButton().then{
        $0.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        $0.tintColor = .black
    }
    
    var searchBar: UISearchBar = UISearchBar().then{
        $0.placeholder = "상호명 또는 주소 검색"
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.searchBarStyle = .minimal

        // Set the border image with an orange border
        let orangeBorderImage = UIImage(color: .orange, size: CGSize(width: 1, height: 1))
        $0.layer.borderColor = UIColor.orange.cgColor
        $0.layer.borderWidth = 1
        $0.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        
    }
    
    var independentBookstoreButton: UIButton = UIButton().then{
        $0.setTitle("독립서점", for: .normal)
        $0.setTitleColor(UIColor(hexCode: "#EE7505"), for: .normal)
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "book.fill"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.frame = CGRect(x: 100, y: 100, width: 200, height: 80)
        
        // Create the button configuration
        var configuration = UIButton.Configuration.plain()
        configuration.image = .actions
        configuration.imagePadding = 10
        configuration.imagePlacement = .top
        
        // Create the button using the configuration

        $0.configuration = configuration
        
    }
    
    var bookPlayGroundButton: UIButton = UIButton().then{
        $0.setTitle("책 놀이터", for: .normal)
        $0.setTitleColor(UIColor(hexCode: "#EE7505"), for: .normal)
        $0.setImage(.actions, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.frame = CGRect(x: 100, y: 100, width: 200, height: 80)
        
        // Create the button configuration
        var configuration = UIButton.Configuration.plain()
        configuration.image = .actions
        configuration.imagePadding = 10
        configuration.imagePlacement = .top
        
        // Create the button using the configuration

        $0.configuration = configuration
    }
    
    var libraryButton: UIButton = UIButton().then{
        $0.setTitle("도서관", for: .normal)
        $0.setTitleColor(UIColor(hexCode: "#EE7505"), for: .normal)
        $0.setImage(.actions, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.frame = CGRect(x: 100, y: 100, width: 200, height: 80)
        
        // Create the button configuration
        var configuration = UIButton.Configuration.plain()
        configuration.image = .actions
        configuration.imagePadding = 10
        configuration.imagePlacement = .top
        
        // Create the button using the configuration

        $0.configuration = configuration
    }
    
    var tableView: UITableView = UITableView().then{
        $0.backgroundColor = .blue  //테스트 확인용 임시 색상
        
    }
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpConstraint()

    }
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
        
        hideKeyboard()
    }

    // MARK: Layout
    
    func setUpLayout(){
        [
            bookJamLabel,
            alarmButton,
            moreButton,
            searchBar,
            independentBookstoreButton,
            bookPlayGroundButton,
            libraryButton,
            tableView
        ].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: Constraints

    func setUpConstraint(){
        bookJamLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.3)
            $0.centerY.equalToSuperview().multipliedBy(0.3)
        }
        alarmButton.snp.makeConstraints{
            $0.centerX.equalToSuperview().multipliedBy(1.75)
            $0.centerY.equalTo(bookJamLabel)
        }
        moreButton.snp.makeConstraints{
            $0.centerX.equalTo(alarmButton.snp.trailing).offset(20)
            $0.centerY.equalTo(bookJamLabel)
        }
        searchBar.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalTo(bookJamLabel.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(60)
        }
        independentBookstoreButton.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            
        }
        bookPlayGroundButton.snp.makeConstraints{
            $0.centerY.equalTo(independentBookstoreButton)
            $0.centerX.equalToSuperview()
        }
        libraryButton.snp.makeConstraints{
            $0.centerY.equalTo(independentBookstoreButton)
            $0.trailing.equalToSuperview().multipliedBy(1)
        }
        tableView.snp.makeConstraints{
            $0.top.equalTo(independentBookstoreButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            
        }
    
    }
}

// MARK: Extension
extension UIImage {
    // Create a UIImage with a solid color
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}

struct MainPageVC_Preview: PreviewProvider {
    static var previews: some View {
        MainPageVC().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
