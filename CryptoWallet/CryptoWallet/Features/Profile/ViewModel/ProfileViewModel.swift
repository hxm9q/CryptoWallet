import UIKit

final class ProfileViewModel {
    
    weak var coordinator: ProfileCoordinator?
    
    let title: String
    var profiles: [Profile] = []
    
    init(title: String) {
        self.title = title
    }
    
    func loadProfiles() {
        profiles = [
            Profile(name: "Anton",
                    email: "hxm9q@icloud.com",
                    settings: ["Notifications", "Privacy", "Security", "Account"]
                   )
        ]
    }
    
    func showProfileDetail() {
        let myProfile = profiles[0]
        coordinator?.showProfileDetail(profile: myProfile)
    }
}
