import Foundation

public struct Customer {
    public let id: String
    
    public var name: String?
    public var billingAddress: Address?
    public var creditCard: CreditCard?
    public var canMakeOnlinePurchase: Bool {
        guard
            let name = self.name,
            name.count > 0,
            let _ = self.billingAddress,
            let _ = self.creditCard
            else { return false }
        return true
    }
    
    public init(with id: String) {
        self.id = id
    }
}

public struct CreditCard {
    public let id: String
    public let cardNumber: String
    public let bankId: String
}

public struct Address {
    public let id: String
    public let address: String
}

public struct Bank {
    public let id: String
    public let name: String
}

extension Customer: CustomStringConvertible {
    public var description: String {
        let check = "✅"
        let cross = "⚠️"
        let nameString = "\(name != nil ? check : cross) | Name"
        let billingAddressString = "\(billingAddress != nil ? check : cross) | Billing Address"
        let creditCardString = "\(creditCard != nil ? check : cross) | Credit Card"
        
        return [nameString, billingAddressString, creditCardString].joined(separator:"\n")
    }
}

