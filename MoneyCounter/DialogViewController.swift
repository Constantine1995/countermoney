//
//  DialogViewController.swift
//  MoneyCounter
//
//  Created by mac on 1/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import DLRadioButton
class DialogViewController: UIViewController {
    
    var delegate: closeProtocol?
    
    @IBOutlet weak var SelectCurrency: DLRadioButton!
    
    @IBAction func selectCurrency(_ sender: DLRadioButton) {
        SetMoneyCurrency(sender)
        delegate?.selectedCurrency = sender.titleLabel?.text
        delegate?.closeModal()
    }
    
    func SetMoneyCurrency(_ sender: DLRadioButton) {
        let VC = ViewController()
        
        switch sender.tag {
        case 0: VC.selectedMoneyCurrency = "$"
        case 1: VC.selectedMoneyCurrency = "₴"
        case 2: VC.selectedMoneyCurrency = "€"
        case 3: VC.selectedMoneyCurrency = "₽"
        default: return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
}

}
