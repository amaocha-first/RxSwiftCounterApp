//
//  CounterViewModel.swift
//  RxSwiftCounterApp
//
//  Created by coco j on 2019/05/05.
//  Copyright © 2019 amaocha. All rights reserved.
//

import Foundation

class counterViewModel {
    private(set) var count = 0
    
    func incrementCount(callback: (Int) -> ()) {
        count += 1
        callback(count)
    }
    
    func decrementCount(callback: (Int) -> ()) {
        count -= 1
        callback(count)
    }
    
    func resetCount(callback: (Int) -> ()) {
        count = 0
        callback(count)
    }
}
