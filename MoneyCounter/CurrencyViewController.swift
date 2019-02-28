//
//  CurrencyViewController.swift
//  MoneyCounter
//
//  Created by mac on 1/23/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import DLRadioButton
import Toast_Swift
class CurrencyViewController: UIViewController,UIPickerViewDelegate, closeProtocol  {

    // TextFields
    @IBOutlet weak var currency: UITextField!
    @IBOutlet weak var hourlyRate: UITextField!
    
     // Variables
    var selectedHourlyRateMoney: String {
        get {
        if let titleHourlyRateMoney = UserDefaults.standard.string(forKey: "SelectedCurrencyValue") as String? { return titleHourlyRateMoney } else { return defaultHourlyCurrencyMoney }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "SelectedCurrencyValue")
            UserDefaults.standard.synchronize()
        }
    }
    
    var selectedMoneyCurrency: String {
        get {
            if let moneyCurrency = UserDefaults.standard.string(forKey: "moneyCurrency") as String? {
                return moneyCurrency
            } else  {return "$"}
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "moneyCurrency")
            UserDefaults.standard.synchronize()
        }
    }
    
    var selectedCurrency: String? {
        get {
            if let currency = UserDefaults.standard.string(forKey: "TitleHorlyRate") {
                return currency
            } else { return defaultMoneyCurrency }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "TitleHorlyRate")
            UserDefaults.standard.synchronize()
        }
    }
    
    var labelcurrencyDestination = String()
    var popVC: DialogViewController?
    let defaultMoneyCurrency = "Доллар $"
    let defaultHourlyCurrencyMoney = "1.0"
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTapsRequired = 1
        currency?.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapped() {
        self.popVC = storyboard?.instantiateViewController(withIdentifier: "popVC") as? DialogViewController
        popVC?.modalPresentationStyle = .popover
        popVC?.delegate = self

        let popOverVC = popVC?.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.currency
        popOverVC?.sourceRect = CGRect(x: self.currency.bounds.midX, y: self.currency.bounds.maxY, width: 0, height: 0)
        popVC?.preferredContentSize = CGSize(width: 200, height: 150)
        self.present(popVC!, animated: true)
    }
    
    @IBAction func SaveAction(_ sender: Any) {
        if hourlyRate.text!.isEmpty {
            toastMessage("Ошибка, заполнены не все поля")
        }  else if Float(hourlyRate.text!)! <= 0 {
            toastMessage("Ошибка, ставка должна быть больше 0")
        }
        else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "FirstVC") as! ViewController
            vc.selectedHourlyMoneyCurrency = Float(hourlyRate.text!)!
            self.navigationController?.pushViewController(vc, animated: true)
            selectedHourlyRateMoney = hourlyRate.text ?? defaultHourlyCurrencyMoney
        }
    }
    
    func closeModal() {
        labelcurrencyDestination = self.selectedCurrency ?? defaultMoneyCurrency
        currency.text = labelcurrencyDestination
        popVC?.dismiss(animated: true, completion: nil)
    }

    func toastMessage(_ text: String) {
        self.view.makeToast(text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        currency.text = selectedCurrency
        hourlyRate.text = selectedHourlyRateMoney
    }
}

extension CurrencyViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
        }
}
