//
//  SomeFilePrivateClass.swift
//  AccessControl
//
//  Created by Allen H on 2021/04/12.
//

import Foundation

fileprivate class SomeFilePrivateClass {        // 명시적인 file-private 선언
    open var someOpenProperty = "SomeOpen"
    public var somePublicProperty = "SomePublic"
    var someInternalProperty = "SomeInternal"
    var someFilePrivateProperty = "SomeFilePrivate"
    private var somePrivateProperty = "SomePrivate"
}
// file-private 보다 낮은 수준들은 다 file-private로 동작
// file-private은 같은 파일 내부에서만 동작 가능 하기에 SomeFilePrivateClass 이 타입 자체는 main.swift에서 못 사용함
// 이 타입을 사용하고 싶으면 아래와 같이 같은 파일 내에서 사용 가능


class SomeFilePrivateControlClass {
    // filepravate 또는 private으로만 선언 가능
    fileprivate let controlProperty = SomeFilePrivateClass()
    
    func controlFunction() {
        let someFilePrivate = SomeFilePrivateClass()
        print(someFilePrivate.someOpenProperty)        // fileprivate으로 동작
        print(someFilePrivate.somePublicProperty)      // fileprivate으로 동작
        print(someFilePrivate.someInternalProperty)    // fileprivate으로 동작
        print(someFilePrivate.someFilePrivateProperty) // 같은 파일이기에 접근가능
        //print(controlProperty.somePrivateProperty)   // 접근 불가
    }
}

