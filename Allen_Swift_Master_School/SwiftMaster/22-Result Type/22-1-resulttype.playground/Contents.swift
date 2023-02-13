import UIKit


/*:
 # Part22 - Result Type
 */
/*:
 ## Result 타입
 * Result 타입에 대한 이해
 ---
 */
/**======================================================
 - 에러가 발생하는 경우, 에러를 따로 외부로 던지는 것이 아니라
 - 리턴 타입 자체를 Result Type(2가지를 다 담을 수 있는)으로 구현해서
 - 함수 실행의 성공과 실패의 정보를 함께 담아서 리턴


 - 실제 Result타입의 내부 구현
 - enum Result<Success, Failure> where Failure : Error
 - https://developer.apple.com/documentation/swift/result


 - Result타입은 열거형
 - case success(연관값)
 - case failure(연관값)
 ========================================================**/

/*:
 ---
 * 에러 처리의 과정 (3단계)
 ---
 */
// 에러 정의 (어떤 에러가 발생할지 경우를 미리 정의)

enum HeightError: Error {    //에러 프로토콜 채택 (약속)
    case maxHeight
    case minHeight
}




// throwing함수 (앞에서 배운)

func checkingHeight(height: Int) throws -> Bool {    // (에러를 던잘수 있는 함수 타입이다)
    
    if height > 190 {
        throw HeightError.maxHeight
    } else if height < 130 {
        throw HeightError.minHeight
    } else {
        if height >= 160 {
            return true
        } else {
            return false
        }
    }
}




do {
    let _ = try checkingHeight(height: 200)
    print("놀이기구 타는 것 가능")
} catch {
    print("놀이기구 타는 것 불가능")
}




/*:
 ---
 * Result타입을 활용한 에러의 처리
 ---
 */
// 에러는 동일하게 정의되어 있다고 가정
// Result타입에는 성공/실패했을 경우에 대한 정보가 다 들어있음

// throws -> 에러를 굳이 따로 던질 필요가 없음  Result 타입안에 성공일때 타입과 실패일때 타입을 구체적으로 명시해주면 됨
// 성공하면 내부적으로 열거형 연관 값에 트루 펄스 Bool 타입을 주고, 실패시 내부적으로 열거형 연관 값에 HeightError 라는 에러 타입을 주는 것임
// 내부적 제네릭이라 어떤 타입 다 줄 수 있음
func resultTypeCheckingHeight(height: Int) -> Result<Bool, HeightError> {
    
    if height > 190 {
        return Result.failure(HeightError.maxHeight)
    } else if height < 130 {
        return Result.failure(HeightError.minHeight)
    } else {
        if height >= 160 {
            return Result.success(true)
        } else {
            return Result.success(false)
        }
    }
}



// 리턴값을 받아서
let result = resultTypeCheckingHeight(height: 200)  // try를 쓸 필요가 없어짐 그냥 받으면 되는 것임 Result 타입이 됨


// 처리
switch result {
case .success(let data):
    print("결과값은 \(data)입니다.")
case .failure(let error):
    print(error)
}

// 코드가 엄청 깔끔해짐 열거형이라 스위치 처리하면 됨


/*:
 ---
 * Result타입의 다양한 활용
 ---
 */
// Result타입에는 여러메서드가 존재
// get()메서드는 결과값을 throwing함수처럼 변환가능한 메서드 (Success밸류를 리턴)

do {
    let data = try result.get()
    print("결과값은 \(data)입니다.")
} catch {
    print(error)    // 성공 실패 두 타입을 가지고 있어서 실패시 여기로 던져줌
}


/**==================================================
 - Result타입을 왜 사용할까?
 
 - 성공/실패의 경우를 깔끔하게 처리가 가능한 타입

 - 기존의 에러처리 패턴을 완전히 대체하려는 목적이 아니라
   개발자에게 에러 처리에 대한 다양한 처리 방법에 대한 옵션을 제공
 ====================================================**/

// 기존 처리는 불편했었음 에러 따로 던질 필요 없음 throws 키워드 x
// do-catch로 감 쌓을 필요도 x, try키워드로 함수를 호출 할 필요도 x
// 실제 함수를 호출하는 곳에서 에러형식을 특정짓기 어려웠음 무슨 에러인지 하지만 결과 타입은
// Result<Bool, HeightError> 이렇게 직접적으로 무슨 에러가 날지 HeightError 에러타입을 명시적 선언 할 수 있음

// 에러 처리 단원에서 사용했던 타입캐스팅도 불 필요
//     if let error = error as? HeightError {    // 실제 우리가 정의한 구체적인 에러 타입이 아니고, 에러 타입(프로토콜)이 넘어올 뿐
//     타입 케스팅을 통해서 우리가 정의한 에러인지 확인 해야 했었음
// 즉 에러에 대한 사후 처리 코드가 엄청 깔끔해짐







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
