
import Foundation

func currencyFormatter(numberToFormat: Double) -> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
    currencyFormatter.currencySymbol = ""
    currencyFormatter.maximumFractionDigits = 5
    
    return currencyFormatter.string(from: NSNumber(value: numberToFormat))!
    
}

func currencyFormatterTwoDecimals(numberToFormat: Double) -> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
    currencyFormatter.currencySymbol = ""
    currencyFormatter.maximumFractionDigits = 2
    
    return currencyFormatter.string(from: NSNumber(value: numberToFormat))!
    
}

func setRounding(symbol:String) -> Double {
    let roundingPair = ["DogeCoin", "Tether", "DOGE", "USDT"]
    
    
    if(roundingPair.contains(symbol)){
        return 100
    } else {
        return 100000
    }
}
