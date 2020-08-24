//
//  NetworkTaskQueue.swift
//  Netswift
//
//  Created by Alex Guretzki on 17/02/2020.
//

import Foundation

/// Queues NetworkRequestPerformable - Fails when at least one of the requests fail
public class NetswiftTaskGroup {
    
    private var tasks = [NetswiftTask]()
    private let dispatchGroup = DispatchGroup()
    private var runningUUIDs = Set<UUID>()
    
    private var error: NetswiftError?
    private var completionHandler: ((_ error: NetswiftError?) -> Void)?
    
    public func cancelAll() {
        tasks.forEach { $0.cancel() }
        tasks.removeAll()
        runningUUIDs.removeAll()
    }
    
    /**
     Performs a NetswiftRequestPerformable
     
     - Note: To execute custom async blocks, use:
     ~~~
     public func perform(_ executionBlock: @escaping (_ success: @escaping () -> Void, _ failure: @escaping (_ error: NetswiftError) -> Void) -> Void)
     ~~~
     
    - Parameters:
        - task: the network call that should be executed
        - success: is called when the call was successful so that the object can be retrieved
        - result: the response object of the succeeded network call
     */
    public func perform<Performable: NetswiftRequestPerformable>(_ task: Performable, success: @escaping (_ result: Performable.Response) -> Void) {
        let uuid = UUID()
        
        runningUUIDs.insert(uuid)
        dispatchGroup.enter()
        
        let performingTask = task.perform { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self, self.runningUUIDs.contains(uuid) else { return }
                
                self.runningUUIDs.remove(uuid)
                self.dispatchGroup.leave()
                
                switch result {
                case .success(let response): success(response)
                case .failure(let error): self.handleError(error)
                }
            }
        }
        
        if let task = performingTask {
            tasks.append(task)
        }
    }
    
    /**
     Performs a custom executionBlock.
     
     - Note: To execute OneFitApi calls, use:
     ~~~
     perform<Performable: NetswiftRequestPerformable>(_ task: Performable, success: @escaping (_ result: Performable.Response) -> Void)
     ~~~
     
     - Parameters:
        - executionBlock: The custom executonBlock to execute anything else than a NetswiftRequestPerformable
        - success: needs to be called when the executionBlock call succeeded
        - failure: needs to be called when the executionBlock call failed. This causes all tasks to be cancelled and the completion handler get's called with the error
     
     - important: make sure you call success() or failure(error:) callback based on the result.
     
     *See Example:*
     ~~~
             taskGroup.perform { (success, failure) in
                 ConfirmedCheckinsStore.shared.forceRefresh { (result) in
                     switch result {
                     case .failure(let error):
                         failure(error)
                         
                     case .success(let confirmedCheckIns):
                         checkIns = confirmedCheckIns.all
                         success()
                     }
                 }
             }
     ~~~
     */
    public func perform(_ executionBlock: @escaping (_ success: @escaping () -> Void, _ failure: @escaping (_ error: NetswiftError) -> Void) -> Void) {
        let uuid = UUID()
        
        runningUUIDs.insert(uuid)
        dispatchGroup.enter()
        
        executionBlock({ [weak self] in
            DispatchQueue.main.async {
                guard let self = self, self.runningUUIDs.contains(uuid) else { return }
                
                self.runningUUIDs.remove(uuid)
                self.dispatchGroup.leave()
                
                // Nothing more to do...
            }
            
        }, { [weak self] error in
            DispatchQueue.main.async {
                guard let self = self, self.runningUUIDs.contains(uuid) else { return }
                
                self.runningUUIDs.remove(uuid)
                self.dispatchGroup.leave()
                
                self.handleError(error)
            }
        })
    }
    /**
     Set the completion handler that gets called after all calls returned or one call fails
     
     - Parameters:
        - completionHandler: The completion handler that's called aftere the calls return
        - error: In case of failure - The first Error that was returned by a call and made the whole group fail
     
     - Important: `setCompletionHandler(completionHandler:)` has to be called after all `perfom` calls
     
     ~~~
     let taskGroup = NetworkTaskGroup()
     taskGroup.perform(...)
     taskGroup.perform(...)
     taskGroup.setCompletionHandler(...)
     ~~~
     */
    public func setCompletionHandler(_ completionHandler: @escaping (_ error: NetswiftError?) -> Void) {
        self.completionHandler = completionHandler
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.callCompletionHandler()
            
            self?.cancelAll() // Just to be sure
        }
    }
    
    public init() {}
}

private extension NetswiftTaskGroup {
    func handleError(_ error: NetswiftError) {
        self.error = error
        
        if runningUUIDs.count > 0 {
            cancelAll()
        }
            
        self.callCompletionHandler()
    }
    
    func callCompletionHandler() {
        self.completionHandler?(self.error)
        self.completionHandler = nil
    }
}
