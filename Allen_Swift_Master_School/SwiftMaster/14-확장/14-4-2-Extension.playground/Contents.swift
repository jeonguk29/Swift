struct Dog {
    var name: String = ""
    var weight: Int = 0
    var height: Int = 0
   
    init(name: String){ // 구조체 확장 정정 : 구조체는 확장 지정이던, 편의던 자유롭게 확장 가능
        self.name = name
    }
}

// Dog(name: <#T##String#>)  생성자 하나 밖에없음 내가 먼저 구조체 안에 만들어서 사라진것임



struct Dog2 {
    var name: String = ""
    var weight: Int = 0
    var height: Int = 0
}

extension Dog2 {
    init(name: String){ // 구조체 확장 정정 : 구조체는 확장 지정이던, 편의던 자유롭게 확장 가능
        self.name = name
    }
}

// 위에서는 내가 지정생성자 만들면 기본 제공 없어졌지만 확장시 기존에 있는걸 살려두면서
// 내가 만든 지정 생성자 까지 추가 가능함
// 하지만 이름 겹치는건 주위 해야함

//Dog2()
//Dog2(name: String ,weight: Int, height: Int) // 기본적으로 두개 재공함
//Dog2(name: String)
