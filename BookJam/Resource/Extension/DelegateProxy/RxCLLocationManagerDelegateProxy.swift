//
//  RxCLLocationManagerDelegateProxy.swift
//  BookJam
//
//  Created by 박민서 on 12/9/23.
//

import RxSwift
import RxCocoa
import CoreLocation

//1. 확장 대상에 HasDelegate Protocol 구현을 추가한다.
extension CLLocationManager: HasDelegate{
    //Delegate라는 연관 형식을 확장 대상과 연결된 Delegate Protocol로 지정해주면 끝난다.
    //CLLocationManager과 연관된 프로토콜은 CLLocationManagerDelegate이다.
    public typealias Delegate = CLLocationManagerDelegate
}

//2.
//DelegateProxy구현, 클래스명은 보통 Rx + 대상 + DelegateProxy, DelegateProxy를 상속해야함
//DelegateProxy는 제네릭클래스이고 형식파라미터 두개를 선언해야한다.(확장할클래스, 연관된Delegate프로토콜
//다음 DelegateProxyType프로토콜을 채용하고 마지막으로 연관된 델리게이트 프로토콜을 채용해야한다.
class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate{
    
    //3. Proxy클래스에 새로운 속성(확장대상)을 추가
    //클래스 내부에서 확장 대상에 접근해야한다면 약한 참조로 확장대상을 저장해야 참조사이클문제가 발생하지 않는다.
    //클래스 내부에서 확장 대상에 접근하지 않아도 된다면 속성을 선언하지 않아도 된다.
    weak private(set) var locationManager: CLLocationManager?
    
    //4. 생성자 구현
    init(locationManager: CLLocationManager){
        //생성자는 보통 확장대상을 파라미터로 받는다
        self.locationManager = locationManager
        //슈퍼클래스에 생성자를 호출하고 확장 대상과 델리게이트 프록시 타입을 전달한다.
        super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
    }
    
    
    //5. DelegateProxyType이 요구하는 필수 멤버를 구현
    static func registerKnownImplementations() {
        //레지스터 메서드를 호출하고 클로저에서 델리게이트 프록시의 인스턴스를 리턴해야한다.
        //이 메서드는 필요한 시점에 자동으로 호출된다.
        //RxCocoa는 내부적으로 ProxyFactory를 가지고 있는데 구현한 Proxy가 팩토리에 자동으로 등록된다.
        self.register{
            RxCLLocationManagerDelegateProxy(locationManager: $0)
        }
    }
}

//6. Reactive Extension 구현
extension Reactive where Base: CLLocationManager{
  
    //7. 델리게이트속성 추가, 속성의형식은 2. 에서 구현한 Proxy클래스에 슈퍼클래스로 선언해야함.
    var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>{
       
        //DelegateProxy인스턴스를 리턴해야하는데 한 가지 주의할 점이 있다.
        // 4에서 구현했던 생성자를 사용하면 새로운 인스턴스를 생성할 수 있다. 그럼 내부적으로 여러가지 문제가 발생한다.
        //문제1 인스턴스가 두개이상 생성되는 문제 이렇게되면 델리게이트프록시가 예상과 다르게 동작
        //그래서 생성자 대신 proxy(for:) 메서드 사용 -> 프록시팩토리가 프록시생성을 담당하게되고 이미 생성된
        //인스턴스가있다면 새로 생성하지 않고 기존 인스턴스를 리턴
        return RxCLLocationManagerDelegateProxy.proxy(for: base)
    }
    
    //8. 델리게이트에서 didupdateLocation메서드가 호출되면 옵저버블을통해 새로운 위치정보를 방출하도록 구현
    //속성 이름은 연관된 델리게이트메서드와 동일하게 선언하거나 특정 부분츨 채용한 형태로
    var didUpdateLocation: Observable<[CLLocation]>{
        //옵저버블은 직접 만들지 않고 methonInvoked메서드를 사용한다
        //didUpdateLocation메서드의 selector를 생성하고 파라미터로 전달해야한다.
        //이메서드가 리턴하는 옵저버블은 셀렉터로 전달한 메서드가 호출되는 시점에 NE를 방출 NE에는 델리게이트메서드로 전달된 파라미터가 [Any]로 저장되어있다. didUpdateLocation메서드에는 두개의 파라미터가 전달된다. 첫 번째는 LocationManager, 두 번쨰는 CLLocation배열이 전달. NE도 두개의요소가 저장되어있다. map연산자로 두번째 파라미터만 방출
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
            .map{ parameters in
                return parameters[1] as! [CLLocation]
            }
        
    }
}
