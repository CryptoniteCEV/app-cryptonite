import Foundation


class AboutCoins{
    
    let coins:[String:String]
    
    private init() {
        
        //información que aparecera en la pantalla de la moneda
        self.coins = ["Bitcoin":"The world’s first cryptocurrency, Bitcoin is stored and exchanged securely on the internet through a digital ledger known as a blockchain. Bitcoins are divisible into smaller units known as satoshis — each satoshi is worth 0.00000001 bitcoin.",
                      "Ethereum": "Ethereum is a decentralized computing platform that uses ETH (also called Ether) to pay transaction fees (or “gas”). Developers can use Ethereum to run decentralized applications (dApps) and issue new crypto assets, known as Ethereum tokens.",
                      "Litecoin": "Litecoin is a cryptocurrency that uses a faster payment confirmation schedule and a different cryptographic algorithm than Bitcoin.",
                      "DogeCoin":"Dogecoin is a cryptocurrency that was created as a joke — its name is a reference to a popular Internet meme. It shares many features with Litecoin. However, unlike Litecoin, there is no hard cap on the number of Dogecoins that can be produced."]
    }
    
    static let shared = AboutCoins()
    
}
