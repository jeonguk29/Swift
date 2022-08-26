/*
프로퍼티 감시자
프로퍼티 감시자를 사용하면 프로퍼티 값이 변경될 때 원하는 동작을 수행할 수 있습니다. 
값이 변경되기 직전에 willSet블럭이, 값이 변경된 직후에 didSet블럭이 호출됩니다.
둘 중 필요한 하나만 구현해 주어도 무관합니다. 
변경되려는 값이 기존 값과 똑같더라도 프로퍼티 감시자는 항상 동작합니다.
willSet 블럭에서 암시적 매개변수 newValue를 사용할 수 있고, didSet 블럭에서 암시적 매개변수 oldValue를 사용할 수 있습니다.

프로퍼티 감시자는 연산 프로퍼티에 사용할 수 없습니다.

*/
struct Money {
    // 프로퍼티 감시자 사용
    var currencyRate: Double = 1100 {
        willSet(newRate) {
            print("환율이 \(currencyRate)에서 \(newRate)으로 변경될 예정입니다")
        }
        
        didSet(oldRate) {
            print("환율이 \(oldRate)에서 \(currencyRate)으로 변경되었습니다")
        }
    }

    // 프로퍼티 감시자 사용
    var dollar: Double = 0 {
        // willSet의 암시적 매개변수 이름 newValue
        willSet {
            print("\(dollar)달러에서 \(newValue)달러로 변경될 예정입니다")
        }
        
        // didSet의 암시적 매개변수 이름 oldValue
        didSet {
            print("\(oldValue)달러에서 \(dollar)달러로 변경되었습니다")
        }
    }

    // 연산 프로퍼티
    var won: Double {
        get {
            return dollar * currencyRate
        }
        set {
            dollar = newValue / currencyRate
        }
        
        /* 프로퍼티 감시자와 연산 프로퍼티 기능을 동시에 사용할 수 없습니다
        // willSet, didSet은 저장되는 값이 변경될때 사용되는 거기 때문에
        // 값을 저장하지 않는 연산 프로퍼티에서는 사용 못하는 것임
        
        willSet {
            
        }
         */
    }    
}

var moneyInMyPocket: Money = Money()

// 환율이 1100.0에서 1150.0으로 변경될 예정입니다
moneyInMyPocket.currencyRate = 1150
// 환율이 1100.0에서 1150.0으로 변경되었습니다

// 0.0달러에서 10.0달러로 변경될 예정입니다
moneyInMyPocket.dollar = 10
// 0.0달러에서 10.0달러로 변경되었습니다

print(moneyInMyPocket.won)
// 11500.0
