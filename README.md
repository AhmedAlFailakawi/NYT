# NYT
Simple app that retrieves all the bad news that New York Times is publishing using their API.

### App Delegate
I'm setting up the navigation controller bar to have a customized New York Times font, and to have a colored background.

### Retrieving data
The app is using Moya to call the API and retrieve the most viewed articles' titles, abstracts, and thumbnails.

## App Flow
First view controller will display all articles in a UITableView; where it's showing all the articles along with their rounded thumbnails. You can scroll down to refresh and get the latest, however, you might not get the latest frequently since the API is free and doesn't bring lots of data. As a suggestion, consider using News app on your iPhone... 
Once you click on any cell it will direct you the second VC. There, you'll find the full abstract in a UIScrollView along with some hard-coded text views pretending to be the body of the article. On the right top of the navigation bar you will find a button that if clicked, it will direct you the article on New York Times website.
