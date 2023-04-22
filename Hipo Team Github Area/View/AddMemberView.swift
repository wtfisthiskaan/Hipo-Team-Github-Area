//
//  AddMemberView.swift
//  Hipo Team Github Area
//
//  Created by Kaan Uslu on 21.04.2023.
//

import SwiftUI

struct AddMemberView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: MemberJSONModel
    @State private var name = ""
    @State private var github = ""
    @State private var position = ""
    @State private var yearsInHipo = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Member Information")) {
                    TextField("Name", text: $name)
                    TextField("GitHub Username", text: $github)
                    TextField("Position", text: $position)
                    TextField("Years in Hipo", text: $yearsInHipo)
                }
                Button("Add Member") {
                    let hipoInfo = Member.Hipo(position: position, years_in_hipo: Int(yearsInHipo) ?? 0)
                    let newMember = Member(name: name, github: github, hipo: hipoInfo)
                    viewModel.members.append(newMember)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Add New Member")
        }
    }
}

struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView(viewModel: MemberJSONModel())
    }
}

