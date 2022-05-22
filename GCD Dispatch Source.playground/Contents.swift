import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let timer = DispatchSource.makeTimerSource(queue: .global())
timer.setEventHandler {
    print("Finish")
}

timer.schedule(deadline: .now(), repeating: 5)
timer.activate()
