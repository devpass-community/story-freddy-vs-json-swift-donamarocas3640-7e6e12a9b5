import Foundation

struct Service {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func fetchList(of user: String, completion: @escaping ([Repository]?) -> Void) {
        let urlString = "https://api.github.com/users/\(user)/repos"
            
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            network.performGet(url: url) { data in
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let repositories = try decoder.decode([Repository].self, from: data)
                    completion(repositories)
                } catch {
                    completion(nil)
                }
        }
    }
}
