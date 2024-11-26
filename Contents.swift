import Foundation


// we can write different type, all of them same meaning

/*
enum Animals {
    
    case cat, dog, rabbit
}

enum Animals {
    
    case cat,
    dog,
    rabbit
}
*/

enum Animals {
    
    case cat
    case dog
    case rabbit
}

let cat = Animals.cat
cat

/*
 
if cat == Animals.cat {
    "this is a cat"
} else if cat == Animals.dog {
    "this is a dog"
} else if cat == 3 {
    "this is a something else"
}


func == (lhs: Animals, rhs: Int) -> Bool {  // Burada operator overloading yapılarak cat == 3 karşılaştırmasının
    lhs == .cat && rhs == 3                 // yapılması sağlanıyor. Yani cat 3. sırada mı diyebilmek için.
}                                           // böyle bir kod yazılmazsa kod hata verir. karşılaştırılmaya
                                            // çalışılan iki değerinde tipi farklı olduğu için.
*/


if cat == Animals.cat {
    "this is a cat"
} else if cat == Animals.dog {
    "this is a dog"
} else  {
    "this is a something else"
}

// enumları if - else bloklarıyla yapmak yerine switch ile yapmak daha mantıklıdır

switch cat {
    
case .cat:
    "this is a cat"
    break
case .dog:
    "this is a dog"
    break
case .rabbit:
    "this is a rabbit"
    break
    
}

// we can write different way, like else block

// this is usually not a good idea, we should write all enums. default sometimes can not be enough
switch cat {
    
case .cat:
    "this is a cat"
    break
case .dog:
    "this is a dog"
    break
default:
    "this is a something else"
    
}

func describeAnimal(_ animal: Animals) {
    
    switch animal {
    case .cat:
        "this is a cat"
        break
    case .dog:
        "this is a dog"
        break
    default:
        "this is a something else"
        
    }
}

describeAnimal(.rabbit)

// ******************************************************


enum Shortcut {
    
    case fileOrFolder(path: URL, name: String)
    case wwwUrl(path: URL)
    case song(artist: String, songName: String)
}

let wwwApple = Shortcut.wwwUrl(path: URL(string: "https://apple.com")!)

// 1. yazım

switch wwwApple {
case .fileOrFolder(path: let path, name: let name):
    path
    name
    break
case .wwwUrl(path: let path):
    path
    break
case .song(artist: let artist, songName: let songName):
    artist
    songName
    break
}

// 2. yazım

switch wwwApple {
case .fileOrFolder(let path, let name):
    path
    name
    break
case .wwwUrl(let path):
    path
    break
case .song(let artist, let songName):
    artist
    songName
    break
}

// 3. yazım

switch wwwApple {
case let .fileOrFolder(path, name):
    path
    name
    break
case let .wwwUrl(path):
    path
    break
case let .song(artist, songName):
    artist
    songName
    break
}

if case let .wwwUrl(path) = wwwApple {
    path
}


let withoutYou = Shortcut.song(artist: "Symphony X", songName: "Without You")

if case let .song(_, songName) = withoutYou {
    songName
}

if case let .song(artist, songName) = withoutYou {
    artist
    songName
}


//**********************************************************

enum Vehicle {
    case car(manufacturer: String, model: String)
    case bike(manufacturer: String, yearMade: Int)
    
    var manufacturer: String {  // computed property
        switch self {
        case let .car(manufacturer, _), let .bike(manufacturer, _):
           return manufacturer
        }
    }
    
/* 4.
    var manufacturer: String {
        switch self {
        case let .car(manufacturer, _):
           return manufacturer
            
        case let .bike(manufacturer, _):
           return manufacturer
        }
    }
*/
    
/* 3.
    func getManufacturer() -> String {
        switch self {
        case let .car(manufacturer, _):
           return manufacturer
            
        case let .bike(manufacturer, _):
           return manufacturer
        }
    }
*/
    
    
}



/* 2.
func getManufacturer(from vehicle: Vehicle) -> String {
    switch vehicle {
    case let .car(manufacturer, _):
       return manufacturer
        
    case let .bike(manufacturer, _):
       return manufacturer
    }
}
*/

let car = Vehicle.car(manufacturer: "Ford", model: "Mustang")
/* 1.
 
switch car {
case let .car(manufacturer, _):
    manufacturer
    
case let .bike(manufacturer, _):
    manufacturer
}

*/
//2. getManufacturer(from: car)
//3. car.getManufacturer()
car.manufacturer // 4. aynı zamanda

let bike = Vehicle.bike(manufacturer: "HD", yearMade: 1987)
/* 1.
 
switch bike {
case let .car(manufacturer, _):
    manufacturer
    
case let .bike(manufacturer, _):
    manufacturer
}
 
*/
//2. getManufacturer(from: bike)
//3. bike.getManufacturer()
bike.manufacturer // 4. aynı zamanda


// ******************************************************* enum taking rawvalue type
enum FamilyMember: String {
    
    case father = "Dad"
    case mother = "Mom"
    case sister = "Sis"
    case brother = "Bro"
}

FamilyMember.father.rawValue
FamilyMember.sister.rawValue

// ******************************************************* enum taking protocol

enum FavoriteEmoji: String, CaseIterable {
    case blush = "😊"
    case rocket = "🚀"
    case fire = "🔥"
}

FavoriteEmoji.allCases
FavoriteEmoji.allCases.map(\.rawValue)
FavoriteEmoji.blush.rawValue

if let blush = FavoriteEmoji(rawValue: "😊") {
    "Found the blush emoji"
    blush
} else {
    "This emoji doesn't exist."
}

if let snow = FavoriteEmoji(rawValue: "❄️") {
    "Found the snow emoji"
    snow
} else {
    "This emoji doesn't exist."
}


// ******************************************************  mutating enum

enum Height {
    case short, medium, long
    mutating func makeLong() {
        self = Height.long
    }
}

var myHeight = Height.medium
myHeight.makeLong()
myHeight


// ******************************************************  recursive enum

indirect enum IntOperation {
    case add(Int, Int)
    case substract(Int, Int)
    case freeHand(IntOperation)
    
    func calculateResult(of operation: IntOperation? = nil) -> Int {
        
        switch operation ?? self {
        case let .add(left, right):
            return left + right
            
        case let .substract(left, right):
            return left - right
            
        case let .freeHand(operation):
            return calculateResult(of: operation)
        }
    }
}

let freeHand = IntOperation.freeHand(.add(2, 4))
freeHand.calculateResult()
