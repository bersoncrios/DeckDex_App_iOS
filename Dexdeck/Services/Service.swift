//
//  Service.swift
//  Dexdeck
//
//  Created by Familia Berson on 29/07/25.
//

import Foundation

class Service {
    private let baseURL: String = "https://api.pokemontcg.io/v2/"
    private let apiKey: String = "4d1d51bc-85fb-4bd7-83ee-04d2376575e5"
    private let session = URLSession.shared
    
    
    func fetchAllCards(_ completion: @escaping (TCGResponse?) -> Void) {
       
        let urlString = "\(baseURL)cards?page=1&pageSize=50"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data else {
                completion(nil)
                return
            }
            
            do {
                let TCGResponse = try JSONDecoder().decode(TCGResponse.self, from: data)
                completion(TCGResponse)
            } catch {
                print("❌ Erro ao decodificar:", error)
                if let jsonStr = String(data: data, encoding: .utf8) {
                    print("📦 JSON recebido:\n\(jsonStr)")
                }
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    
    func fetchAllColecoes(_ completion: @escaping (TCGColecoes?) -> Void) {
        let configuration = URLSessionConfiguration.default
        
        let urlString = "\(baseURL)sets?page=1&pageSize=50"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data else {
                completion(nil)
                return
            }
            
            do {
                let TCGColecoes = try JSONDecoder().decode(TCGColecoes.self, from: data)
                completion(TCGColecoes)
            } catch {
                print("❌ Erro ao decodificar:", error)
                if let jsonStr = String(data: data, encoding: .utf8) {
                    print("📦 JSON recebido:\n\(jsonStr)")
                }
                completion(nil)
            }
        }
        
        task.resume()
    }

}


// MARK: - TCGResponse
struct TCGResponse: Codable {
    let data: [Datum]
    let page, pageSize, count, totalCount: Int
}

// MARK: - Datum
struct Datum: Codable {
    let id, name: String
    let supertype: Supertype
    let subtypes: [Subtype]
    let hp: String
    let types: [RetreatCost]
    let evolvesFrom: String?
    let attacks: [Attack]?
    let weaknesses, resistances: [Resistance]?
    let retreatCost: [RetreatCost]?
    let convertedRetreatCost: Int?
    let datumSet: SetPokede
    let number, artist: String
    let rarity: Rarity?
    let flavorText: String?
    let nationalPokedexNumbers: [Int]
    let legalities: Legalities
    let images: DatumImages
    let tcgplayer: Tcgplayer?
    let cardmarket: Cardmarket?
    let evolvesTo: [String]?
    let level: String?
    let abilities: [Ability]?
    let rules: [String]?
    let regulationMark: String?

    enum CodingKeys: String, CodingKey {
        case id, name, supertype, subtypes, hp, types, evolvesFrom, attacks, weaknesses, resistances, retreatCost, convertedRetreatCost
        case datumSet = "set"
        case number, artist, rarity, flavorText, nationalPokedexNumbers, legalities, images, tcgplayer, cardmarket, evolvesTo, level, abilities, rules, regulationMark
    }
}

// MARK: - Ability
struct Ability: Codable {
    let name, text: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case ability = "Ability"
    case pokéBody = "Poké-Body"
    case pokéPower = "Poké-Power"
    case pokémonPower = "Pokémon Power"
}

// MARK: - Attack
struct Attack: Codable {
    let name: String
    let cost: [RetreatCost]
    let convertedEnergyCost: Int
    let damage, text: String
}

enum RetreatCost: String, Codable {
    case colorless = "Colorless"
    case darkness = "Darkness"
    case dragon = "Dragon"
    case fighting = "Fighting"
    case fire = "Fire"
    case grass = "Grass"
    case lightning = "Lightning"
    case metal = "Metal"
    case psychic = "Psychic"
    case water = "Water"
}

// MARK: - Cardmarket
struct Cardmarket: Codable {
    let url: String
    let updatedAt: UpdatedAt
    let prices: [String: Double]
}

struct UpdatedAt: Codable {
    let date: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let date = formatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
        }
        
        self.date = date
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let dateString = formatter.string(from: date)
        try container.encode(dateString)
    }
}


// MARK: - Set
struct SetPokede: Codable {
    let id, name: String
    let series: Series
    let printedTotal, total: Int
    let legalities: Legalities
    let ptcgoCode: String?
    let releaseDate, updatedAt: String
    let images: SetImages
}

// MARK: - SetImages
struct SetImages: Codable {
    let symbol, logo: String
}

// MARK: - Legalities
struct Legalities: Codable {
    let unlimited: Expanded
    let expanded: Expanded?
}

enum Expanded: String, Codable {
    case legal = "Legal"
}

enum Series: String, Codable {
    case base = "Base"
    case blackWhite = "Black & White"
    case diamondPearl = "Diamond & Pearl"
    case eCard = "E-Card"
    case ex = "EX"
    case gym = "Gym"
    case heartGoldSoulSilver = "HeartGold & SoulSilver"
    case neo = "Neo"
    case other = "Other"
    case platinum = "Platinum"
    case pop = "POP"
    case sunMoon = "Sun & Moon"
    case swordShield = "Sword & Shield"
    case xy = "XY"
}

// MARK: - DatumImages
struct DatumImages: Codable {
    let small, large: String
}

enum Rarity: String, Codable {
    case common = "Common"
    case promo = "Promo"
    case rare = "Rare"
    case rareHolo = "Rare Holo"
    case rareHoloEX = "Rare Holo EX"
    case rareHoloGX = "Rare Holo GX"
    case rareHoloV = "Rare Holo V"
    case rareUltra = "Rare Ultra"
    case uncommon = "Uncommon"
}

// MARK: - Resistance
struct Resistance: Codable {
    let type: RetreatCost
    let value: String
}

enum Subtype: String, Codable {
    case basic = "Basic"
    case ex = "EX"
    case gx = "GX"
    case mega = "MEGA"
    case restored = "Restored"
    case sp = "SP"
    case stage1 = "Stage 1"
    case stage2 = "Stage 2"
    case tagTeam = "TAG TEAM"
    case teamPlasma = "Team Plasma"
    case v = "V"
}

enum Supertype: String, Codable {
    case pokémon = "Pokémon"
}

// MARK: - Tcgplayer
struct Tcgplayer: Codable {
    let url: String
    let updatedAt: UpdatedAt
    let prices: Prices?
}

// MARK: - Prices
struct Prices: Codable {
    let holofoil, reverseHolofoil, normal, the1StEditionHolofoil: The1_StEditionHolofoil?
    let unlimitedHolofoil: The1_StEditionHolofoil?

    enum CodingKeys: String, CodingKey {
        case holofoil, reverseHolofoil, normal
        case the1StEditionHolofoil = "1stEditionHolofoil"
        case unlimitedHolofoil
    }
}

// MARK: - The1_StEditionHolofoil
struct The1_StEditionHolofoil: Codable {
    let low, mid, high: Double
    let market, directLow: Double?
}




// MARK: - TCGSets
struct TCGColecoes: Codable {
    let data: [ColecoesData]
    let page, pageSize, count, totalCount: Int
}

// MARK: - Datum
struct ColecoesData: Codable {
    let id, name, series: String
    let printedTotal, total: Int
    let legalities: ColecoesLegalities
    let ptcgoCode: String?
    let releaseDate, updatedAt: String
    let images: Images
}

// MARK: - Images
struct Images: Codable {
    let symbol, logo: String
}

// MARK: - Legalities
struct ColecoesLegalities: Codable {
    let unlimited: String
}

