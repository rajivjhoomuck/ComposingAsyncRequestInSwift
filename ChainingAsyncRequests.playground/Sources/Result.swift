import Foundation

/// Basic implementation of the Result type.
///
/// - failure: an error occurred.
/// - success: wraps a successful response object.
public enum Result<T> {
    case failure(Error)
    case success(T)
}
