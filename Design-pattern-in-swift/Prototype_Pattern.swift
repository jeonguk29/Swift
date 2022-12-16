protocol Prototype: AnyObject {
    func clone() -> Self
}

class Odongnamu: Prototype {
    var age: Int

    init(age: Int) {
        self.age = age
    }

    func clone() -> Self {
        return Odongnamu(age: self.age) as! Self
    }
}

let odongnamu = Odongnamu(age: 500)
odongnamu.age += 50
print(odongnamu.age)

let odongnamu2 = odongnamu.clone()
odongnamu2.age += 30
print(odongnamu2.age)

/*
550
580
*/

//clone() 이라는 메서드를 통해서 타입을 복제하여 초기화해주고 있습니다. 직접 초기화를 해주는 방법도 있지만 패턴을 사용하여 재사용성을 높여주고 있는 모습입니다.