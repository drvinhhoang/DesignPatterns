
import Foundation

class Address: NSCopying {
    var street: String
    var city: String
    var zip: String

    init(street: String, city: String, zip: String) {
        self.street = street
        self.city = city
        self.zip = zip
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return Address(street: self.street, city: self.city, zip: self.zip)
    }
}

extension Address: CustomStringConvertible {
    public var description: String {
        return "street: \(street), city: \(city), zip: \(zip)"
    }
}

class Contact {
    var firstName: String
    var lastName: String
    var address: Address
    
    init(firstName: String, lastName: String, address: Address) {
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
    }
}

extension Contact: CustomStringConvertible {
    public var description: String {
        return "Contact(firstName: \(firstName), lastName: \(lastName), address: \(address))"
    }
}

extension Contact: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        return Contact(firstName: self.firstName, lastName: self.lastName, address: self.address.copy() as! Address)
    }
}

extension Contact {
    func clone() -> Contact {
        return self.copy() as! Contact
    }
}

let john = Contact(firstName: "John", lastName: "AppleSeed", address: Address(street: "1", city: "Cupertino", zip: "95014"))
let bob = john.clone()

bob.firstName = "Bob"
bob.lastName = "Burger"
bob.address.city = "Los Angeles"
bob.address.street = "2700, N Vermont Ave"
bob.address.zip = "90027"

print(john, bob)
