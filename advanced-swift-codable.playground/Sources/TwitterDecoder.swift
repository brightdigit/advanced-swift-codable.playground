import Foundation

public struct TwitterDateFormatter {
  public static let formatString = "eee MMM dd HH:mm:ss ZZZZ yyyy"
  
  public static let shared = {
    dateFormat -> DateFormatter in
    let formatter = DateFormatter ()
    formatter.dateFormat = dateFormat
    return formatter
  }(formatString)
  
  private init() {
    
  }
}

public struct TwitterDecoder {
  public static let jsonDecoder = {
    dateFormatter -> JSONDecoder in
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }(TwitterDateFormatter.shared)
  
  public static let shared = TwitterDecoder()
  
  public func tweet(fromUrl url: URL) throws -> Tweet {
    let twitterData = try Data(contentsOf: url)
    return try TwitterDecoder.jsonDecoder.decode(Tweet.self, from: twitterData)
  }
}
