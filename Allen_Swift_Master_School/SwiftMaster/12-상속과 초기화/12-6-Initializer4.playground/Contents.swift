import UIKit



/*:
## 클래스의 지정, 편의 생성자 상속의 예외사항
 * 클래스의 생성자 자동 상속 규칙
 ---
 */
//:> 지정생성자 자동상속의 예외 상황 → 저장속성의 기본값 설정
/**============================================================
 - 새 저장 속성이 아예 없거나, 기본값이 설정되어 있다면 (실패 가능성 배제)
   ===> 슈퍼클래스의 지정생성자 모두 자동 상속(하위에서 어떤 재정의도 하지 않으면)
===============================================================**/


// 편의 생성자 같은 경우는 원래 무조건 상속을 안하는게 원칙임
//:> 편의생성자 자동상속의 예외 상황 → 상위지정생성자 모두 상속
/**============================================================
   (초기화 실패 가능성 배제시) 자동 상속
 
 - (1) 지정 생성자 자동으로 상속하는 경우
 - (2) 상위 지정생성자 모두 재정의 구현 (실패 가능성 배제)

   (결국, 모든 지정생성자를 상속하는 상황이 되면 편의생성자는 자동으로 상속됨)
===============================================================**/

// 즉 1번 새 저장 속성이 아예 없거나, 기본값이 설정되어 있다면 => 슈퍼클래스의 지정생성자 모두 자동 상속 + 상속 되지 않는
// 편의생성자도 자동으로 상속됨

/*:
---
* 지정 생성자와 편의 생성자의 실제 사례 - 애플 공식 문서
---
*/
// 음식

class Food {
    var name: String
    
    init(name: String) {     // 지정생성자
        self.name = name
    }
    
    convenience init() {     // 편의생성자 ===> 지정생성자 호출
        self.init(name: "[Unnamed]")
    }
}



let namedMeat = Food(name: "Bacon")   // namedMeat의 이름은 "Bacon"
namedMeat.name

let mysteryMeat = Food()      // mysteryMeat의 이름은 "[Unnamed]"
mysteryMeat.name


// 상위의 지정생성자 ⭐️
// init(name: String)    지정생성자
// convenience init()    편의생성자


// 레서피 재료

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {  // 모든 속성 초기화
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {    // 상위 지정생성자를 편의생성자로 재정의 ===> 지정생성자 호출
        self.init(name: name, quantity: 1)
    }
    
    // convenience init() { }      // 자동 상속 (예외 규칙) : 상위 지정 생정자를 모두 재정의 했음 (현재 하나)
}

// 위에처럼 override convenience init(name: String) 상위 지정 생성자를 그대로 재정의 하면
// 편의 생정자도 그대로 오는데 이유는 convenience init(). 사용시 override convenience init(name: String) 호출할거고
// init(name: String, quantity: Int) 까지 호출 해서 문제가 없는 것임

/*
 convenience init()코드를 보면    self.init(name: "[Unnamed]") 인데
 init(name: String, quantity: Int) 로 바로 안가냐면 상위에서 구현한 부분이 결국에 init( ) 의 내부 구현에서 ====> self.init(name: String)을 호출을 하고 있습니다. 그래서 자동으로 상속이 되면.. 내부구현은 그대로 가져오게 되니..
 init( ) ==> init(name: String) 을 가지오게 되는 것이예요! 즉 상위 기준으로 지정생성자를 부르는거라 여기서
 그 그 형태인 재정의를 했지만 override convenience init(name: String) 를 호출하고 그다음 또 편의 기준으로 같은 층에 있는
 지정 생성자를 호출해야 하니까 init(name: String, quantity: Int) 호출 => 그다음 상위에 있는 지정생성자 호출 순인 것임 

 */

let oneMysteryItem = RecipeIngredient()    //  편의생성자
oneMysteryItem.name
oneMysteryItem.quantity

let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)



// 상위의 지정생성자 ⭐️
// init(name: String, quantity: Int)          지정생성자
// override convenience init(name: String)    편의생성자
// convenience init()                         편의생성자



// 쇼핑아이템 리스트

class ShoppingListItem: RecipeIngredient {
    
    var purchased = false       // 모든 저장속성에 기본값 설정
    // 생각해 볼수 있음 내가 지정생성자를 굳이 만들 필요가 없군아
    
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
    
    // init(name: String, quantity: Int) {}    // 지정생성자 모두 자동 상속
    
    // convenience init(name: String) {}       // 따라서 ====> 편의상속자도 모두 자동 상속됨
    
    // convenience init() {}                   // 따라서 ====> 편의상속자도 모두 자동 상속됨
    
}




var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]


breakfastList[0].name
//breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true


for item in breakfastList {
    print(item.description)
}


// 출력결과 ============================

// 1 x Orange juice ✔
// 1 x Bacon ✘
// 6 x Eggs ✘










//Copyright (c) 2021 we.love.code.allen@gmail.com
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
//distribute, sublicense, create a derivative work, and/or sell copies of the
//Software in any work that is designed, intended, or marketed for pedagogical or
//instructional purposes related to programming, coding, application development,
//or information technology.  Permission for such use, copying, modification,
//merger, publication, distribution, sublicensing, creation of derivative works,
//or sale is expressly withheld.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
