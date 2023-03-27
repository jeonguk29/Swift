//
//  ViewController.swift
//  VC-CyCle
//
//  Created by Allen H on 2022/01/10.
//

import UIKit

// ⭐️ 뷰 컨트롤러 라이프 사이클 관련 메서드 정리
// 내부 메커니즘상 Persent 스타일에 따라 어떤 함수가 해당시점에 호출 될수도 호출이 되지 않을 수도 있음 스토리보드의 세그웨이에서 어떻게 화면을 보여줄지 선택하면
// 옵션에 따라 동작 함수가 다름 ()

class ViewController: UIViewController {

    // view(메인뷰)를 만들어 내는 시점/지점 (한번만 호출): 코드로 짤때 뷰 교체 가능 시점
    // 스토리보드로 이용할때, 호출하면 화면 로드 안됨 ⭐️
//    override func loadView() {
//        //super.loadView() // 재정의해서, 구현할때 상위호출 필요하지 않음(하면 안됨)
//        print("VC-1 loadView 호출됨")
//    }
    // ⭐️ 원칙적으로 코드로 화면 교체시 호출하는 시점임
    /*
     아래 메서드들을 보면 다 super 를 통해 상위메서드들을 호출하는데 내부적으로 상위에서 해당 메서들이 중요한 것을 이미 하고 있기에 부르는것임
     loadView는 상위에서 중요하게 하는 것이 없어 호출하지 않는다라고 생각하자
     */
    
    // 스토리보드 뷰와 연결된 후 (한번만 호출): 코드와 스토리보드의 뷰가 연결된 후 (메모리에 올라와서)
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VC-1 viewDidLoad 호출됨")
    }
    
    

    // 뷰가 나타나기 전 (여러번 호출): 뷰가 화면에서 가려졌다 다시 올라올때마다 호출됨 (즉 화면 갱신이 필요한 경우)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)  // viewDidLoad 와 똑같이 상위 것을 호출해야하고 매개변수로 들어오는걸 거대로 넣어주며 됨 내부적 메커니즘(iOS)으로 인해 불려질것이고 참과 거짓이 전달될 것임
        print("VC-1 viewWillAppear 호출됨")
        /*
         예시) 다음 화면으로 갔다가 다시 돌아오면, (변경사항 업데이트를 위해) 서버에서 데이터를 다 시 받아와야할 수도 있음
         여기에 구현 하면 될것임 화면 뛰우기 전
         */
    }

    // 뷰가 나타난 후
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("VC-1 viewDidAppear 호출됨")
    }

    // 뷰가 사라지기 전
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("VC-1 viewWillDisappear 호출됨")
    }

    // 뷰가 사라지기 전
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("VC-1 viewDidDisappear 호출됨")
    }

    deinit {
        print("VC-1 메모리에서 내려감")
    }

}

