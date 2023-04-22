# Hipo-Team-Github-Area

Project is wrote with SwiftUI. MVC design pattern is used.


# Problem Solution Approach

I created an iOS app using SwiftUI and the MVC design pattern. The app should display a list of members from a given JSON file, allow searching and sorting of members, and enable adding new members. It should also fetch and display details of each member using the GitHub API.

I identified the models necessary for representing the members, companies, and GitHub repositories. These include the Member, Company, Repository, and UserInfo models.

I designed the views required for the app, including MemberListView, AddMemberView, and MemberDetailView. I made sure to create a user-friendly interface and include all necessary UI components.

I implemented the MemberViewModel and GitHubAPI classes to handle data processing and API requests. I made sure to follow the MVC design pattern and separate concerns appropriately.

I added the search functionality to MemberListView to allow users to search for members based on their name and position. I also implemented the sorting functionality by creating a custom sorting function and adding a "Sort" button to the UI.

I integrated the GitHub API into the project to fetch and display member details in MemberDetailView. I made sure to handle errors and show loading indicators when necessary.

I thoroughly tested the app to ensure that all functionalities were working as expected. I made sure to test edge cases and verify that the app could handle different situations gracefully.

I organized the project files into Model, View, and Controller groups to maintain a clean and easy-to-navigate structure finally. This separation helped to improve the overall readability and maintainability of the code.



