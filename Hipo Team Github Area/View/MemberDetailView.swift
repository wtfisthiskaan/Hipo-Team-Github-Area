import SwiftUI

struct MemberDetailView: View {
    let member: Member
    @State private var userInfo: UserInfo?
    @State private var repositories: [Repository] = []
    @State private var isLoading = false
    @State private var error: Error?

    private let gitHubAPI = GitHubAPI()
    
    
    //colors
    //RGB: 110, 84, 148
    let BGColor = Color(red: 110 / 255, green: 84 / 255, blue: 148 / 255)
    //RGB: 108, 198, 68
    let repoBGColor = Color(red: 108 / 255, green: 198 / 255, blue: 68 / 255)


    var body: some View {
        ZStack{
            BGColor
            
            VStack() {
            if isLoading {
                ProgressView("Loading...")
            } else if let userInfo = userInfo {
                VStack(spacing: -20){
                    Text(member.github)
                        .font(Font.custom("Avenir-Light", size: 15))
                        .padding(.top, 35)
                HStack(spacing: 50){
                    AsyncImage(url: URL(string: userInfo.avatar_url)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 150)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                            .frame(width: 150, height: 150)
                    }
                    .padding(.top)
                    VStack(spacing: 5){
                        Text("Followers")
                            .font(Font.custom("Avenir-Heavy", size: 15))
                        Text("\(userInfo.followers)")
                            .font(Font.custom("Avenir", size: 15))
                    }
                    VStack(spacing: 5){
                        Text("Following")
                            .font(Font.custom("Avenir-Heavy", size: 15))
                        Text("\(userInfo.following)")
                            .font(Font.custom("Avenir", size: 15))
                    }
                }
            }
                ScrollView {
                    ForEach(repositories) { repository in
                        HStack(alignment: .top, spacing: 25) {
                            Text(repository.language ?? "Unknown")
                                .rotationEffect(Angle(degrees: 270))
                                .font(Font.custom("Avenir", size: 18))
                                .frame(width: 100, alignment: .center)
                                .minimumScaleFactor(0.01)
                                .padding(.top, 10)

                            VStack(alignment: .leading) {
                                Text(repository.name)
                                    .font(Font.custom("Avenir-Heavy", size: 15))
                                    //.lineLimit(1)
                                    //.truncationMode(.tail)
                                    .fixedSize(horizontal: true, vertical: false)

                                Text(formatTime(created: repository.updated_at))
                                    .font(Font.custom("Avenir-Light", size: 18))
                            }
                            .frame(width: 200, alignment: .leading)

                            Text("\(repository.stargazers_count) ⭐️")
                                .rotationEffect(Angle(degrees: 270))
                                .font(Font.custom("Avenir", size: 18))
                                .frame(width: 100, alignment: .center)
                                .padding(.top, 10)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                            .frame(height: 125)
                            .background(repoBGColor)
                            .frame(width: 400, alignment: .center)
                            .cornerRadius(30)
                            .foregroundColor(.white)
                    }



                       
                }
            } else {
                Text("Error loading data.")
            }
        }
            .padding(.top, 50)
        .navigationTitle(member.name)
        .onAppear(perform: fetchGitHubInfo)
        }.ignoresSafeArea()
    }

    private func fetchGitHubInfo() {
        isLoading = true
        gitHubAPI.fetchUserInfo(username: member.github) { userInfoResult in
            gitHubAPI.fetchPublicRepos(username: member.github) { reposResult in
                DispatchQueue.main.async {
                    isLoading = false
                    switch userInfoResult {
                    case .success(let userInfo):
                        self.userInfo = userInfo
                    case .failure(let error):
                        self.error = error
                    }
                    
                    switch reposResult {
                    case .success(let repos):
                        self.repositories = repos
                    case .failure(let error):
                        self.error = error
                    }
                }
            }
        }
    }
    
    
    private func formatTime(created: String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = dateFormatter.date(from: created) {
            dateFormatter.dateFormat = "d MMM yyyy, HH:mm:ss"
            return dateFormatter.string(from: date)
        }

        return created
}

}






struct MemberDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MemberDetailView(member: Member(name: "Salih Karasuluoğlu", github: "sakkaras", hipo: Member.Hipo(position: "Team Lead", years_in_hipo: 7)))
    }
}
