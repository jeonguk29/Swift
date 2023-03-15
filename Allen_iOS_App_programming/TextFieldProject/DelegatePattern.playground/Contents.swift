import UIKit

// 델리게이트 패턴 객체와 객체사이의 의사소통(커뮤니케이션)을 돕는 디자인 패턴
// 이 커뮤니케이션을 어떻게 하냐? => 대리자를 설정하는데 이 대리자를 프로토콜로 타입으로 설정함
// 이 프로토콜 타입을 통해서 동작이 전달 되는 것임

// 자격증(정의) (텍스트필드 프로토콜)
protocol RemoteControlDelegate {
    func channelUp()
    func channelDown()
    // func channelRemove() -> Bool  // ⭐️ 텍스트필드처럼 이렇게 해주면 리모컨에서 메서드 실행시 대리자에게 (참/거짓)을 물어보고 그거에 따라 리모컨에서 동작을 처리 하게 해줄 수 있음 
}


// 리모콘 클래스(텍스트필드의 역할 - 직접적으로 유저와 커뮤니케이션)
class RemoteControl {
    
    var delegate: RemoteControlDelegate?    //😀 옵셔널 프로토콜 타입으로 정의되어 있음 즉 데리자는 RemoteControlDelegate 프로토콜을 채택한 타입이면 다 가능
    
    func doSomething() {
        print("리모콘의 조작이 일어나고 있음")
    }
    
    func channelUp() {   // 어떤 기기가 리모콘에 의해 작동되는지 몰라도 됨
        delegate?.channelUp()   //😀 데리자의 channelUp을 호출함
    }
    
    func channelDown() {   // 어떤 기기가 리모콘에 의해 작동되는지 몰라도 됨
        delegate?.channelDown()
    }
}
// 텍스트 필드라고 가정하면 텍스트 필드안에서 직접적인 일이 일단 일어나는 것임 채널을 올릴지, 내릴지 하지만 이 직접적인 일을 전달을 하는것임 대리자한테

// TV 클래스(뷰컨트롤러의 역할 - 리모콘과 커뮤니케이션)
class TV: RemoteControlDelegate {
    
    func channelUp() {
        print("TV의 채널이 올라간다.")
    }

    func channelDown() {
        print("TV의 채널이 내려간다.")
    }

}



let remote = RemoteControl()    // 텍스트 필드와 동일한 객체(인스턴스를) 하나 생성
let samsungTV = TV()    // TV 인스턴스 생성

remote.delegate = samsungTV // 이코드가 객체 안에 있다면 remote.delegate = self 로 선언가능 한것임


// 😀 remote가 실질적으로 동작 처리를 하지만 내부적으로는 티비에서 처리 되는 것임
remote.channelUp()        // 리모콘 실행 ====> delegate?.channelUp()
remote.channelDown()      // 리모콘 실행 ====> delegate?.channelDown()






// SmartPhone 클래스(뷰컨트롤러의 역할 - 리모콘과 커뮤니케이션)
class SmartPhone: RemoteControlDelegate {

    init(remote: RemoteControl) {
        remote.delegate = self       // remote.delegate = smartPhone
    }
    
    func channelUp() {
        print("스마트폰의 채널이 올라간다.")
    }
    
    func channelDown() {
        print("스마트폰의 채널이 내려간다.")
    }
}



let smartPhone = SmartPhone(remote: remote)
remote.channelUp()        // 리모콘 실행 ====> delegate?.channelUp()
remote.channelDown()      // 리모콘 실행 ====> delegate?.channelDown()
