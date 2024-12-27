//
// CountryName.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct CountryName: Codable, Hashable {

    /** Общепринятое название страны. */
    public var common: String?
    /** Официальное название страны. */
    public var official: String?
    public var nativeName: [String: CountryNameNativeNameValue]?

    public init(common: String? = nil, official: String? = nil, nativeName: [String: CountryNameNativeNameValue]? = nil) {
        self.common = common
        self.official = official
        self.nativeName = nativeName
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case common
        case official
        case nativeName
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(common, forKey: .common)
        try container.encodeIfPresent(official, forKey: .official)
        try container.encodeIfPresent(nativeName, forKey: .nativeName)
    }
}
