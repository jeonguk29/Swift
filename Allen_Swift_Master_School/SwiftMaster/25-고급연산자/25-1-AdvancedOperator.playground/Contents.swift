import UIKit


/*:
 # Part25 - 고급연산자(Advanced Operators)
 */
/*:
 ## 숫자 리터럴
* 스위프트의 숫자 리터럴 표기방법
---
*/
//스위프트의	 숫자 리터럴을 표기하는 방법

var num: Int = 25


// 2진법/8진법/16진법의 수도 직접 써 넣을 수 있음
num = 0b00011001    //0b는 2진법을 뜻함
num = 0o31
num = 0x19


// 큰숫자는 읽기 쉽게하기위해 언더바를 붙이는 것도 가능
// (단순히 언더바를 읽지않음)
num = 1_000_000
num = 10_000_000
num = 10000_0000



/*:
---
* 스위프트 정수 타입과 범위
---
*/
/**========================================
[스위프트의 정수 타입]
 - 플랫폼 사양에 따르는 타입 : Int, UInt (최근 대부분 64비트)             😀32비트 사용시 4바이트 64비트시 8바이트 사용
 -  8-bit : Int8, UInt8                                                             뒤에 붙는 숫자는 비트를 말함 8비트 즉 1바이트 256 까지 저장가능
 - 16-bit : Int16, UInt16                                                         2바이트
 - 32-bit : Int32, UInt32
 - 64-bit : Int64, UInt64
===========================================**/

// MemoryLayout<> 제네릭들어감 몇바이트 사용하는지 어떤 타입을 넣는 확인 가능함

MemoryLayout<Int8>.size   // 1바이트
Int8.max      //  127    ( 2^7승 -1)
Int8.min      // -128    (-2^7승)


MemoryLayout<UInt8>.size     // 1바이트
UInt8.max     //  255     ( 2^8승 -1)
UInt8.min     //    0


MemoryLayout<Int>.size     // 8바이트      64비트 
Int.max       //  9223372036854775807   ( 2^63승 -1)
Int.min       // -9223372036854775808   (-2^63승 )







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
