import Cocoa

//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.


enum NumberError: Error {
  case NegativeNumber(number: Int)
  case ZeroNumber
  case OddNumber(number: Int)
}

extension NumberError: CustomStringConvertible {
         var description: String {
         switch self {
             case .NegativeNumber(let number):
                 return "Отрицательное число \(number)"
             case .OddNumber(let number):
                return "Число не четное \(number)"
             case .ZeroNumber:
                return "0."
      }
   }
}


class EvenNumbers {
    
     func validateEvenNumber(_ number: Int)  -> (Int?, NumberError?) {
         if number == 0 {
            return (nil, NumberError.ZeroNumber)
         } else if number < 0 {
            return (nil, NumberError.NegativeNumber(number: number))
         } else if number % 2 == 1 {
             return (nil, NumberError.OddNumber(number: number))
         }
        return (number, nil)
    }
}

let evenNumbers = EvenNumbers()
let number1 = evenNumbers.validateEvenNumber(8)
print(number1)


struct Burger {
    var typeOfBurger: TypeOfBurger
    var typeOfBun: TypeOfBun
    let onion: String
    var souses: Souses
    let price: Int
    var count: Int
    let name: String
}

enum TypeOfBurger: Int {
    case beef = 10
    case chicken = 5
    case fish = 0
}

enum TypeOfBun: Int {
    case white = 3
    case black = 10
}

enum Souses: Int {
    case ketchup = 4
    case mayonnaise = 5
    case mustard = 6
}

enum MakeBurgerError: Error {
    case invalidSelection
    case outOfStock
    case notEnoughMoney(coinsNeeded: Int)
    case notEnoughIngredients
}


class MakeBurger {
    var burgers = ["Beef Burger": Burger(typeOfBurger: TypeOfBurger.beef, typeOfBun: TypeOfBun.white, onion: "Red", souses: Souses.ketchup, price: 10, count: 12, name: "Beef Burger"), "Chicken Burger": Burger(typeOfBurger: TypeOfBurger.chicken, typeOfBun: TypeOfBun.white, onion: "White", souses: Souses.mayonnaise, price: 8, count: 20, name: "Chicken Burger"), "Fish Burger": Burger(typeOfBurger: TypeOfBurger.fish, typeOfBun: TypeOfBun.black, onion: "Red", souses: Souses.ketchup, price: 15, count: 3, name: "Fish Burger")]
    
    var receivedMoney = 0
    
    func checkIngredients(typeOfBurger name: String) throws {
       guard let item = burgers[name] else {
            throw MakeBurgerError.invalidSelection
        }
        guard item.typeOfBurger.rawValue > 0 else {
            throw MakeBurgerError.notEnoughIngredients
        }
        guard item.typeOfBun.rawValue > 0 else {
            throw MakeBurgerError.notEnoughIngredients
        }
        guard item.souses.rawValue > 0 else {
            throw MakeBurgerError.notEnoughIngredients
        }
    }
    
    func sellBurger(typeOfBurger name: String) throws -> Burger {
        guard let item = burgers[name] else {
            throw MakeBurgerError.invalidSelection
        }
        guard item.count > 0 else {
            throw MakeBurgerError.outOfStock
        }
        
        guard item.price <= receivedMoney else {
                throw MakeBurgerError.notEnoughMoney(coinsNeeded: item.price - receivedMoney)
            }

        receivedMoney -= item.price
        var newItem = item
        newItem.count -= 1
        burgers[name] = newItem
        return newItem.self
    }
    

        
}



let makeBurger = MakeBurger()
makeBurger.receivedMoney = 3

do {
    _ = try makeBurger.checkIngredients(typeOfBurger: "Fish Burger")
} catch MakeBurgerError.notEnoughIngredients {
    print("Не достаточно ингредиентов для этого бургера")
}

do {
    _ = try makeBurger.sellBurger(typeOfBurger: "Beef Burger")
} catch MakeBurgerError.invalidSelection {
    print("Таких бургеров у нас нет")
} catch MakeBurgerError.notEnoughMoney(let coinsNeeded) {
    print("Не достаточно средств, добавьте \(coinsNeeded)")
} catch MakeBurgerError.outOfStock {
    print("К сожалению эти бургеры закончились, выберете другой")
} catch let error {
    print(error.localizedDescription)
}
