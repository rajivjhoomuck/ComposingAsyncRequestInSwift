import Foundation

let requestQueue = DispatchQueue(label: "RequestQueue", qos: .background)

/// Mock request that waits for 0.5 seconds and then call the completion block
///
/// - Parameter completion: the block of code to execute for the request
public func request(completion: @escaping () -> Void) {
    requestQueue.asyncAfter(deadline: .now() + 0.5) { completion() }
}



