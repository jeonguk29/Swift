//
//  SomeInternalClass.swift
//  AccessControl
//
//  Created by Allen H on 2021/04/12.
//

import Foundation

class SomeInternalClass {                          // 암시적인 internal 선언
    open var someOpenProperty = "SomeOpen"         // internal으로 동작 ⭐️
    public var somePublicProperty = "SomePublic"
    var someInternalProperty = "SomeInternal"
    fileprivate var someFilePrivateProperty = "SomeFilePrivate"
    private var somePrivateProperty = "SomePrivate"
}

// internal 보다 낮은 수준은 internal로 동작
