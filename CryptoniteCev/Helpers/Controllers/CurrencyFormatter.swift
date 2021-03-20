
import Foundation

/**
 Funcion que formateará número double y lo devolverá en forma de string
 */
func currencyFormatter(numberToFormat: Double) -> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
    currencyFormatter.currencySymbol = ""
    currencyFormatter.maximumFractionDigits = 5
    
    return currencyFormatter.string(from: NSNumber(value: numberToFormat))!
    
}

/**
 Funcion que formateará número double y lo devolverá en forma de string con solo 2 decimales
*/
func currencyFormatterTwoDecimals(numberToFormat: Double) -> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
    currencyFormatter.currencySymbol = ""
    currencyFormatter.maximumFractionDigits = 2
    
    return currencyFormatter.string(from: NSNumber(value: numberToFormat))!
    
}

/**
Funcion que decidirá el tipo de redondeo según la moneda
*/
func setRounding(symbol:String) -> Double {
    let roundingPair = ["DogeCoin", "Tether", "DOGE", "USDT"]
    
    if(roundingPair.contains(symbol)){
        return 100
    } else {
        return 100000
    }
}

/**
 Funcion que formateará número float y lo devolverá en forma de string
*/
func currencyFormatterFloat(numberToFormat: Float, decimalsQuantity:Int ) -> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
    currencyFormatter.currencySymbol = ""
    currencyFormatter.maximumFractionDigits = decimalsQuantity
    
    return currencyFormatter.string(from: NSNumber(value: numberToFormat))!
    
}
