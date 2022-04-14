
import Foundation

struct NewsAPI{
    static let shared = NewsAPI()
    private init() {}
    
    private let apiKey = "94bae6b1d7b84a079bfacf4380fc2555"
    private let session = URLSession.shared
    private let jsonDecoder:JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetch(from category:Category) async throws -> [Article]{
       try await fetchArticles(from: generateNewsURL(from: category))
    }
    
    func search(for query:String) async throws -> [Article]{
        try await fetchArticles(from: generateSearchURL(from: query))
    }
    
    private func fetchArticles(from url:URL) async throws -> [Article]{
        let ( data, response) = try await session.data(from: url)
        guard let response = response as? HTTPURLResponse else{
            throw generateError(description: "Bad Request")
        }
        switch response.statusCode{
        case (200...299) ,(400...499):
            let apiResponse = try jsonDecoder.decode(APIResponse.self, from: data)
            if apiResponse.status == "ok"{
                return apiResponse.articles ?? []
            }
            else{
                throw generateError(description: apiResponse.message ?? "An error occured")
            }
        default:
            throw generateError(description: "An server error occured")
        }
    }
    
    private func generateError(code:Int = 1, description: String) -> Error{
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey : description])
    }
    
    private func generateSearchURL(from query:String) -> URL{
        let percentageEncodingString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        var url = "https://newsapi.org/v2/everything?"
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&q=\(percentageEncodingString)"
        return URL(string: url)!
    }
    
    private func generateNewsURL(from category:Category) -> URL{
        var url = "https://newsapi.org/v2/top-headlines?"
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&category=\(category.rawValue)"
        return URL(string: url)!
    }
    
}
