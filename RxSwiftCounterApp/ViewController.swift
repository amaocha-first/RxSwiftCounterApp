//
//  ViewController.swift
//  RxSwiftCounterApp
//
//  Created by coco j on 2019/05/05.
//  Copyright © 2019 amaocha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countUpButton: UIButton!
    @IBOutlet weak var countDownButton: UIButton!
    @IBOutlet weak var countResetButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: CounterRxViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        
    }
    
    private func setupViewModel() {
        viewModel = CounterRxViewModel()
        let input = CounterViewModelInput(
            countUpButton: countUpButton.rx.tap.asObservable(),
            countDownButton: countDownButton.rx.tap.asObservable(),
            countResetButton: countResetButton.rx.tap.asObservable(),
            userNameTextField: userNameTextField.rx.text.asObservable(),
            userNameLabel: self.userNameLabel
        )
        viewModel.setup(input: input)
        
        viewModel.outputs?.counterText.drive(countLabel.rx.text).disposed(by: disposeBag)
    }
}

