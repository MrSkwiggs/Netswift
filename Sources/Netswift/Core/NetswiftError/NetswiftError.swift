//
//  NetswiftError.swift
//  Netswift
//
//  Created by Dorian Grolaux on 27/06/2018.
//  Copyright © 2020 Skwiggs. All rights reserved.
//

import Foundation

public struct NetswiftError: Swift.Error {

    /// The category for the error
    public let category: Category
    /// Additonal information about the error
    public let payload: Data?
    
    public init(category: Category, payload: Data?) {
        self.category = category
        self.payload = payload
    }
    
    public init(_ category: Category) {
        self.category = category
        self.payload = nil
    }
}

extension NetswiftError: Equatable {
    public static func == (lhs: NetswiftError, rhs: NetswiftError) -> Bool {
        switch (lhs.category, rhs.category) {
        case (.requestSerialisationError, .requestSerialisationError),
            (.requestError, .requestError),
            (.unexpectedResponseError, .unexpectedResponseError),
            (.noResponseError, .noResponseError),
            (.responseCastingError, .responseCastingError),
            (.notAuthenticated, .notAuthenticated),
            (.notPermitted, .notPermitted),
            (.timedOut, .timedOut),
            (.preconditionFailed, .preconditionFailed),
            (.methodNotAllowed, .methodNotAllowed),
            (.tooManyRequests, .tooManyRequests),
            (.serverError, .serverError),
            (.paymentRequired, .paymentRequired),
            (.resourceNotFound, .resourceNotFound),
            (.resourceRemoved, .resourceRemoved),
            (.unprocessableEntity, .unprocessableEntity):
            return true
            
        case (.responseDecodingError(let lhsError), .responseDecodingError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
            
        default:
            return false
        }
    }
}

extension NetswiftError: CustomDebugStringConvertible {
    public var debugDescription: String {
        let description: String
        switch self.category {
        case .requestSerialisationError:
            description = "The request couldn't be serialised before being sent out"
        case .requestError:
            description = "The request couldn't be processed by the server"
        case .serverError:
            description = "The server encountered an internal error while processing the request"
        case .resourceNotFound:
            description = "The specified resource could not be found on the server (404)"
        case .resourceRemoved:
            description = "The specified resource has been permanently removed"
        case .unexpectedResponseError:
            description = "The response returned by the server does not conform to expected type"
        case .noResponseError:
            description = "The response returned by the server is empty / nil"
        case let .responseDecodingError(decodingError):
            description = decodingError.fullDescription
        case .responseCastingError:
            description = "The response could not be casted to the Request's IncomingType"
        case .notAuthenticated:
            description = "Cannot authenticate the request; authentication needed"
        case .paymentRequired:
            description = "The server requires payment data before it can process the request"
        case .notPermitted:
            description = "The server didn't allow this request for this user"
        case .timedOut:
            description = "The request took too long to return."
        case .preconditionFailed:
            description = "The server does not meet one of the preconditions that the requester put on the request"
        case .methodNotAllowed:
            description = "A request method is not supported for the requested resource"
        case .tooManyRequests:
            description = "The user has sent too many requests in a given amount of time"
        case .unprocessableEntity:
            description = "The server understands the content type of the request entity, and the syntax of the request entity is correct, but it was unable to process the contained instructions. The client should not repeat this request without modification."
        case .generic(let error):
            description = error.localizedDescription
        case .unknown:
            description = "An unknown error occured"
        }

        return """
        \(description)

        Payload:
        \(payload?.prettyPrinted ?? "None")
        """
    }
}

private extension Data {
    var prettyPrinted: String {
        let plainString = String(data: self, encoding: .utf8)
        let plainDescription = "Data with \(count) bytes"

        if let json = try? JSONSerialization.jsonObject(with: self) {
            guard let data = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]),
                  let prettyString = String(data: data, encoding: .utf8) else {
                return "Invalid JSON\n\(plainString ?? plainDescription)"
            }
            return prettyString
        } else if let plainString = plainString {
            return plainString
        } else {
            return plainDescription
        }
    }
}

private extension DecodingError {
    var fullDescription: String {
        switch self {
        case .typeMismatch(let any, let context):
            return context.debugDescription
        case .valueNotFound(let any, let context):
            return context.debugDescription
        case .keyNotFound(let codingKey, let context):
            return context.debugDescription
        case .dataCorrupted(let context):
            return context.debugDescription
        @unknown default:
            return "Unknown default decoding error"
        }
    }
}
