//
//  ViewModelProtocol.swift
//  BookJam
//
//  Created by 박민서 on 12/2/23.
//

import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
