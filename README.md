# Throttle

- Simply put, it means to execute your block/operation/task once in a period of time (for instance once every 10 seconds).

<img src="https://imgur.com/rzzZNFm.gif" height="560" alt="repetition"><img src="https://imgur.com/FSezVSS.gif" height="560" alt="throttle">

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
**Without Throttle**
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
**With Throttle**

In effect, there is a hodgepodge of different patterns you can use to execute your function for once like:
* [`dispatch_once`](#`dispatch_once`)
* [Throttle](#throttle)

## `dispatch_once`

`dispatch_once` is one of the solutions that you can use when you have more than one thread kicks off its function at the same time. so in order to solve 
the repetition that can occur you can use `dispatch_once`.
Now you're waiting the `dispatch_once` code. Unfortunately it's deprecated, but likely you can use `lazy var` instead.

`lazy var` or nominally `dispatch_once` used to execute your operation once.
The initial setup phase wrapped in the `dispatch_once` block.
So when the second thread starts, it reaches the `dispatch_once` block and it's prevented from continuing because that section of code is currently running, 
It just like let dispatch block's thread 2 until `dispatch_once` has been completed in thread 1.
When thread 3 comes along, it too blocks until the thread one has completed the `dispatch_once` block.
Once the `dispatch_once` block has completed, then all three threads able to continue with the reminder of the function.

## How to create it:
     lazy var showOnce: Void = {
        return setupNotificationMessage()
     }()

## Usage:
     @objc func handleCheckOut() {
        return showOnce
    }

### Note: 
- In that window of time your app is running, the function will be executed for once. So it's not the best option to use for user experience design.
- If you're looking for getting your user experience desing stable and better, you can use **Throttle**.

## Throttle
 - To throttle a function means to ensure the function is called at most once in a specified time period.

## A simple way of creating throttle:
     class Throttle {

      var workItem = DispatchWorkItem(block: {})

      func throttle(_ block: @escaping ()->()) {

      // Cancel any operation comes along, and initializes the workItem to execute the block of code after two seconds.
      workItem.cancel()
      workItem = DispatchWorkItem {
        block()
      }
      
      // After two seconds we'll start executing the workItem.
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: workItem)
      }
     }

## Usage:
    var throttler = Throttle()
    @objc func handleCheckOut() {
        throttler.throttle({ [weak self] in
            self?.setupNotificationMessage()
        })
    }

- Check out the annotation of [`throttle`](https://github.com/ahmedelserafy7/Throttle/blob/master/Throttle/Throttle.swift) function to manage to grasp the main points better.
## Requirements

This project requires: 
* **Xcode 11+** 
* **iOS 13+**
