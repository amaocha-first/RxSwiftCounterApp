//
//  CounterRxViewModel.swift
//  RxSwiftCounterApp
//
//  Created by coco j on 2019/05/05.
//  Copyright © 2019 amaocha. All rights reserved.
//

import RxSwift
import RxCocoa
import RxOptional

struct CounterViewModelInput {
    let countUpButton: Observable<Void>
    let countDownButton: Observable<Void>
    let countResetButton: Observable<Void>
    let userNameTextField: Observable<String?>
    let userNameLabel: UILabel?
}

protocol CounterViewModelOutput {
    var counterText: Driver<String?> { get }
}

protocol CounterViewModelType {
    var outputs: CounterViewModelOutput? { get }
    func setup(input: CounterViewModelInput)
}

class CounterRxViewModel: CounterViewModelType {
    var outputs: CounterViewModelOutput?
    
    private let countRelay = BehaviorRelay<Int>(value: 0)
    private let nameRelay = BehaviorRelay<String>(value: "default")
    private let initialCount = 0
    private let disposeBag = DisposeBag()
    
    private let nameText: (String) -> String = {
        return "あなたの名前は\($0)です"
    }
    
    init() {
        self.outputs = self
        resetCount()
    }
    
    func setup(input: CounterViewModelInput) {
        input.countUpButton.subscribe(onNext: {[weak self] in
            self?.incrementCount()
        }).disposed(by: disposeBag)
        input.countDownButton.subscribe(onNext: {[weak self] in
            self?.decrementCount()
        }).disposed(by: disposeBag)
        input.countResetButton.subscribe(onNext: {[weak self] in
            self?.resetCount()
        }).disposed(by: disposeBag)
        input.userNameTextField.map {[weak self] text -> String? in
            return self!.nameText(text!)
            }.filterNil().bind(to: input.userNameLabel!.rx.text).disposed(by: disposeBag)
    }
    
    private func incrementCount() {
        let count = countRelay.value + 1
        countRelay.accept(count)
    }
    
    private func decrementCount() {
        let count = countRelay.value - 1
        countRelay.accept(count)
    }
    
    private func resetCount() {
        countRelay.accept(initialCount)
    }
    
}

extension CounterRxViewModel: CounterViewModelOutput {
    var counterText: Driver<String?> {
        return countRelay.map { "Rxパターン：\($0)"}.asDriver(onErrorJustReturn: nil)
    }
}
