//
//  Order.swift
//  CupcakeCorner
//
//  Created by Alejandro González on 27/01/26.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if self.specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = "" {
        didSet {
            storeAddress()
        }
    }
    var streetAddress = "" {
        didSet {
            storeAddress()
        }
    }
    var city = "" {
        didSet {
            storeAddress()
        }
    }
    var zip = "" {
        didSet {
            storeAddress()
        }
    }
    
    var hasValidAddress: Bool {
        let checkName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let checkStreet = streetAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        let checkCity = city.trimmingCharacters(in: .whitespacesAndNewlines)
        let checkZip = zip.allSatisfy { $0.isNumber }
        
        if (checkName.isEmpty || checkStreet.isEmpty || checkCity.isEmpty || zip.isEmpty || !checkZip) {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    struct Address: Codable {
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
    }
    
    func storeAddress() {
        let address = Address(name: name, streetAddress: streetAddress, city: city, zip: zip)
        
        if let encoded_address = try? JSONEncoder().encode(address) {
            UserDefaults.standard.set(encoded_address, forKey: "address")
        }
    }
    
    init() {
        if let savedAddress = UserDefaults.standard.data(forKey: "address") {
            if let decodedAddress = try? JSONDecoder().decode(Address.self, from: savedAddress) {
                name = decodedAddress.name
                streetAddress = decodedAddress.streetAddress
                city = decodedAddress.city
                zip = decodedAddress.zip
            }
        }
    }
}
