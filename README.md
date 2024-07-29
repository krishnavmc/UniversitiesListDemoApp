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
