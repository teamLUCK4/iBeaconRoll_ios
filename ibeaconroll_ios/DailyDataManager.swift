import Foundation

class DailyDataManager {
    static let shared = DailyDataManager()
    
    private let cacheKey = "cachedData"
    private let dateKey = "lastFetchDate"

    private let apiURL = URL(string: "http://localhost:8080/api/students/1/schedule/today")!  // 여기에 진짜 API 넣기

    private init() {}

    func getDailyData(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let today = formattedDate(Date())
        let lastFetched = UserDefaults.standard.string(forKey: dateKey)
        
        if lastFetched == today, let cached = UserDefaults.standard.data(forKey: cacheKey) {
            do {
                if let json = try JSONSerialization.jsonObject(with: cached, options: []) as? [String: Any] {
                    completion(.success(json))
                } else {
                    throw NSError(domain: "ParseError", code: 0)
                }
            } catch {
                completion(.failure(error))
            }
        } else {
            fetchFromAPI { result in
                switch result {
                case .success(let json):
                    if let data = try? JSONSerialization.data(withJSONObject: json, options: []) {
                        UserDefaults.standard.set(data, forKey: self.cacheKey)
                        UserDefaults.standard.set(today, forKey: self.dateKey)
                    }
                    completion(.success(json))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    private func fetchFromAPI(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        URLSession.shared.dataTask(with: apiURL) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(.success(json))
                    } else {
                        throw NSError(domain: "ParseError", code: 0)
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }    
    // 캐시 클리어 함수 (개발/테스트용)
    func clearCache() {
        UserDefaults.standard.removeObject(forKey: cacheKey)
        UserDefaults.standard.removeObject(forKey: dateKey)
        print("🗑️ Cache cleared")
    }

}

