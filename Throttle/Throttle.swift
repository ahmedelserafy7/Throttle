//
//  Throttle.swift
//  Throttle
//
//  Created by Elser_10 on 2/6/21.
//  Copyright © 2021 Elser_10. All rights reserved.
//

import Foundation

class Throttle {
    
    private var workItem: DispatchWorkItem = DispatchWorkItem(block: {})
    private var previousRun: Date = Date.distantPast
    private let queue: DispatchQueue
    private let minimumDelay: TimeInterval
    
    /// Takes `minumumDelay`, and `queue` parameter.
    /// - Parameter minimumDelay: The given window of time by the user.
    /// - Parameter queue: It's `main` queue by default, but you can change it if you want.
    init(minimumDelay: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
        self.minimumDelay = minimumDelay
        self.queue = queue
    }
    
    
    /// Takes block of code that will be executed later.
      /// - Parameter block: takes a closure that takes no parameters and returns void.
    /**
     ## An annotation of using a throttle function:
     
     * *workItem.cancel*: First off, cancel any operation comes along.
     * *workItem = DispatchWorkItem*: Initializes the workItem to execute the block of code after a given window of time.
     * *previousRun = Date*: Refresh the `previousRun` when it executes by giving it new date.
     * *delay*: If the time exceeds the `miniumDelay` that you should wait for, execute the function immediately; it's time to  launch the app, it just like the  launch time or the zero hour!, but if the time doesn't exceed the the given window of time, it should wait for the `minimumDelay` to come through.
         * then the `delay` variable will be given to the `asyncAfter` to choose between  the the  current moments  to execute the task now or later.
   */
    func throttle(_ block: @escaping () -> ()) {
        workItem.cancel()
        workItem = DispatchWorkItem() { [weak self] in
            self?.previousRun = Date()
            block()
        }
        
        let delay = previousRun.timeIntervalSinceNow > minimumDelay ? 0 : minimumDelay
        queue.asyncAfter(deadline: .now() + Double(delay), execute: workItem)
    }
}
