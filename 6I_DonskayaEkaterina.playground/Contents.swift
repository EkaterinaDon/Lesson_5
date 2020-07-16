import Cocoa

//
//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.


struct QueueArray<T: Comparable> {
   
    private var elements: [T] = []
    mutating func enQueue(_ element: T) {
        elements.append(element)
    }
    mutating func deQueue() -> T? {
        return elements.removeFirst()
    }
    
    
    subscript(index: Int) -> Int? {
        while index > self.elements.count {
            return nil
            }
        return index
    }
    
    func myEvenInts() -> [T] {
        
        let newElements = elements.filter { $0 as! Int % 2 == 0 }
        return newElements
    }
        
    
    func multiplyInt(by: Int) -> [Int] {
        let result = elements.map { $0 as! Int * by }
        return result
    }
    
    func reversedQueue () -> [T] {
        let reversed = elements.sorted { (s1: T, s2: T) -> Bool in
            s1 > s2
        }
        return reversed
    }
    

    func printIndex() -> T {
        elements.enumerated().forEach({print("\($0) - \($1)")}) as! T // здесь ругается: Thread 1: signal SIGABRT , но работает.
    }
}


var queue = QueueArray<Int>()
queue.enQueue(1)
queue.enQueue(2)
queue.enQueue(3)
queue.enQueue(4)
queue.enQueue(5)
queue.enQueue(6)
queue.enQueue(7)
queue.enQueue(8)
queue.enQueue(9)
queue.enQueue(10)
print(queue)
//queue.deQueue()
//print(queue)
print(queue[11] as Any)

let evenQueue = queue.myEvenInts()
print(evenQueue)

let byThree = queue.multiplyInt(by: 3)
print(byThree)

let reverseQueue = queue.reversedQueue()
print(reverseQueue)

var queueNames = QueueArray<String>()
queueNames.enQueue("Masha")
queueNames.enQueue("Dasha")
queueNames.enQueue("Olya")
queueNames.enQueue("Misha")
queueNames.enQueue("Sasha")
print(queueNames)

let reverseNames = queueNames.reversedQueue()
print(reverseNames)

//let showIndex = queueNames.printIndex()
