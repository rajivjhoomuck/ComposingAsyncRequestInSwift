import Foundation

infix operator |>: AdditionPrecedence

public func |> <T, U, V> (f: @escaping Request<T, Result<U>>, g: @escaping Request<U, Result<V>>) -> Request<T, Result<V>> {
    return { (input, combineCompletion) in
        
        f(input) { (u: Result<U>) in
            switch u {
            case .success(let unwrappedU): g(unwrappedU, combineCompletion)
            case .failure(let error): combineCompletion(.failure(error))
            }
        }
    }
}
