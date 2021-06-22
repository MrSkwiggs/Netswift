//
//  NetswiftError.swift
//  Netswift
//
//  Created by Dorian Grolaux on 27/06/2018.
//  Copyright © 2020 Skwiggs. All rights reserved.
//

import Foundation

public struct NetswiftError: Swift.Error {
    
    /// The HTTP status code of the error if applicable
    public let code: Int?
    /// The category for the error
    public let category: Category
    /// Additonal information about the error
    public let payload: Data?
    
    public init(httpStatusCode: Int? = nil, category: Category, payload: Data?) {
        self.code = httpStatusCode
        self.category = category
        self.payload = payload
    }
    
    public init(_ category: Category) {
        self.code = nil
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
             (.resourceRemoved, .resourceRemoved):
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
        switch self.category {
        case .requestSerialisationError:
            return "The request couldn't be serialised before being sent out"
        case .requestError:
            return "The request couldn't be processed by the server"
        case .serverError:
            return "The server encountered an internal error while processing the request"
        case .resourceNotFound:
            return "The specified resource could not be found on the server (404)"
        case .resourceRemoved:
            return "The specified resource has been permanently removed"
        case .unexpectedResponseError:
            return "The response returned by the server does not conform to expected type"
        case .noResponseError:
            return "The response returned by the server is empty / nil"
        case .responseDecodingError:
            return "The response's raw data could not be understood"
        case .responseCastingError:
            return "The response could not be casted to the Request's IncomingType"
        case .notAuthenticated:
            return "Cannot authenticate the request; authentication needed"
        case .paymentRequired:
            return "The server requires payment data before it can process the request"
        case .notPermitted:
            return "The server didn't allow this request for this user"
        case .timedOut:
            return "The request took too long to return."
        case .preconditionFailed:
            return "The server does not meet one of the preconditions that the requester put on the request"
        case .methodNotAllowed:
            return "A request method is not supported for the requested resource"
        case .tooManyRequests:
            return "The user has sent too many requests in a given amount of time"
        case .generic(let error):
            return error.localizedDescription
        case .unknown:
            return "An unknown error occured"
        }
    }
}
