//  Created by Lech Lipnicki on 2021-03-01.
//

import Foundation

enum Series: String {
    case breakingBad = "Breaking+Bad"
    case betterCallSaul = "Better+Call+Saul"
}

enum APIEndpoint {
    case episodes(from: Series)
    case characters(from: Series)
    case characterQuotes(forCharacter: String)
    case randomQuote

    var url: URL? {
        switch self {
        case let .episodes(series):
            let queryItem = URLQueryItem(name: QueryKey.series.rawValue, value: series.rawValue)
            return makeURL(endpoint: .episodes, queryItems: [queryItem])

        case let .characters(series):
            let queryItem = URLQueryItem(name: QueryKey.category.rawValue, value: series.rawValue)
            return makeURL(endpoint: .characters, queryItems: [queryItem])

        case let .characterQuotes(name):
            let queryItem = URLQueryItem(name: QueryKey.author.rawValue, value: name)
            return makeURL(endpoint: .characterQuote, queryItems: [queryItem])

        case .randomQuote:
            return makeURL(endpoint: .randomQuote)
        }
    }
}

private extension APIEndpoint {

    enum Endpoint: String {
        case episodes = "/api/episodes"
        case characters = "/api/characters"
        case characterQuote = "/api/quote"
        case randomQuote = "/api/quote/random"
    }

    enum QueryKey: String {
        case series
        case category
        case author
    }

    private var baseURL: String {
        "https://www.breakingbadapi.com"
    }

    func makeURL(endpoint: Endpoint, queryItems: [URLQueryItem]? = nil) -> URL? {
        let urlString = baseURL + endpoint.rawValue

        guard let queryItems = queryItems else {
            return URL(string: urlString)
        }

        var components = URLComponents(string: urlString)
        components?.queryItems = queryItems
        return components?.url
    }
}
