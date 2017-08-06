import Foundation

public typealias RequestCompletion<T> = (T) -> Void
public typealias Request<T, U> = (T, @escaping RequestCompletion<U>) -> Void

public func fetchCustomer(using customerId: String, completion: @escaping RequestCompletion<Result<Customer>>) {
    request {
        print("Name request:")
        
        let shouldFail = false
        
        switch shouldFail {
        case false:
            var customer = Customer(with: customerId)
            customer.name = "Bonzy"
            print(customer, "\n")
            completion(.success(customer))
        case true:
            let err = NSError(domain: "com.bonzy", code: 1, userInfo: nil)
            completion(.failure(err))
        }
    }
}

public func updateAddress(of customer: Customer, completion: @escaping RequestCompletion<Result<Customer>>) {
    request {
        print("Billing Address request:")
        
        let shouldFail = false
        
        switch shouldFail {
        case false:
            var customer = customer
            customer.billingAddress = Address(id: "123", address: "3 rue Mazarin")
            print(customer, "\n")
            completion(.success(customer))
        case true:
            let err = NSError(domain: "com.bonzy", code: 1, userInfo: nil)
            completion(.failure(err))
        }
    }
}

public func updateCreditCard(of customer: Customer, completion: @escaping RequestCompletion<Result<Customer>>) {
    request {
        print("Credit Card request:")
        
        let shouldFail = false
        
        switch shouldFail {
        case false:
            var customer = customer
            customer.creditCard = CreditCard(id: "456", cardNumber: "1234567890", bankId: "789")
            print(customer, "\n")
            completion(.success(customer))
        case true:
            let err = NSError(domain: "com.bonzy", code: 1, userInfo: nil)
            completion(.failure(err))
        }
    }
}

public func fetchBank(of customer: Customer, completion: @escaping RequestCompletion<Result<Bank>>) {
    request {
        print("Bank request:")
        
        let shouldFail = false
        
        switch shouldFail {
        case false:
            let bankId = customer.creditCard?.bankId ?? "000"
            let bank = Bank(id: bankId, name: "Paro Bank")
            print(bank, "\n")
            completion(.success(bank))
        case true:
            let err = NSError(domain: "com.bonzy", code: 1, userInfo: nil)
            completion(.failure(err))
        }
    }
}


