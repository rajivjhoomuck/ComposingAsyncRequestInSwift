/*: 
 ## Chaining Async Requests
 Companion playground for medium article: [Composing Asynchronous Functions in Swift](https://medium.com/@jhoomuck/composing-asynchronous-functions-in-swift-acd24cf5b94a)

 */

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 ## Use the `|>` operator to compose requests.

 - Note:
 **Each request (open API.swift from the Sources directory) has a `shouldFail` toggle. You can set it to `true` and test the result for `validation` and `bankUsing`.**
 */


/*:
 ### A simple validation
 - Experiment: **Validating a user for purchase**
 */
func foo(customer: Customer) { print("🔥Customer naam update: " + (customer.name ?? "Unnamed!")) }

let update: Request<Customer, Result<Customer>> = { customer, customerCompletion in
    foo(customer: customer);
    customerCompletion(.success(customer))
}

let startIdentity: Request<String, Result<String>> =  { $1(.success($0)) }

let validation = startIdentity
    |> fetchCustomer
    |> { print("🆔"); $1(.success($0)) }
    |> (update)
    |> updateAddress
    |> updateCreditCard

/*:
 * Callout(Using the `validation` function):
 Here is how you could use the `validation` function:
 
 
    validation("12345") {
        switch $0 {
        case .success(let customer): print(customer)
        case .failure(let error): print(error.localizedDescription)
        }
    }
*/
// <#Type the above code here to see the request#>
validation("12345") {
    print("\n\nAfter validation: 👹")
    switch $0 {
    case .success(let customer): print(customer.canMakeOnlinePurchase)
    case .failure(let error): print(error.localizedDescription)
    }
}

/*:
 ### Grab the bank from a customer identifier
 Now, say you want to reach the bank of the customer, you could compose a function like the following:
 
 - Experiment: **Reach bank using a customer identifier**
 */
let bankUsing = fetchCustomer |> updateCreditCard |> fetchBank

/*:
 * Callout(Reach the bank from a customer identifier):
 Here is how you use the above function.:
 
 
    bankUsing("12345") {
        switch $0 {
        case .success(let bank): print(bank)
        case .failure(let error): print(error.localizedDescription)
        }
    }
*/
// <#Type the above code here to see the request#>
