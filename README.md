# UniversitiesListDemoApp
This is sample app which loads list of universities from the backend service and present in tableview controller.

## Application Functionality
- Fetching list of universities form backend.
- Storing data in local db using `Realm`
- Showing them on UITableView.
- Present details of each item in details screen.

## Technical design.
- Used Xcode 15 & UIKit, Swift.
- User `Realm` third party to persist data for offline support.
- Used VIPER architecture.
- App contains two modules called `UniversitiesListModule`, `UniversitiesDetailsModule`. Code modularised properly with these groups. 
- DatabaseManager is responsible for saving data using Realm.

## Improvements can be considered if we have some more time.
- Unit tests
- Accessibility.
- UITests

## How it looks 
![Simulator Screenshot - iPhone 15 Pro - 2024-07-29 at 11 53 48](https://github.com/user-attachments/assets/f9a520ea-83d6-4fc8-ad81-7d7a182b2e63)
![Simulator Screenshot - iPhone 15 Pro - 2024-07-29 at 11 53 52](https://github.com/user-attachments/assets/5e13bff6-a031-4e44-a30c-152345a3c86b)


https://github.com/user-attachments/assets/83c65599-dd0e-497a-8aed-1cce559c0ded

