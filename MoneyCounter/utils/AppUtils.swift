//
//  AppUtils.swift
//  MoneyCounter
//
//  Created by mac on 1/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

extension String {
    
    func formatTime(_ time: Int) -> String {
        let hours = time / 3600
        let minutes = (time / 60) % 60
        let seconds = time % 60
        return String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
    }
    
    func formatMoney(_ moneyDelta: Float,_ currency: String,_ time: Int) -> String {

        let result : Float = Float(time) * moneyDelta / 3600
        return String(format: "%.02f" + currency, result)
    }
}

