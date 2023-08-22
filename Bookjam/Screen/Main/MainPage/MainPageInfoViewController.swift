//
//  MainPageInfoViewController.swift
//  Bookjam
//
//  Created by 장준모 on 2023/08/21.
//

import UIKit
import SwiftUI

class MainPageInfoViewController: UIViewController {

    var infoView1: UIView = UIView().then{
        
        $0.backgroundColor = gray02

    }
    
    let label:UILabel = UILabel().then{
        $0.text = "독립 서점은 대규모 자본, 큰 유통망에 의지하지 않고 꾸며진 작은 서점을 의미해요 :)"
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.textAlignment = .left
        $0.font = paragraph06
        $0.sizeToFit()
    }
    
    let infoView: UIImageView = UIImageView().then{
        $0.image = UIImage(named: "InfoView")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    /// 뒷쪽 뷰 클릭하면 화면 dismiss되도록 설정
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // shadow 적용하기 위한 containerView
        let containerView = UIView()
        containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        containerView.layer.shadowOffset = CGSize(width: 1, height: 4)
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOpacity = 1
        containerView.addSubview(infoView)
//        infoView.addSubview(label)
        
        // infoView 모서리 둥글게 만들기
        infoView.layer.cornerRadius = 25
        infoView.clipsToBounds = true
        self.view.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-180)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(200)
            $0.width.equalTo(300)

//            $0.trailing.equalToSuperview().offset(-30)
        }
        infoView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalTo(273)
            $0.height.equalTo(78)
        }
//        label.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//        }
        
    }
}

//struct MainPageInfoViewController_Preview: PreviewProvider {
//    static var previews: some View {
//        MainPageInfoViewController().toPreview()
//            //.edgesIgnoringSafeArea(.all)
//    }
//}
