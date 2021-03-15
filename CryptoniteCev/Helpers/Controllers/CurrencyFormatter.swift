
import Foundation

func currencyFormatter(numberToFormat: Double) -> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
    currencyFormatter.currencySymbol = ""
    currencyFormatter.maximumFractionDigits = 10
    
    return currencyFormatter.string(from: NSNumber(value: numberToFormat))!
    
}
