import SwiftUI

struct MembersListView: View {
    let navigationBGColor = Color(red: 51 / 255, green: 51 / 255, blue: 51/255)
    let listBGColor = Color(red: 245 / 255, green: 245 / 255, blue: 245/255)
    let sortBGColor = Color(red: 201 / 255, green: 81 / 255, blue: 12/255)
    let addBGColor = Color(red: 64 / 255, green: 120 / 255, blue: 192/255)

    
    func sortMembers() {
        let characterToSortBy: Character = "a"
        let lastNames = viewModel.members.map { $0.name.split(separator: " ").last! }
        let sortedLastNames = sort(array: lastNames.map { String($0) }, character: characterToSortBy)

        viewModel.members.sort { member1, member2 in
            let lastName1 = member1.name.split(separator: " ").last!
            let lastName2 = member2.name.split(separator: " ").last!

            return sortedLastNames.firstIndex(of: String(lastName1))! < sortedLastNames.firstIndex(of: String(lastName2))!
        }
    }

    
    @State private var searchText = ""
    @ObservedObject var viewModel = MemberJSONModel()
    @State private var isAddingMember = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                List {
                    ForEach(viewModel.members.filter { member in
                        searchText.isEmpty ||
                        member.name.lowercased().contains(searchText.lowercased()) ||
                        member.hipo.position.lowercased().contains(searchText.lowercased())
                    }) { member in
                        NavigationLink(destination: MemberDetailView(member: member)) {
                            HStack(alignment: .top) {
                                Text("\(member.hipo.years_in_hipo) years")
                                    .rotationEffect(Angle(degrees: 270))
                                    .font(Font.custom("Avenir", size: 11))
                                    .padding(.top)
                                
                                VStack(alignment: .leading) {
                                    Text(member.name).font(Font.custom("Avenir", size: 22))
                                        .padding(.trailing)
                                    Text(member.hipo.position)
                                        .font(Font.custom("Avenir-Light", size: 11))
                                        .padding(.trailing)
                                }
                            }

                            
                        }
                    }
                }
                VStack  {
                    Button("Sort Members") {
                        sortMembers()
                    }
                    .padding()
                    .font(Font.custom("Avenir", size: 22))
                    .frame(width: 300, height: 75, alignment: .center)
                    .background(sortBGColor)
                    .cornerRadius(25)
                    .foregroundColor(.white)
                    
                    Button("Add New Member") {
                        isAddingMember = true
                    }
                    .padding()
                    .font(Font.custom("Avenir", size: 22))
                    .frame(width: 300, height: 75, alignment: .center)
                    .background(addBGColor)
                    .cornerRadius(25)
                    .foregroundColor(.white)
                    .sheet(isPresented: $isAddingMember) {
                        AddMemberView(viewModel: viewModel)
                    }
                }

            }
            
            .navigationTitle("Members")
            .navigationBarTitleDisplayMode(.inline)
            .background(navigationBGColor)
        }
    }
}



struct MembersListView_Previews: PreviewProvider {
    static var previews: some View {
        MembersListView()
    }
}
/**/
