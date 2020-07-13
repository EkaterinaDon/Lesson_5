import Cocoa

//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//
//6. Вывести сами объекты в консоль.


protocol Car: CustomStringConvertible {
    var model: String { get }
    var year: Int { get }
    var km: Double { get set }
    func doorPosition(type: String)
    func transmission(type: String)
}

extension Car {
    func printCar() {
        print(description)
    }
}

extension Car {
    func doorPosition(type: String) {
        if type == "open" {
            print("Двери открыты")
        } else if type == "close" {
            print("Двери закрыты")
        }
    }
}

extension Car {
    func tramsmission(type: String) {
            }
}

enum TruckTypes {
    case dump, garbage, logCarrier, refrigerator, tractor
}

enum AutotruckLoad: Int {
    case fullTruckLoad = 3000
    case lowTruckLoad = 1000
    case fullContainerLoad = 2000
}

class TruncCar: Car {
    
    var model: String = ""
    
    var year: Int = 0
    
    var km: Double = 0.0
    
    var truckType: TruckTypes
    
    var truckLoad: AutotruckLoad {
        willSet {
            if newValue == .fullTruckLoad {
                print("Грузовик загружен полностью")
            } else if newValue == .fullContainerLoad {
                print("Заполнен один контейнер")
            } else {
               print("Еще есть место для груза")
            }
        }
    }
    
    init(model: String = "", year: Int = 0, km: Double = 0.0, truckType: TruckTypes, truckLoad: AutotruckLoad) {
        self.model = model
        self.year = year
        self.km = km
        self.truckType = truckType
        self.truckLoad = truckLoad
    }
    
    var description: String {
        return String("model: \(model), year: \(year),  km: \(km), truckType: \(truckType), truckLoad: \(truckLoad)")
    }
        
    func transmission(type: String) {
        if type == "auto" {
            print("Автоматическая коробка передач")
        } else if type == "manual" {
            print("Механическая коробка передач")
        } else {
            print("Выберете auto или manual")
        }
    }
    
    
}

enum ModelType{
    case coupe, roadster
}

enum SportSpeed {
    case turboS, superS
}

class SportCar: Car {
    
    var model: String = ""
    
    var year: Int = 0
    
    var km: Double = 0
    
    var speed: SportSpeed
    
    var typeOfModel: ModelType
    
    init(model: String = "", year: Int = 0, km: Double = 0, speed: SportSpeed, typeOfModel: ModelType) {
        self.model = model
        self.year = year
        self.km = km
        self.speed = speed
        self.typeOfModel = typeOfModel
    }
    
    var description: String {
        return String("model: \(model), year: \(year),  km: \(km), speed: \(speed), typeOfModel: \(typeOfModel)")
    }
    
    func transmission(type: String) {
        if type == "auto" {
            print("Автоматическая роботизированная коробка передач")
        } else if type == "manual" {
            print("Механическая 6-ти ступенччатая коробка передач")
        } else {
            print("Выберете auto или manual")
        }
    }
   
}

var zil = TruncCar(model: "ZIL", year: 1999, km: 250000, truckType: .logCarrier, truckLoad: .lowTruckLoad)
zil.printCar()
zil.doorPosition(type: "close")
zil.transmission(type: "manual")
zil.truckLoad = .lowTruckLoad

var scania = TruncCar(model: "SCANIA", year: 2015, km: 100000, truckType: .garbage, truckLoad: .fullTruckLoad)
scania.printCar()
scania.doorPosition(type: "open")
scania.transmission(type: "auto")
scania.truckLoad = .fullTruckLoad

var tesla = SportCar(model: "Tesla", year: 2020, km: 0, speed: .superS, typeOfModel: .roadster)
tesla.printCar()
tesla.doorPosition(type: "open")

var honda = SportCar(model: "Honda", year: 2010, km: 200000, speed: .turboS, typeOfModel: .coupe)
honda.printCar()
honda.transmission(type: "manual")
honda.doorPosition(type: "close")
