//  Created by Lech Lipnicki on 2021-03-01.
//

import Foundation

struct APIManager {}

// MARK: - API Calls

extension APIManager {

    func getEpisodes(_ completion: @escaping (Result<[Episode], APIError>) -> Void) {
        performRequest(
            url: APIEndpoint.episodes(from: .breakingBad).url,
            completion: { result in
                switch result {
                case let .success(data):
                    do {
                        let episodes = try JSONDecoder().decode([Episode].self, from: data)
                        completion(.success(episodes))
                    } catch {
                        completion(.failure(.parsingFailed))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        )
    }

    func getCharacters(_ completion: @escaping (Result<[Character], APIError>) -> Void) {
        performRequest(
            url: APIEndpoint.characters(from: .breakingBad).url,
            completion: { result in
                switch result {
                case let .success(data):
                    do {
                        let characters = try JSONDecoder().decode([Character].self, from: data)
                        completion(.success(characters))
                    } catch {
                        completion(.failure(.parsingFailed))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        )
    }
}

// MARK: - Helpers

private extension APIManager {

    func performRequest(
        url: URL?,
        completion: @escaping (Result<Data, APIError>) -> Void
    ) {
        guard let url = url else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.requestFailed(reason: error?.localizedDescription)))
            }
        }
        task.resume()
    }
}
