//  Created by Lech Lipnicki on 2021-03-01.
//

import Foundation

struct Episode: Decodable {
    let episodeId: Int
    let title: String
    let season: String
    let airDate: String
    let characters: [String]
    let episode: String
    let series: String
    
    private enum CodingKeys: String, CodingKey {
        case episodeId = "episode_id"
        case title
        case season
        case airDate = "air_date"
        case characters
        case episode
        case series
    }
}
