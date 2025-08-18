import UIKit

final class ProfileDetailViewModel {
    
    weak var coordinator: ProfileCoordinator?
    
    private let profile: Profile
    
    init(profile: Profile) {
        self.profile = profile
    }
    
    var profileName: String {
        return profile.name
    }
    
    var profileEmail: String {
        return profile.email
    }
    
    var profileSettings: String {
        return profile.settings.joined(separator: ", ")
    }
    
    func goBack() {
        coordinator?.goBackFromProfileDetail()
    }
}
